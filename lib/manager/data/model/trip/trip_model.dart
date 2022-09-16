class TripModel {
  String? id;
  String? city;
  double? price;
  String? image;
  String? endTime;
  String? fromTime;
  String? location;
  String? driverName;
  String? driverPhone;
  String? description;
  int? availableSeats;
  int? totalSeats;
  String? tourGuideName;
  String? tourGuidePhone;
  String? shortDescription;

  TripModel({
    this.id,
    this.city,
    this.price,
    this.image,
    this.endTime,
    this.fromTime,
    this.location,
    this.driverName,
    this.driverPhone,
    this.description,
    this.tourGuideName,
    this.tourGuidePhone,
    this.availableSeats,
    this.shortDescription,
    this.totalSeats,
  });

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    price = json['price'];
    image = json['image'];
    endTime = json['endTime'];
    fromTime = json['fromTime'];
    location = json['location'];
    driverName = json['driverName'];
    driverPhone = json['driverPhone'];
    description = json['description'];
    tourGuideName = json['tourGuideName'];
    tourGuidePhone = json['tourGuidePhone'];
    availableSeats = json['availableSeats'];
    shortDescription = json['shortDescription'];
    totalSeats = json['totalSeats'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'price': price,
        'image': image,
        'endTime': endTime,
        'fromTime': fromTime,
        'location': location,
        'driverName': driverName,
        'driverPhone': driverPhone,
        'description': description,
        'tourGuideName': tourGuideName,
        'tourGuidePhone': tourGuidePhone,
        'availableSeats': availableSeats,
        'shortDescription': shortDescription,
        'totalSeats': totalSeats,
      };
}
