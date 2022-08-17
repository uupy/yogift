class PayTypeVo {
  String? title;
  String? desc;
  String? key;
  String? icon;

  PayTypeVo({this.title, this.desc, this.key, this.icon});

  PayTypeVo.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    desc = json['Desc'];
    key = json['Key'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Desc'] = desc;
    data['Key'] = key;
    data['Icon'] = icon;
    return data;
  }
}
