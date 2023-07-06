import 'dart:convert';

class MessageModel {
  String text;
  String sender;

  MessageModel({required this.text, required this.sender});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(text: json["text"], sender: json["sender"]);
  }

  static Map<String, dynamic> toMap(MessageModel msgModel) =>
      {'text': msgModel.text, 'sender': msgModel.sender};

  static String encode(List<MessageModel> msgModel) =>
      jsonEncode(msgModel.map<Map<String, dynamic>>((msg) => MessageModel.toMap(msg)));

  static List<MessageModel> decode(String msgModel) => (jsonDecode(msgModel) as List<dynamic>)
      .map<MessageModel>((item) => MessageModel.fromJson(item))
      .toList();
}
