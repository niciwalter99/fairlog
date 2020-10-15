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

  List<Map<String,dynamic>> members = [];

  @override
  void initState() {
    updateDataBase();
    super.initState();
  }

  void updateDataBase() async {
    members = await DataBaseHelper.instance.getTeamMember(team);
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
      return Scaffold(
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
                itemBuilder: (context, index) {
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
                                icon: Icon(Icons.delete),
                            //TODO Altert Dialog mit Are you sure you want to delete
                            onPressed: () {
                                  DataBaseHelper.instance.delete(members[index][DataBaseHelper.columnId]);
                                  updateDataBase();
                            },)

                            ],
                        ),
                        title: Text(members[index][DataBaseHelper.columnName]),
                      ),
                    ),
                  );

                }
              ),
            ),


            /*Padding(
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
            )*/
        ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {

              createData(context);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,

          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
