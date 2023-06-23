import 'package:girlfriend_gpt/model/chat_gpt/request/messages.dart';

class GptRequest {
  String? model;
  List<Messages>? messages;

  GptRequest({this.model, this.messages});

  GptRequest.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
