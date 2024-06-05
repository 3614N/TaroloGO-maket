import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maket/feedback.dart';
import 'package:maket/messenger.dart';
import 'package:maket/notification.dart';
import 'package:maket/service_history.dart';
import 'package:maket/services.dart';

class Profile extends StatefulWidget {
  String username;
  String phoneNumber;
  String email;
  String firstName;
  String secondName;
  String dateBirth;

  Profile({
    super.key,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.dateBirth,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.firstName),
              Text(widget.secondName),
              Text(widget.username),
              Text(widget.email),
              Text(widget.phoneNumber),
              Text(widget.dateBirth),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Выйти'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Services()),
                  );
                },
                child: Text('Тарологи'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServiceHistory()),
                  );
                },
                child: Text('Покупки'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Messenger()),
                  );
                },
                child: Text('Чаты'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notifications()),
                  );
                },
                child: Text('Уведомления'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedbackScreen()),
                  );
                },
                child: Text('Обратная связь'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
