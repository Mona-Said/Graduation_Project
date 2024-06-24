class SellerAboutAppModel {
  int? status;
  String? message;
  List<Data>? data;

  SellerAboutAppModel({this.status, this.message, this.data});

  SellerAboutAppModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? copyright;
  String? description;
  Null phone;
  String? infoEmail;
  String? withdrawalEmail;
  String? supportEmail;
  String? logo;
  String? favicon;
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtupe;
  String? tiktok;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.title,
        this.copyright,
        this.description,
        this.phone,
        this.infoEmail,
        this.withdrawalEmail,
        this.supportEmail,
        this.logo,
        this.favicon,
        this.facebook,
        this.twitter,
        this.instagram,
        this.youtupe,
        this.tiktok,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    copyright = json['copyright'];
    description = json['description'];
    phone = json['phone'];
    infoEmail = json['info_email'];
    withdrawalEmail = json['withdrawal_email'];
    supportEmail = json['support_email'];
    logo = json['logo'];
    favicon = json['favicon'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    youtupe = json['youtupe'];
    tiktok = json['tiktok'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['copyright'] = this.copyright;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['info_email'] = this.infoEmail;
    data['withdrawal_email'] = this.withdrawalEmail;
    data['support_email'] = this.supportEmail;
    data['logo'] = this.logo;
    data['favicon'] = this.favicon;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['youtupe'] = this.youtupe;
    data['tiktok'] = this.tiktok;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
