class ScanModel {
  String? id;
  String? data;
  String? type;

  ScanModel({this.id, this.data, this.type});

  ScanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['data'] = this.data;
    data['type'] = type;
    return data;
  }
}
