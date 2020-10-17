import 'package:flutter/material.dart';
import 'package:fairlog/utility/Data.dart';
import 'file:///D:/IISL/apps/fairlog/lib/pages/ChooseProtocolant/presentList.dart';

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
    teams = out.split('\,');
    print(teams);
    setState(() {

    });
  }

//TODO Screen with "you dont have any teams yet, click here to add some"
  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.fromLTRB(0,30,0,0),
                      child: FlatButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PresentList(teams[index])));
                          //Navigator.pushNamed(context, '/presentList', arguments: {'team': teams[index]});
                          //final result = await Navigator.push(
                            //context,
                            //MaterialPageRoute(builder: (context) => EditMemberList(team: teamNames[index],)),
                          //);
                        },
                        child: Text(teams[index]),
                        color: Colors.orange[getColor(index)],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          //side: BorderSide(color: Colors.white),
                        ),
                        minWidth: 330,
                        height: 50,
                      ),
                    ),
                  );
                }),
          ),

        ],

      ),
    );
  }
  
  int getColor(int index) {
    int num = 400 - index * 100;
    if(num > 0) return num;
    
    return 0;
  }
}

