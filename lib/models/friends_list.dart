class IntroducerVo {
  String? id;
  String? wGuid;
  String? phone;
  String? phonePrefix;
  String? nickName;
  String? createUserTime;
  int? jifen;

  IntroducerVo(
      {this.id,
      this.wGuid,
      this.phone,
      this.phonePrefix,
      this.nickName,
      this.createUserTime,
      this.jifen});

  IntroducerVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    wGuid = json['W_Guid'];
    phone = json['Phone'];
    phonePrefix = json['PhonePrefix'];
    nickName = json['NickName'];
    createUserTime = json['CreateUserTime'];
    jifen = json['Jifen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['W_Guid'] = wGuid;
    data['Phone'] = phone;
    data['PhonePrefix'] = phonePrefix;
    data['NickName'] = nickName;
    data['CreateUserTime'] = createUserTime;
    data['Jifen'] = jifen;
    return data;
  }
}

class FriendVo {
  int? id;
  int? friendId;
  String? friendNickName;
  String? friendPhone;
  String? friendPhonePrefix;
  String? friendHeadSrc;
  String? msgContent;
  String? msgCreateTime;
  int? giveN;
  int? showStar;
  int? operateByUserId;

  FriendVo(
      {this.id,
      this.friendId,
      this.friendNickName,
      this.friendPhone,
      this.friendPhonePrefix,
      this.friendHeadSrc,
      this.msgContent,
      this.msgCreateTime,
      this.giveN,
      this.showStar,
      this.operateByUserId});

  FriendVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    friendId = json['Friend_id'];
    friendNickName = json['Friend_NickName'];
    friendPhone = json['Friend_Phone'];
    friendPhonePrefix = json['Friend_PhonePrefix'];
    friendHeadSrc = json['Friend_Head_Src'];
    msgContent = json['MsgContent'];
    msgCreateTime = json['MsgCreateTime'];
    giveN = json['give_n'];
    showStar = json['ShowStar'];
    operateByUserId = json['Operate_By_UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Friend_id'] = friendId;
    data['Friend_NickName'] = friendNickName;
    data['Friend_Phone'] = friendPhone;
    data['Friend_PhonePrefix'] = friendPhonePrefix;
    data['Friend_Head_Src'] = friendHeadSrc;
    data['MsgContent'] = msgContent;
    data['MsgCreateTime'] = msgCreateTime;
    data['give_n'] = giveN;
    data['ShowStar'] = showStar;
    data['Operate_By_UserId'] = operateByUserId;
    return data;
  }
}

class FriendMsgVo {
  String? id;
  int? friendId;
  String? friendNickName;
  String? friendPhone;
  String? friendPhonePrefix;
  String? friendHeadSrc;
  String? msgContent;
  int? msgType;
  int? msgEventId;
  int? isRead;
  int? operateByUserId;
  String? createTime;
  String? giftName;
  String? gGuid;
  String? cCoverImg;

  FriendMsgVo(
      {this.id,
      this.friendId,
      this.friendNickName,
      this.friendPhone,
      this.friendPhonePrefix,
      this.friendHeadSrc,
      this.msgContent,
      this.msgType,
      this.msgEventId,
      this.isRead,
      this.operateByUserId,
      this.createTime,
      this.giftName,
      this.gGuid,
      this.cCoverImg});

  FriendMsgVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    friendId = json['Friend_id'];
    friendNickName = json['Friend_NickName'];
    friendPhone = json['Friend_Phone'];
    friendPhonePrefix = json['Friend_PhonePrefix'];
    friendHeadSrc = json['Friend_Head_Src'];
    msgContent = json['MsgContent'];
    msgType = json['MsgType'];
    msgEventId = json['MsgEventId'];
    isRead = json['IsRead'];
    operateByUserId = json['Operate_By_UserId'];
    createTime = json['CreateTime'];
    giftName = json['GiftName'];
    gGuid = json['G_Guid'];
    cCoverImg = json['C_CoverImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Friend_id'] = friendId;
    data['Friend_NickName'] = friendNickName;
    data['Friend_Phone'] = friendPhone;
    data['Friend_PhonePrefix'] = friendPhonePrefix;
    data['Friend_Head_Src'] = friendHeadSrc;
    data['MsgContent'] = msgContent;
    data['MsgType'] = msgType;
    data['MsgEventId'] = msgEventId;
    data['IsRead'] = isRead;
    data['Operate_By_UserId'] = operateByUserId;
    data['CreateTime'] = createTime;
    data['GiftName'] = giftName;
    data['G_Guid'] = gGuid;
    data['C_CoverImg'] = cCoverImg;
    return data;
  }
}
