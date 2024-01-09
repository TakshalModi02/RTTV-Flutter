class UserModel{
  final String? phone_number;
  final String? age;
  final String? email;
  final String? password;

  UserModel({required this.phone_number, required this.age, required this.email, required this.password});

  Map<String, dynamic> toJson(){
    return {
      'phone_number': phone_number,
      'age': age,
      'email': email,
      'password': password
    };
  }

  UserModel fromJson(Map<String, dynamic> map){
    return UserModel(phone_number: map['phone_number'], age: map['age'], email: map['email'], password: map['password']);
  }
}