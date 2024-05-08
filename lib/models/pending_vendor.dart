class PendingVendor {
  String? id;
  String? name;
  String? email;
  String? status;
  String? role;
  String? avatar;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? mobile;
  List<String>? favoriteFoods;
  List<String>? favoriteStores;
  int? coin;
  String? createdAt;
  String? updatedAt;
  int? v;

  PendingVendor({
     this.id,
     this.name,
     this.email,
     this.status,
     this.role,
     this.avatar,
     this.gender,
     this.dateOfBirth,
     this.address,
     this.mobile,
     this.favoriteFoods,
     this.favoriteStores,
     this.coin,
     this.createdAt,
     this.updatedAt,
     this.v,
  });

  factory PendingVendor.fromJson(Map<String, dynamic> json) {
    return PendingVendor(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      role: json['role'],
      avatar: json['avatar'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      mobile: json['mobile'],
      favoriteFoods: List<String>.from(json['favoriteFoods']),
      favoriteStores: List<String>.from(json['favoriteStores']),
      coin: json['coin'],
      createdAt: (json['createdAt']),
      updatedAt: (json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'status': status,
      'role': role,
      'avatar': avatar,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'mobile': mobile,
      'favoriteFoods': favoriteFoods,
      'favoriteStores': favoriteStores,
      'coin': coin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
