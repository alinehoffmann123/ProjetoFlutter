import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_gratitudes_screen.dart'; 

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _gratitudes = [];
  final TextEditingController _gratitudeController = TextEditingController();

  void _addGratitude() {
    if (_gratitudeController.text.trim().isNotEmpty) {
      setState(() {
        _gratitudes.add({'text': _gratitudeController.text.trim(), 'favorite': false});
        _gratitudeController.clear();
        _saveGratitudes();
      });
    }
  }

  void _showEditDialog(int index) {
    _gratitudeController.text = _gratitudes[index]['text'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Editar Gratidão'),
              content: TextField(
                controller: _gratitudeController,
                decoration: InputDecoration(hintText: "Nova gratidão"),
                onChanged: (value) {
                  setDialogState(() {});
                },
              ),
              actions: [
                TextButton(
                  child: Text("Salvar"),
                  onPressed: _gratitudeController.text.trim().isNotEmpty
                      ? () {
                          setState(() {
                            _gratitudes[index]['text'] = _gratitudeController.text.trim();
                            _gratitudeController.clear();
                            _saveGratitudes();
                          });
                          Navigator.of(context).pop();
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      _gratitudes[index]['favorite'] = !_gratitudes[index]['favorite'];
      _saveGratitudes();
    });
  }

  void _deleteGratitude(int index) {
    setState(() {
      _gratitudes.removeAt(index);
      _saveGratitudes();
    });
  }

  Future<void> _saveGratitudes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('gratitudes', _gratitudes.map((g) => '${g['text']},${g['favorite']}').toList());
  }

  Future<void> _loadGratitudes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedGratitudes = prefs.getStringList('gratitudes') ?? [];
    setState(() {
      _gratitudes.clear();
      for (String gratitude in savedGratitudes) {
        List<String> parts = gratitude.split(',');
        _gratitudes.add({'text': parts[0], 'favorite': parts[1] == 'true'});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadGratitudes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Gratidões'),
        backgroundColor: Colors.teal,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteGratitudesScreen(
                      gratitudes: _gratitudes.where((g) => g['favorite']).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _gratitudeController,
              decoration: InputDecoration(
                labelText: 'Algo pelo qual você é grato hoje',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addGratitude,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _gratitudes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_gratitudes[index]['text']),
                  leading: IconButton(
                    icon: Icon(
                      _gratitudes[index]['favorite'] ? Icons.favorite : Icons.favorite_border,
                      color: Colors.teal,
                    ),
                    onPressed: () => _toggleFavorite(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteGratitude(index),
                  ),
                  onTap: () => _showEditDialog(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
