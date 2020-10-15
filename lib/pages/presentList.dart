import 'package:flutter/material.dart';
import 'package:fairlog/db/databaseHelper.dart';
class PresentList extends StatefulWidget {
  @override
  _PresentListState createState() => _PresentListState();
}

class _PresentListState extends State<PresentList> {

  var upperBottonText = ['Mark all as present', 'Mark all as not present'];
  int buttonIndex = 0;

  bool isInitalised = false;
  List<bool> _isChecked;

  String team;
  List<Map<String,dynamic>> teamMember = [];

  @override
  void initState() {

    // TODO: implement initState
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
    Map<String, String> data = ModalRoute.of(context).settings.arguments;
    team = data['team'];
    if(!isInitalised) {
      getTeamMember();
      isInitalised = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Present List'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        children: [
               FlatButton(onPressed: () {
                 setState(() {
                   if(buttonIndex == 0) {
                     _isChecked =
                         List.generate(_isChecked.length, (index) => true);
                     buttonIndex = 1;
                     print('up');
                   } else {
                    _isChecked =
                          List.generate(_isChecked.length, (index) => false);
                     print(teamMember);
                     buttonIndex = 0;
                   }
                 });
               },
                  child: Text(upperBottonText[buttonIndex]),
                 color: Colors.orange,
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
                    child: CheckboxListTile(
                      checkColor: Colors.orange,
                      activeColor: Colors.black,
                      title: Text(
                          teamMember[index][DataBaseHelper.columnName]),
                      value: _isChecked[index],
                      onChanged: (bool value) {
                        setState(() {
                          _isChecked[index] = value;
                        });
                      }
                    ),
                  );
                }
          ),
            ),
          ),
          FlatButton(onPressed: () {
            List<int> presentIDs = [];
            for(int i = 0; i < teamMember.length; i++) {
              if(_isChecked[i]) {
                presentIDs.add(teamMember[i][DataBaseHelper.columnId]);
              }
            }
            print(presentIDs);
          },
            child: Text('Choose Protocolant'),
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              //side: BorderSide(color: Colors.white),
            ),
          ),
          SizedBox(height: 30),
        ]
      ),

    );
  }
}
