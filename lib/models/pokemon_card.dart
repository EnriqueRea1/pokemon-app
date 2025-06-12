class PokemonCard {
  final String name;
  final String image;
  final String stats;
  double rating;  // Guardará el rating de la carta

  PokemonCard({required this.name, required this.image, required this.stats, this.rating = 0.0});
}
