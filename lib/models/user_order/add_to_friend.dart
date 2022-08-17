class AddToFriendVo {
  int? num;
  String? giftIdGuid;
  int? skuid;
  int? money;
  String? bgGive;
  String? msgGive;
  String? content2;
  int? ygcoupon1id;

  AddToFriendVo({
    this.num,
    this.giftIdGuid,
    this.skuid,
    this.money,
    this.bgGive,
    this.msgGive,
    this.content2,
    this.ygcoupon1id,
  });

  AddToFriendVo.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    giftIdGuid = json['gift_id_guid'];
    skuid = json['skuid'];
    money = json['money'];
    bgGive = json['bg_give'];
    msgGive = json['msg_give'];
    content2 = json['content2'];
    ygcoupon1id = json['ygcoupon1id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['gift_id_guid'] = giftIdGuid;
    data['skuid'] = skuid;
    data['money'] = money;
    data['bg_give'] = bgGive;
    data['msg_give'] = msgGive;
    data['content2'] = content2;
    data['ygcoupon1id'] = ygcoupon1id;
    return data;
  }
}
