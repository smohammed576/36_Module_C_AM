import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';

class DetailsAppbar extends StatelessWidget{
  final String label;
  const DetailsAppbar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            child: IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero
              ),
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left, color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue, size: 30,),
            ),
          ),
          Text(label, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}