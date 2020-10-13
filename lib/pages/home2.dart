import 'package:flutter/material.dart';

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("FairLog"),
      ),
      drawer: Drawer (
        child: ListView(
          padding: EdgeInsets.zero,
            children: <Widget> [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  )
                ),
              ),
              ListTile(
                leading: Icon(Icons.pedal_bike),
                title: Text('   Edit Member List'),
              ),
              Divider( color: Colors.grey,
              height: 0),
              ListTile(
                leading: Icon(Icons.baby_changing_station_outlined),
                title: Text('Overview'),
              ),
            ],
        )
      ),
      body:
          Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [],
              ),
              SizedBox(height: 100),
              Text(
                  'Choose your ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey[400],
              ),),
              Text(
                'Protocolant now! ',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[400],
                ),),
              SizedBox(height: 200),
              FlatButton(
                onPressed: () {},
                child: Text("Tap here"),
                color: Colors.lightBlueAccent[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  //side: BorderSide(color: Colors.white),
                ),
                minWidth: 200,
              )
            ],
          )
      );

  }
}
