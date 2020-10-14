class TeamMember {

  /*int writtenProtocols = 0;
  String name;
  String teamName;*/

  int id;
  String name;
  int age;

  TeamMember({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }


}