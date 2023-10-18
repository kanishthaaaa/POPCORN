import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 244, 220, 219),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          hintText: 'Search a movie',
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey[700],
          )),
    );
  }
}
