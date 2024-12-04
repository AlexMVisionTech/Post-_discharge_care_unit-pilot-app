import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HealthRecord {
  final String title;
  final String description;
  final String date;

  HealthRecord({required this.title, required this.description, required this.date});

  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }
}

class HealthRecordsScreen extends StatefulWidget {
  final int userId; 

  const HealthRecordsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _HealthRecordsScreenState createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  List<HealthRecord> healthRecords = [];
  String errorMessage = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHealthRecords();
  }

  Future<void> fetchHealthRecords() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/myapis/yu.php?action=fetch_health_records&user_id=${widget.userId}')); 

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 1) {
          List<dynamic> recordsJson = data['data'];
          setState(() {
            healthRecords = recordsJson.map((json) => HealthRecord.fromJson(json)).toList();
            errorMessage = '';
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'No health records found';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load health records: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Health Records'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: healthRecords.isNotEmpty
                    ? ListView.builder(
                        itemCount: healthRecords.length,
                        itemBuilder: (context, index) {
                          final record = healthRecords[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Icon(Icons.health_and_safety, size: 40, color: Colors.teal),
                              title: Text(
                                record.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(record.description),
                                  const SizedBox(height: 4),
                                  Text(
                                    record.date,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              trailing: Icon(Icons.arrow_forward, color: Colors.teal),
                            ),
                          );
                        },
                      )
                    : Center(child: Text(errorMessage, style: TextStyle(color: Colors.red))),
              ),
      ),
    );
  }
}