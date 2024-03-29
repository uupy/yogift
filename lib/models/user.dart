class LoginFormDataVo {
  String? code;
  String? phone;
  String? phoneprefix;
  String? regfrom;
  String? password;

  LoginFormDataVo({
    this.code,
    this.phone,
    this.phoneprefix,
    this.regfrom,
    this.password,
  });

  LoginFormDataVo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
    regfrom = json['regfrom'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['phone'] = phone;
    data['phoneprefix'] = phoneprefix;
    data['regfrom'] = regfrom;
    data['password'] = password;
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

class ResetPwdFormVo {
  String? code;
  String? password;
  String? phone;
  String? phoneprefix;

  ResetPwdFormVo({
    this.code,
    this.password,
    this.phone,
    this.phoneprefix,
  });

  ResetPwdFormVo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    password = json['password'];
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['password'] = password;
    data['phone'] = phone;
    data['phoneprefix'] = phoneprefix;
    return data;
  }
}

class SetPhoneFormVo {
  String? code;
  String? operationcode;
  String? phone;
  String? phoneprefix;

  SetPhoneFormVo({
    this.code,
    this.operationcode,
    this.phone,
    this.phoneprefix,
  });

  SetPhoneFormVo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    operationcode = json['operationcode'];
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['operationcode'] = operationcode;
    data['phone'] = phone;
    data['phoneprefix'] = phoneprefix;
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
    this.password = '',
    this.code = '',
    this.introducer = '',
    this.acceptnotice,
    this.recommendationcode = '',
    this.gener,
    this.birthday = '',
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

class UpdateInfoFormVo {
  int? acceptnotice;
  int? gener;
  String? email;
  String? birthday;
  String? nickname;

  UpdateInfoFormVo({
    this.acceptnotice,
    this.gener,
    this.email,
    this.birthday,
    this.nickname,
  });

  UpdateInfoFormVo.fromJson(Map<String, dynamic> json) {
    acceptnotice = json['acceptnotice'];
    gener = json['gener'];
    email = json['email'];
    birthday = json['birthday'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acceptnotice'] = acceptnotice;
    data['gener'] = gener;
    data['email'] = email;
    data['birthday'] = birthday;
    data['nickname'] = nickname;
    return data;
  }
}

class AuthDataVo {
  String? accessToken;
  String? refreshToken;
  int? accessTokenExpires;
  int? refreshTokenExpires;

  AuthDataVo({
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpires,
    this.refreshTokenExpires,
  });

  AuthDataVo.fromJson(Map<String, dynamic> json) {
    accessToken = json['AccessToken'];
    refreshToken = json['RefreshToken'];
    accessTokenExpires = json['AccessTokenExpires'];
    refreshTokenExpires = json['RefreshTokenExpires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccessToken'] = accessToken;
    data['RefreshToken'] = refreshToken;
    data['AccessTokenExpires'] = accessTokenExpires;
    data['RefreshTokenExpires'] = refreshTokenExpires;
    return data;
  }
}

class UserInfoVo {
  String? id;
  String? wGuid;
  String? phonePrefix;
  String? phone;
  String? headSrc;
  String? nickName;
  int? gener;
  String? birthday;
  String? email;
  int? acceptNotice;
  int? area0Id;
  int? area1Id;
  String? area0;
  String? area1;
  int? favoriteOpen;
  int? jifen;
  int? isEnable;

  UserInfoVo(
      {this.id,
      this.wGuid,
      this.phonePrefix,
      this.phone,
      this.headSrc,
      this.nickName,
      this.gener,
      this.birthday,
      this.email,
      this.acceptNotice,
      this.area0Id,
      this.area1Id,
      this.area0,
      this.area1,
      this.favoriteOpen,
      this.jifen,
      this.isEnable});

  UserInfoVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    wGuid = json['W_Guid'];
    phonePrefix = json['PhonePrefix'];
    phone = json['Phone'];
    headSrc = json['Head_Src'];
    nickName = json['NickName'];
    gener = json['Gener'];
    birthday = json['Birthday'];
    email = json['Email'];
    acceptNotice = json['AcceptNotice'];
    area0Id = json['Area0_id'];
    area1Id = json['Area1_id'];
    area0 = json['Area0'];
    area1 = json['Area1'];
    favoriteOpen = json['Favorite_open'];
    jifen = json['Jifen'];
    isEnable = json['IsEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['W_Guid'] = wGuid;
    data['PhonePrefix'] = phonePrefix;
    data['Phone'] = phone;
    data['Head_Src'] = headSrc;
    data['NickName'] = nickName;
    data['Gener'] = gener;
    data['Birthday'] = birthday;
    data['Email'] = email;
    data['AcceptNotice'] = acceptNotice;
    data['Area0_id'] = area0Id;
    data['Area1_id'] = area1Id;
    data['Area0'] = area0;
    data['Area1'] = area1;
    data['Favorite_open'] = favoriteOpen;
    data['Jifen'] = jifen;
    data['IsEnable'] = isEnable;
    return data;
  }
}
