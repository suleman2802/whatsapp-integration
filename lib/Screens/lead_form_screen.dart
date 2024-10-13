import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class LeadFormScreen extends StatelessWidget {
  const LeadFormScreen({super.key});
  final String accessToken = 'EAALjUD5guDkBO4CbIf58hAdGjFLrZAKp7Tu6sdVQh2P8CKMZA0FDJQS3gk8DZBgX5iX4qn9OSZCT0zTR29X7owjvbZCZC8cYX0bftXfkqOZBIbknIB6PGvg9x18LjTbUta6fElcnzkCQ2ibfLghim2sSlAk5ZBdUazMRUL1E39zMb2MYVTxZC0ZCtwrNlG1HojvF2ZAcGbtZCSnuQFCknYZAyCQZDZD'; // Replace with your access token
  final String adId = '120206938578830571';
   fetchLeads() async {
    final response = await http.get(
      Uri.parse('https://graph.facebook.com/v19.0/$adId/leads'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print( data['data']);
    } else {
      throw Exception('Failed to load leads');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchLeads();
    return Scaffold(
      appBar: AppBar(
        title: Text("Leads Table"),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Table(
          border: TableBorder.all(
              color: Colors.black, style: BorderStyle.solid, width: 1),
          children: [
            TableRow(children: [
              Column(
                children: [
                  Text(
                    "Email",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Full Name",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "City",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Job Title",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Company Name",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }
}
