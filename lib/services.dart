import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maket/link/link.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  late Future<List<ServiceCard>> _servicesFuture;

  @override
  void initState() {
    super.initState();
    _servicesFuture = generateServices();
  }

  Future<List<ServiceCard>> generateServices() async {
    final response = await http.get(Uri.parse('$link/user/find_tarot'));

    final parsedJson = jsonDecode(utf8.decode(response.bodyBytes));

    return parsedJson.values.map<ServiceCard>((message) {
      return ServiceCard(
        firstName: message["first_name"],
        secondName: message["second_name"],
        description: message["user_description"],
        rating: (message["tarot_rating"] as num).toDouble(),
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
          child: FutureBuilder<List<ServiceCard>>(
            future: _servicesFuture,
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

class ServiceCard extends StatelessWidget {
  final String firstName;
  final String secondName;
  final String description;
  final double rating;

  const ServiceCard({
    required this.firstName,
    required this.secondName,
    required this.description,
    required this.rating,
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
            Text(description),
            SizedBox(height: 8.0),
            Text('Rating: $rating'),
          ],
        ),
      ),
    );
  }
}
