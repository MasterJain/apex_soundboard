import 'package:apex_soundboard/abouthelpers/ui_helper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'abouthelpers/sexy_title.dart';

class MyAboutPage extends StatefulWidget {
  @override
  _MyAboutPageState createState() => _MyAboutPageState();
}

class _MyAboutPageState extends State<MyAboutPage> {
  List<String> itemContent = [
    'What is this app about?',
    'It is just a fun Apex Legends Soundboard app containing all quips of all characters in the game,This was made with the idea of pranking friends and others with legend quips and other things,New legend quips and new quips will be added at the start of every season with  some more exciting features.\n\n Do contact me over Instagram or Facebook by clicking the icons above if you have any issues or you have any improvments to convey :D \n\nThanks for checking out',
    'Credits',
    'All voice lines and images used in the are from the game Apex Legends, and all of it\'s rights belong to Respawn Entertainment and EA,For any disputes please contact me on my socials\n\nHuge Thanks to the amazing team at Respawn for making this game\n\nThis app would not have been possible without the Flutter framework, the open source projects that I\'ve used and the tireless efforts of developers and contributors in the Flutter community. \n\nApp logo is created by LorscoJR',
  ]; //the text in the tile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(fontFamily: 'Raleway', fontSize: 16.0),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Hero(
                    tag: 'tile2',
                    child: SexyTile(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/anish.jpg'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                Icon(
                                  EvaIcons.code,
                                  color: Colors.black,
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  'with',
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Icon(
                                  EvaIcons.heart,
                                  color: Colors.red,
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  'by',
                                ),
                              ],
                            ),
                            const Text(
                              'Anish Jain',
                              //style: Color(Colors.black),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              'For Emma❤️ ',
                              //style: Color(Colors.black),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                            ),
                            const Text(
                              'For Dad',
                              //style: Color(Colors.black),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                            ),
                            const Text(
                              'For Mr and Mrs Jaschinski',
                              //style: Color(Colors.black),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(
                                    LineAwesomeIcons.instagram,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                  onPressed: () => launchURL(
                                      'https://www.instagram.com/anishjain108/'),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    EvaIcons.facebook,
                                    color: Colors.blue,
                                    size: 26.0,
                                  ),
                                  onPressed: () => launchURL(
                                      'https://www.facebook.com/ItsAnishJain'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      splashColor: Colors.red,
                      color: Colors.white,
                      onTap: () {},
                    ),
                  ),
                  SexyTile(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            itemContent[0],
                            //style: HeadingStylesDefault.accent,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            itemContent[1],
                            textAlign: TextAlign.left,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    splashColor: Colors.red,
                    color: Colors.white,
                    onTap: () {},
                  ),
                  SexyTile(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            itemContent[2],

                            ///style: HeadingStylesDefault.accent,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            itemContent[3],
                            // style: isThemeCurrentlyDark(context)
                            //    ? BodyStylesDefault.white
                            //  : BodyStylesDefault.black,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    splashColor: Colors.red,
                    color: Colors.white,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: const Icon(
          EvaIcons.globe,
          size: 36.0,
        ),
        tooltip: 'View GitHub repo',
        foregroundColor: Colors.white,
        backgroundColor: Colors.red[800],
        elevation: 5.0,
        onPressed: () => launchURL('https://apexsounds.xyz/'),
      ),
    );
  }
}
