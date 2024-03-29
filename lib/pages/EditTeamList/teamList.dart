
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


      String out = await Data.instance.readCounter();
      if(out != '0') {
        if(out != '') {
        teamNames = out.split('\,');
          print(teamNames);
          print(teamNames.length);
          setState(() {

          });
        }
      } //TODO No Team yet
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
        backgroundColor: Colors.grey[200],
          title: Text('Team Name'),
          content: TextField(
          decoration: InputDecoration(

            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: (Colors.orange)[200]!),
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
                borderSide: BorderSide(color: Colors.orange[200]!),
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

  sureToDelete(BuildContext context, int index) {

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey[200],
        title: Text('Are you sure you want to delete this team? You will also delete all members and all written protocols.'),
        actions: <Widget> [
          Row(
            children: [ FlatButton(onPressed: () async {
              DataBaseHelper.instance.deleteTeam(teamNames[index]);
              teamNames.remove(teamNames[index]);
              changeData();
              setState(() {

              });

              Navigator.pop(context);
            },
                child: Text('Yes')),
              FlatButton(onPressed: () {
                Navigator.pop(context);
              },
                  child: Text('No'))
            ],
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if(teamNames.length == 0) {
      print('noTeams');
      print(teamNames.length);
      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text('Choose your Team'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('You don\'t have any team member yet',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black26,
                      letterSpacing: 2,
                    ),),
                  Row(
                    children: [Text('')],
                  ),
                ],
              ),
            ),
          ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: 80,
            width: 80,
            child: FloatingActionButton(
              elevation: 0,
              onPressed: (){
                createTeam(context);
              },
              child: Icon(Icons.add, size: 50,),
              backgroundColor: Colors.orange[400],

            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      print(teamNames[index]);
                                      change(context, teamNames[index]);
                                    },
                                  ),
                                ),

                            Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      sureToDelete(context, index);
                                    },),
                                )
                              ],
                            ),
                            title: Text(teamNames[index], style: new TextStyle(fontSize: 25)),
                          ),
                          color: Colors.orange[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            //side: BorderSide(color: Colors.white),
                          ),
                          minWidth: 330,
                          height: 60,
                        ),
                      ),
                    );
                  }),
            ),

          ],

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: (){
              createTeam(context);
            },
            child: Icon(Icons.add, size: 50,),
            backgroundColor: Colors.orange[400],


          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }





}
