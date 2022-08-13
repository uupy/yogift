class AreaVo {
  int? id;
  String? title;

  AreaVo({
    this.id,
    this.title,
  });

  AreaVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Title1'] = title;
    return data;
  }
}
