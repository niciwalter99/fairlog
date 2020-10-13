import 'package:flutter/material.dart';

class EditMemberList extends StatefulWidget {
  @override
  _EditMemberListState createState() => _EditMemberListState();

}

class _EditMemberListState extends State<EditMemberList> {

  Map data = {};

  final controller = TextEditingController();

  var members = {0: 'hllp', 1:'t'};


  Map<int, TextEditingController> _controllers = {};

  int memberCount = 5;

  Widget initialList;
  bool isInitialised = false;

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(data['team']),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: memberCount,
              itemBuilder: (context, index) {
              print('here again: $index');
              if(members.containsKey(index)) {
                print('in editing');
                _controllers[index] = new TextEditingController(
                  text: members[index],);
              } else {
                print('nothing found');
                _controllers[index] = new TextEditingController();
              }
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(

                      onChanged: (text) {
                        print(members.length);
                        print(index);
                        members[index] = text;
                        print('index: $index');
                        print(members);
                      },
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: InputBorder.none,
                    ),
                    ),
                  ),
                );

              }
            ),
          ),


          Padding(
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                  iconSize: 30,
                  color: Colors.red,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          memberCount++;
                        });
                      }
                  ),
              ),
            ),
          )
      ],
      ),
    );
  }

  List<String> getMemberList() {
    List<String> list = List();
    members.forEach((key, value) => list.add(value));
    list.remove('');
    return list;
  }

  Map<int, String> initiateMap(list) {
    var map = {};
    Iterable<int>.generate(list.length).forEach((index)
    => {map[index] = list[index]});
    print(map);
  }

}
