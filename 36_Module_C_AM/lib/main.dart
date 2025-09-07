import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';
import 'package:edu.ws2022.c36.am/routes/tabs.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ValueListenableBuilder<bool>(
      valueListenable: darkmodeNotifier,
      builder: (context, darkmode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: darkmode ? AppColors.black : AppColors.white,
            brightness: darkmode ? Brightness.dark : Brightness.light
          ),
          home: TabsNavigation(),
        );
      }
    )
  );
}