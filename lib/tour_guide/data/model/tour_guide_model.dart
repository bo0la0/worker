class TourGuideModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? location;

  TourGuideModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.location,
  });

  TourGuideModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'location': location,
    };
  }
}
