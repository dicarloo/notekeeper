import 'package:flutter/material.dart';
import 'package:notekeeper/compontens/tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Map<String, dynamic>>> fetchNotes() async {
    final url = 'https://86knm175u0.execute-api.us-east-1.amazonaws.com/prod/get-notes';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to load notes");
    }
  }

  @override
  Widget build(BuildContext context) {
    final notes = fetchNotes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notekeeper'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final notes = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetchNotes();
                });
              }, 
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, i) {
                  final note = notes[i];
                  return TileNote(
                    title: note['note'] ?? 'Sin nota',
                    date: note['timestamp']?.substring(0, 10) ?? 'Sin fecha',
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No hay datos'));
          }
        },
      ),
    );
  }
}
