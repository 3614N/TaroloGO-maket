import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maket/id/id.dart';
import 'package:maket/link/link.dart';

class Messenger extends StatefulWidget {
  const Messenger({super.key});

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  late Future<List<MessageCard>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    _messagesFuture = generateMessages();
  }

  Future<List<MessageCard>> generateMessages() async {
    final response =
        await http.get(Uri.parse('$link/message/contacts_info/$userId'));

    final parsedJson = jsonDecode(utf8.decode(response.bodyBytes));

    return parsedJson.values.map<MessageCard>((message) {
      return MessageCard(
        firstName: message["first_name"],
        secondName: message["second_name"],
        lastMessage: message["message_text"],
        time: message["message_date_send"],
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
          child: FutureBuilder<List<MessageCard>>(
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

class MessageCard extends StatelessWidget {
  final String firstName;
  final String secondName;
  final String lastMessage;
  final String time;

  const MessageCard({
    super.key,
    required this.firstName,
    required this.secondName,
    required this.lastMessage,
    required this.time,
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
              '$firstName $secondName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(lastMessage),
            SizedBox(height: 8.0),
            Text('time: $time'),
          ],
        ),
      ),
    );
  }
}
