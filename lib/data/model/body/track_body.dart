class TrackBody {
  double longitude;
  double latitude;
  String location;
  String orderId;

  TrackBody(
      {this.longitude, this.latitude, this.location, this.orderId});

  TrackBody.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['location'] = location;
    data['order_id'] = orderId;
    return data;
  }
}
