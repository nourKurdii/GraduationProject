class User {
  static String email = "";
  static String password = "";
  static String name = "";
  static String image = "";
  static String phone = "";
  User();

  static setEmail(String Email) {
    User.email = Email;
  }

  static setPassword(String Password) {
    User.password = Password;
  }

  static setName(String Name) {
    User.name = Name;
  }

  static setImage(String Image) {
    User.image = Image;
  }

  static setPhone(String Phone) {
    User.phone = phone;
  }

  static getEmail() {
    return email;
  }

  static getName() {
    return name;
  }

  static getPassword() {
    return password;
  }

  static getImage() {
    return image;
  }

  static getPhone() {
    return phone;
  }
}
