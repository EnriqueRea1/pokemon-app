import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  const ProfileScreen({super.key, required this.username, required this.email});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: Text("Perfil", style: GoogleFonts.pressStart2p(textStyle: TextStyle(fontFamily: 'PokemonFont'))),
        centerTitle: true,
        elevation: 0
      ),
      body: Stack(
       children: [
        Container(
          color: Colors.yellow[100],
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Image.network('https://cdn-icons-png.flaticon.com/512/914/914726.png',
          width: 100
          ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    color: Colors.amber,  // Pokémon color for the card
                    child: Column(
                      children: [
                       Image.network('https://cdn-icons-png.flaticon.com/512/362/362003.png',
                       width: 100 
                       ),
                        SizedBox(height: 20),
                        Text("Usuario: $username",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                        SizedBox(height: 10),
                        Text("Correo: $email",
                            style: TextStyle(fontSize: 20, color: Colors.black)),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () => _logout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text("Cerrar Sesión", style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
