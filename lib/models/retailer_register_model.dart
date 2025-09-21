class RetailerRegisterModel {
  String? message;
  NewUser? newUser;
  String? token;

  RetailerRegisterModel({this.message, this.newUser, this.token});

  RetailerRegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    newUser =
    json['newUser'] != null ? new NewUser.fromJson(json['newUser']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.newUser != null) {
      data['newUser'] = this.newUser!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class NewUser {
  String? distributorId;
  String? name;
  String? email;
  List<Null>? shopPhoto;
  Plan? plan;
  Address? address;
  List<Null>? directorKycFiles;
  List<Null>? extraPermissions;
  List<Null>? restrictedPermissions;
  String? pinCode;
  bool? isSpecial;
  List<Null>? documents;
  int? mpin;
  String? mobileNumber;
  bool? isKycVerified;
  bool? isVideoKyc;
  bool? agreement;
  String? role;
  bool? status;
  int? cappingMoney;
  int? mainWallet;
  int? eWallet;
  String? sId;
  List<Null>? references;
  List<Null>? planHistory;
  List<Null>? questions;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  NewUser(
      {this.distributorId,
        this.name,
        this.email,
        this.shopPhoto,
        this.plan,
        this.address,
        this.directorKycFiles,
        this.extraPermissions,
        this.restrictedPermissions,
        this.pinCode,
        this.isSpecial,
        this.documents,
        this.mpin,
        this.mobileNumber,
        this.isKycVerified,
        this.isVideoKyc,
        this.agreement,
        this.role,
        this.status,
        this.cappingMoney,
        this.mainWallet,
        this.eWallet,
        this.sId,
        this.references,
        this.planHistory,
        this.questions,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.id});

  NewUser.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributorId'];
    name = json['name'];
    email = json['email'];
    if (json['shopPhoto'] != null) {
      shopPhoto = <Null>[];
      // json['shopPhoto'].forEach((v) {
      //   shopPhoto!.add(new Null.fromJson(v));
      // });
    }
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['directorKycFiles'] != null) {
      directorKycFiles = <Null>[];
      // json['directorKycFiles'].forEach((v) {
      //   directorKycFiles!.add(new Null.fromJson(v));
      // });
    }
    if (json['extraPermissions'] != null) {
      extraPermissions = <Null>[];
      // json['extraPermissions'].forEach((v) {
      //   extraPermissions!.add(new Null.fromJson(v));
      // });
    }
    if (json['restrictedPermissions'] != null) {
      restrictedPermissions = <Null>[];
      // json['restrictedPermissions'].forEach((v) {
      //   restrictedPermissions!.add(new Null.fromJson(v));
      // });
    }
    pinCode = json['pinCode'];
    isSpecial = json['isSpecial'];
    if (json['documents'] != null) {
      documents = <Null>[];
      // json['documents'].forEach((v) {
      //   documents!.add(new Null.fromJson(v));
      // });
    }
    mpin = json['mpin'];
    mobileNumber = json['mobileNumber'];
    isKycVerified = json['isKycVerified'];
    isVideoKyc = json['isVideoKyc'];
    agreement = json['agreement'];
    role = json['role'];
    status = json['status'];
    cappingMoney = json['cappingMoney'];
    mainWallet = json['mainWallet'];
    eWallet = json['eWallet'];
    sId = json['_id'];
    if (json['references'] != null) {
      references = <Null>[];
      // json['references'].forEach((v) {
      //   references!.add(new Null.fromJson(v));
      // });
    }
    if (json['planHistory'] != null) {
      planHistory = <Null>[];
      // json['planHistory'].forEach((v) {
      //   planHistory!.add(new Null.fromJson(v));
      // });
    }
    if (json['questions'] != null) {
      questions = <Null>[];
      // json['questions'].forEach((v) {
      //   questions!.add(new Null.fromJson(v));
      // });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distributorId'] = this.distributorId;
    data['name'] = this.name;
    data['email'] = this.email;
    // if (this.shopPhoto != null) {
    //   data['shopPhoto'] = this.shopPhoto!.map((v) => v.toJson()).toList();
    // }
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    // if (this.directorKycFiles != null) {
    //   data['directorKycFiles'] =
    //       this.directorKycFiles!.map((v) => v.toJson()).toList();
    // }
    // if (this.extraPermissions != null) {
    //   data['extraPermissions'] =
    //       this.extraPermissions!.map((v) => v.toJson()).toList();
    // }
    // if (this.restrictedPermissions != null) {
    //   data['restrictedPermissions'] =
    //       this.restrictedPermissions!.map((v) => v.toJson()).toList();
    // }
    data['pinCode'] = this.pinCode;
    data['isSpecial'] = this.isSpecial;
    // if (this.documents != null) {
    //   data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    // }
    data['mpin'] = this.mpin;
    data['mobileNumber'] = this.mobileNumber;
    data['isKycVerified'] = this.isKycVerified;
    data['isVideoKyc'] = this.isVideoKyc;
    data['agreement'] = this.agreement;
    data['role'] = this.role;
    data['status'] = this.status;
    data['cappingMoney'] = this.cappingMoney;
    data['mainWallet'] = this.mainWallet;
    data['eWallet'] = this.eWallet;
    data['_id'] = this.sId;
    // if (this.references != null) {
    //   data['references'] = this.references!.map((v) => v.toJson()).toList();
    // }
    // if (this.planHistory != null) {
    //   data['planHistory'] = this.planHistory!.map((v) => v.toJson()).toList();
    // }
    // if (this.questions != null) {
    //   data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class Plan {
  Null? planId;
  Null? planType;
  Null? startDate;
  Null? endDate;

  Plan({this.planId, this.planType, this.startDate, this.endDate});

  Plan.fromJson(Map<String, dynamic> json) {
    planId = json['planId'];
    planType = json['planType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planId'] = this.planId;
    data['planType'] = this.planType;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class Address {
  String? country;

  Address({this.country});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    return data;
  }
}
