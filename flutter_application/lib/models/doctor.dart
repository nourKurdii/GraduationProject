class doctor {
  String id = "";
  String name = "";
  String email = "";
  String title = "";
  String phone = "";
  List ? unavailable ;

  doctor(
      this.id, this.name, this.email, this.phone, this.title, this.unavailable);
  doctor.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    title = json['title'];
    email = json['email'];
    unavailable = json['unAvailableTime'].cast<String>();
  }
}
