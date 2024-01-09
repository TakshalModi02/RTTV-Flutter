class userModel{
  final String? phone_number;
  final String? email;
  final String? password;

  userModel({required this.phone_number, required this.email, required this.password});

  Map<String, dynamic> toJson(){
    return {
      'phone_number': phone_number,
      'email': email,
      'password': password
    };
  }

  userModel fromJson(Map<String, dynamic> map){
    return userModel(phone_number: map['phone_number'], email: map['email'], password: map['password']);
  }
}