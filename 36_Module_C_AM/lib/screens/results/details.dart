import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/models/results/person.dart';
import 'package:edu.ws2022.c36.am/models/results/result.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';
import 'package:edu.ws2022.c36.am/widgets/appbar.dart';
import 'package:edu.ws2022.c36.am/widgets/results/medal.dart';
import 'package:edu.ws2022.c36.am/widgets/results/person.dart';

class ResultsDetailsScreen extends StatelessWidget{
  final Result item;
  const ResultsDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: DetailsAppbar(label: 'Results')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: darkmodeNotifier.value ? AppColors.darkgrey : AppColors.black.withAlpha(30)
              ),
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/${item.flag}', width: 140,),
                  SizedBox(height: 10,),
                  Text(item.country, style: TextStyle(
                    color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
              child: Column(
                children: [
                  ResultsMedal(color: 'Gold'),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: item.gold.length,
                      itemBuilder: (context, index) {
                        final Person person = item.gold[index];
                        return ResultsPerson(person: person);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  ResultsMedal(color: 'Silver'),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: item.silver.length,
                      itemBuilder: (context, index) {
                        final Person person = item.silver[index];
                        return ResultsPerson(person: person);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  ResultsMedal(color: 'Bronze'),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: item.bronze.length,
                      itemBuilder: (context, index) {
                        final Person person = item.bronze[index];
                        return ResultsPerson(person: person);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  ResultsMedal(color: 'Excellence'),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: item.excellence.length,
                      itemBuilder: (context, index) {
                        final Person person = item.excellence[index];
                        return ResultsPerson(person: person);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}