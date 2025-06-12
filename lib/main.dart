import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/info_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class App extends StatefulWidget {
  final String username;
  final String email;

  const App({super.key, required this.username, required this.email});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      FavoritesScreen(),
      InfoScreen(),
      ProfileScreen(username: widget.username, email: widget.email),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon_outlined), 
            label: "Cartas"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), 
            label: "Favoritos"),
          BottomNavigationBarItem(
            icon: Icon(Icons.games_outlined), 
            label: "TCG"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: "Perfil"),
        ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.amberAccent,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.redAccent,
            type: BottomNavigationBarType.fixed,
      ),
    );
  }
}