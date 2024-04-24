class Space {
  String name;
  String type;

  Space({
    required this.name,
    required this.type,
  });

 

  set spaceName(String newName) {
    name = newName;
  }

  set spaceType(String newType) {
    type = newType;
  }

  toJson() {}
}
