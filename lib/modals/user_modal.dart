class UserModal {
  int id;
  String firstName;
  String lastName;
  String profileImage;
  Map<String, dynamic> fullData;


  UserModal({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.fullData,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) {
    return UserModal(id: json['id'], firstName: json['firstName'], lastName: json['lastName'], profileImage: json['profileImage'], fullData: json);
  }

  Map<String, dynamic> toJson() {

    return fullData;
  }
}
