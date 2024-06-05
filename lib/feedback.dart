import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maket/id/id.dart';
import 'package:maket/link/link.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _sendFeedback() async {
    final String _userId = '$userId'; // замените на реальный userId
    final String feedbackText = _controller.text;
    final String feedbackDatetime = DateTime.now().toIso8601String();

    final Map<String, dynamic> feedbackData = {
      'user_id': _userId,
      'feedback_text': feedbackText,
      'feedback_datetime': feedbackDatetime,
    };

    final response = await http.post(
      Uri.parse('$link/feedback/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(feedbackData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback sent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send feedback')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ОТПРАВИТЬ ОБРАТНУЮ СВЯЗЬ'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Введите ваш отзыв'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _sendFeedback,
                child: Text('ОТПРАВИТЬ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
