import 'package:edu.ws2022.c36.am/models/results/person.dart';

class Result{
  String country;
  String flag;
  List<Person> gold;
  List<Person> silver;
  List<Person> bronze;
  List<Person> excellence;

  Result({required this.country, required this.flag, required this.gold, required this.silver, required this.bronze, required this.excellence});

  factory Result.fromJson(Map<String, dynamic> json){
    final List goldData = json['categories']['gold'];
    final List<Person> allGold = goldData.map((item) => Person.fromJson(item)).toList();

    final List silverData = json['categories']['silver'];
    final List<Person> allSilver = silverData.map((item) => Person.fromJson(item)).toList();

    final List bronzeData = json['categories']['bronze'];
    final List<Person> allBronze = bronzeData.map((item) => Person.fromJson(item)).toList();

    final List excellence = json['categories']['excellence'];
    final List<Person> allExcellence = excellence.map((item) => Person.fromJson(item)).toList();
    
    return Result(
      country: json['country'], 
      flag: json['flag'], 
      gold: allGold.isEmpty ? [] : allGold, 
      silver: allSilver.isEmpty ? [] : allSilver, 
      bronze: allBronze.isEmpty ? [] : allBronze, 
      excellence: allExcellence.isEmpty ? [] : allExcellence
    );
  }
  
}