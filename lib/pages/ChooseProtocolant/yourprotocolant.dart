import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fairlog/db/databaseHelper.dart';
import 'package:confetti/confetti.dart';


class YourProtocolant extends StatefulWidget {


  List<int> iDs;
  String team;
  YourProtocolant(List<int> iDs, String team) {
    this.iDs = iDs;
    this.team = team;
  }

  @override
  _YourProtocolantState createState() => _YourProtocolantState(iDs,team);
}

class _YourProtocolantState extends State<YourProtocolant> {


  List<int> iDs;
  String protocolant = '';
  int protocolantId;
  String team;
  ConfettiController _controllerCenter;

  _YourProtocolantState(List<int> iDs, String team) {
    this.team = team;
    this.iDs = iDs;
    getTeamMember();

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenter.play();
  }



  Future getTeamMember() async {
    iDs = await DataBaseHelper.instance.getPossibleCandidates(iDs, team);
    Random random = new Random();
    protocolantId = iDs[random.nextInt(iDs.length)];
    protocolant = await DataBaseHelper.instance.getName(protocolantId);
    setState(() {

    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Your Protocolant'),),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
      children: [

          ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Your Protocolant is:',
              style: TextStyle(
                fontSize: 40,
                color: Colors.black26,
              ),),
             SizedBox(height: 60),
          FlatButton(
            onPressed: () { _controllerCenter.play();/*Firework*/},
            child: Text(protocolant,
            style: TextStyle(
              fontSize: 40,
            ),),
            color: Colors.orange[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              //side: BorderSide(color: Colors.white),
            ),
            minWidth: 220,
            height: 70,
          ),

              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        getTeamMember();
                      },
                      child: Text('choose another member'),
                    color: Colors.red[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),

                    ),
                      height: 50,
                      minWidth: 170,

                ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () async {
                        int a = await DataBaseHelper.instance.getWrittenProtocolOfName(protocolantId);
                        a++;
                        await DataBaseHelper.instance.update({DataBaseHelper.columnId: protocolantId,DataBaseHelper.columnWrittenProtocol: a.toString()});
                        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                      },
                      child: Text('Submit'), //TODO SnackBar in Beginning with Submitted
                      //TODO Protocol List with Date/ Present List
                      color: Colors.green[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        //side: BorderSide(color: Colors.white),
                      ),
                      height: 50,
                      minWidth: 170,

                    ),
                  )],
              )
            ],
          ),
        ),
    ],
      ),
    );
  }
}
