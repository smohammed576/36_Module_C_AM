import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';

Future openSettingsBottomsheet(BuildContext context) async{
  return showModalBottomSheet(
    context: context, 
    builder: (context) {
    bool darkmode = darkmodeNotifier.value;
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Settings', style: TextStyle(
                    color: darkmodeNotifier.value ? AppColors.white : AppColors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dark Mode', style: TextStyle(
                        fontSize: 18
                      ),),
                      Switch(
                        value: darkmodeNotifier.value, 
                        activeColor: AppColors.green,
                        padding: EdgeInsets.zero,
                        inactiveThumbColor: AppColors.white,
                        trackOutlineWidth: WidgetStatePropertyAll(0),
                        trackOutlineColor: WidgetStateColor.transparent,
                        onChanged: (value) {
                          setState((){
                            darkmode = !darkmode;
                            darkmodeNotifier.value = value;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}