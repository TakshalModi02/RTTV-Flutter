class userModel{
  final String? phone_number;
  final String? age;
  final String? email;
  final String? otp;

  userModel({required this.phone_number, required this.age, required this.email, required this.otp});

  Map<String, dynamic> toJson(){
    return {
      'phone_number': phone_number,
      'age': age,
      'email': email,
      'otp': otp
    };
  }

  userModel fromJson(Map<String, dynamic> map){
    return userModel(phone_number: map['phone_number'], age: map['age'], email: map['email'], otp: map['otp']);
  }
}