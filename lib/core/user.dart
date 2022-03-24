class User{
  final String __name;
  final String __phone; 
  final String __email;
  final String __password; 
  final String __photo;

  User (
    {required String name ,
    required String phone,
    required String email,
    required String password,
    String? photo})
    :__name = name,
    __phone = phone,
    __email = email,
    __password = password,
    __photo = photo!;

  factory User.fromJSON(Map<String, dynamic> json) => User(
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    photo: json['photo'] as String);

  String getName() => __name;
  String getPhone() => __phone;
  String getEmail() => __email;
  String getPassword() => __password;
  String getPhoto() => __photo; 
  
}