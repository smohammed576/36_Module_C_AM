class Person{
  String name;
  String avatar;
  String skill;

  Person({required this.name, required this.avatar, required this.skill});

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    name: json['name'], 
    avatar: json['avatar'], 
    skill: json['skill_name']
  );
}