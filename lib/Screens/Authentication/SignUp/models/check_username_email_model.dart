class CheckUsernameEmailModel {
  String? message;
  Data? data;
  Map<String, List<String>>? errors;

  CheckUsernameEmailModel({this.message, this.data, this.errors});

  factory CheckUsernameEmailModel.fromJson(Map<String, dynamic> json) {
    return CheckUsernameEmailModel(
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
  String? email;
  String? username;

  Data({this.email, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}
