class Palette {
  int id;
  final String name;
  final String myColorList;
  int priority;

  Palette({this.id, this.name, this.myColorList, this.priority});

  factory Palette.fromJson(Map<String, dynamic> parsedJson) {
    return Palette(
      id: parsedJson['id'],
      name: parsedJson['name'],
      myColorList: parsedJson['myColorList'],
      priority: parsedJson['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "myColorList": this.myColorList,
      "priority": this.priority,
    };
  }
}
