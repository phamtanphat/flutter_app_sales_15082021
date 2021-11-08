class ResponseModel<T>{
  int? code;
  T? data;
  String? message;

  ResponseModel.fromJson(Map<String , dynamic> json , Function fromJsonModel){
    code = json['code'];
    data = fromJsonModel(json['data']);
    message = json['message'];
  }
}