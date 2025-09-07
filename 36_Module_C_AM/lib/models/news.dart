class News{
  String title;
  String summary;
  String image;
  String content;

  News({required this.title, required this.summary, required this.image, required this.content});

  factory News.fromJson(Map<String, dynamic> json) => News(
    title: json['Title'], 
    summary: json['Summary'], 
    image: json['Image'], 
    content: json['Content']
  );
}