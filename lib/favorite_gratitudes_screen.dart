import 'package:flutter/material.dart';

class FavoriteGratitudesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> gratitudes;

  FavoriteGratitudesScreen({required this.gratitudes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gratidões Favoritas'),
        backgroundColor: Colors.teal,
      ),
      body: gratitudes.isNotEmpty
          ? ListView.builder(
              itemCount: gratitudes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(gratitudes[index]['text']),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                );
              },
            )
          : Center(child: Text('Nenhuma gratidão favorita ainda.')),
    );
  }
}
