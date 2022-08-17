class AddForRequestVo {
  String? requestGuid;
  int? money;
  String? bgGive;
  String? msgGive;
  String? content2;
  int? ygcoupon1id;

  AddForRequestVo(
      {this.requestGuid,
      this.money,
      this.bgGive,
      this.msgGive,
      this.content2,
      this.ygcoupon1id});

  AddForRequestVo.fromJson(Map<String, dynamic> json) {
    requestGuid = json['request_guid'];
    money = json['money'];
    bgGive = json['bg_give'];
    msgGive = json['msg_give'];
    content2 = json['content2'];
    ygcoupon1id = json['ygcoupon1id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_guid'] = requestGuid;
    data['money'] = money;
    data['bg_give'] = bgGive;
    data['msg_give'] = msgGive;
    data['content2'] = content2;
    data['ygcoupon1id'] = ygcoupon1id;
    return data;
  }
}
