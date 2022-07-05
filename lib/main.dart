import 'package:circular_countdown_timer/circular_countdown_timer.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
//import 'package:hive_flutter/hive_flutter.dart';
//import 'package:learning_dart/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: true, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color powerupButtonDefaultColor = const Color.fromARGB(255, 226, 162, 94);
  final CountDownController _controller = CountDownController();
  Color _buttonColorSelector(bool keyAttribute, int useCount) {
    if (keyAttribute) {
      return Colors.amber;
    } else {
      if (useCount == 0) {
        return Colors.grey;
      } else {
        return greyishBlue;
      }
    }
  }

  final List<String> _words = [
    "BUSINESS",
    "FINANCIAL",
    "INVESTMENT",
    "ASSISTANT",
    "PROFITABLE",
    "TURNOVER",
    "ELEGANT",
    "GORGEOUS",
    "LABEL",
    "PALETTE",
    "SECURITY",
    "COLLEAGUE",
    "TRAINEE",
    "LIABILITY",
    "RESIGNATION"
  ];
  final List<String> _teamOne = ["Duệ Trung", "Hiếu Thảo", "Duy Minh"];
  final List<String> _teamTwo = ["Yến Thy", "Vĩnh Nghị", "Thuý Hiền"];
  final clockBackgroundColor = const Color.fromARGB(255, 226, 162, 94);
  final greyishBlue = const Color.fromARGB(255, 48, 55, 71);
  final lemonishYellow = const Color.fromARGB(255, 254, 218, 94);
  final orangeYellow = const Color.fromARGB(255, 254, 195, 94);
  final lightOrangeBackground = const Color.fromARGB(255, 237, 206, 127);
  int _widgetId = 1;
  int _scoreOne = 0, _scoreTwo = 0;
  int _starCountLeft = 1, _hourglassCountLeft = 2, _switchCountLeft = 1;
  int _starCountRight = 1, _hourglassCountRight = 2, _switchCountRight = 1;
  bool _isPaused = true;
  bool _isStarted = false;
  bool _scorePowerUpOne = false, _scorePowerUpTwo = false;
  bool _timerExtendedOne = false, _timerExtendedTwo = false;
  bool _switchPowerUpOne = false, _switchPowerUpTwo = false;
  bool _activateSwitchOneLeft = false, _activateSwitchOneRight = false;
  bool _activateSwitchTwoLeft = false, _activateSwitchTwoRight = false;
  bool _activateSwitchThreeLeft = false, _activateSwitchThreeRight = false;
  int playerTurn = 0;
  int _speltWords = 0;

  Widget _clockCountDown1() {
    return CircularCountDownTimer(
      key: const Key('first'),
      ringColor: Colors.transparent,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      duration: 60,
      fillColor: greyishBlue,
      controller: _controller,
      backgroundColor: clockBackgroundColor,
      strokeWidth: 10.0,
      strokeCap: StrokeCap.round,
      isReverse: true,
      isTimerTextShown: true,
      isReverseAnimation: true,
      autoStart: false,
      textStyle: TextStyle(fontSize: 70, color: greyishBlue),
    );
  }

  Widget _clockCountDown2() {
    return CircularCountDownTimer(
      key: const Key('second'),
      ringColor: Colors.transparent,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      duration: 80,
      fillColor: greyishBlue,
      controller: _controller,
      backgroundColor: clockBackgroundColor,
      strokeWidth: 10.0,
      strokeCap: StrokeCap.round,
      isReverse: true,
      isTimerTextShown: true,
      isReverseAnimation: true,
      autoStart: false,
      textStyle: const TextStyle(fontSize: 70, color: Colors.black),
    );
  }

  Widget _clockCountDown() {
    return _widgetId == 1 ? _clockCountDown1() : _clockCountDown2();
  }

  void _updateWidget() {
    setState(() {
      _widgetId = _widgetId == 1 ? 2 : 1;
    });
  }

  int _currentTurn(int speltWords) {
    return (speltWords % 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightOrangeBackground,
      /* 
      appBar: AppBar(
        title: const Text('SPELLING BEE TIMER'),
        centerTitle: true,
      ), */
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Total score: ${_scoreOne.toString()}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: greyishBlue)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_scorePowerUpOne) {
                              _scoreOne += 20;
                            } else {
                              _scoreOne += 10;
                            }
                            _scorePowerUpOne = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_scorePowerUpOne) {
                                _scoreOne -= 5;
                              }
                              _scorePowerUpOne = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                !_scorePowerUpOne ? Colors.grey : Colors.red,
                          ),
                          child: const Icon(Icons.remove)),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: _activateSwitchOneLeft
                        ? Colors.green
                        : (_currentTurn(_speltWords) == 0
                            ? Colors.amber
                            : greyishBlue),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    onPressed: () {
                      if (_switchPowerUpOne) {
                        setState(() {
                          _activateSwitchOneLeft = true;
                        });
                      }
                    },
                    label: Text(
                      _teamOne[0],
                      style: TextStyle(
                          fontWeight: (_currentTurn(_speltWords) == 0
                              ? FontWeight.bold
                              : FontWeight.normal),
                          fontSize: 25,
                          color: (_currentTurn(_speltWords) == 0
                              ? greyishBlue
                              : Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                    backgroundColor: _activateSwitchTwoLeft
                        ? Colors.green
                        : (_currentTurn(_speltWords) == 1
                            ? Colors.amber
                            : greyishBlue),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    onPressed: () {
                      if (_switchPowerUpOne) {
                        setState(() {
                          _activateSwitchTwoLeft = true;
                        });
                      }
                    },
                    label: Text(
                      _teamOne[1],
                      style: TextStyle(
                          fontWeight: (_currentTurn(_speltWords) == 1
                              ? FontWeight.bold
                              : FontWeight.normal),
                          fontSize: 25,
                          color: (_currentTurn(_speltWords) == 1
                              ? greyishBlue
                              : Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                    backgroundColor: _activateSwitchThreeLeft
                        ? Colors.green
                        : (_currentTurn(_speltWords) == 2
                            ? Colors.amber
                            : greyishBlue),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    onPressed: () {
                      if (_switchPowerUpOne) {
                        setState(() {
                          _activateSwitchThreeLeft = true;
                        });
                      }
                    },
                    label: Text(_teamOne[2],
                        style: TextStyle(
                            fontWeight: (_currentTurn(_speltWords) == 2
                                ? FontWeight.bold
                                : FontWeight.normal),
                            fontSize: 25,
                            color: (_currentTurn(_speltWords) == 2
                                ? greyishBlue
                                : Colors.white))),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          if (_starCountLeft > 0) {
                            _starCountLeft--;
                            _scorePowerUpOne = true;
                          }
                        });
                      },
                      backgroundColor: _buttonColorSelector(
                          _scorePowerUpOne, _starCountLeft),
                      icon: const Icon(Icons.star),
                      label:
                          Text('Shooting Star ${_starCountLeft.toString()}')),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          if (_hourglassCountLeft > 0) {
                            _timerExtendedOne = true;
                            _hourglassCountLeft--;
                            _updateWidget();
                          }
                          //_controller.reset();
                        });
                      },
                      backgroundColor: _buttonColorSelector(
                          _timerExtendedOne, _hourglassCountLeft),
                      icon: const Icon(Icons.hourglass_bottom),
                      label: Text(
                          'Hopeful Hourglass ${_hourglassCountLeft.toString()}')),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          if (_switchCountLeft > 0) {
                            _switchPowerUpOne = true;
                            _switchCountLeft--;
                          }
                        });
                      },
                      backgroundColor: _buttonColorSelector(
                          _switchPowerUpOne, _switchCountLeft),
                      icon: const Icon(Icons.sos),
                      label: Text('Switcheroo ${_switchCountLeft.toString()}')),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Current word: ${(_speltWords + 1)} of 15',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: greyishBlue),
              ),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _clockCountDown(),
                ),
              ),
              SizedBox(
                // progress bar and turn controls
                width: 300,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      width: 300,
                      lineHeight: 15,
                      percent: ((_speltWords + 1) / 15),
                      progressColor: Colors.amber,
                      backgroundColor: greyishBlue,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  greyishBlue)),
                          child: const Icon(Icons.skip_next),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (_speltWords + 1 < 15) {
                                  _speltWords++;
                                }
                                _controller.reset();
                                _timerExtendedOne = false;
                                _timerExtendedTwo = false;
                                _switchPowerUpOne = false;
                                _switchPowerUpTwo = false;
                                _activateSwitchOneLeft = false;
                                _activateSwitchTwoLeft = false;
                                _activateSwitchThreeLeft = false;
                                _activateSwitchOneRight = false;
                                _activateSwitchTwoRight = false;
                                _activateSwitchThreeRight = false;
                                if (_widgetId == 2) {
                                  _updateWidget();
                                }
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        greyishBlue)),
                            child: const Icon(Icons.arrow_right_alt_rounded))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Total score: ${_scoreTwo.toString()}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: greyishBlue)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_scorePowerUpTwo) {
                                _scoreTwo += 20;
                              } else {
                                _scoreTwo += 10;
                              }
                              _scorePowerUpTwo = false;
                            });
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          child: const Icon(Icons.add)),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_scorePowerUpTwo) {
                                _scoreTwo -= 5;
                              }
                              _scorePowerUpTwo = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                !_scorePowerUpTwo ? Colors.grey : Colors.red,
                          ),
                          child: const Icon(Icons.remove)),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: _activateSwitchOneRight
                        ? Colors.green
                        : (_currentTurn(_speltWords) == 0
                            ? Colors.amber
                            : greyishBlue),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    onPressed: () {
                      setState(() {
                        _activateSwitchOneRight = true;
                      });
                    },
                    label:
                        Text(_teamTwo[0], style: const TextStyle(fontSize: 25)),
                  ),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                    backgroundColor: _activateSwitchTwoRight
                        ? Colors.green
                        : (_currentTurn(_speltWords) == 1
                            ? Colors.amber
                            : greyishBlue),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    onPressed: () {
                      setState(() {
                        _activateSwitchTwoRight = true;
                      });
                    },
                    label:
                        Text(_teamTwo[1], style: const TextStyle(fontSize: 25)),
                  ),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                    backgroundColor: _activateSwitchThreeRight
                        ? Colors.green
                        : (_currentTurn(_speltWords) == 2
                            ? Colors.amber
                            : greyishBlue),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    onPressed: () {
                      setState(() {
                        _activateSwitchThreeRight = true;
                      });
                    },
                    label:
                        Text(_teamTwo[2], style: const TextStyle(fontSize: 25)),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          if (_starCountRight > 0) {
                            _starCountRight--;
                            _scorePowerUpTwo = true;
                          }
                        });
                      },
                      backgroundColor: _buttonColorSelector(
                          _scorePowerUpTwo, _starCountRight),
                      icon: const Icon(Icons.star),
                      label:
                          Text('Shooting Star ${_starCountRight.toString()}')),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          if (_hourglassCountRight > 0) {
                            _timerExtendedTwo = true;
                            _hourglassCountRight--;
                            _updateWidget();
                          }
                          //_controller.reset();
                        });
                      },
                      backgroundColor: _buttonColorSelector(
                          _timerExtendedTwo, _hourglassCountRight),
                      icon: const Icon(Icons.hourglass_bottom),
                      label: Text(
                          'Hopeful Hourglass ${_hourglassCountRight.toString()}')),
                  const SizedBox(height: 5),
                  FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          if (_switchCountRight > 0) {
                            _switchPowerUpTwo = true;
                            _switchCountRight--;
                          }
                        });
                      },
                      backgroundColor: _buttonColorSelector(
                          _switchPowerUpTwo, _switchCountRight),
                      icon: const Icon(Icons.sos),
                      label:
                          Text('Switcheroo ${_switchCountRight.toString()}')),
                ],
              )
            ],
          )
        ],
      ),
      //floatingActionButton:
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Timer control: Start, resume, and pause
          FloatingActionButton(
            backgroundColor: greyishBlue,
            onPressed: () {
              setState(() {
                if (!_isStarted && _isPaused) {
                  _isStarted = true;
                  _isPaused = false;
                  _controller.start();
                } else if (_isPaused) {
                  _isPaused = false;
                  _controller.resume();
                  //_controller.resume();
                } else {
                  _isPaused = true;
                  _controller.pause();
                }
              });
            },
            child: Icon(_isPaused ? Icons.play_arrow : Icons.pause_circle),
            //label: Text(buttonText(_isPaused, _isStarted))
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: greyishBlue,
            // timer reset button
            onPressed: () {
              setState(() {
                _controller.reset();
                _isPaused = true;
                _isStarted = false;
                _timerExtendedOne = false;
                _timerExtendedTwo = false;
                _switchPowerUpOne = false;
                _switchPowerUpTwo = false;
                _activateSwitchOneLeft = false;
                _activateSwitchTwoLeft = false;
                _activateSwitchThreeLeft = false;
                _activateSwitchOneRight = false;
                _activateSwitchTwoRight = false;
                _activateSwitchThreeRight = false;
                if (_widgetId == 2) {
                  _updateWidget();
                }
                //_updateWidget();
              });
            },
            child: const Icon(Icons.restore),
            //label: const Text('RESET')
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            backgroundColor: greyishBlue,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('The word was ${_words[_speltWords]}'),
                      ));
            },
            child: const Icon(Icons.text_snippet),
          )
        ],
      ),
    );
  }
}
