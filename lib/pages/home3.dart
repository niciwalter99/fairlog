import 'package:flutter/material.dart';

class Home3 extends StatefulWidget {
  @override
  _Home3State createState() => _Home3State();
}

class _Home3State extends State<Home3> {

  static List<String> items = List<String>.generate(10, (i) => "Item $i");

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
 /* Container(
    child: Column(
      children: <Widget> [
      Text('Test'),
      ListView.builder (
        itemCount: items.length,
        itemBuilder: (context, index) {
        return ListTile(
      title: Text('${items[index]}'),
      );
        },
      ),
      ]
    ),
  ),
    */Column (
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
        SizedBox(height: 20),
        SizedBox(height: 100),
        FlatButton(
          onPressed: () {},
          child: Text("Team A"),
          color: Colors.lightBlueAccent[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            //side: BorderSide(color: Colors.white),
          ),
          minWidth: 200,
        ),
        SizedBox(height: 10),
        FlatButton(
          onPressed: () {},
          child: Text("Team B"),
          color: Colors.lightBlueAccent[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            //side: BorderSide(color: Colors.white),
          ),
          minWidth: 200,
        ),
        SizedBox(height: 10),
        FlatButton(
          onPressed: () {},
          child: Text("Team C"),
          color: Colors.lightBlueAccent[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            //side: BorderSide(color: Colors.white),
          ),
          minWidth: 200,
        )
      ],
    ),
    Text(
      'Choose Team, Edit Member List',
      style: optionStyle,
    ),
    Text(
      'List with Teams -> Every person count of written protocols',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent[100],
        title: const Text('FairLog'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Edit Member List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Overview',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
  }
