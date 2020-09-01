class Rule {
  int id;
  String rule;
  String createdAt;
  String updatedAt;

  Rule({this.id, this.rule, this.createdAt, this.updatedAt});

  Rule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rule = json['rule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}