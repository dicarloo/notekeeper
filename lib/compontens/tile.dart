import 'package:flutter/material.dart';

class TileNote extends StatelessWidget {
  const TileNote({super.key, required this.title, required this.date});
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(date),
      ),
    );
  }
}
