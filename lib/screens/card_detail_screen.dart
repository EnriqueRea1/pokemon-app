import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zwidget/zwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDetailScreen extends StatefulWidget {
  final Map<String, dynamic> card;

  const CardDetailScreen({super.key, required this.card});

  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  final GlobalKey _imageKey = GlobalKey(); // To get the position of the image
  double _rotationX = 0;
  double _rotationY = 0;
  Size? _size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _size = MediaQuery.of(context).size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.card["name"], style: GoogleFonts.pressStart2p())),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Use ZWidget for animated rotation
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  if (_size != null) {
                    final distance = details.localPosition - _imageKey.currentContext!.findRenderObject()!.paintBounds.center;
                    _rotationY = distance.dx / (_size!.width / 2.0) * 2 * pi;
                    _rotationX = distance.dy / (_size!.height / 2.0) * 2 * pi;
                  }
                });
              },
              child: ZWidget.backwards(
                key: _imageKey,
                midChild: ClipRect(
                  child: Image.network(widget.card["image"], height: 400),
                ),
                rotationX: _rotationX,
                rotationY: _rotationY,
                layers: 11,
                depth: 12,
              ),
            ),
            SizedBox(height: 20),
            Text("Estadísticas", style: GoogleFonts.pressStart2p(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                _buildTableRow("Nombre", widget.card["name"]),
                _buildTableRow("HP", widget.card["hp"]),
                _buildTableRow("Rareza", widget.card["rarity"]),
                _buildTableRow("Tipos", widget.card["types"].isNotEmpty ? widget.card["types"].join(", ") : "N/A"),
                _buildTableRow("Ataques", widget.card["attacks"].isNotEmpty ? widget.card["attacks"].map((a) => a["name"]).join(", ") : "N/A"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String key, String value) {
    return TableRow(
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(key, style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(value)),
      ],
    );
  }
}
