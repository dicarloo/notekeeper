import 'package:flutter/material.dart';
import 'package:notekeeper/compontens/tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notekeeper'),centerTitle: true,
      ),
      body: ListView(
        children: [
          for(int i = 0; i < 20; i++)
            TileNote(title: 'Note $i', date: 'Subtitle $i'),
        ],
      ),
    );
  }
}