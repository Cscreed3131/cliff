import 'package:cliff/models/food_item.dart';
import 'package:cliff/screens/food/food_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Put frequently used elements here so as to avoid repetition

final pageGradient = LinearGradient(
  colors: [
    const Color.fromRGBO(225, 218, 230, 1).withOpacity(0.5),
    const Color.fromRGBO(246, 196, 237, 1).withOpacity(0.9),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [0, 1],
);

List<FoodItem> items = [
  FoodItem(1, 'Pasta', 'Breakfast', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(2, 'Vada', 'South Indian', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(3, 'Paratha', 'North Indian', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(4, 'Dosa', 'South Indian', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(5, 'Chola Bhatura', 'North Indian', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(6, 'Brownie', 'Desserts', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(7, 'Bruschetta', 'Breakfast', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(8, 'Quesadillas ', 'Breakfast', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(9, 'Lassi', 'Beverages', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(10, 'Soda', 'Beverages', 'assets/images/image4.png', 20,
      'Food test Food test Food Food test Food test Food Food test Food test Food '),
];

//Alumni section
class AlumniItem {
  final int id;
  final String imgUrl;
  final String name;
  final String branch;
  final int year;
  final String linkedIn;
  final String mail;

  const AlumniItem(this.id, this.imgUrl, this.name, this.branch, this.year,
      this.linkedIn, this.mail);
}

const List<AlumniItem> alumniDetails = [
  AlumniItem(
      1, 'assets/images/image3.png', 'John Doe', 'CSE', 2024, "Link", "Link"),
  AlumniItem(
      2, 'assets/images/image3.png', 'Johwwn Doe', 'EEE', 2023, "Link", "Link"),
  AlumniItem(3, 'assets/images/image3.png', 'Jowwwehn Doe', 'ECE', 2019, "Link",
      "Link"),
  AlumniItem(
      4, 'assets/images/image3.png', 'Johadn Doe', 'CSE', 2024, "Link", "Link"),
  AlumniItem(
      5, 'assets/images/image3.png', 'Jdohn Doe', 'MECH', 2024, "Link", "Link"),
  AlumniItem(6, 'assets/images/image3.png', 'John Dadoe adwdwdwd', 'CVIL', 2020,
      "Link", "Link"),
  AlumniItem(
      7, 'assets/images/image3.png', 'Jdaohn Doe', 'CSE', 2020, "Link", "Link"),
  AlumniItem(
      8, 'assets/images/image3.png', 'Joddhn Doe', 'CSE', 2021, "Link", "Link"),
  AlumniItem(9, 'assets/images/image3.png', 'Joehn Dq2oe', 'ECE', 2022, "Link",
      "Link"),
  AlumniItem(10, 'assets/images/image3.png', 'Joahn Doe', 'MECH', 2018, "Link",
      "Link"),
];

//urls for memories images
List<String> listOfUrls = const [
  "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
  "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
  "https://wallpapers.com/images/featured/2ygv7ssy2k0lxlzu.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/7/77/Big_Nature_%28155420955%29.jpeg",
  "https://www.rd.com/wp-content/uploads/2020/04/GettyImages-1093840488-5-scaled.jpg",
  "https://media.cntraveller.com/photos/611bf0b8f6bd8f17556db5e4/1:1/w_2000,h_2000,c_limit/gettyimages-1146431497.jpg",
  "https://img.freepik.com/premium-photo/fantastic-view-kirkjufellsfoss-waterfall-near-kirkjufell-mountain-sunset_761071-868.jpg",
  "https://www.travelandleisure.com/thmb/KLPvXakEKLGE5AY2jVyovl3Md1k=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/iceland-BEAUTCONT1021-b1aeafa7ac2847a484cbca48d3172b6c.jpg",
  "https://w0.peakpx.com/wallpaper/265/481/HD-wallpaper-nature.jpg",
  "https://e0.pxfuel.com/wallpapers/163/906/desktop-wallpaper-beautiful-nature-with-girl-beautiful-girl-with-nature-and-moon-high-resolution-beautiful.jpg",
];

Future<String> getUserData() async {
  String userId = '';
  var currrentUser = FirebaseAuth.instance.currentUser!.uid;
  final userQuery = await FirebaseFirestore.instance
      .collection("users")
      .where("userid", isEqualTo: currrentUser)
      .get();
  for (var docSnapshot in userQuery.docs) {
    userId = docSnapshot.id;
  }

  return userId;
}
