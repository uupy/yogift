class PhonePasswordVo {
  String? password;
  String? phone;
  String? phoneprefix;

  PhonePasswordVo({
    this.password,
    this.phone,
    this.phoneprefix,
  });

  PhonePasswordVo.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['phone'] = phone;
    data['phoneprefix'] = phoneprefix;
    return data;
  }
}

class PhoneCodeVo {
  String? code;
  String? phone;
  String? phoneprefix;
  String? regfrom;

  PhoneCodeVo({
    this.code,
    this.phone,
    this.phoneprefix,
    this.regfrom,
  });

  PhoneCodeVo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
    regfrom = json['regfrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['phone'] = phone;
    data['phoneprefix'] = phoneprefix;
    data['regfrom'] = regfrom;
    return data;
  }
}

class EmailPasswordVo {
  String? password;
  String? email;

  EmailPasswordVo({
    this.password,
    this.email,
  });

  EmailPasswordVo.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['email'] = email;
    return data;
  }
}

class ModifyPwdFormVo {
  String? newpassword;
  String? oldpassword;

  ModifyPwdFormVo({this.newpassword, this.oldpassword});

  ModifyPwdFormVo.fromJson(Map<String, dynamic> json) {
    newpassword = json['newpassword'];
    oldpassword = json['oldpassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newpassword'] = newpassword;
    data['oldpassword'] = oldpassword;
    return data;
  }
}

class RegisterFormVo {
  String? phone;
  String? phoneprefix;
  String? password;
  String? code;
  String? introducer;
  int? acceptnotice;
  String? recommendationcode;
  String? gener;
  String? birthday;

  RegisterFormVo({
    this.phone,
    this.phoneprefix,
    this.password,
    this.code,
    this.introducer,
    this.acceptnotice,
    this.recommendationcode,
    this.gener,
    this.birthday,
  });

  RegisterFormVo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
    password = json['password'];
    code = json['code'];
    introducer = json['introducer'];
    acceptnotice = json['acceptnotice'];
    recommendationcode = json['recommendationcode'];
    gener = json['gener'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['phoneprefix'] = phoneprefix;
    data['password'] = password;
    data['code'] = code;
    data['introducer'] = introducer;
    data['acceptnotice'] = acceptnotice;
    data['recommendationcode'] = recommendationcode;
    data['gener'] = gener;
    data['birthday'] = birthday;
    return data;
  }
}
