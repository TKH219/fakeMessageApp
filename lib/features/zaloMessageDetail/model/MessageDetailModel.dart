


import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageItemModel.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MessageDetailModel extends Object {
  String receiverName;
  String lastTimeOnline;
  String receiverAvatar;
  List<MessageItemModel> contents;

  MessageDetailModel(this.receiverName, this.lastTimeOnline, this.receiverAvatar, this.contents);
}