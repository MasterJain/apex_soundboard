import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class Seer extends StatefulWidget {
  @override
  _SeerState createState() => _SeerState();
}

class _SeerState extends State<Seer> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_tauntMutation_01_01_1p.wav?alt=media&token=831ecafd-030e-43e4-af6c-2e9a5339fd7a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_arenasClutch_01_01_1p.wav?alt=media&token=485ca98c-12ea-4ae4-a9f3-881defcd5030",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_arenasClutch_02_01_3p.wav?alt=media&token=46c4ad83-8c57-445e-965d-4a9cee6534e8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_arenasFlawless_01_01_1p.wav?alt=media&token=a3fadb33-4ebe-4fbf-895e-7da53258500f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_congratsKill_condRampart_01_01_1p.wav?alt=media&token=f0c31131-f35b-4c5f-b62f-bfce9e464f74",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_reviveThanks_condBloodhound_01_01_1p.wav?alt=media&token=e5d314ec-6370-44fe-bd7f-b1c9103fb75a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_revivingPlayer_condBloodhound_02_01_3p.wav?alt=media&token=546f6de2-3978-449f-b9b3-f4656f341533",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_reviveThanks_condOctane_01_01_1p.wav?alt=media&token=b3b250a7-6581-46c4-bafe-bcc6c00af420",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_reviveThanks_condOctane_02_01_1p.wav?alt=media&token=ca65fe4f-9561-4971-b2a8-c38e7d44d1ae",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_revivingPlayer_condBloodhound_01_01_1p.wav?alt=media&token=56e4a97a-7205-44d3-bd76-1dca5aa35b2e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_revivingPlayer_condOctane_01_01_1p.wav?alt=media&token=28bdfa99-c46e-4959-967e-0608fb37ff08",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_bc_revivingPlayer_condOctane_02_01_1p.wav?alt=media&token=dcce24f8-0251-4919-8568-812a5e614dee",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_01_01_3p.wav?alt=media&token=65e6e428-9fc1-4fd6-89c6-784098e67de7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_02_01_3p.wav?alt=media&token=e36b6833-476f-42e7-a309-a5a9e70f991b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_03_01_3p.wav?alt=media&token=08e5f87c-26b5-4263-9bde-2fbdf7e0792a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_04_01_3p.wav?alt=media&token=23dedb2a-9e12-4ef4-9982-8e7bbf47b3bf",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_05_01_3p.wav?alt=media&token=322d0da7-c4f5-475a-a962-aac90cd02726",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_06_01_3p.wav?alt=media&token=19a91a0d-e0ff-4136-97de-d2c88fe7937f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_07_01_3p.wav?alt=media&token=123fa9cd-0c47-49da-abdf-c4c1ba590ebd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_08_01_3p.wav?alt=media&token=f5e6a06e-4afe-482d-9966-b8aed0997d2e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_09_01_3p.wav?alt=media&token=38013cd4-36dd-46e0-8985-d9b3139fbcf9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_10_01_3p.wav?alt=media&token=0b8106b4-78a6-4fc0-8e42-ade7d0e4e1ae",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_11_01_3p.wav?alt=media&token=90903346-c080-48f7-808e-0e1ef83fbdda",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_12_01_3p.wav?alt=media&token=92a95dc7-26f9-42dd-aa81-a7aac365a0d8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_13_02_3p.wav?alt=media&token=d15486dc-6d6f-4901-93a6-8e6e8f6ac8b2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_14_01_3p.wav?alt=media&token=981876f2-eb7b-4994-b424-54fd43e2bbcf",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_15_01_3p.wav?alt=media&token=a139bfd9-a33d-47da-b615-295cf0d517b0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_16_01_3p.wav?alt=media&token=203199e9-94bf-45b4-8ef6-880576da18f6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_17_01_3p.wav?alt=media&token=eaeb4963-32a7-4be0-8dab-c64bec1cfa57",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_18_01_3p.wav?alt=media&token=df203e97-43c6-4a86-a062-4ed2980b20aa",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_19_01_3p.wav?alt=media&token=c1f987a9-8aeb-450a-a799-2ef48cac942e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_20_01_3p.wav?alt=media&token=111e3deb-8c7d-41af-8a91-c7ca7f059d15",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_introSeq_21_01_3p.wav?alt=media&token=1fdb16f1-d51e-4d0f-a505-e2f5ed72453f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_rankNewSeason_01_01_3p.wav?alt=media&token=9b0a79ed-4978-4cb0-a9fa-12b3d132c1f9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_rankNewSeries_01_01_3p.wav?alt=media&token=6bb40ed7-05aa-4ef3-a222-acd63a18cb41",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_rankNewSplit_01_01_3p.wav?alt=media&token=8c792e7e-0a4e-4789-afcb-3c18d0de8e23",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_seer_glad_seasonOpen_01_01_3p.wav?alt=media&token=6d9daae6-e599-428c-88b4-81acce14ffe3",
  ];

  final List<String> quipnames = [
    "Change is Inevitable my friend",
    "A Clutch Victory pulled from the heart of the flame",
    "Discounted Rejected Tossed Aside I return with a clutch victory",
    "A flawless Victory",
    "With moves like that the arenas can never hold you Ramya",
    "Do not allow me to weigh on your heavy heart",
    "You have more to do here Bloodhound",
    "Atleast you didnt accidently inject with me stim again",
    "Ypu revived me Sililva Perhaps you do appreciate art",
    "Talos Need you still my friend",
    "So I will pick you up",
    "Perhaps you will consider your actions from now on",
    "Stand out or Stand Aside",
    "Look for me and what you will see you will never forget",
    "I have been described as deadly and beautiful but I'm also approachable",
    "I fight for the refused the cursed",
    "You kill I create this is why I win",
    "To be the last thing you see will be my honour legends",
    "All legends have endings",
    "I will make your end live forever",
    "You will achieve greatness just not in victory",
    "Do not believe any rumours about me",
    "Do not look away",
    "The game is not merciful to those who lack imagination",
    "I will not be cast aside",
    "Today the cursed once triumph",
    "Play with all your heart",
    "To give the crowds a show sacrifice will be necessary",
    "Look away but I will be the last thing you see",
    "Underestimate me Please do",
    "I do not fight to be accepted",
    "When the flame beckons you obey",
    "I fight on behalf of the odd ones",
    "A new ranked season begins",
    "A new ranked series begins",
    "New ranked split",
    "Welcome to the opening season",
  ];

  final List<String> quipcategory = [
    'Legend Interactions',
    'Quest quips'
        'Wraith Quips',
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    //
    // Future<void> _shareSoundfromUrl() async {
    //   try {
    //    final ByteData bytes =
    //      await rootBundle.load('assets/images/' + this.item.share);
    //  await Share.file(this.item.killquip, 'blood26.mp3',
    //      bytes.buffer.asUint8List(), 'audio/*');
    // } catch (e) {
    //   print('error: $e');
    //  }
    //}

    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');

        //trigger leaving and use own data
        Navigator.pop(context);

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
              title: const Text(
            'Seer Quips',
            style: TextStyle(fontFamily: 'Raleway'),
          )),
          body: ListView.builder(
              itemCount: audio.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100.0,
                  height: 90.0,
                  child: Slidable(
                    key: ValueKey(index),
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset("assets/images/seer.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Seer Quips",
                          style: TextStyle(
                              fontFamily: 'Raleway', color: Colors.red),
                        ),
                        onTap: () async {
                          AudioPlayer audioPlayer = AudioPlayer();
                          await audioPlayer.setUrl(audio[index]);
                          await audioPlayer.play(audio[index]);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Playing'), //Success
                          ));
                        },
                      ),
                    ),
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      extentRatio: 0.25,
                      children: <Widget>[
                        SlidableAction(
                          label: 'Share',
                          backgroundColor: Colors.black,
                          icon: Icons.share,
                          onPressed: (context) async {
                            downloadmp3(audio[index]);

                            //startDownload(
                            //     context,
                            //  "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/blood26.mp3?alt=media&token=d219c1e1-1a88-4a7c-8d8a-fbf98243ee37",
                            // "ShareSound");
                            String dir =
                                (await getApplicationDocumentsDirectory()).path;
                            File testFile = File('$dir/apexsoun.aac');
                            if (!await testFile.exists()) {
                              await testFile.create(recursive: true);
                              testFile.writeAsStringSync(
                                  "test for share documents file");
                            }

                            //  shareaudio.Share.file(path: "content:/data/user/0/com.example.test1/app_flutter/apexsoun.aac", mimeType: shareaudio.ShareType.fromMimeType('audio/*'), title: 'Share' , text: "audio");

                            ShareExtend.share(testFile.path, "audio");

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Sharing Quip'),
                            ));
                          },
                        ),
                        SlidableAction(
                          label: 'Download',
                          backgroundColor: Colors.red[800]!,
                          icon: Icons.file_download,
                          onPressed: (context) async {
                            downloadFile(
                                context,
                                audio[index],
                                quipnames[index],
                                '/storage/emulated/0/Download');

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text('Audio saved in Downloadsfolder'),
                            ));
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const StretchMotion(),
                      children: <Widget>[
                        SlidableAction(
                          label: 'Share',
                          backgroundColor: Colors.black,
                          icon: Icons.share,
                          onPressed: (conetxt) async {
                            downloadmp3(audio[index]);

                            //startDownload(
                            //     context,
                            //  "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/blood26.mp3?alt=media&token=d219c1e1-1a88-4a7c-8d8a-fbf98243ee37",
                            // "ShareSound");
                            String dir =
                                (await getApplicationDocumentsDirectory()).path;
                            File testFile = File('$dir/apexsoun.aac');
                            if (!await testFile.exists()) {
                              await testFile.create(recursive: true);
                              testFile.writeAsStringSync(
                                  "test for share documents file");
                            }

                            //  shareaudio.Share.file(path: "content:/data/user/0/com.example.test1/app_flutter/apexsoun.aac", mimeType: shareaudio.ShareType.fromMimeType('audio/*'), title: 'Share' , text: "audio");

                            ShareExtend.share(testFile.path, "audio");

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Sharing Quip'),
                            ));
                          },
                        ),
                        SlidableAction(
                          label: 'Download',
                          backgroundColor: Colors.red[800]!,
                          icon: Icons.file_download,
                          onPressed: (context) async {
                            downloadFile(
                                context,
                                audio[index],
                                quipnames[index],
                                '/storage/emulated/0/Download');

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text('Audio saved in Downloads folder'),
                            ));
                          },
                        ),
                      ],
                      // child: ListTile(title: Text('$index'),)
                    ),
                  ),
                );
              })),

      // child: ListTile(title: Text('$index'),)
    );
  }
}

