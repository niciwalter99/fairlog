import 'package:fairlog/pages/ChooseProtocolant/yourprotocolant.dart';
import 'package:flutter/material.dart';
import 'package:fairlog/db/databaseHelper.dart';
class PresentList extends StatefulWidget {

  String team = "";

  PresentList(String team) {
    this.team = team;
  }
  @override
  _PresentListState createState() => _PresentListState(team);
}

class _PresentListState extends State<PresentList> {

  String team = "";

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
        new TextSpan(text: 'Do you really want to choose ',  style: new TextStyle(fontSize: 25)),
        new TextSpan(text: name, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          new TextSpan(text: ' as volunteer?', style: new TextStyle(fontSize: 25)),
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
                  child: Text('Yes', style: new TextStyle(fontSize: 30))),
                  FlatButton(onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No', style: new TextStyle(fontSize: 30)))
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
  late List<bool> _isChecked;

  List<Map<String,dynamic>> teamMember = [];

  Color grey = Colors.grey;
  Color? orange = Colors.orange[300];
  

  late Color buttonColor;
  @override
  void initState() {
      buttonColor = grey;
      getTeamMember();
    super.initState();
  }

  void getTeamMember() async {
    teamMember = (await DataBaseHelper.instance.getTeamMember(team))!;
    setState(() {

    });
    _isChecked = List.generate(teamMember.length, (index) => false);

    print(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    if(teamMember.length == 0) {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text('Present List'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
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
          )
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Present List'),
        centerTitle: true,
      ),
      body: Builder(
      builder: (ctx) =>  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: FlatButton(onPressed: () {
                       setState(() {
                         if(buttonIndex == 0) {
                           _isChecked =
                               List.generate(_isChecked.length, (index) => true);
                           buttonIndex = 1;
                           buttonColor = orange!;
                         } else {
                          _isChecked =
                                List.generate(_isChecked.length, (index) => false);
                          buttonColor = grey;
                           print(teamMember);
                           buttonIndex = 0;
                         }
                       });
                     },
                        child: Text(upperBottonText[buttonIndex], style: TextStyle(fontSize: 20)),
                       color: Colors.orange[300],
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                         //side: BorderSide(color: Colors.white),
                       ),
                       height: 50,
                     ),
                   ),


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListView.builder(
                  itemCount: teamMember.length,
                    itemBuilder: (context, index) {
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
                              teamMember[index][DataBaseHelper.columnName],
                            style: TextStyle(fontSize: 30),
                          ),
                          value: _isChecked[index],
                          onChanged: (bool? value) => {
                            setState(() {
                              _isChecked[index] = value!;
                              if(!_isChecked.contains(true)) {
                                buttonColor = grey;
                              } else {
                                buttonColor = orange!;
                              }
                            })
                          }
                        ),
                      );
                    }
              ),
                ),
              ),
              FlatButton(
                minWidth: 350,
                height: 60,
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
                  borderRadius: BorderRadius.circular(10),
                  //side: BorderSide(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
            ]
          ),
      ),

    );
  }
}
