class Maps {
  int id;
  String mapImage;
  String userId;
  Null deletedAt;

  Maps({this.id, this.mapImage, this.userId, this.deletedAt});

  Maps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mapImage = json['map_image'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['map_image'] = this.mapImage;
    data['user_id'] = this.userId;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}