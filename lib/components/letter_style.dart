import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LetterStyle extends StatelessWidget {
  final String label;
  final double size;
  final FontWeight fw;
  final double spacing;
  final Color clr;
  const LetterStyle(
      {super.key,
      required this.label,
      this.size = 15,
      this.fw = FontWeight.w500,
      this.spacing = 1,
      this.clr = Colors.black87});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: GoogleFonts.encodeSans(
            color: clr,
            fontSize: size,
            fontWeight: fw,
            letterSpacing: spacing));
  }
}

class BigHeading extends StatelessWidget {
  final String label;
  final double size;
  final FontWeight fw;
  final double spacing;
  final Color clr;
  const BigHeading(
      {super.key,
        required this.label,
        this.size = 15,
        this.fw = FontWeight.w500,
        this.spacing = 1,
        this.clr = Colors.black87});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: GoogleFonts.raleway(
            color: clr,
            fontSize: size,
            fontWeight: fw,
            letterSpacing: spacing));
  }
}

class MidHeading extends StatelessWidget {
  final String label;
  final double size;
  final FontWeight fw;
  final double spacing;
  final Color clr;
  final FontStyle fs;
  const MidHeading(
      {super.key,
        required this.label,
        this.size = 15,
        this.fw = FontWeight.w500,
        this.spacing = 1,
        this.clr = Colors.black87, this.fs = FontStyle.normal});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.lato(
          fontStyle: fs,
            color: clr,
            fontSize: size,
            fontWeight: fw,
            letterSpacing: spacing, ));
  }
}