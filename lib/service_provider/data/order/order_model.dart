class OrderModel {
  String? productId;
  String? price;
  String? title;
  String? image;
  String? quantity;
  String? providerId;

  OrderModel({
    this.productId,
    this.price,
    this.title,
    this.image,
    this.quantity,
    this.providerId,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    price = json['price'];
    title = json['title'];
    image = json['image'];
    quantity = json['quantity'];
    providerId = json['providerId'];
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'price': price,
        'title': title,
        'image': image,
        'quantity': quantity,
        'providerId': providerId,
      };
}
