class GetMyContentVo {
  String? type;
  String? content;
  GetMyContentVo({this.type, this.content});
  GetMyContentVo.fromJson(Map<String, dynamic> json) {
    type = json['Type1'];
    content = json['Content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type1'] = type;
    data['Content'] = content;
    return data;
  }
}
