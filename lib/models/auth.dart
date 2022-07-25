class LoginFormDataVo {
  String? code;
  String? password;
  String? phone;
  String? phoneprefix;
  String? regfrom;

  LoginFormDataVo({
    this.code,
    this.password,
    this.phone,
    this.phoneprefix,
    this.regfrom,
  });

  LoginFormDataVo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    password = json['password'];
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
    regfrom = json['regfrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['password'] = password;
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

class UserVo {
  String? avatar;
  String? clientId;
  String? idNumber;
  List<String>? permissionCodes;
  String? realName;
  List<String>? roleCodes;
  String? systemId;
  String? telephone;
  String? userId;
  String? username;

  UserVo({
    this.avatar,
    this.clientId,
    this.idNumber,
    this.permissionCodes,
    this.realName,
    this.roleCodes,
    this.systemId,
    this.telephone,
    this.userId,
    this.username,
  });

  UserVo.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    clientId = json['clientId'];
    idNumber = json['idNumber'];
    permissionCodes = json['permissionCodes'].cast<String>();
    realName = json['realName'];
    roleCodes = json['roleCodes'].cast<String>();
    systemId = json['systemId'];
    telephone = json['telephone'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['clientId'] = clientId;
    data['idNumber'] = idNumber;
    data['permissionCodes'] = permissionCodes;
    data['realName'] = realName;
    data['roleCodes'] = roleCodes;
    data['systemId'] = systemId;
    data['telephone'] = telephone;
    data['userId'] = userId;
    data['username'] = username;
    return data;
  }
}
