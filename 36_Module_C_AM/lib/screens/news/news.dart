import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/models/news.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';
import 'package:edu.ws2022.c36.am/screens/news/details.dart';

class NewsScreen extends StatefulWidget{
  final Function(int) onDrag;
  const NewsScreen({super.key, required this.onDrag});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>{
  List<News>? news;

  @override
  void initState(){
    super.initState();
    getNews();
  }

  void getNews() async{
    final String response = await rootBundle.loadString('assets/data/news.json');
    final List results = json.decode(response);
    final List<News> data = results.map((item) => News.fromJson(item)).toList();
    setState(() {
      news = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if(details.primaryVelocity! < -400){
            widget.onDrag(1);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: news != null && news!.isNotEmpty ? List.generate(news!.length, (index) {
              final News item = news![index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsDetailsScreen(item: item),)
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: darkmodeNotifier.value ? AppColors.darkgrey : AppColors.black.withAlpha(20)
                  ),
                  width: MediaQuery.sizeOf(context).width - 40,
                  height: 90,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        child: Image.asset('assets/images/${item.image}', width: 100, height: 90, fit: BoxFit.cover,),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, style: TextStyle(
                              color: darkmodeNotifier.value ? AppColors.white : AppColors.darkblue,
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(item.summary, style: TextStyle(
                              color: darkmodeNotifier.value ? AppColors.lightgrey : AppColors.black.withAlpha(100),
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },) : []
          ),
        ),
      ),
    );
  }
}