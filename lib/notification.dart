import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maket/id/id.dart';
import 'package:maket/link/link.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late Future<List<NotificationCard>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    _messagesFuture = generateMessages();
  }

  Future<List<NotificationCard>> generateMessages() async {
    final response =
        await http.get(Uri.parse('$link/notification/user/$userId'));

    final parsedJson = jsonDecode(utf8.decode(response.bodyBytes));

    return parsedJson.values.map<NotificationCard>((message) {
      return NotificationCard(
        notificationTitle: message["notification_title"],
        notificationText: message["notification_text"],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder<List<NotificationCard>>(
            future: _messagesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data ?? [],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String notificationTitle;
  final String notificationText;

  const NotificationCard({
    super.key,
    required this.notificationTitle,
    required this.notificationText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$notificationTitle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(notificationText),
          ],
        ),
      ),
    );
  }
}
