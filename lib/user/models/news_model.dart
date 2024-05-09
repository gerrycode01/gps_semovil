class News{
  String title;
  String description;
  String date;

  News({
    required this.title,
    required this.description,
    required this.date
  });


  Map<String, dynamic> toJSON() {
    return {
      'title':title,
      'description':description,
      'date':date
    };
  }



}