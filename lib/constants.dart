import 'package:flutter/material.dart';

// literl wings
//var pallet = ["ff9f1c", "ffbf69", "ffffff", "008800", "00b300"];

// Anna's bedroom and yellow
//var pallet = ["fbb02d", "f3de2c", "7cb518", "5c8001", "fbb02d"];

// Most popular
//var pallet = ["264653", "2a9d8f", "e9c46a", "f4a261", "e76f51"];

// 2nd most popular
var pallet = ["e63946", "f1faee", "a8dadc", "457b9d", "1d3557"];

// Mallard
//var pallet = ["606c38", "283618", "fefae0", "F5E7D6", "bc6c25"];

Color kPrimaryColor = Color(int.parse('ff' + pallet[0], radix: 16));
Color kAccentColor = Color(int.parse('ff' + pallet[1], radix: 16));
Color kBackgroundColor = Color(int.parse('ff' + pallet[2], radix: 16));
Color kColor1 = Color(int.parse('ff' + pallet[3], radix: 16));
Color kColor2 = Color(int.parse('ff' + pallet[4], radix: 16));

class Risk {
  int value;
  String title;

  Risk(this.value, this.title);
}

List<Risk> risks = [
  Risk(1, "Opening the mail"),
  Risk(2, "Getting restaurant takeout"),
  Risk(2, "Pumping gasoline"),
  Risk(2, "Playing tennis"),
  Risk(2, "Going camping"),
  Risk(3, "Grocery shopping"),
  Risk(3, "Going for a walk, run, or bike ride with others"),
  Risk(3, "Playing golf"),
  Risk(4, "Staying at a hotel for two nights"),
  Risk(4, "Sitting in a doctor’s waiting room"),
  Risk(4, "Going to a library or museum"),
  Risk(4, "Eating in a restaurant (outside)"),
  Risk(4, "Walking in a busy downtown"),
  Risk(4, "Spending an hour at a playground"),
  Risk(5, "Having dinner at someone else’s house"),
  Risk(5, "Attending a backyard barbecue"),
  Risk(5, "Going to a beach"),
  Risk(5, "Shopping at a mall"),
  Risk(6, "Sending kids to school, camp, or day care"),
  Risk(6, "Working a week in an office building"),
  Risk(6, "Swimming in a public pool"),
  Risk(6, "Visiting an elderly relative or friend in their home"),
  Risk(7, "Going to a hair salon or barbershop"),
  Risk(7, "Eating in a restaurant (inside)"),
  Risk(7, "Attending a wedding or funeral"),
  Risk(7, "Traveling by plane"),
  Risk(7, "Playing basketball"),
  Risk(7, "Playing football"),
  Risk(7, "Hugging or shaking hands when greeting a friend"),
  Risk(8, "Eating at a buffet"),
  Risk(8, "Working out at a gym"),
  Risk(8, "Going to an amusement park"),
  Risk(8, "Going to a movie theater"),
  Risk(9, "Attending a large music concert"),
  Risk(9, "Going to a sports stadium"),
  Risk(9, "Attending a religious service with 500 worshipers"),
  Risk(9, "Going to a bar"),
];
