class GptResponse {
  String? id;
  String? object;
  int? created;
  List<Choices>? choices;
  Usage? usage;

  GptResponse({this.id, this.object, this.created, this.choices, this.usage});

  GptResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? new Usage.fromJson(json['usage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['created'] = this.created;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    if (this.usage != null) {
      data['usage'] = this.usage!.toJson();
    }
    return data;
  }
}
