import 'dart:io';
import 'dart:math';

import 'package:apex_soundboard/about_page.dart';
import 'package:apex_soundboard/ioslegends/bangaloreios.dart';
import 'package:apex_soundboard/ioslegends/bloodhoundios.dart';
import 'package:apex_soundboard/ioslegends/causticios.dart';
import 'package:apex_soundboard/ioslegends/cryptoios.dart';
import 'package:apex_soundboard/ioslegends/fuseios.dart';
import 'package:apex_soundboard/ioslegends/gibbyios.dart';
import 'package:apex_soundboard/ioslegends/horizonios.dart';
import 'package:apex_soundboard/ioslegends/lifelineios.dart';
import 'package:apex_soundboard/ioslegends/lobaios.dart';
import 'package:apex_soundboard/ioslegends/mirageios.dart';
import 'package:apex_soundboard/ioslegends/octaneios.dart';
import 'package:apex_soundboard/ioslegends/pathyios.dart';
import 'package:apex_soundboard/ioslegends/rampartios.dart';
import 'package:apex_soundboard/ioslegends/revios.dart';
import 'package:apex_soundboard/ioslegends/seerios.dart';
import 'package:apex_soundboard/ioslegends/valkios.dart';
import 'package:apex_soundboard/ioslegends/wattsonios.dart';
import 'package:apex_soundboard/ioslegends/wraithios.dart';
import 'package:apex_soundboard/legends/bangalore.dart';
import 'package:apex_soundboard/legends/bloodhound.dart';
import 'package:apex_soundboard/legends/caustic.dart';
import 'package:apex_soundboard/legends/crypto.dart';
import 'package:apex_soundboard/legends/gibby.dart';
import 'package:apex_soundboard/legends/horizon.dart';
import 'package:apex_soundboard/legends/lifeline.dart';
import 'package:apex_soundboard/legends/loba.dart';
import 'package:apex_soundboard/legends/mirage.dart';
import 'package:apex_soundboard/legends/octane.dart';
import 'package:apex_soundboard/legends/pathy.dart';
import 'package:apex_soundboard/legends/rampart.dart';
import 'package:apex_soundboard/legends/seer.dart';
import 'package:apex_soundboard/legends/valk.dart';
import 'package:apex_soundboard/legends/wattson.dart';
import 'package:apex_soundboard/legends/wraith.dart';
import 'package:apex_soundboard/splash.dart';

import 'package:flutter/material.dart';

import 'legends/fuse.dart';
import 'legends/rev.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final double textScaleFactor = 1.0;
  @override
  Widget build(BuildContext context) {
    return
        //MultiProvider(
        // providers: [],
        // child:
        MaterialApp(
      title: 'Apex Soundboard',
      theme:
          ThemeData(primarySwatch: Colors.red, backgroundColor: Colors.white10),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) =>
            const MyHomePage(title: 'Apex Soundboard')
      },
      debugShowCheckedModeBanner: false,
      //  ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  static String appName = "Apex Sounds";
  static String androidDownload = "Audio saved in Downloadsfolder";

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  _MyHomePageState();

  String url =
      "https://vgmdownloads.com/soundtracks/apex-legends-2019/zqoxecihsr/01%20Apex%20Legends%20Main%20Theme.mp3";

  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  ///   super.initState();
  //  scrollController =new ScrollController();
  //}

  //String url = "http://server-23.stream-server.nl:8438";

  final List<String> _category = [
    'Wraith',
    'Bangalore',
    'Lifeline',
    'Pathfinder',
    'Mirage',
    'Bloodhound',
    'Gibraltar',
    'Caustic',
    'Octane',
    'Wattson',
    'Crypto',
    'Revenant',
    'Loba',
    'Rampart',
    'Horizon',
    'Fuse',
    'Valkyrie',
    'Seer',
  ];

  final List<String> _categoryImage = [
    'assets/images/wraith.png',
    'assets/images/bangalore.png',
    'assets/images/lifeline.png',
    'assets/images/path.png',
    'assets/images/mirage.png',
    'assets/images/bloodhound.png',
    'assets/images/gibby.png',
    'assets/images/caustic.png',
    'assets/images/octane.png',
    'assets/images/watt.png',
    'assets/images/crypto.png',
    'assets/images/revy.png',
    'assets/images/loba.png',
    'assets/images/rampart.png',
    'assets/images/horizon.png',
    'assets/images/fuse.png',
    'assets/images/valk.png',
    'assets/images/seer.png',
  ];

  bool isplaying = true;
  bool button1 = true;
  bool button2 = false;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    print(textScale);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading:

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAboutPage()),
              );

              print("pressed");
            },
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Raleway', fontSize: 16.0 * textScale),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 19.0, vertical: 20.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Image(
                        image: AssetImage("assets/images/apexlogo.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 9.0),
                      child: Text(
                        "Hey Legends",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 30.0 * textScale,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 4.0),
                        child: Text(
                          "Welcome to Apex Legends Soundboard.",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 24.0 * textScale,
                            color: Colors.black,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        8,
                        0,
                        8,
                      ),
                      child: Text(
                        "Slide left or right to share sounds with your friends",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18.0 * textScale,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      "New Voice Quips will be uploaded every new season",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 14.0,
                          color: Colors.black),
                    ),
                    Text(
                      "Have Fun Stay Frosty",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 14.0,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.0, vertical: 0),
                  child: Text(
                    "Legends",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 30.0 * textScale,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Container(
              height: 700,
              child: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: _category.length,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      height: 1000,
                      padding: const EdgeInsets.all(3),
                      width: 250,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: SizedBox(
                          // height: 25,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_categoryImage[index]),
                                fit: BoxFit.fill,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            child: Container(
                              //padding: const EdgeInsets.all(1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(_category[index],
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 26.0 * textScale,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (index == 0) {
                        //analytics.setUserId(id);
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WraithsIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wraiths()));
                        }
                      } else if (index == 1) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BangaloreIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bangalore()));
                        }
                      } else if (index == 2) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LifelineIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lifeline()));
                        }
                      } else if (index == 3) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PathfinderIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pathfinder()));
                        }
                      } else if (index == 4) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MirageIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Mirage()));
                        }
                      } else if (index == 5) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BloodhoundIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bloodhound()));
                        }
                      } else if (index == 6) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GibbyIOS()));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Gibby()));
                        }
                      } else if (index == 7) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CausticIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Caustic()));
                        }
                      } else if (index == 8) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OctaneIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Octane()));
                        }
                      } else if (index == 9) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WattsonIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wattson()));
                        }
                      } else if (index == 10) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CryptoIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Crypto()));
                        }
                      } else if (index == 11) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RevenantIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Revenant()));
                        }
                      } else if (index == 12) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LobaIOS()));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Loba()));
                        }
                      } else if (index == 13) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RampartIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Rampart()));
                        }
                      } else if (index == 14) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HorizonIOS()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Horizon()));
                        }
                      } else if (index == 15) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FuseIOS()));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Fuse()));
                        }
                      } else if (index == 16) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ValkIOS()));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Valk()));
                        }
                      } else if (index == 17) {
                        if (Platform.isIOS) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeerIOS()));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Seer()));
                        }
                      }
                    },
                  );

                  // return LegendSelectionBox(item: items[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("My title"),
      content: const Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
