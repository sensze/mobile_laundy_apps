import 'package:flutter/material.dart';

class AuthCheck extends StatefulWidget {
  final String name;
  final String email;

  final String password;
  const AuthCheck({super.key, required this.name, required this.email, required this.password});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.name),
          Text(widget.email),
          Text(widget.password)
        ]
      )
    );
  }
}