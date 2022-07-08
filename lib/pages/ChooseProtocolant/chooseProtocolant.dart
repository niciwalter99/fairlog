import 'package:flutter/material.dart';
import 'package:fairlog/utility/Data.dart';
import 'package:fairlog/pages/ChooseProtocolant/presentList.dart';

class ChooseProtocolant extends StatefulWidget {
  @override
  _ChooseProtocolantState createState() => _ChooseProtocolantState();
}



class _ChooseProtocolantState extends State<ChooseProtocolant> {

  List<String> teams = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async{
    String out = await Data.instance.readCounter();  //read Data from local storage
    if(out != '0') {
      if(out != '') {
        teams = out.split('\,');
        print(teams);
        print(teams.length);
        setState(() {

        });
      }
    } //TODO No Team yet
  }

//TODO Screen with "you dont have any teams yet, click here to add some"
  @override
  Widget build(BuildContext context) {
    if(teams.length == 0) {
      print('noTeams');
      print(teams.length);
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
          )
      );
    } else {
      print('teams');
      print(teams);
      print(teams.length);
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
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: FlatButton(
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    PresentList(teams[index])));
                            //Navigator.pushNamed(context, '/presentList', arguments: {'team': teams[index]});
                            //final result = await Navigator.push(
                            //context,
                            //MaterialPageRoute(builder: (context) => EditMemberList(team: teamNames[index],)),
                            //);
                          },
                          child: Text(teams[index], style: TextStyle(fontSize: 25)),
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
      );
    }
  }
}

