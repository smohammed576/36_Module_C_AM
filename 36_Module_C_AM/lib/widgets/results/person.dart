import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/models/results/person.dart';
import 'package:edu.ws2022.c36.am/notifiers/settings.dart';

class ResultsPerson extends StatefulWidget{
  final Person person;
  const ResultsPerson({super.key, required this.person});

  @override
  State<ResultsPerson> createState() => _ResultsPersonState();
}

class _ResultsPersonState extends State<ResultsPerson> with SingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void initState(){
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4)
    )..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkmodeNotifier.value ? AppColors.darkgrey : AppColors.black.withAlpha(25),
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/${widget.person.avatar}', width: 150, height: 150, fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          ClipRRect(
            child: SizedBox(
              width: 150,
              child: AnimatedBuilder(
                animation: animationController, 
                builder: (context, child) {
                  final offset = widget.person.name.length > 12 ? -(animationController.value * 200) : 0.0;
                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: child,
                  );
                },
                child: Text(widget.person.name, softWrap: false, style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                    overflow: TextOverflow.visible,
                  ),
              )
            ),
          ),
          ClipRRect(
            child: SizedBox(
              width: 150,
              child: AnimatedBuilder(
                animation: animationController, 
                builder: (context, child) {
                  final offset = widget.person.skill.length > 12 ? -(animationController.value * 200) : 0.0;
                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: child,
                  );
                },
                child: Text(widget.person.skill, style: TextStyle(
                  color: darkmodeNotifier.value ? AppColors.lightgrey : AppColors.black.withAlpha(150),
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
                  softWrap: false,
                  overflow: TextOverflow.visible,
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}