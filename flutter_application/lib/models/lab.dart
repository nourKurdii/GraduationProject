class lab {
  String? id;
  String name = "";
  String email = "";
  String openTime = "";
  double latitude = 0.0;
  double longitude = 0.0;
  int rating = 0;
  String location = "";
  String ownerName = "";
  String about = "";
  List? test;
  bool homeVisit = false;
  String closeTime = "";
  String phone = "";

  lab(
      this.id,
      this.name,
      this.email,
      this.latitude,
      this.longitude,
      this.rating,
      this.test,
      this.openTime,
      this.ownerName,
      this.closeTime,
      this.about,
      this.homeVisit);
  lab.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    about = json['about'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    ownerName = json['ownerName'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    email = json['email'];
  }
}
