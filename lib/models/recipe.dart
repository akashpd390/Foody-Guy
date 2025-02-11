

class Recipe{
  int id;
  String title;
  String image;

  Recipe({required this.id, required this.title, required this.image});

  factory Recipe.fromJson(Map<String,dynamic> json){
    var id = json["id"];
    var title = json["title"];
    var image = json["image"];

    return Recipe(id: id, title: title, image: image);
  }

  Map toMap()=>{
   "id" : id,
    "title" : title,
    "image" : image,
  };

}