import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageAttachmentType { image, audio, sticker }

class ChatMessageModel {
  String? text;
  late String userId;
  String? attachmentUrl;
  ChatMessageAttachmentType? attachmentType;
  Timestamp? createAt;

  ChatMessageModel({
    this.text,
    required this.userId,
    this.attachmentType,
    this.attachmentUrl,
    this.createAt,
  });

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    userId = json['userId'];
    attachmentType = json['attachmentType'];
    attachmentUrl = json['attachmentUrl'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "userId": userId,
      "attachmentType": attachmentType,
      "attachmentUrl": attachmentUrl,
      "createAt": createAt,
    };
  }
}
