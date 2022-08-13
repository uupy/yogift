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

class CheckCodeDataVo {
  String? code;
  String? phone;
  String? prefix;

  CheckCodeDataVo({
    this.code,
    this.phone,
    this.prefix,
  });

  CheckCodeDataVo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    phone = json['phone'];
    prefix = json['prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['phone'] = phone;
    data['prefix'] = prefix;
    return data;
  }
}
