import 'package:fairlog/db/databaseHelper.dart';
import 'package:flutter/material.dart';

class EditMemberList extends StatefulWidget {

  final String team;
  EditMemberList({this.team});


  @override
  _EditMemberListState createState() => _EditMemberListState(team);

}

class _EditMemberListState extends State<EditMemberList> {

  String team;

  _EditMemberListState(String team) {
    this.team = team;
  }

  final controller = TextEditingController();

  List<Map<String,dynamic>> members = [];


  Map<int, TextEditingController> _controllers = {};


  @override
  void initState() {
    updateDataBase();
    super.initState();
  }

  void updateDataBase() async {
    members = await DataBaseHelper.instance.queryAll();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    changeData(BuildContext context, int iD) async{

      TextEditingController c = TextEditingController(text: await DataBaseHelper.instance.getName(iD));
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Change Name'),
          content: TextField(
            controller: c,
          ),
          actions: <Widget> [
            MaterialButton(onPressed: () async {
              await DataBaseHelper.instance.update({DataBaseHelper.columnId: iD,
                  DataBaseHelper.columnName: c.text.toString()});
                  Navigator.of(context).pop(c.text.toString());
                  updateDataBase();
            },
            child: Text('Submit'))
          ]
        );
      });
    }

    createData(BuildContext context) {

      TextEditingController c = TextEditingController();
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
            title: Text('Change Name'),
            content: TextField(
              controller: c,
            ),
            actions: <Widget> [
              MaterialButton(onPressed: () async{
                await DataBaseHelper.instance.insert({DataBaseHelper.columnTeam: team,
                    DataBaseHelper.columnWrittenProtocol: '0', DataBaseHelper.columnName: c.text.toString()});
                    Navigator.of(context).pop(c.text.toString());
                    updateDataBase();
              },
                  child: Text('Submit'))
            ]
        );
      });
    }

   // data = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, members);
        return false;},
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(team),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder (
              itemCount: members.length,
                itemBuilder: (context, index) {/*
                  key = members.keys.elementAt(index);
                  _controllers[index] = new TextEditingController(
                    text: members[key],);
                } else {
                  key = index;
                  _controllers[index] = new TextEditingController();
                }*/
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                            onPressed: () { changeData(context, members[index][DataBaseHelper.columnId]);
                            },
                            ),
                            IconButton(
                                icon: Icon(Icons.delete),)

                            ],
                        ),
                        title: Text(members[index][DataBaseHelper.columnName]),
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

                      createData(context);
                        }
                    ),
                ),
              ),
            )
        ],
        ),
      ),
    );
  }

}
