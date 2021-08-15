import 'package:json_annotation/json_annotation.dart';

import 'MessageItemModel.dart';

@JsonSerializable()
class MessageDetailModel extends Object {
  String receiverName;
  String lastTimeOnline;
  String? receiverAvatar;
  List<MessageItemModel> contents = [];

  MessageDetailModel(
      {this.receiverName = "Mr. X",
      this.lastTimeOnline = 'Just now',
      this.receiverAvatar,
      this.contents = const<MessageItemModel>[]}) {
    this.contents = [];
  }
}