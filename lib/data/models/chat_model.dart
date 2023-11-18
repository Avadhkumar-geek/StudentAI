import 'dart:convert';

enum ChatSender { user, ai }

class ChatModel {
  String text;
  ChatSender sender;

  ChatModel({required this.text, required this.sender});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      text: json["text"],
      sender: _parseChatUser(json["sender"]),
    );
  }

  Map<String, dynamic> toMap() => {
        'text': text,
        'sender': sender.toString(),
      };

  static ChatSender _parseChatUser(String user) {
    return ChatSender.values
        .firstWhere((e) => e.toString() == 'ChatUser.$user');
  }

  static String encode(List<ChatModel> msgModels) => jsonEncode(
      msgModels.map<Map<String, dynamic>>((msg) => msg.toMap()).toList());

  static List<ChatModel> decode(String msgModel) =>
      (jsonDecode(msgModel) as List<dynamic>)
          .map<ChatModel>((item) => ChatModel.fromJson(item))
          .toList();
}
