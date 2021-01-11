class PropertyDetails {
  String id;
  String propertyName;
  String address;
  String bedroom;
  String washroom;
  String locationLat;
  String locationLng;
  String image;

  PropertyDetails(
      {this.id,
        this.propertyName,
        this.address,
        this.bedroom,
        this.washroom,
        this.locationLat,
        this.locationLng,
        this.image});

  PropertyDetails.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    propertyName = json['propertyName'];
    address = json['address'];
    bedroom = json['bedroom'];
    washroom = json['washroom'];
    locationLat = json['locationLat'];
    locationLng = json['locationLng'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['propertyName'] = this.propertyName;
    data['address'] = this.address;
    data['bedroom'] = this.bedroom;
    data['washroom'] = this.washroom;
    data['locationLat'] = this.locationLat;
    data['locationLng'] = this.locationLng;
    data['image'] = this.image;
    return data;
  }
}
