import 'package:fairlog/pages/ChooseProtocolant/yourprotocolant.dart';
import 'package:flutter/material.dart';
import 'package:fairlog/db/databaseHelper.dart';
class PresentList extends StatefulWidget {

  String team;

  PresentList(String team) {
    this.team = team;
  }
  @override
  _PresentListState createState() => _PresentListState(team);
}

class _PresentListState extends State<PresentList> {

  _PresentListState(String team) {
    this.team = team;
  }
  volunteer(BuildContext context, String name, int iD) async{

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: new RichText(
              text: new TextSpan(
              style: new TextStyle(
              color: Colors.black,
        ),
        children: <TextSpan>[
        new TextSpan(text: 'Do you really want to choose '),
        new TextSpan(text: 'Nici ', style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: 'as volunteer?'),
        ],
      ),
          ),
          actions: <Widget> [
                Row(
                  children: [ FlatButton(onPressed: () async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => YourProtocolant([iD], team)));
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

  //TODO "non" Present or "not"Present?
  var upperBottonText = ['Mark all as present', 'Mark all as not present'];
  int buttonIndex = 0;

  bool isInitalised = false;
  List<bool> _isChecked;

  String team;
  List<Map<String,dynamic>> teamMember = [];

  Color grey = Colors.grey;
  Color orange = Colors.orange[300];
  

  Color buttonColor;
  @override
  void initState() {
      buttonColor = grey;
      getTeamMember();
    super.initState();
  }

  void getTeamMember() async {
    teamMember = await DataBaseHelper.instance.getTeamMember(team);
    setState(() {

    });
    _isChecked = List.generate(teamMember.length, (index) => false);

    print(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Present List'),
        centerTitle: true,
      ),
      body: Builder(
      builder: (ctx) =>  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            children: [
                   FlatButton(onPressed: () {
                     setState(() {
                       if(buttonIndex == 0) {
                         _isChecked =
                             List.generate(_isChecked.length, (index) => true);
                         buttonIndex = 1;
                         buttonColor = orange;
                       } else {
                        _isChecked =
                              List.generate(_isChecked.length, (index) => false);
                        buttonColor = grey;
                         print(teamMember);
                         buttonIndex = 0;
                       }
                     });
                   },
                      child: Text(upperBottonText[buttonIndex]),
                     color: Colors.orange[300],
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                       //side: BorderSide(color: Colors.white),
                     ),
                   ),


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListView.builder(
                  itemCount: teamMember.length,
                    itemBuilder: (context, index) {
                    //TODO if no TeamMember, BUTOON FOR SIGNING TEAMs
                      return Card(
                        color: Colors.grey[50],
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: Colors.orange[300],
                          secondary: IconButton(
                            onPressed: () {
                              volunteer(context, teamMember[index][DataBaseHelper.columnName], teamMember[index][DataBaseHelper.columnId]);
                            },
                            icon: Icon(Icons.volunteer_activism),
                          ),
                          title: Text(
                              teamMember[index][DataBaseHelper.columnName]),
                          value: _isChecked[index],
                          onChanged: (bool value) {
                            setState(() {
                              _isChecked[index] = value;
                              if(!_isChecked.contains(true)) {
                                buttonColor = grey;
                              } else {
                                buttonColor = orange;
                              }
                            });
                          }
                        ),
                      );
                    }
              ),
                ),
              ),
              FlatButton(
                minWidth: 400,
                onPressed: () async{
                if(buttonColor == grey) {
                  final snackBar = SnackBar(
                    content: Text('Please choose at least one Team Member!'),
                      duration: const Duration(seconds: 1),
                  );

                  Scaffold.of(ctx).showSnackBar(snackBar);
                } else {
                  List<int> presentIDs = [];
                  for(int i = 0; i < teamMember.length; i++) {
                    if(_isChecked[i]) {
                      presentIDs.add(teamMember[i][DataBaseHelper.columnId]);
                    }
                  }
                  await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YourProtocolant(presentIDs, team)));
                }
              },
                child: Text('Choose Protocolant'),
                color: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  //side: BorderSide(color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
            ]
          ),
      ),

    );
  }
}
