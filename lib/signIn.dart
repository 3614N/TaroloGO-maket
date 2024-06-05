import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maket/id/id.dart';
import 'package:maket/link/link.dart';
import 'package:maket/profile.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _log = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _log,
            ),
            TextField(
              controller: _pass,
            ),
            ElevatedButton(
                onPressed: () async {
                  var response = await http.get(Uri.parse(
                      '$link/user/get_info/${_log.text}/${_pass.text}'));
                  var parsedJson = jsonDecode(utf8.decode(response.bodyBytes));
                  String username = parsedJson["profile_info"]["username"];
                  String phoneNumber =
                      parsedJson["profile_info"]["phone_number"];

                  String email = parsedJson["profile_info"]["email"];

                  String firstName = parsedJson["profile_info"]["first_name"];

                  String secondName = parsedJson["profile_info"]["second_name"];

                  String dateBirth = parsedJson["profile_info"]["date_birth"];
                  userId = parsedJson["profile_info"]["user_id"];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                            username: username,
                            phoneNumber: phoneNumber,
                            email: email,
                            firstName: firstName,
                            secondName: secondName,
                            dateBirth: dateBirth)),
                  );
                },
                child: Text('ВОЙТИ'))
          ],
        ),
      )),
    );
  }
}
