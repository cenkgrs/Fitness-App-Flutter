import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../models/models.dart';

class ChatReply {
  final String? text;
  final bool limitReached;
  final int remainingToday;
  const ChatReply({this.text, required this.limitReached, required this.remainingToday});
}

/// Chat history lives server-side (ai_chat_messages, written by the
/// ai-coach Edge Function's "chat" action) — this just reads it back and
/// sends new messages. See supabase/functions/ai-coach/index.ts for the
/// daily-limit enforcement and Gemini call.
class SupabaseAiChatService {
  final sb.SupabaseClient _client;

  SupabaseAiChatService(this._client);

  Future<List<ChatMessage>> getHistory(String userId) async {
    final rows = await _client
        .from('ai_chat_messages')
        .select()
        .eq('user_id', userId)
        .order('created_at');
    return (rows as List).cast<Map<String, dynamic>>().map(ChatMessage.fromRow).toList();
  }

  Future<ChatReply> sendMessage(String message, {String locale = 'en'}) async {
    final res = await _client.functions.invoke('ai-coach', body: {
      'action': 'chat',
      'message': message,
      'locale': locale,
    });
    final data = res.data as Map<String, dynamic>?;
    if (data == null || data['error'] != null) {
      throw StateError(data?['error']?.toString() ?? 'Chat request failed');
    }
    return ChatReply(
      text: data['reply'] as String?,
      limitReached: data['limitReached'] as bool? ?? false,
      remainingToday: (data['remainingToday'] as num?)?.toInt() ?? 0,
    );
  }
}
