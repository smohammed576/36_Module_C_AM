import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/models/history.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';

class HistoryScreen extends StatefulWidget{
  final Function(int) onDrag;
  const HistoryScreen({super.key, required this.onDrag});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<History>? history;

  @override
  void initState(){
    super.initState();
    getHistory();
  }

  void getHistory() async{
    final String response = await rootBundle.loadString('assets/data/history.json');
    final List results = json.decode(response);
    final List<History> data = results.map((item) => History.fromJson(item)).toList();
    setState(() {
      history = data;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if(details.primaryVelocity! > 400){
            widget.onDrag(1);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: history != null && history!.isNotEmpty ? 
            SizedBox(
              height: 1200,
              child: Timeline.tileBuilder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                builder: TimelineTileBuilder.connected(
                  itemCount: history!.length,
                  nodePositionBuilder: (context, index) => 0,
                  contentsAlign: ContentsAlign.basic,
                  indicatorPositionBuilder: (context, index) => 0,
                  indicatorBuilder: (context, index) {
                    return DotIndicator(
                      color: Colors.transparent,
                      border: BoxBorder.all(color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue, width: 2),
                      size: 20,
                      child: index == 1 ? Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue,
                          ),
                        ),
                      ) : null
                    );
                  },
                  connectorBuilder: (context, index, type) => SolidLineConnector(
                    color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue,
                  ),
                  contentsBuilder: (context, index) {
                    final History item = history![history!.length - (index + 1)];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.date, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),),
                          Text(item.title, style: TextStyle(
                            color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Image.asset('assets/images/${item.logo}', width: 100,),
                              SizedBox(width: 10,),
                              SizedBox(
                                width: 200,
                                child: Text(item.description)
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
           : null,
        ),
      ),
    );
  }
}