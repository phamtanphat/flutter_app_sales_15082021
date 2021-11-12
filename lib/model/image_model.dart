/// imageUrl : "https://cf.shopee.vn/file/bcec6db84b27aded1e8a5626b781b39a"
class Images {
  Images({
    String? imageUrl,}){
    _imageUrl = imageUrl;
  }

  Images.fromJson(dynamic json) {
    _imageUrl = json['imageUrl'];
  }
  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = _imageUrl;
    return map;
  }

}