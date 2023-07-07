import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color.fromARGB(255, 208, 223, 234),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          label,
          style: GoogleFonts.lato(color: Colors.white),
        ),
      ],
    );
  }
}
