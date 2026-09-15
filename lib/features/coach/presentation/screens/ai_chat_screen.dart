import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/ai/ai_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _input = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _loadingHistory = true;
  bool _sending = false;
  bool _limitReached = false;
  int? _remainingToday;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final service = ref.read(aiChatServiceProvider);
    final userId = ref.read(authStateProvider).valueOrNull?.id;
    if (service == null || userId == null) {
      setState(() => _loadingHistory = false);
      return;
    }
    try {
      final history = await service.getHistory(userId);
      if (!mounted) return;
      setState(() {
        _messages.addAll(history);
        _loadingHistory = false;
      });
      _scrollToBottom();
    } catch (_) {
      if (mounted) setState(() => _loadingHistory = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending || _limitReached) return;
    final service = ref.read(aiChatServiceProvider);
    if (service == null) return;

    final l10n = AppLocalizations.of(context)!;
    final languageCode = ref.read(settingsControllerProvider).languageCode;
    final locale = languageCode == 'tr' ? 'tr' : 'en';

    setState(() {
      _messages.add(ChatMessage(
        id: const Uuid().v4(),
        role: ChatRole.user,
        content: text,
        createdAt: DateTime.now(),
      ));
      _sending = true;
      _input.clear();
    });
    _scrollToBottom();

    try {
      final reply = await service.sendMessage(text, locale: locale);
      if (!mounted) return;
      setState(() {
        _remainingToday = reply.remainingToday;
        if (reply.limitReached || reply.text == null) {
          _limitReached = true;
        } else {
          _messages.add(ChatMessage(
            id: const Uuid().v4(),
            role: ChatRole.assistant,
            content: reply.text!,
            createdAt: DateTime.now(),
          ));
        }
      });
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.genericError(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  void dispose() {
    _input.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aiChatTitle),
        bottom: _remainingToday != null && !_limitReached
            ? PreferredSize(
                preferredSize: const Size.fromHeight(24),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Text(
                    l10n.aiChatRemainingToday(_remainingToday!),
                    style: AppTypography.caption,
                  ),
                ),
              )
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: _loadingHistory
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : _messages.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Text(l10n.aiChatEmptyState, textAlign: TextAlign.center, style: AppTypography.bodyMd),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(AppSpacing.screenMargin),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) => _ChatBubble(message: _messages[index]),
                      ),
          ),
          if (_limitReached)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin, vertical: AppSpacing.sm),
              child: Text(l10n.aiChatLimitReached, style: AppTypography.caption.copyWith(color: AppColors.warning)),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      enabled: !_limitReached && !_sending,
                      decoration: InputDecoration(hintText: l10n.aiChatInputHint),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton.filled(
                    onPressed: _limitReached || _sending ? null : _send,
                    icon: _sending
                        ? const SizedBox(
                            width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : AppColors.surface2,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Text(
          message.content,
          style: AppTypography.bodyMd.copyWith(color: isUser ? AppColors.onPrimary : AppColors.textPrimary),
        ),
      ),
    );
  }
}
