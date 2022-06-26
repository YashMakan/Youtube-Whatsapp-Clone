import 'package:whatsapp_application/models/location.dart';

class User {
  static const String nameKey = "name";
  static const String emailKey = "email";
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

  final String name;
  final String email;
  final String gender;
  final String phoneNumber;
  final int birthDate;
  final Location location;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String title;
  final String picture;

  User(
      {required this.name,
      required this.email,
      required this.gender,
      required this.phoneNumber,
      required this.birthDate,
      required this.location,
      required this.username,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.title,
      required this.picture});

  factory User.fromJson(Map json) => User(
        name: "${json[firstNameKey]} ${json[lastNameKey]}",
        email: json[emailKey],
        gender: json[genderKey],
        phoneNumber: json[phoneNumberKey],
        birthDate: json[birthDateKey],
        location: Location.fromJson(json[locationKey]),
        username: json[usernameKey],
        password: json[passwordKey],
        firstName: json[firstNameKey],
        lastName: json[lastNameKey],
        title: json[titleKey],
        picture: json[pictureKey],
      );

  toJson() => {
        nameKey: name,
        emailKey: email,
        genderKey: gender,
        phoneNumberKey: phoneNumber,
        birthDateKey: birthDate,
        locationKey: location.toJson(),
        usernameKey: username,
        passwordKey: password,
        firstNameKey: firstName,
        lastNameKey: lastName,
        titleKey: title,
        pictureKey: picture,
      };
}
