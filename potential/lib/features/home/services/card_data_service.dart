import 'package:flutter/material.dart';

class CardDataService {
  static List<Map<String, dynamic>> cardData = [
    {
      "cardTitle": "Spark",
      "cardSubtitle": "Vibe.Energy.Chemistry",
      "cardIcon": "assets/svg/spark_card.svg",
      "cardStartColor": const Color(0xFFC623F6),
      "cardEndColor": const Color(0xFF891BAA),
      "heartSvgAssetPath": "assets/svg/spark_heart.svg",
    },
    {
      "cardTitle": "Mind",
      "cardSubtitle": "Values.Thoughts.Perspectives",
      "cardIcon": "assets/svg/mind_card.svg",
      "cardStartColor": const Color(0xFF5250D4),
      "cardEndColor": const Color(0xFF0703FF),
      "heartSvgAssetPath": "assets/svg/mind_heart.svg",
    },
    {
      "cardTitle": "Heart",
      "cardSubtitle": "Empathy.Passion.Emotions",
      "cardIcon": "assets/svg/heart_card.svg",
      "cardStartColor": const Color(0xFFFF5325),
      "cardEndColor": const Color(0xFF8A2306),
      "heartSvgAssetPath": "assets/svg/heartcard_heart.svg",
    },
    {
      "cardTitle": "Soul",
      "cardSubtitle": "Self Journey.Destiny.",
      "cardIcon": "assets/svg/soul_card.svg",
      "cardStartColor": const Color.fromARGB(255, 226, 210, 117),
      "cardEndColor": const Color.fromARGB(255, 175, 149, 0),
      "heartSvgAssetPath": "assets/svg/soul_heart.svg",
    },
  ];
}
