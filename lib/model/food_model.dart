import 'image_model.dart';

/// foodId : "40fc68da-eb8d-42a5-bd91-250fd2996b19"
/// foodName : "Gà Ủ Muối Hoa Tiêu"
/// images : [{"imageUrl":"https://cf.shopee.vn/file/bcec6db84b27aded1e8a5626b781b39a"},{"imageUrl":"https://cf.shopee.vn/file/a1c622a7715e7835ddc6e6e5ecdae5ed"}]
/// description : "GÀ ĐỒI Ủ MUỐI HOA TIÊU Gà ta xịn, thịt chắc, da giòn thơm ngon được hấp muối thực phẩm làm chín sẵn, tẩm ướp gia vị rất thơm và ngon được làm sạch sẽ hút chân không + 🍗Không ngán như gà rán  🍗Không nhạt như gà luộc + 🍗Không mất sức mất công + 🍗Không vặt lông cắt tiết"
/// price : 90000
/// cateId : "ff6bf7e9-1bea-43d0-b6cc-71d01d1c7724"
/// cateName : "Đồ ăn"
/// createdAt : "2021-06-11T10:48:58.747243Z"
/// updatedAt : "2021-06-11T10:48:58.747243Z"

class FoodModel {
  FoodModel({
      String? foodId, 
      String? foodName, 
      List<Images>? images, 
      String? description, 
      int? price, 
      String? cateId, 
      String? cateName, 
      String? createdAt, 
      String? updatedAt,}){
    _foodId = foodId;
    _foodName = foodName;
    _images = images;
    _description = description;
    _price = price;
    _cateId = cateId;
    _cateName = cateName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  FoodModel.fromJson(dynamic json) {
    _foodId = json['foodId'];
    _foodName = json['foodName'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    _description = json['description'];
    _price = json['price'];
    _cateId = json['cateId'];
    _cateName = json['cateName'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _foodId;
  String? _foodName;
  List<Images>? _images;
  String? _description;
  int? _price;
  String? _cateId;
  String? _cateName;
  String? _createdAt;
  String? _updatedAt;

  String? get foodId => _foodId;
  String? get foodName => _foodName;
  List<Images>? get images => _images;
  String? get description => _description;
  int? get price => _price;
  String? get cateId => _cateId;
  String? get cateName => _cateName;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foodId'] = _foodId;
    map['foodName'] = _foodName;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['description'] = _description;
    map['price'] = _price;
    map['cateId'] = _cateId;
    map['cateName'] = _cateName;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

  static List<FoodModel> pareJsonModelToList(List<dynamic> data){
    // List<FoodModel> listModel = [];
    // for(var i = 0 ; i < data.length ; i++){
    //   FoodModel model = FoodModel.fromJson(data[i]);
    //   listModel.add(model);
    // }
    return data.map((json) => FoodModel.fromJson(json)).toList();
  }

  static FoodModel fromJsonModel(Map<String,dynamic> json) => FoodModel.fromJson(json);

}


