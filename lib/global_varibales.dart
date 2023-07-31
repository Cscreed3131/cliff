import 'package:cliff/screens/food/food_screen.dart';
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
  FoodItem(1, 'Pasta', 'Breakfast' , 'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(2, 'Vada', 'South Indian' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(3, 'Paratha', 'North Indian' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(4, 'Dosa', 'South Indian' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(5, 'Chola Bhatura', 'North Indian' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(6, 'Brownie', 'Desserts' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(7, 'Bruschetta', 'Breakfast' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(8, 'Quesadillas ', 'Breakfast' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(9, 'Lassi', 'Beverages' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
  FoodItem(10, 'Soda', 'Beverages' ,'assets/images/image4.png', 20, 'Food test Food test Food Food test Food test Food Food test Food test Food '),
];