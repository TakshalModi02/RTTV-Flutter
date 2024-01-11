class otpResponseModel{
  int? code;
  String? status;
  String? message;
  String? token;
  Map<String, dynamic>? user;

  otpResponseModel(Map<String, dynamic> map){
    code = map['code'];
    status = map['status'];
    message = map['message'];
    user = map['user'];
    token = map['token'];
  }

  Map<String, dynamic> toJson(){
    return {
      'code': code,
      'status': status,
      'message': message,
      'token': token,
      'user': user
    };
  }
}