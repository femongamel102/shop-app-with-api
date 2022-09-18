class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannerModel>? banners=[];
  List<ProductModel>? products=[];
  String? ad;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((v) {
        banners!.add( BannerModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((v) {
        products!.add( ProductModel.fromJson(v));
      });
    }
    ad = json['ad'];
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel({this.id, this.image});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  ProductModel(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.images,
      this.inFavorites,
      this.inCart});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}