import 'package:equatable/equatable.dart';

enum ChatRole { user, assistant }

class ChatMessage extends Equatable {
  final String id;
  final ChatRole role;
  final String content;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory ChatMessage.fromRow(Map<String, dynamic> row) => ChatMessage(
        id: row['id'] as String,
        role: row['role'] == 'assistant' ? ChatRole.assistant : ChatRole.user,
        content: row['content'] as String,
        createdAt: DateTime.parse(row['created_at'] as String),
      );

  @override
  List<Object?> get props => [id, role, content, createdAt];
}
