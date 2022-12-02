class labModel {
  String id = "";
  List<String> test = [];
  String name = "";
  String? location;
  String? image;
  String? email;
  bool? homeVisit;
  double? latitude;
  double? longitude;
  String? password;
  int? rating;
  String? about;
  String? closeTime;
  String? openTime;
  String? ownerName;
  String? phone;

  labModel(
      {required this.test,
      required this.name,
      required this.id,
      this.location,
      this.image,
      this.email,
      this.homeVisit,
      this.latitude,
      this.longitude,
      this.password,
      this.rating,
      this.about,
      this.closeTime,
      this.openTime,
      this.ownerName,
      this.phone});

  labModel.fromJson(Map<String, dynamic> json) {
    test = json['test'].cast<String>();
    name = json['name'];
    location = json['location'];
    image = json['image'];
    email = json['email'];
    homeVisit = json['homeVisit'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    password = json['password'];
    rating = json['rating'];
    about = json['about'];
    closeTime = json['closeTime'];
    openTime = json['openTime'];
    ownerName = json['ownerName'];
    phone = json['phone'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test'] = this.test;
    data['name'] = this.name;
    data['location'] = this.location;
    data['image'] = this.image;
    data['email'] = this.email;
    data['homeVisit'] = this.homeVisit;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['password'] = this.password;
    data['rating'] = this.rating;
    data['about'] = this.about;
    data['closeTime'] = this.closeTime;
    data['openTime'] = this.openTime;
    data['ownerName'] = this.ownerName;
    data['phone'] = this.phone;
    return data;
  }
}
