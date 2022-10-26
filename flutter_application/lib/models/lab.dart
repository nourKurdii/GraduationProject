class lab {
  String name, location;
  String image;

  lab({required this.name,  required this.location, required this.image});
}

List<lab> demolab = [
  lab(
      name: "Lab name",
      location: "Lab location",
      image: "assets/images/lab1.jpg"),
  lab(
      image: "assets/images/lab1.jpg",
      name: "Lab name",
      location: "Lab location"),
  lab(
      name: "Lab name",
      location: "Lab location",
      image: "assets/images/lab1.jpg"),
  lab(
      name: "Lab name",
      location: "Lab location",
      image: "assets/images/lab1.jpg"),
];
