import 'package:flutter/material.dart';

class User {
  String uid;
  String username;
  String userEmail;
  String token;

  User(
      {required this.uid,
      required this.userEmail,
      required this.token,
      required this.username});
}