Future<String> downloadFile12(
    BuildContext context, String url, String fileName, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '/storage/emulated/0/Download';
  String myUrl = url;

  try {
    myUrl = url + '/' + '$fileName.mp3';
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();

    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName.mp3';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    } else
      filePath = 'Error code: ' + response.statusCode.toString();
  } catch (ex) {
    filePath = 'Can not fetch url';
  }

  return filePath;
}

Future<dynamic> downloadmp3(String url) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File('$dir/apexsoun.aac');
  var request = await http.get(
    Uri.parse(url),
  );
  var bytes = request.bodyBytes;
  await file.writeAsBytes(bytes);
  print(file.path);
}

Future downloadFile(
    BuildContext context, String url, String fileName, String dir) async {
  await Permission.storage.request().then((_) async {
    if (await Permission.storage.status == PermissionStatus.granted) {
      // startDownload(context, url, filename);
      downloadFile12(context, url, fileName, dir);
    } else if (await Permission.storage.status == PermissionStatus.denied) {
    } else if (await Permission.storage.status ==
        PermissionStatus.permanentlyDenied) {
      askOpenSettingsDialog(context);
    }
  });
}

askOpenSettingsDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Grant Storage Permission to Download'),
          content: const Text(
              'You have to allow storage permission to download any wallpaper fro this app'),
          contentTextStyle:
              const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
          actions: [
            TextButton(
              child: const Text('Open Settins'),
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () async {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
