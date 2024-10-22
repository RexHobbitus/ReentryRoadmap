class LoginUser {
  String? role;
  var data;

  LoginUser({this.data, this.role});

  LoginUser.empty() {}

  bool get isLoggedIn => (role != null);
}
