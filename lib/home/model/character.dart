class Character {
  int? id;
  String? name;
  String? system;
  String? gender;
  String? image;
  String? sendUrl;

  Character(
      {this.id, this.name, this.system, this.gender, this.image, this.sendUrl});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    system = json['system'];
    gender = json['gender'];
    image = json['image'];
    sendUrl = json['send_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['system'] = this.system;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['send_url'] = this.sendUrl;
    return data;
  }
}
