import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone maior e mais colorido
            Icon(
              Icons.favorite,
              size: 120,
              color: Colors.teal[800],
            ),
            SizedBox(height: 20),
            // Título com mais destaque
            Text(
              'Diário de Gratidão',
              style: TextStyle(
                fontSize: 32,
                color: Colors.teal[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Texto explicativo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Comece seu dia com gratidão! Anote suas bênçãos e sinta a diferença.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal[700],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            // Botão para ir para a tela de login
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Começar',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            // Pequeno texto de rodapé com a versão do app
            Text(
              'Versão 1.0',
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}