import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'card_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> cards = [];

  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  Future<void> fetchCards() async {
    final url = Uri.parse("https://api.pokemontcg.io/v2/cards?q=name:victini%20or%20name:pikachu%20or%20name:charizard%20or%20name:blastoise%20or%20name:mewtwo%20or%20name:arcanine%20or%20name:quagsire%20or%20name:darkrai%20or%20name:gyarados%20or%20name:dragonite%20or%20name:snorlax");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List cardsData = data["data"];

      setState(() {
        cards = cardsData.take(30).map((card) {
          return {
            "id": card["id"],
            "name": card["name"],
            "image": card["images"]["small"],
            "hp": card["hp"] ?? "N/A",
            "rarity": card["rarity"] ?? "Desconocida",
            "types": card["types"] ?? [],
            "attacks": card["attacks"] ?? [],
          };
        }).toList();
      });
    } else {
      print("Error al obtener cartas: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: Text(
          "Cartas Pokémon TCG",
          style: GoogleFonts.pressStart2p(),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,),
        backgroundColor: Colors.yellow[100],
        
      body: cards.isEmpty
          ? Center(child: CircularProgressIndicator()) // Muestra un loader mientras se cargan las cartas
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cartas por fila
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];

                return GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CardDetailScreen(card: card)),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(card["image"], height: 150),
                        SizedBox(height: 8),
                        Text(card["name"], style: GoogleFonts.pressStart2p(fontSize: 10, fontWeight: FontWeight.bold), ),// Aplicar la fuente a los textos de las cartas),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
