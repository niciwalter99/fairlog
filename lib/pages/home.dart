import 'package:fairlog/pages/ChooseProtocolant/chooseProtocolant.dart';
import 'package:fairlog/pages/Overview/Overview.dart';
import 'package:flutter/material.dart';
import 'package:fairlog/pages/EditTeamList/teamList.dart';
import 'package:fairlog/pages/Connect/connect.dart';
import 'package:fairlog/globals.dart' as globals;


class Home extends StatefulWidget {

  //TODO loadscreen for Picture
  @override
  _HomeState createState() => _HomeState();
}

//Navigator.pushNamed(context, '/location');
class _HomeState extends State<Home> {

  void play() {
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 70),
                Image.asset('assets/Page1.png',
                  scale: 6,),
                Row(
                  children: <Widget>[
                  ],
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChooseProtocolant()));
                  },
                  child: Text("Choose Protocolant"),
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //side: BorderSide(color: Colors.white),
                  ),
                  minWidth: 250,
                  height: 60,
                ),
                SizedBox(height: 30),
                FlatButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeamList()));
                  },
                  child: Text("Edit Team List",
                  ),
                  color: Colors.orange[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //side: BorderSide(color: Colors.white),
                  ),
                  minWidth: 250,
                  height: 60,
                ),
                SizedBox(height: 30),
                FlatButton(
                  onPressed: () async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Overview()));
                  },
                  child: Text("Overview"),
                  color: Colors.orange[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //side: BorderSide(color: Colors.white),
                  ),
                  minWidth: 250,
                  height: 60,
                ),
                SizedBox(height: 30),
                FlatButton(
                  onPressed: () async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Connect()));
                  },
                  child: Text("Connect "),
                  color: Colors.orange[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //side: BorderSide(color: Colors.white),
                  ),
                  minWidth: 250,
                  height: 60,
                ),


              ]
          );
        }
      )
    );
  }
}
