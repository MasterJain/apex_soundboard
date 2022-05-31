import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class RampartIOS extends StatefulWidget {
  @override
  _RampartIOSState createState() => _RampartIOSState();
}

class _RampartIOSState extends State<RampartIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_rampart_glad_tauntOrigin_01_02_1p.wav?alt=media&token=0e20360a-9e20-422f-808b-e8cb1a18833d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F23111%20-%20diag_mp_rampart_bc_seasonalTrickOrTreat_1p.wav?alt=media&token=4fd9b0f2-ae51-48e3-bb28-11be570d6808",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F24068%20-%20diag_mp_rampart_ping_jumpPad_calm_condOctane_1p.wav?alt=media&token=19369adb-4dd5-4a57-8cf3-6af65f4632fd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F24147%20-%20diag_mp_rampart_ping_markerNo_calm_condMirage_3p.wav?alt=media&token=669075c7-c205-4ccc-86a5-d75a62066b86",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F24156%20-%20diag_mp_rampart_ping_markerWait_calm_condMirage_1p.wav?alt=media&token=b464fadf-8360-4c6a-b2d8-a7cb9cdd107d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F24691%20-%20diag_mp_rampart_ping_youreWelcome_calm_condMirage_3p.wav?alt=media&token=0dd51fce-42cf-4d8b-87eb-ed1cdd127258",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F24692%20-%20diag_mp_rampart_ping_youreWelcome_calm_condRevenant_1p.wav?alt=media&token=2ea53518-2c1f-410a-a8e7-d45afd366265",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23222%20-%20diag_mp_rampart_glad_finisher_01_01_3p_victim.wav?alt=media&token=163f1379-2931-451a-acaf-0febdd1ab0ad",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23224%20-%20diag_mp_rampart_glad_introSeq_01_qw_1p.wav?alt=media&token=77ace526-1bc8-4cf5-a36f-f84c2cba4944",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23227%20-%20diag_mp_rampart_glad_introSeq_02_qw_1p.wav?alt=media&token=a1e998d3-76f6-47b8-85c5-b08315f1958f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23230%20-%20diag_mp_rampart_glad_introSeq_03_qw_1p.wav?alt=media&token=f40d1346-7896-4eba-8903-e8be57ae8a81",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23233%20-%20diag_mp_rampart_glad_introSeq_04_qw_1p.wav?alt=media&token=dcd9e547-8b34-4d06-a790-cb7e1c0851fc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23236%20-%20diag_mp_rampart_glad_introSeq_05_qw_1p.wav?alt=media&token=ca9ff999-9bbe-463c-b838-27ab3b43662e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23239%20-%20diag_mp_rampart_glad_introSeq_06_qw_1p.wav?alt=media&token=607ea503-8e81-44ee-9c3c-0f374e668607",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23243%20-%20diag_mp_rampart_glad_introSeq_07_qw_3p.wav?alt=media&token=66fa894a-d26d-4b03-a975-98cf98e1f83d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23246%20-%20diag_mp_rampart_glad_introSeq_08_qw_3p.wav?alt=media&token=8ae57cc5-2a21-4caf-9c7b-9be23243c707",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23249%20-%20diag_mp_rampart_glad_introSeq_09_qw_3p.wav?alt=media&token=900a098b-07ff-4fd5-9ab7-777560761c12",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23252%20-%20diag_mp_rampart_glad_introSeq_10_qw_3p.wav?alt=media&token=b4078488-1384-467e-b604-19aaa2ed1e07",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23255%20-%20diag_mp_rampart_glad_introSeq_11_qw_3p.wav?alt=media&token=2b999627-62fa-4ebe-9846-46c7eb6598ff",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23257%20-%20diag_mp_rampart_glad_introSeq_12_qw_1p.wav?alt=media&token=2c63ff22-897e-44ee-9d43-e57686015198",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23261%20-%20diag_mp_rampart_glad_introSeq_13_qw_3p.wav?alt=media&token=d10e0d2c-c668-427c-8965-aeddd81703f8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23263%20-%20diag_mp_rampart_glad_introSeq_14_qw_1p.wav?alt=media&token=263c393f-8c73-428c-9271-fc5bed560f72",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23266%20-%20diag_mp_rampart_glad_introSeq_15_qw_1p.wav?alt=media&token=6e4237f0-1dbe-426b-bf27-396e5f160c99",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23270%20-%20diag_mp_rampart_glad_introSeq_16_qw_3p.wav?alt=media&token=dced2af2-1229-4265-b3f1-5f35ea72bcd2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23272%20-%20diag_mp_rampart_glad_introSeq_17_qw_1p.wav?alt=media&token=ef154fa1-5b44-4be8-a82c-a9687e7a5cd3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23276%20-%20diag_mp_rampart_glad_introSeq_18_qw_3p.wav?alt=media&token=fcf3ddb5-2d3a-493e-beb2-c6b60760c068",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23279%20-%20diag_mp_rampart_glad_introSeq_19_qw_3p.wav?alt=media&token=d63565fa-77fe-48f3-87d1-0c49192f27bd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23281%20-%20diag_mp_rampart_glad_introSeq_20_qw_1p.wav?alt=media&token=cfa952c6-b870-4e50-8923-ea2035a395f5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23284%20-%20diag_mp_rampart_glad_introSeq_21_qw_1p.wav?alt=media&token=1714c9db-7fac-4d8f-be43-ee16f4bf980e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23300%20-%20diag_mp_rampart_glad_seasonOpen_qw_3p.wav?alt=media&token=0985eea5-e528-481c-bf53-d8fe1e7632bb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23301%20-%20diag_mp_rampart_glad_taunt_01_1p.wav?alt=media&token=c4ca081a-2827-4fda-aa55-252a91812376",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23305%20-%20diag_mp_rampart_glad_taunt_02_3p.wav?alt=media&token=8e8382f5-88b3-425d-9006-64a077f3533a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23308%20-%20diag_mp_rampart_glad_taunt_03_3p.wav?alt=media&token=9787031d-dfab-4454-97be-57dd69a04fb3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23311%20-%20diag_mp_rampart_glad_taunt_04_3p.wav?alt=media&token=257701a9-3fd8-40e3-9704-c3ff81768eb3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23314%20-%20diag_mp_rampart_glad_taunt_05_3p.wav?alt=media&token=1233e04c-01b3-4e99-9d35-5618fd2c3ecb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23316%20-%20diag_mp_rampart_glad_taunt_06_1p.wav?alt=media&token=e8a0e9d6-40c0-4c2a-8693-304b7bcf216c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23319%20-%20diag_mp_rampart_glad_taunt_07_1p.wav?alt=media&token=04e39ec5-e686-48bb-a04f-600c34098db1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23322%20-%20diag_mp_rampart_glad_taunt_08_1p.wav?alt=media&token=eb2be171-b374-4c87-b496-aadd9b357f40",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23326%20-%20diag_mp_rampart_glad_taunt_09_3p.wav?alt=media&token=3ec4eb24-155e-4c5b-a9c7-10209a8545ef",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23328%20-%20diag_mp_rampart_glad_taunt_10_1p.wav?alt=media&token=5b57c5ad-a858-4387-b891-36bb2e37597c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23332%20-%20diag_mp_rampart_glad_taunt_11_3p.wav?alt=media&token=cb1a5b0d-e1ba-42f9-b1ea-4f051eaa07c0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23334%20-%20diag_mp_rampart_glad_taunt_12_1p.wav?alt=media&token=3c2ce542-d5fe-4c3f-af66-1f8f07760231",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23337%20-%20diag_mp_rampart_glad_taunt_13_1p.wav?alt=media&token=3c11871f-79f4-4396-ada9-d0032f5dcffa",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23340%20-%20diag_mp_rampart_glad_taunt_14_1p.wav?alt=media&token=c018dc31-e046-46b8-992b-eff4a9c10b29",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23344%20-%20diag_mp_rampart_glad_taunt_15_3p.wav?alt=media&token=ba1c3430-88c2-4380-bbba-9e0578521d3d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23346%20-%20diag_mp_rampart_glad_taunt_16_1p.wav?alt=media&token=69af39ad-162d-433c-b76b-d115e61e3a6b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23350%20-%20diag_mp_rampart_glad_taunt_17_3p.wav?alt=media&token=f095bffd-7774-4441-bd63-593cec4793cd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23352%20-%20diag_mp_rampart_glad_taunt_18_1p.wav?alt=media&token=e14cad94-7067-4629-90e8-405a41a2ec34",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23355%20-%20diag_mp_rampart_glad_taunt_19_1p.wav?alt=media&token=2a2193a4-92d1-400c-927b-7ad4030f1400",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23358%20-%20diag_mp_rampart_glad_taunt_20_1p.wav?alt=media&token=5d85bc19-3499-4143-8029-0984e7f4b5ae",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23362%20-%20diag_mp_rampart_glad_taunt_21_3p.wav?alt=media&token=9520fdeb-5f77-480c-abf7-02e19703dde0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23364%20-%20diag_mp_rampart_glad_taunt_22_1p.wav?alt=media&token=95126582-80b9-4b9f-bce0-6d3a226beb45",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23368%20-%20diag_mp_rampart_glad_taunt_23_3p.wav?alt=media&token=6b32a455-0a41-481a-b05c-b64d7803d546",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23370%20-%20diag_mp_rampart_glad_taunt_24_1p.wav?alt=media&token=6256b766-558d-4348-b821-e2fab06c9214",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23373%20-%20diag_mp_rampart_glad_taunt_25_1p.wav?alt=media&token=3f92d230-351f-438c-a345-46eb09488700",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23377%20-%20diag_mp_rampart_glad_taunt_26_3p.wav?alt=media&token=b48e596e-d17e-4877-847d-84517f7924c3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23380%20-%20diag_mp_rampart_glad_taunt_27_3p.wav?alt=media&token=e26b92c5-4380-4005-b063-0cb3ae231659",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23383%20-%20diag_mp_rampart_glad_taunt_28_3p.wav?alt=media&token=307b011d-ee8c-4211-a783-99defc56068c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23386%20-%20diag_mp_rampart_glad_taunt_29_3p.wav?alt=media&token=e5d917b9-bda1-49a9-bb09-5f511daa5c54",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23389%20-%20diag_mp_rampart_glad_taunt_30_3p.wav?alt=media&token=5cbc205b-4bf3-4531-849e-e943a73bbcea",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23392%20-%20diag_mp_rampart_glad_taunt_31_3p.wav?alt=media&token=e2440377-55ce-47cd-a915-154210cc58ba",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23395%20-%20diag_mp_rampart_glad_taunt_32_3p.wav?alt=media&token=9420cb61-48f1-4117-aa44-1bc8f0e9cfa3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23398%20-%20diag_mp_rampart_glad_taunt_33_3p.wav?alt=media&token=5eb8e6ae-cca3-41ac-aa36-ccfacd72f171",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23401%20-%20diag_mp_rampart_glad_taunt_34_3p.wav?alt=media&token=10c6229f-89f8-4b7c-8de7-2912dff9dab3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23404%20-%20diag_mp_rampart_glad_taunt_35_3p.wav?alt=media&token=5bcb9755-e750-4285-8c17-080fb4952390",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23407%20-%20diag_mp_rampart_glad_taunt_36_3p.wav?alt=media&token=1103cce9-f8a7-4369-948c-bfc2de0ccebb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23409%20-%20diag_mp_rampart_glad_taunt_37_1p.wav?alt=media&token=dfc9eade-e0be-418d-9564-ce3a7f48067f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23413%20-%20diag_mp_rampart_glad_taunt_38_3p.wav?alt=media&token=9b301d30-eecb-433a-b57b-d6e15e8a5b80",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23416%20-%20diag_mp_rampart_glad_taunt_39_3p.wav?alt=media&token=7c68dbc5-3340-4fe6-a36f-56159192c22c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23419%20-%20diag_mp_rampart_glad_taunt_40_3p.wav?alt=media&token=57199d67-b761-4d81-b3f4-b31b23b2072d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23422%20-%20diag_mp_rampart_glad_taunt_41_3p.wav?alt=media&token=57917a60-639e-4d0e-a61e-fb7e3eca97da",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F23425%20-%20diag_mp_rampart_glad_taunt_42_3p.wav?alt=media&token=357434a6-b1f8-40af-b9ac-6c47f5a703fc",
  ];

  final List<String> quipnames = [
    "Sorry mate had to, Boss may be watching (NEW)",
    "Trick or Treat",
    "Jumppad here bloody piece of junk that is",
    "you got a screw loose,no way",
    "Hold it you yank",
    "Oi! The wheel maybe spinning but the hamster's dead",
    "Haven't you had enough you bloody wannabe devil",
    "Boom HAHAHA",
    "Eh It's alright to be afraid feels normal if you are a wimp",
    "Eh if you don't like what you see put a bag over your head",
    "Grab your mash, Rampart's in town",
    "Take a long look at me,that's the price you have to pay",
    "Eh That's right what you gonna do",
    "Cmon mates just get a new start with the rampart",
    "I think everyone who helped me get here,but they are all dead",
    "Here's the deal you get down there, have fun and I will ruin it",
    "Chin Up mates you just ain't that good as all",
    "Suppose you had skill",
    "I'm not one for bragging",
    "Yeah This is a dead game mates :'-)",
    "I don't think myself as the best just the all of you is the worst",
    "Not to worry you all will be here soon",
    "Look it ain't mechanical engineering you are either here or",
    "Champion or not",
    "Eh no need to get razzled yet",
    "Listen I don't wanna be here anymore than you do",
    "Let's face it,only way you get here if you kill me",
    "Eh if it makes you feel any better",
    "Must be a bit of a drag for those of you who ain't me",
    "Feel that hype season's opening up",
    "Well you are one of the greatest fighters I have ever seen",
    "That's tip top mate",
    "Aww you should have",
    "I'm still deciding whether or not I need to wash my hands after this",
    "Must have hit that head on that bloody speed train",
    "Don't blame yourself",
    "I will never forget this fight with you",
    "Eh How is your Maa",
    "You all right mate lookin a bit messy",
    "You certainly got the minerals but I got a",
    "I could have killed you with both eyes closed",
    "You should be ashamed Not you I'm talking to your teammates",
    "You lost time to go home to your loved ones",
    "Oh Sorry mate,I took you for a dummy",
    "Face first in the dirt might feel like an insult",
    "Don't feel bad if it was the other way around I would have hit you",
    "Take this time to reflect",
    "Eh look on the bright side mate",
    "We all make mistakes mate,but lucky for me",
    "Sorry mate but you are dead",
    "I don't believe it you got knocked out by the rampart",
    "This place ain't for you",
    "Oh you fools can't fight with crap,Who taught you?",
    "Fancy seeing you here",
    "You mind if I don't feel bad for you great thanks mate",
    "Next Time, Try glasses maybe not to see",
    "I'm a big fan of yours, not you the gun",
    "I have had a perfectly wonderful fight but this wasn't it",
    "Don't kill yourself over this,I'm already doing that",
    "It's alright mate we all make mistakes",
    "C'mon mate get your crap together",
    "You a legend or a mouse",
    "Well Crap there goes another customer",
    "Suppose you had a bigger gun",
    "Don't take this personal mate",
    "That was fun, time for a cup of",
    "You poor little plonker never had a chance",
    "Oh What happened you had this in the bag",
    "Hey if it helps, I will tell all my mates",
    "This must have been the greatest fight the games have ever seen",
    "You are a legend alright,very few have tricked people",
    "Between you and me maybe give it a rest",
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
            'Rampart Quips',
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
                          child: Image.asset("assets/images/rampart.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Rampart Quips",
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
