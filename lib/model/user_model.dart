class UserModel {
  String? uid;
  String? name;
  int? age;
  String? image;

  UserModel({
    this.age,
    this.image,
    this.name,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      age: json['age'],
      image: json['image'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'image': image,
    };
  }
}
