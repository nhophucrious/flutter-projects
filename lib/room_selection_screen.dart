import 'package:flutter/material.dart';
import 'package:learning_dart/home_page.dart';
import 'constants.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  final _loginTextSize = 30.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightOrangeBackground,
      appBar: AppBar(backgroundColor: greyishBlue),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Welcome to Spelling Bee', style: TextStyle(fontSize: 40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: greyishBlue,
                    textStyle: TextStyle(fontSize: _loginTextSize)),
                child: const Text('Room 1'),
                onPressed: () {
                  setState(() {
                    roomNumber = 1;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: greyishBlue,
                    textStyle: TextStyle(fontSize: _loginTextSize)),
                child: const Text('Room 2'),
                onPressed: () {
                  setState(() {
                    roomNumber = 2;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: greyishBlue,
                    textStyle: TextStyle(fontSize: _loginTextSize)),
                child: const Text('Room 3'),
                onPressed: () {
                  setState(() {
                    roomNumber = 3;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
