import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/models/results/result.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';
import 'package:edu.ws2022.c36.am/screens/results/details.dart';
import 'package:edu.ws2022.c36.am/widgets/results/medals.dart';

class ResultsScreen extends StatefulWidget{
  final Function(int) onDrag;
  const ResultsScreen({super.key, required this.onDrag});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<Result>? results;

  @override
  void initState(){
    super.initState();
    getResults();
  }

  void getResults() async{
    final String response = await rootBundle.loadString('assets/data/result.json');
    final List result = json.decode(response);
    final List<Result> data = result.map((item) => Result.fromJson(item)).toList();
    setState(() {
      results = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if(details.primaryVelocity! >= 400){
            widget.onDrag(0);
          }
          else if(details.primaryVelocity! < -400){
            widget.onDrag(2);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mock data', style: TextStyle(
                    color: AppColors.black.withAlpha(150),
                    fontWeight: FontWeight.w600
                  ),),
                  Row(
                    children: [
                      Image.asset('assets/images/medals/medal.png', height: 25, width: 18, fit: BoxFit.cover, colorBlendMode: BlendMode.srcATop, color: AppColors.medals['gold'],),
                      SizedBox(width: 2,),
                      Image.asset('assets/images/medals/medal.png', height: 25, width: 18, fit: BoxFit.cover, colorBlendMode: BlendMode.srcATop, color: AppColors.medals['silver'],),
                      SizedBox(width: 2,),
                      Image.asset('assets/images/medals/medal.png', height: 25, width: 18, fit: BoxFit.cover, colorBlendMode: BlendMode.srcATop, color: AppColors.medals['bronze'],),
                      SizedBox(width: 2,),
                      Image.asset('assets/images/medals/medal.png', height: 25, width: 18, fit: BoxFit.cover, colorBlendMode: BlendMode.srcATop, color: AppColors.medals['excellence'],),
                      SizedBox(width: 15,),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: results != null && results!.isNotEmpty ? List.generate(results!.length, (index) {
                  final Result item = results![index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultsDetailsScreen(item: item),)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkmodeNotifier.value ? AppColors.darkgrey : AppColors.black.withAlpha(20),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/${item.flag}', width: 70, height: 50, fit: BoxFit.contain,),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.country, style: TextStyle(
                                  // color: AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),),
                                Text('#${index + 1}', style: TextStyle(
                                  color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            child: Row(
                              children: [
                                ResultsMedals(
                                  amount: item.gold.length, 
                                  color: 'gold'
                                ),
                                SizedBox(width: 8,),
                                ResultsMedals(
                                  amount: item.silver.length, 
                                  color: 'silver'
                                ),
                                SizedBox(width: 8,),
                                ResultsMedals(
                                  amount: item.bronze.length, 
                                  color: 'bronze'
                                ),
                                SizedBox(width: 8,),
                                ResultsMedals(
                                  amount: item.excellence.length, 
                                  color: 'excellence'
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },) : [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}