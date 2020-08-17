import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0.22, 0.32),
              colors: [Color(0xE06E548F),Color(0xE05B4773),Color(0xE0483A58),Color(0xE0342E3C), Theme.of(context).primaryColor.withAlpha(130)])),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left : 25, top:80),
        children: <Widget>[
          Text('Good Afternoon', style: GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.w600, letterSpacing: 0.6),)
        ],
      ),
    );
  }
}
