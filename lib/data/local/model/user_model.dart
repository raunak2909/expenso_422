class UserModel {
  int? id;
  String name;
  String email;
  String mobNo;
  String pass;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.mobNo,
    required this.pass
  });
}
