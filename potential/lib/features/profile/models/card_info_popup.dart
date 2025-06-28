import 'package:flutter/material.dart';

/// Model that stores information for each card's info popup
/// 
/// use [infoText] to display the list of texts belonging to a card
/// 
/// [noteTextColor] is the basic theme of the card popup
class CardInfoPopupModel {
  String assetPath;
  List<String> infoText;
  List<String> infoNotes;
  Color noteTextColor;
  List<Color> gradientColors;

  CardInfoPopupModel({
    required this.assetPath,
    required this.infoText,
    this.infoNotes = const [
      "This isnt a profile creation, this is you putting in that extra effort to build meaningfull connections.",
      "Be as authentic and introspective as you possibly can, your potential for a depeer relationship starts by discovering your true self.",
    ],
    required this.noteTextColor,
    required this.gradientColors,
  });
}
