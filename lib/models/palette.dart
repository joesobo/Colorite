class Palette{
  final String name;
  final String myColorList;

  Palette({this.name, this.myColorList});

  factory Palette.fromJson(Map<String, dynamic> parsedJson){
    return Palette(
      name: parsedJson['name'],
      myColorList: parsedJson['myColorList'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "name": this.name,
      "myColorList": this.myColorList,
    };
  }

  
}