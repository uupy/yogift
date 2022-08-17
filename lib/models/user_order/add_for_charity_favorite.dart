class AddForCharityFavoriteVo {
  String? charityfavoritesIdGuid;
  double? money;
  String? bgGive;
  String? msgGive;
  int? num;
  int? skuid;
  String? content2;
  int? ygcoupon1id;

  AddForCharityFavoriteVo(
      {this.charityfavoritesIdGuid,
      this.money,
      this.bgGive,
      this.msgGive,
      this.num,
      this.skuid,
      this.content2,
      this.ygcoupon1id});

  AddForCharityFavoriteVo.fromJson(Map<String, dynamic> json) {
    charityfavoritesIdGuid = json['charityfavorites_id_guid'];
    money = json['money'];
    bgGive = json['bg_give'];
    msgGive = json['msg_give'];
    num = json['num'];
    skuid = json['skuid'];
    content2 = json['content2'];
    ygcoupon1id = json['ygcoupon1id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['charityfavorites_id_guid'] = charityfavoritesIdGuid;
    data['money'] = money;
    data['bg_give'] = bgGive;
    data['msg_give'] = msgGive;
    data['num'] = num;
    data['skuid'] = skuid;
    data['content2'] = content2;
    data['ygcoupon1id'] = ygcoupon1id;
    return data;
  }
}
