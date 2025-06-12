import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favoriteCards = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteCards();
  }

  Future<void> fetchFavoriteCards() async {
    final List<String> pokemonNames = ["Quagsire", "Victini", "Alakazam", "Dragonite"];
    final List<Map<String, dynamic>> fetchedCards = [];

    for (final name in pokemonNames) {
      final url = Uri.parse("https://api.pokemontcg.io/v2/cards?q=name:$name");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List cardsData = data["data"];

        if (cardsData.isNotEmpty) {
          final card = cardsData.first;
          fetchedCards.add({
            "id": card["id"],
            "name": card["name"],
            "image": card["images"]["small"],
            "hp": card["hp"] ?? "N/A",
            "rarity": card["rarity"] ?? "Desconocida",
            "types": card["types"] ?? [],
            "attacks": card["attacks"] ?? [],
          });
        }
      } else {
        print("Error al obtener la carta de $name: ${response.statusCode}");
      }
    }

    setState(() {
      favoriteCards = fetchedCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cartas Favoritas",style: GoogleFonts.pressStart2p()),
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        
      ),
      backgroundColor: Colors.yellow[100],
      body: favoriteCards.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 75.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: favoriteCards.map((card) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: CardGalleryItem(card: card),
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class CardGalleryItem extends StatelessWidget {
  final Map<String, dynamic> card;

  const CardGalleryItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            card["name"],
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          ClipRRect(
            child: Image.network(
              card["image"],
              width: 250,
              height: 340,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "HP: ${card["hp"]}",
            style: TextStyle(
              fontSize: 14, color: Colors.black54),
          ),
          Text(
            "Rareza: ${card["rarity"]}",
            style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}