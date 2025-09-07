class History{
  String date;
  String title;
  String logo;
  String description;

  History({required this.date, required this.title, required this.logo, required this.description});

  factory History.fromJson(Map<String, dynamic> json) => History(
    date: json['date'], 
    title: json['title'], 
    logo: json['logo'], 
    description: json['description']
  );
}