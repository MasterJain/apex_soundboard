import 'dart:math';

import 'package:apex_soundboard/abouthelpers/customalert.dart';
import 'package:apex_soundboard/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DownloadAlert extends StatefulWidget {
  final String url;
  final String path;
  static formatBytes(bytes, decimals) {
    if(bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  const DownloadAlert({
    Key? key,
    required this.url,
    required this.path
  }):super(key: key);

  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}

class _DownloadAlertState extends State<DownloadAlert> {

  Dio dio = Dio();
  int received = 0;
  String progress = "0";
  int total = 0;
  String androiddownload = 'Image Saved in /storage/emulated/0/Apexsounds/';

  download() async{
    await dio.download(widget.url,widget.path,
      deleteOnError: true,
      onReceiveProgress: (receivedBytes, totalBytes) {
        setState(() {
          received = receivedBytes;
          total = totalBytes;
          progress = (received / total * 100).toStringAsFixed(0);
        });
        //Check if download is complete and close the alert dialog
        if(receivedBytes == totalBytes){
          Navigator.pop(context, "${MyHomePage.formatBytes(total, 1)}");

        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: CustomAlert(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Downloading...",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 15,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: double.parse(progress)/100,
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "$progress %",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    "${MyHomePage.formatBytes(received, 1)} "
                        "of ${MyHomePage.formatBytes(total, 1)}",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
              Text(
                "${MyHomePage.androidDownload} "
                ,
                style: const TextStyle(
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}