class ProductModel {
  String? id;
  String? price;
  String? title;
  String? image;
  String? category;
  String? description;
  String? serviceProviderId;

  ProductModel({
    this.id,
    this.price,
    this.title,
    this.image,
    this.category,
    this.description,
    this.serviceProviderId,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    image = json['image'];
    category = json['category'];
    description = json['description'];
    serviceProviderId = json['serviceProviderId'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'title': title,
        'image': image,
        'category': category,
        'description': description,
        'serviceProviderId': serviceProviderId,
      };
}
