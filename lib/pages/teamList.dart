import 'package:flutter/material.dart';
import 'package:fairlog/pages/editMemberList.dart';
import 'package:fairlog/db/databaseHelper.dart';


class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {

  List<String> teamNames = ['Team A', 'Team B', 'Team C'];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Choose your Team'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: teamNames.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      child: FlatButton(
                        onPressed: () async {
                          print(await DataBaseHelper.instance.queryAll());
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditMemberList(team: teamNames[index],)),
                          );
                          print(await DataBaseHelper.instance.queryAll());
                          print(result);
                        },
                        child: Text(teamNames[index]),
                        color: Colors.orange[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          //side: BorderSide(color: Colors.white),
                        ),
                        minWidth: 200,
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
          onPressed: (){},
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,

        ),
      ),
    );
  }

}
