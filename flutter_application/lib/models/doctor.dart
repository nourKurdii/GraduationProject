class doctor {
  String name, title;
  String image;

  doctor({required this.name, required this.title, required this.image});
}

List<doctor> demoDoctor = [
  doctor(name: "name", title: "title", image: "assets/images/main1.png"),
  doctor(image: "assets/images/main2.png", name: "name", title: "title"),
  doctor(name: "name", title: "title", image:"assets/images/main3.png"),
  doctor(name: "name", title: "title", image: "assets/images/main3.png"),
];
