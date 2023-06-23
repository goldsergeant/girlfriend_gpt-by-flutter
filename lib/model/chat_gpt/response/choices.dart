import 'message.dart';

class Choices {
  int? index;
  Message? message;
  String? finishReason;

  Choices({this.index, this.message, this.finishReason});

  Choices.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    finishReason = json['finish_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['finish_reason'] = this.finishReason;
    return data;
  }
}
