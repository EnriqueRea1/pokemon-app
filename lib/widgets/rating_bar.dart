import 'package:flutter/material.dart';

class RatingBarWidget extends StatefulWidget {
  final double initialRating;

  const RatingBarWidget({super.key, this.initialRating = 0.0});

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () {
            setState(() {
              rating = index + 1.0;
            });
          },
        );
      }),
    );
  }
}
