import 'package:fairlog/pages/ChooseProtocolant/chooseProtocolant.dart';
import 'package:flutter/material.dart';
import 'package:fairlog/pages/EditTeamList/teamList.dart';


class Home extends StatefulWidget {

  //TODO loadscreen for Picture
  @override
  _HomeState createState() => _HomeState();
}

//Navigator.pushNamed(context, '/location');
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 70),
                Image.asset('assets/FairLog.jpg',
                  scale: 1,),
                Row(
                  children: <Widget>[
                  ],
                ),
                SizedBox(height: 60),
                FlatButton(
                  onPressed: () async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChooseProtocolant()));
                  },
                  child: Text("Choose Protocolant"),
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    //side: BorderSide(color: Colors.white),
                  ),
                  minWidth: 250,
                  height: 50,
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
                    borderRadius: BorderRadius.circular(18),
                    //side: BorderSide(color: Colors.white),
                  ),
                  minWidth: 250,
                  height: 50,
                ),
                SizedBox(height: 30),
                FlatButton(
                  onPressed: () {},
                  child: Text("Overview"),
                  color: Colors.orange[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    //side: BorderSide(color: Colors.white),
                  ),
                  minWidth: 250,
                  height: 50,
                ),

              ]
          );
        }
      )
    );
  }
}
