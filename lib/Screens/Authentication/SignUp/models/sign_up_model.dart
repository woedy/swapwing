class SignUpModel {
  String? message;
  Data? data;
  Map<String, List<String>>? errors;

  SignUpModel({this.message, this.data, this.errors});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      errors: json['errors'] != null ? _parseErrors(json['errors']) : null,
    );
  }
  static Map<String, List<String>> _parseErrors(Map<String, dynamic> errorData) {
    Map<String, List<String>> errors = {};
    errorData.forEach((key, value) {
      if (value is List) {
        errors[key] = List<String>.from(value);
      } else if (value is String) {
        errors[key] = [value];
      }
    });
    return errors;
  }
}
class Data {
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? token;

  Data({this.userId, this.email, this.firstName, this.lastName, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['token'] = this.token;
    return data;
  }
}

class Errors {
  List<String>? email;

  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}
