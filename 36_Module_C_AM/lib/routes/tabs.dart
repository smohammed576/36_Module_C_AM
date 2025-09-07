import 'package:flutter/material.dart';
import 'package:edu.ws2022.c36.am/constants/colors.dart';
import 'package:edu.ws2022.c36.am/helpers/settings.helper.dart';
import 'package:edu.ws2022.c36.am/screens/history.dart';
import 'package:edu.ws2022.c36.am/screens/news/news.dart';
import 'package:edu.ws2022.c36.am/screens/results/results.dart';

class TabsNavigation extends StatefulWidget{
  const TabsNavigation({super.key});

  @override
  State<TabsNavigation> createState() => _TabsNavigationState();
}

class _TabsNavigationState extends State<TabsNavigation> with TickerProviderStateMixin{
  late ScrollController scrollController;
  late TabController tabController;
  late AnimationController animationController;
  bool hasScrolled = false;
  int tabIndex = 0;

  @override
  void initState(){
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener((){
      final scrolled = scrollController.offset > 80;
      if(scrolled != hasScrolled){
        setState(() {
          hasScrolled = scrolled;
        });
      }
    });
    tabController = TabController(
      initialIndex: 0,
      length: 3, 
      vsync: this
    );
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
      reverseDuration: Duration(seconds: 4)
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.blue,
            stretch: true,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () => openSettingsBottomsheet(context),
                icon: Icon(Icons.settings, color: AppColors.white,),
              )
            ],
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
            title: Stack(
              children: [
                Align(
                  child: Image.asset('assets/images/WS_Logo_White_RGB-close.png', height: hasScrolled ? 100 : null, width: 200,)
                ),
                ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(11), bottomRight: Radius.circular(11)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedBuilder(
                      animation: animationController, 
                      builder: (context, child) {
                        final dx = animationController.value * (MediaQuery.sizeOf(context).width - 10);
                        return Positioned(
                          left: dx - 400,
                          bottom: -780,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightblue.withAlpha(150),
                              borderRadius: BorderRadius.circular(500)
                            ),
                            width: 800,
                            height: 800,
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: animationController, 
                      builder: (context, child) {
                        final dx = animationController.value * (MediaQuery.sizeOf(context).width - 10);
                        return Positioned(
                          right: dx - 400,
                          bottom:  -780,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.darkblue.withAlpha(150),
                              borderRadius: BorderRadius.circular(500)
                            ),
                            width: 800,
                            height: 800,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              ],
            ),
              stretchModes: [
                StretchMode.zoomBackground
              ],
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: hasScrolled ? 0 : 80),
            ),
            bottom: TabBar(
              controller: tabController,
              labelColor: AppColors.white,
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              unselectedLabelColor: AppColors.lightblue,
              indicatorColor: AppColors.white,
              dividerHeight: 0,
              indicatorPadding: EdgeInsets.all(5),
              labelPadding: EdgeInsets.all(10),
              onTap: (value) {
                setState(() {
                  tabIndex = value;
                });
              },
              tabs: [
                Text('News'),
                Text('Results'),
                Text('History')
              ],
            ),
          ),
          if(tabIndex == 0)
          NewsScreen(
            onDrag: (index){
              setState(() {
                tabIndex = index;
                tabController.animateTo(index);
              });
            },
          ),
          if(tabIndex == 1)
          ResultsScreen(
            onDrag: (index){
              setState(() {
                tabIndex = index;
                tabController.animateTo(index);
              });
            },
          ),
          if(tabIndex == 2)
          HistoryScreen(
            onDrag: (index){
              setState(() {
                tabIndex = index;
                tabController.animateTo(index);
              });
            }
          )
        ],
      ),
    );
  }
}