part of flutter_openim_sdk_ffi;

/// 部门信息
class DeptInfo {
  /// 部门id
  String? departmentID;

  /// 头像
  String? faceURL;

  /// 显示名
  String? name;

  /// 上一级部门id
  String? parentID;

  /// 排序方式
  int? order;

  /// 部门类型
  int? departmentType;

  /// 创建时间
  int? createTime;

  /// 子部门数量
  int? subDepartmentNum;

  /// 成员数量
  int? memberNum;

  /// 扩展字段
  String? ex;

  /// 附加信息
  String? attachedInfo;

  String? relatedGroupID;

  DeptInfo(
      {this.departmentID,
      this.faceURL,
      this.name,
      this.parentID,
      this.order,
      this.departmentType,
      this.createTime,
      this.subDepartmentNum,
      this.memberNum,
      this.ex,
      this.attachedInfo,
      this.relatedGroupID});

  DeptInfo.fromJson(Map<String, dynamic> json) {
    departmentID = json['departmentID'];
    faceURL = json['faceURL'];
    name = json['name'];
    parentID = json['parentID'];
    order = json['order'];
    departmentType = json['departmentType'];
    createTime = json['createTime'];
    subDepartmentNum = json['subDepartmentNum'];
    memberNum = json['memberNum'];
    ex = json['ex'];
    attachedInfo = json['attachedInfo'];
    relatedGroupID = json['relatedGroupID'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['departmentID'] = departmentID;
    data['faceURL'] = faceURL;
    data['name'] = name;
    data['parentID'] = parentID;
    data['order'] = order;
    data['departmentType'] = departmentType;
    data['createTime'] = createTime;
    data['subDepartmentNum'] = subDepartmentNum;
    data['memberNum'] = memberNum;
    data['ex'] = ex;
    data['attachedInfo'] = attachedInfo;
    data['relatedGroupID'] = relatedGroupID;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DeptInfo && runtimeType == other.runtimeType && departmentID == other.departmentID;

  @override
  int get hashCode => departmentID.hashCode;
}

/// 部门成员信息
class DeptMemberInfo {
  /// 用户id
  String? userID;

  /// 用户昵称
  String? nickname;

  /// 英文名
  String? englishName;

  /// 头像
  String? faceURL;

  /// 性别
  int? gender;

  /// 手机号
  String? mobile;

  /// 座机
  String? telephone;

  /// 出生时间
  int? birth;

  /// 邮箱
  String? email;

  /// 所在部门的id
  String? departmentID;

  /// 排序方式
  int? order;

  /// 职位
  String? position;

  /// 是否是领导
  int? leader;

  /// 状态
  int? status;

  /// 创建时间
  int? createTime;

  /// 入职时间
  int? entryTime;

  /// 离职时间
  int? terminationTime;

  /// 扩展字段
  String? ex;

  /// 附加信息
  String? attachedInfo;

  /// 搜索时使用
  String? departmentName;

  /// 所在部门的所有上级部门
  List<DeptInfo>? parentDepartmentList;

  /// 当前部门信息
  DeptInfo? department;

  DeptMemberInfo({
    this.userID,
    this.nickname,
    this.englishName,
    this.faceURL,
    this.gender,
    this.mobile,
    this.telephone,
    this.birth,
    this.email,
    this.departmentID,
    this.order,
    this.position,
    this.leader,
    this.status,
    this.createTime,
    this.ex,
    this.attachedInfo,
    this.departmentName,
    this.parentDepartmentList,
    this.department,
  });

  DeptMemberInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nickname = json['nickname'];
    englishName = json['englishName'];
    faceURL = json['faceURL'];
    gender = json['gender'];
    mobile = json['mobile'];
    telephone = json['telephone'];
    birth = json['birth'];
    email = json['email'];
    departmentID = json['departmentID'];
    order = json['order'];
    position = json['position'];
    leader = json['leader'];
    status = json['status'];
    createTime = json['createTime'];
    ex = json['ex'];
    attachedInfo = json['attachedInfo'];
    departmentName = json['departmentName'];
    if (json['parentDepartmentList'] != null) {
      parentDepartmentList = <DeptInfo>[];
      json['parentDepartmentList'].forEach((v) {
        parentDepartmentList!.add(DeptInfo.fromJson(v));
      });
    }
    department = json['department'] == null ? null : DeptInfo.fromJson(json['department']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['nickname'] = nickname;
    data['englishName'] = englishName;
    data['faceURL'] = faceURL;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['telephone'] = telephone;
    data['birth'] = birth;
    data['email'] = email;
    data['departmentID'] = departmentID;
    data['order'] = order;
    data['position'] = position;
    data['leader'] = leader;
    data['status'] = status;
    data['createTime'] = createTime;
    data['ex'] = ex;
    data['attachedInfo'] = attachedInfo;
    data['departmentName'] = departmentName;
    if (parentDepartmentList != null) {
      data['parentDepartmentList'] = parentDepartmentList!.map((v) => v.toJson()).toList();
    }
    data['department'] = department?.toJson();
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DeptMemberInfo && runtimeType == other.runtimeType && userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}

/// 用户所在的部门
class UserInDept {
  /// 部门信息
  DeptInfo? department;

  /// 所在部门自己的信息
  DeptMemberInfo? member;

  UserInDept({this.department, this.member});

  UserInDept.fromJson(Map<String, dynamic> json) {
    department = json['department'] != null ? DeptInfo.fromJson(json['department']) : null;
    member = json['member'] != null ? DeptMemberInfo.fromJson(json['member']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (department != null) {
      data['department'] = department!.toJson();
    }
    if (member != null) {
      data['member'] = member!.toJson();
    }
    return data;
  }
}

/// 部门下的一级子部门跟员工
class DeptMemberAndSubDept {
  /// 一级子部门
  List<DeptInfo>? departmentList;

  /// 一级成员
  List<DeptMemberInfo>? departmentMemberList;

  /// 当前部门的所有上一级部门
  List<DeptInfo>? parentDepartmentList;

  DeptMemberAndSubDept({
    this.departmentList,
    this.departmentMemberList,
    this.parentDepartmentList,
  });

  DeptMemberAndSubDept.fromJson(Map<String, dynamic> json) {
    if (json['departmentList'] != null) {
      departmentList = <DeptInfo>[];
      json['departmentList'].forEach((v) {
        departmentList!.add(DeptInfo.fromJson(v));
      });
    }
    if (json['departmentMemberList'] != null) {
      departmentMemberList = <DeptMemberInfo>[];
      json['departmentMemberList'].forEach((v) {
        departmentMemberList!.add(DeptMemberInfo.fromJson(v));
      });
    }
    if (json['parentDepartmentList'] != null) {
      parentDepartmentList = <DeptInfo>[];
      json['parentDepartmentList'].forEach((v) {
        parentDepartmentList!.add(DeptInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (departmentList != null) {
      data['departmentList'] = departmentList!.map((v) => v.toJson()).toList();
    }
    if (departmentMemberList != null) {
      data['departmentMemberList'] = departmentMemberList!.map((v) => v.toJson()).toList();
    }
    if (parentDepartmentList != null) {
      data['parentDepartmentList'] = parentDepartmentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// 搜索结果
class OrganizationSearchResult {
  /// 部门列表
  List<DeptInfo>? departmentList;

  /// 部门成员列表
  List<DeptMemberInfo>? departmentMemberList;

  OrganizationSearchResult({
    this.departmentList,
    this.departmentMemberList,
  });

  OrganizationSearchResult.fromJson(Map<String, dynamic> json) {
    if (json['departmentList'] != null) {
      departmentList = <DeptInfo>[];
      json['departmentList'].forEach((v) {
        departmentList!.add(DeptInfo.fromJson(v));
      });
    }
    if (json['departmentMemberList'] != null) {
      departmentMemberList = <DeptMemberInfo>[];
      json['departmentMemberList'].forEach((v) {
        departmentMemberList!.add(DeptMemberInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (departmentList != null) {
      data['departmentList'] = departmentList!.map((v) => v.toJson()).toList();
    }
    if (departmentMemberList != null) {
      data['departmentMemberList'] = departmentMemberList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
