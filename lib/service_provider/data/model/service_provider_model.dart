class ServiceProviderModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? balance;
  String? location;
  String? category;

  ServiceProviderModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.balance,
    this.location,
    this.category,
  });

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    balance = json['balance'];
    location = json['location'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'balance': balance,
      'location': location,
      'category': category,
    };
  }
}
