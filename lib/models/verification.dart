class SendDataVo {
  String? phone;
  String? prefix;

  SendDataVo({
    this.phone,
    this.prefix,
  });

  SendDataVo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    prefix = json['prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['prefix'] = prefix;
    return data;
  }
}
