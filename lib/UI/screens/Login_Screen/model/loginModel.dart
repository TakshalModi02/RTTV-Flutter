class LoginModel{
  final String? phone_number;

  LoginModel({required this.phone_number});

  Map<String, dynamic> toJson(){
    return {
      'phone_number': phone_number
    };
  }

  LoginModel fromJson(Map<String, dynamic> map){
    return LoginModel(phone_number: map['phone_number']);
  }
}