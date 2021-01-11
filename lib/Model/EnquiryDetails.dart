class EnquiryDetails {
  String id;
  String email;
  String name;
  int mobile;

  EnquiryDetails({this.id, this.email, this.name, this.mobile});

  EnquiryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}
