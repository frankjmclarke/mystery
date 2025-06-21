import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Map<String, dynamic>> loadUniverse() async {
    final String jsonString = await rootBundle.loadString('assets/universe.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystery Game',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Mystery Game')),
        body: FutureBuilder<Map<String, dynamic>>(
          future: loadUniverse(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading universe.'));
            } else {
              final universe = snapshot.data!;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Start Location: ${universe["mystery"]["start_location"]}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Victim: ${universe["mystery"]["victim"]}'),
                  Text('Perpetrator: ${universe["mystery"]["perpetrator"]}'),
                  Text('Method: ${universe["mystery"]["method"]}'),
                  Text('Motive: ${universe["mystery"]["motive"]}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}