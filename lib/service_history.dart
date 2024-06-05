import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maket/id/id.dart';
import 'package:maket/link/link.dart';

class ServiceHistory extends StatefulWidget {
  const ServiceHistory({super.key});

  @override
  State<ServiceHistory> createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  late Future<List<ServiceHistoryCard>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    _messagesFuture = generateMessages();
  }

  Future<List<ServiceHistoryCard>> generateMessages() async {
    final response = await http.get(Uri.parse('$link/history/$userId'));

    final parsedJson = jsonDecode(utf8.decode(response.bodyBytes));

    return parsedJson.values.map<ServiceHistoryCard>((message) {
      return ServiceHistoryCard(
        firstName: message["first_name"],
        secondName: message["second_name"],
        serviceName: message["service_name"],
        price: message["service_price"].toString(), // Convert price to string
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
          child: FutureBuilder<List<ServiceHistoryCard>>(
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

class ServiceHistoryCard extends StatelessWidget {
  final String firstName;
  final String secondName;
  final String serviceName;
  final String price;

  const ServiceHistoryCard({
    super.key,
    required this.firstName,
    required this.secondName,
    required this.serviceName,
    required this.price,
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
            Text(serviceName),
            SizedBox(height: 8.0),
            Text('Price: $price'),
          ],
        ),
      ),
    );
  }
}
