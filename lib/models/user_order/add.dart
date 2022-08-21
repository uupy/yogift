class AddVo {
  int? num;
  String? giftIdGuid;
  int? skuid;
  double? money;
  String? content2;
  // int? ygcoupon1id;

  AddVo({
    this.num,
    this.giftIdGuid,
    this.skuid,
    this.money,
    this.content2,
    // this.ygcoupon1id,
  });

  AddVo.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    giftIdGuid = json['gift_id_guid'];
    skuid = json['skuid'];
    money = json['money'];
    content2 = json['content2'];
    // ygcoupon1id = json['ygcoupon1id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['gift_id_guid'] = giftIdGuid;
    data['skuid'] = skuid;
    data['money'] = money;
    data['content2'] = content2;
    // data['ygcoupon1id'] = ygcoupon1id;
    return data;
  }
}
