/// userId : "18b541b8-68e3-461d-a065-5424617304eb"
/// fullName : "Nguyen Van A"
/// email : "nguyenvana@gmail.com"
/// phone : "000000001"
/// address : "p.Linh Tây, Tp.Thủ Đức, Tp.Hồ Chí Minh"
/// role : "MEMBER"
/// createdAt : "2021-06-23T04:47:25.962966Z"
/// updatedAt : "2021-06-23T04:47:25.962966Z"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIxOGI1NDFiOC02OGUzLTQ2MWQtYTA2NS01NDI0NjE3MzA0ZWIiLCJSb2xlIjoiTUVNQkVSIiwiZXhwIjoxNjM2MzgzODk0fQ.fAaG8hFGcEgb9zH4aFB8QOKQsLda9_yUfFP1SRNi7Ss"

class UserModel {
  UserModel({
      String? userId, 
      String? fullName, 
      String? email, 
      String? phone, 
      String? address, 
      String? role, 
      String? createdAt, 
      String? updatedAt, 
      String? token,}){
    _userId = userId;
    _fullName = fullName;
    _email = email;
    _phone = phone;
    _address = address;
    _role = role;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _token = token;
}

  UserModel.fromJson(Map<String,dynamic> json) {
    _userId = json['userId'];
    _fullName = json['fullName'];
    _email = json['email'];
    _phone = json['phone'];
    _address = json['address'];
    _role = json['role'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _token = json['token'];
  }
  String? _userId;
  String? _fullName;
  String? _email;
  String? _phone;
  String? _address;
  String? _role;
  String? _createdAt;
  String? _updatedAt;
  String? _token;

  String? get userId => _userId;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phone => _phone;
  String? get address => _address;
  String? get role => _role;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['fullName'] = _fullName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['address'] = _address;
    map['role'] = _role;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['token'] = _token;
    return map;
  }

  static UserModel fromJsonModel(Map<String,dynamic> json) => UserModel.fromJson(json);

}