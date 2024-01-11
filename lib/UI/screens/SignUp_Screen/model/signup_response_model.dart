class SignUpResponseModel{
  int? code;
  String? status;
  String? message;
  Map<String, dynamic>? user;

  SignUpResponseModel(Map<String, dynamic> map){
    code = map['code'];
    status = map['status'];
    message = map['message'];
    user = map['user'];
  }

  Map<String, dynamic> toJson(){
    return {
      'code': code,
      'status': status,
      'message': message,
      'user': user
    };
  }
}