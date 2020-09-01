class Update {
  int id;
  String update;
  String createdAt;
  String updatedAt;

  Update({this.id, this.update, this.createdAt, this.updatedAt});

  Update.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    update = json['update'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}