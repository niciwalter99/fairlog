
import 'package:flutter/material.dart';
import 'package:fairlog/pages/EditTeamList/editMemberList.dart';
import 'package:fairlog/db/databaseHelper.dart';
import 'package:fairlog/utility/Data.dart';
import 'dart:convert';



class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {

  List<String> teamNames = [];

  @override
  void initState() {
    updateData();
    super.initState();
  }

  void updateData() async {


      String out = await Data.instance.readCounter();  //read Data from local storage
      teamNames = out.split('\,');
      print(teamNames);
      setState(() {

      });
  }

  void changeData() async{
   await Data.instance.writeCounter(teamNames);  //write Data to local storage
   setState(() {

   });
  }

  createTeam(BuildContext context) async{
    //TODO Check if TeamName is forgiven
    TextEditingController c = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.orange[50],
          title: Text('Team Name'),
          content: TextField(
          decoration: InputDecoration(

            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange[200]),
            ),
          ),
      controller: c,
          ),
          actions: <Widget> [
            MaterialButton(onPressed: () async {
              teamNames.add(c.text);
              changeData();
              Navigator.of(context).pop();
            },
                child: Text('Submit'))
          ]
      );
    });
  }

  change(BuildContext context, String teamName) async{
//TODO Check if TeamName is forgiven
    TextEditingController c = TextEditingController(text: teamName);
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: Text('Team Name'),
          content: TextField(
            controller: c,
            decoration: InputDecoration(

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange[200]),
              ),
            ),
          ),
          actions: <Widget> [
            MaterialButton(onPressed: () async {
              String name = c.text;
              await DataBaseHelper.instance.changeTeamNames(teamName, name);
              Navigator.of(context).pop();
              teamNames[teamNames.indexOf(teamName)] = name;
              changeData();
            },
                child: Text('Submit'))
          ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Choose your Team'),
        centerTitle: true,
      ),
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: teamNames.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        child: FlatButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditMemberList(team: teamNames[index],)),
                            );
                            print(result);
                          },
                          child: ListTile(
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    print(teamNames[index]);
                                    change(context, teamNames[index]);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  //TODO Altert Dialog mit Are you sure you want to delete
                                  onPressed: () {
                                    teamNames.remove(teamNames[index]);
                                    //TODO delete Data from Table
                                  },)

                              ],
                            ),
                            title: Text(teamNames[index]),
                          ),
                          color: Colors.orange[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            //side: BorderSide(color: Colors.white),
                          ),
                          minWidth: 330,
                        ),
                      ),
                    );
                  }),
            ),

          ],

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: (){
            createTeam(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.orange[400],

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }





}
