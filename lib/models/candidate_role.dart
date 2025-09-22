class CandidateRole {
  bool? success;
  String? message;
  List<CandidateRoleData>? data;

  CandidateRole({this.success, this.message, this.data});

  CandidateRole.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CandidateRoleData>[];
      json['data'].forEach((v) {
        data!.add(new CandidateRoleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CandidateRoleData {
  String? sId;
  String? role;
  List<String>? permissions;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CandidateRoleData(
      {this.sId,
      this.role,
      this.permissions,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CandidateRoleData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    permissions = json['permissions'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['permissions'] = this.permissions;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
