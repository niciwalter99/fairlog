import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              children: <Widget> [
              ],
            ),
            Container(

              child: Padding(
                  padding: EdgeInsets.all(0),
                child: Text(
                  '',

                   style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                     letterSpacing: 0,
                     color: Colors.grey[100],
                     backgroundColor: Colors.orange[400],
                  )
            ),
              )
            ),
            SizedBox(height: 220),
            FlatButton(
              onPressed: () {},
              child: Text("Choose Protocolant"),
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                //side: BorderSide(color: Colors.white),
              ),
              minWidth: 200,
            ),
            SizedBox(height: 30),
            FlatButton(
              onPressed: () {},
              child: Text("Edit Team List",
              ),
              color: Colors.orange[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                //side: BorderSide(color: Colors.white),
              ),
              minWidth: 200,
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
              minWidth: 200,
            ),

          ]
        )
    );
  }
}
