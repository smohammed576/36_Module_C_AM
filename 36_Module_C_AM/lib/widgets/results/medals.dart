import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';

class ResultsMedals extends StatelessWidget{
  final int amount;
  final String color;

  const ResultsMedals({super.key, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text('$amount', style: TextStyle(
      color: AppColors.medals[color],
      fontWeight: FontWeight.w500,
      fontSize: 16
    ),);
  }
}