class GreetingCardVo {
  String? gCGuid;
  String? title1;
  List<String>? content1;
  String? greetingCardImg;
  String? bigImg;

  GreetingCardVo({
    this.gCGuid,
    this.title1,
    this.content1,
    this.greetingCardImg,
    this.bigImg,
  });

  GreetingCardVo.fromJson(Map<String, dynamic> json) {
    gCGuid = json['GC_Guid'];
    title1 = json['Title1'];
    content1 = json['Content1'].cast<String>();
    greetingCardImg = json['GreetingCardImg'];
    bigImg = json['BigImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GC_Guid'] = gCGuid;
    data['Title1'] = title1;
    data['Content1'] = content1;
    data['GreetingCardImg'] = greetingCardImg;
    data['BigImg'] = bigImg;
    return data;
  }
}
