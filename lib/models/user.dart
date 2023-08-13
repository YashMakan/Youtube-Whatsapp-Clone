import 'package:whatsapp_redesign/models/location.dart';

class User {
  static const String nameKey = "name";
  static const String genderKey = "gender";
  static const String phoneNumberKey = "phone_number";
  static const String birthDateKey = "birthdate";
  static const String locationKey = "location";
  static const String usernameKey = "username";
  static const String passwordKey = "password";
  static const String firstNameKey = "first_name";
  static const String lastNameKey = "last_name";
  static const String titleKey = "title";
  static const String pictureKey = "picture";
  static const String uuidKey = "uuid";
  static const String firebaseTokenKey = "firebase_token";

  final String name;
  final String? gender;
  final String phoneNumber;
  final int? birthDate;
  final Location? location;
  final String? username;
  final String firstName;
  final String? lastName;
  final String? title;
  final String? picture;
  final String uuid;
  final String? firebaseToken;

  User(
      {required this.name,
      this.gender,
      required this.phoneNumber,
      this.birthDate,
      this.location,
      this.username,
      required this.firstName,
      this.lastName,
      this.title,
      required this.uuid,
      this.firebaseToken,
      this.picture});

  factory User.fromJson(Map json) => User(
        name: "${json[firstNameKey]} ${json[lastNameKey]}",
        gender: json[genderKey],
        phoneNumber: json[phoneNumberKey],
        birthDate: json[birthDateKey],
        location: Location.fromJson(json[locationKey]),
        username: json[usernameKey],
        firstName: json[firstNameKey],
        lastName: json[lastNameKey],
        title: json[titleKey],
        firebaseToken: json[firebaseTokenKey] ?? "",
        uuid: json[uuidKey] ?? "",
        picture: json[pictureKey],
      );

  Map<String, dynamic> toJson() => {
        nameKey: name,
        genderKey: gender,
        phoneNumberKey: phoneNumber,
        birthDateKey: birthDate,
        locationKey: location?.toJson(),
        usernameKey: username,
        firstNameKey: firstName,
        lastNameKey: lastName,
        titleKey: title,
        uuidKey: uuid,
        firebaseTokenKey: firebaseToken,
        pictureKey: picture,
      };
}
