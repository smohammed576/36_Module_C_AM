import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';

class ResultsMedal extends StatelessWidget{
  final String color;
  const ResultsMedal({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/medals/medal.png', width: 30, colorBlendMode: BlendMode.srcATop, color: AppColors.medals[color.toLowerCase()],),
          Text('$color Medals', style: TextStyle(
            color: AppColors.medals[color.toLowerCase()],
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),)
        ],
      ),
    );
  }
}