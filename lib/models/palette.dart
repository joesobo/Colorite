class Palette{
  int id;
  final String name;
  final String myColorList;

  Palette({this.id, this.name, this.myColorList});

  factory Palette.fromJson(Map<String, dynamic> parsedJson){
    return Palette(
      id: parsedJson['id'],
      name: parsedJson['name'],
      myColorList: parsedJson['myColorList'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "myColorList": this.myColorList,
    };
  }

  
}