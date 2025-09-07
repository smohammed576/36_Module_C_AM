import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/models/news.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';
import 'package:edu.ws2022.c36.am/widgets/appbar.dart';

class NewsDetailsScreen extends StatefulWidget{
  final News item;
  const NewsDetailsScreen({super.key, required this.item});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  bool liked = false;

  @override
  void initState(){
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300)
    );
    animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: DetailsAppbar(label: 'News'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.title, style: TextStyle(
                color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 10,),
              Text(widget.item.summary, style: TextStyle(
                // color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17
              ),),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/${widget.item.image}', width: MediaQuery.sizeOf(context).width, height: 260, fit: BoxFit.cover,),
              ),
              SizedBox(height: 10,),
              Text(widget.item.content, style: TextStyle(
                color: darkmodeNotifier.value ? AppColors.lightgrey : AppColors.black.withAlpha(180),
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        liked = !liked;
                        animationController.forward(from: 0);
                      });
                    },
                    icon: ScaleTransition(
                      scale: Tween<double>(begin: 1, end: 1.2).animate(
                        CurvedAnimation(
                          parent: animationController, 
                          curve: Curves.easeOut,
                          reverseCurve: Curves.easeIn
                        )
                      ),
                      child: Icon(liked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined, color: darkmodeNotifier.value ? AppColors.lightblue : AppColors.blue, size: 30,),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}