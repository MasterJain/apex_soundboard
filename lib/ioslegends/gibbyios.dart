import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class GibbyIOS extends StatefulWidget {
  @override
  _GibbyIOSState createState() => _GibbyIOSState();
}

class _GibbyIOSState extends State<GibbyIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_gibraltar_glad_tauntMutation_01_02_3p.wav?alt=media&token=0519601a-7880-48bd-99cd-3d0196e02ba5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_gibraltar_glad_tauntOrigin_01_01_1p.wav?alt=media&token=73b7f88a-696b-48c4-a17f-db74c50b28c3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_gibraltar_glad_tauntOrigin_01_02_3p.wav?alt=media&token=af539a18-bf20-4a84-8a7f-587f74452107",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F11725%20-%20diag_mp_gibraltar_bc_congratsKill_condRampart_3p.wav?alt=media&token=70720a5f-00cc-4a1e-b492-cb543c454a4b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F11820%20-%20diag_mp_gibraltar_bc_reviveThanks_condCaustic_1p.wav?alt=media&token=8174a3a4-a378-496c-89f2-e33abd299024",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F11824%20-%20diag_mp_gibraltar_bc_revivingPlayer_condCaustic_1p.wav?alt=media&token=59506c3c-3b14-47ad-b484-8b7289617484",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F11827%20-%20diag_mp_gibraltar_bc_revivingPlayer_condRevenant_3p.wav?alt=media&token=25be0cfe-5752-4184-b91f-bcf96b826cff",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F12803%20-%20diag_mp_gibraltar_ping_iWillJoin_calm_condCaustic_1p.wav?alt=media&token=4a32ce5b-cc6d-4dff-8307-b20d1ff9b7d4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2Fgibby%20talks%20about%20skull%20town.mp3?alt=media&token=76e38eed-6f22-41ab-a761-de12ffd61305",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2Fgibby2.mp3?alt=media&token=df900e4a-33eb-40b9-8605-23a418d84411",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F13092%20-%20diag_mp_gibraltar_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=3eb75bca-532b-42ed-967e-75ca8afb5963",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11546%20-%20diag_mp_gibraltar_bc_thIntroHushed_3p.wav?alt=media&token=8b54fecd-33af-4a9d-ae6f-25fdf07e0488",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11545%20-%20diag_mp_gibraltar_bc_thIntroHushed_1p.wav?alt=media&token=4ecbb855-500f-4df9-b7b6-465ac348a7f5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11544%20-%20diag_mp_gibraltar_bc_thIntro_solo.wav?alt=media&token=cf0fda0c-1856-46e2-811b-345590c77d11",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11535%20-%20diag_mp_gibraltar_bc_thCompletedCombat_solo.wav?alt=media&token=0c900d36-cedd-429d-add9-c942ff360ff3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11530%20-%20diag_mp_gibraltar_bc_thCompleted_1p.wav?alt=media&token=c011fd83-821e-4b1d-b6c7-06293031c1e2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11502%20-%20diag_mp_gibraltar_bc_skydive_3p.wav?alt=media&token=3308b7b6-588b-4917-bea0-37e01dd7aae3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11493%20-%20diag_mp_gibraltar_bc_revivingPlayer_condRevenant_1p.wav?alt=media&token=7e51924d-d57a-4383-947f-052ea517c067",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11490%20-%20diag_mp_gibraltar_bc_reviveThanks_condRevenant_3p.wav?alt=media&token=9cae8368-bb9f-48cb-bcc6-6334175e90e1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11486%20-%20diag_mp_gibraltar_bc_reviveSelf_3p.wav?alt=media&token=df01c5aa-a0fe-48ce-9e37-7c32555885ba",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fgibby%2F11485%20-%20diag_mp_gibraltar_bc_reviveSelf_1p.wav?alt=media&token=373b8384-370f-4d94-8ee0-83e4912580e2",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11588%20-%20diag_mp_gibraltar_glad_introHalloween_01_qw_1p.wav?alt=media&token=5c9cf9bf-764a-47cf-8ef2-55fbbc4dd88e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11594%20-%20diag_mp_gibraltar_glad_introSeq_01_qw_3p.wav?alt=media&token=62791cbe-acec-44ca-ae51-7ba518e0579b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11599%20-%20diag_mp_gibraltar_glad_introSeq_02_qw_3p.wav?alt=media&token=ebf2efa3-5214-4c5c-9f72-f1896071d077',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11601%20-%20diag_mp_gibraltar_glad_introSeq_03_qw_1p.wav?alt=media&token=574e0b7a-2674-4b6b-a34d-ea230354c55c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11604%20-%20diag_mp_gibraltar_glad_introSeq_04_qw_1p.wav?alt=media&token=c5926a55-d84b-4950-8898-0e80092a7413',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11609%20-%20diag_mp_gibraltar_glad_introSeq_05_qw_3p.wav?alt=media&token=fc894add-6d25-4d52-8920-5f1c9dd7ec47',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11611%20-%20diag_mp_gibraltar_glad_introSeq_06_qw_1p.wav?alt=media&token=3e1859dc-6b19-4776-9c4c-76efa17c15bd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11615%20-%20diag_mp_gibraltar_glad_introSeq_07_qw_3p.wav?alt=media&token=90cb6a86-2c5d-4cd1-9bc7-02a531e31398',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11617%20-%20diag_mp_gibraltar_glad_introSeq_08_qw_1p.wav?alt=media&token=3c0da4ae-cc89-4ea5-87ef-419ece187ba2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11620%20-%20diag_mp_gibraltar_glad_introSeq_09_qw_1p.wav?alt=media&token=dd591224-1f4c-44fa-9d92-2044cf6eb152',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11624%20-%20diag_mp_gibraltar_glad_introSeq_10_qw_3p.wav?alt=media&token=0a3a94b1-0971-4d96-85fb-ff6b37216e33',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11627%20-%20diag_mp_gibraltar_glad_introSeq_11_qw_3p.wav?alt=media&token=e04806f2-5fcb-4158-8b6e-f10a93187442',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11630%20-%20diag_mp_gibraltar_glad_introSeq_12_qw_3p.wav?alt=media&token=d57d58cf-1341-4470-a8e5-6048054d50b1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11633%20-%20diag_mp_gibraltar_glad_introSeq_13_qw_3p.wav?alt=media&token=4c81d63e-a4cd-41dd-8a85-2ca97970ae8b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11635%20-%20diag_mp_gibraltar_glad_introSeq_14_qw_1p.wav?alt=media&token=51e2d392-b899-4f20-99fc-88d60e114c1a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11638%20-%20diag_mp_gibraltar_glad_introSeq_15_qw_1p.wav?alt=media&token=f3e07b28-37fd-45d8-b9e8-f034411bdb0a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11641%20-%20diag_mp_gibraltar_glad_introSeq_16_qw_1p.wav?alt=media&token=04de8984-f084-4616-b965-5a4ffe3dff78',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11645%20-%20diag_mp_gibraltar_glad_introSeq_17_qw_3p.wav?alt=media&token=6083b86a-f016-4a8b-b21d-65640cf81058',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11648%20-%20diag_mp_gibraltar_glad_introSeq_18_qw_3p.wav?alt=media&token=5fee80bb-dddd-4ae8-9bba-837308b7e109',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11650%20-%20diag_mp_gibraltar_glad_introSeq_19_qw_1p.wav?alt=media&token=913f5a1f-e978-4ae4-8a6e-673e4fd15d3c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11654%20-%20diag_mp_gibraltar_glad_introSeq_20_qw_3p.wav?alt=media&token=4208bce6-79a4-4690-a57f-e757732bb158',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11656%20-%20diag_mp_gibraltar_glad_introSeq_21_qw_1p.wav?alt=media&token=e0215630-d9cb-4ce8-8eb1-5ce5c03c78a3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11670%20-%20diag_mp_gibraltar_glad_seasonOpen_qw_1p.wav?alt=media&token=c70479df-f5df-48d4-906c-84dbe4277868',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11675%20-%20diag_mp_gibraltar_glad_taunt_01_3p_template.wav?alt=media&token=d68f44eb-76e5-4856-9619-e05c721a48c3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11678%20-%20diag_mp_gibraltar_glad_taunt_02_1p.wav?alt=media&token=e1805331-a5cb-42c4-894e-38b43a98c09a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11681%20-%20diag_mp_gibraltar_glad_taunt_03_1p.wav?alt=media&token=5bd2dd23-f5ed-4c0c-ae1c-8f12ab156814',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11685%20-%20diag_mp_gibraltar_glad_taunt_04_3p.wav?alt=media&token=8efa12c1-c6f1-4236-9ee4-2188ce52fea2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11688%20-%20diag_mp_gibraltar_glad_taunt_05_3p.wav?alt=media&token=88503675-6f49-4e88-a66d-dc23157ca35f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11690%20-%20diag_mp_gibraltar_glad_taunt_06_1p.wav?alt=media&token=72575e30-f18f-4495-88a3-18aa07bc9a2f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11693%20-%20diag_mp_gibraltar_glad_taunt_07_1p.wav?alt=media&token=b44ecde5-5262-4a02-988e-98569a02ec82',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11696%20-%20diag_mp_gibraltar_glad_taunt_08_1p.wav?alt=media&token=b5f1f65a-65f1-4fa5-bc74-8cea49baab11',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11700%20-%20diag_mp_gibraltar_glad_taunt_09_3p.wav?alt=media&token=1b62b794-17c6-4ba4-9fd2-f962d256c5ab',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11705%20-%20diag_mp_gibraltar_glad_taunt_11_1p.wav?alt=media&token=1e1f2cd5-1e28-4d4a-a42c-6712bb917c0f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11709%20-%20diag_mp_gibraltar_glad_taunt_12_3p.wav?alt=media&token=a6b17ce8-279e-4435-9c26-149b2c24cdcf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11711%20-%20diag_mp_gibraltar_glad_taunt_13_1p.wav?alt=media&token=14c66c87-f016-441d-9f2e-a68780120b1b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11714%20-%20diag_mp_gibraltar_glad_taunt_14_1p.wav?alt=media&token=64b80d43-19d1-4d11-9ad0-ab16648775c6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11717%20-%20diag_mp_gibraltar_glad_taunt_15_1p.wav?alt=media&token=2925c185-61dc-4f71-a5aa-7f5273d02671',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11721%20-%20diag_mp_gibraltar_glad_taunt_16_3p.wav?alt=media&token=44241541-7074-411d-963b-e6a08bcfdf80',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11723%20-%20diag_mp_gibraltar_glad_taunt_17_1p.wav?alt=media&token=e9cca444-6ca3-4e87-9d0b-acf078e9b3f8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11727%20-%20diag_mp_gibraltar_glad_taunt_18_3p.wav?alt=media&token=3197fee0-e8b6-4d1c-b0c6-619914cc147e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11729%20-%20diag_mp_gibraltar_glad_taunt_19_1p.wav?alt=media&token=bc5d3649-b4b4-434d-a7fd-fd26dd0d5f88',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11732%20-%20diag_mp_gibraltar_glad_taunt_20_1p.wav?alt=media&token=af2a9ca7-3c9b-44df-bf03-dfa0e54eeab4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11736%20-%20diag_mp_gibraltar_glad_taunt_21_3p.wav?alt=media&token=f0dbf54a-6d60-4bd7-a564-e91a55e2c8db',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11739%20-%20diag_mp_gibraltar_glad_taunt_22_3p.wav?alt=media&token=0574d1e6-c426-4940-a672-ba09e542cee7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11741%20-%20diag_mp_gibraltar_glad_taunt_23_1p.wav?alt=media&token=a83f668a-8ac0-4ef5-821e-60caf967f65f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11744%20-%20diag_mp_gibraltar_glad_taunt_24_1p.wav?alt=media&token=0bd74b1a-d295-4751-8805-3423fafb0da2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11748%20-%20diag_mp_gibraltar_glad_taunt_25_3p.wav?alt=media&token=2bd640ba-ae0c-43ae-9ff0-0fc1dd8575a9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11751%20-%20diag_mp_gibraltar_glad_taunt_26_3p.wav?alt=media&token=6c7b9059-76a8-4dff-80f8-4b40f9b309a5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11753%20-%20diag_mp_gibraltar_glad_taunt_27_1p.wav?alt=media&token=4edfa51b-0559-4e21-a424-615bfdbb0a8d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11756%20-%20diag_mp_gibraltar_glad_taunt_28_1p.wav?alt=media&token=ed0183bc-d867-4d7c-80dd-ee421a91a07c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11759%20-%20diag_mp_gibraltar_glad_taunt_29_1p.wav?alt=media&token=39438de9-489d-4e5b-b92d-cc3e88e96919',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11762%20-%20diag_mp_gibraltar_glad_taunt_30_1p.wav?alt=media&token=824ab658-6977-4270-8107-43851b8aa5a7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11765%20-%20diag_mp_gibraltar_glad_taunt_31_1p.wav?alt=media&token=a1dab08c-87ab-454f-afbc-0af7ce3a1d41',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11768%20-%20diag_mp_gibraltar_glad_taunt_32_1p.wav?alt=media&token=3a0ade61-816a-43a5-acfd-92498a1309c4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11771%20-%20diag_mp_gibraltar_glad_taunt_33_1p.wav?alt=media&token=68418c95-fc1e-4eb3-a915-e76f14a083f9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11774%20-%20diag_mp_gibraltar_glad_taunt_34_1p.wav?alt=media&token=a1ae233f-de2d-4214-86b2-08382596d6de',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11778%20-%20diag_mp_gibraltar_glad_taunt_35_3p.wav?alt=media&token=db918af5-001c-43c4-87d6-503b037f7fa3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11780%20-%20diag_mp_gibraltar_glad_taunt_36_1p.wav?alt=media&token=9900af54-4957-40b6-a46c-a8efd2962579',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11784%20-%20diag_mp_gibraltar_glad_taunt_37_3p.wav?alt=media&token=c366de7d-131b-455e-8e5c-a639ad54a2eb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11786%20-%20diag_mp_gibraltar_glad_taunt_38_1p.wav?alt=media&token=b02d765e-dd8a-4cc2-a81a-2d81e01b5b3d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11789%20-%20diag_mp_gibraltar_glad_taunt_39_1p.wav?alt=media&token=3bbb0844-4632-4fe7-b106-73c2bbeb0656',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11792%20-%20diag_mp_gibraltar_glad_taunt_40_1p.wav?alt=media&token=98895ab6-e735-47dc-8b4e-fa16088df439',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11795%20-%20diag_mp_gibraltar_glad_taunt_41_1p.wav?alt=media&token=27e2a9b4-26e1-4fe8-91b1-a951e2d6ae23',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11798%20-%20diag_mp_gibraltar_glad_taunt_43_1p.wav?alt=media&token=fbc0f19e-4836-44a5-a2e3-ed1db99e1dbb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11801%20-%20diag_mp_gibraltar_glad_tauntHalloween_01_1p.wav?alt=media&token=e42b7b0c-fe80-433d-bbac-ca49bce256c7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11805%20-%20diag_mp_gibraltar_glad_tauntHalloween_02_3p.wav?alt=media&token=0659b0b8-b311-4c50-b0b7-31ae25fd67fe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11808%20-%20diag_mp_gibraltar_glad_tauntValentines_01_3p.wav?alt=media&token=b6f86e6f-4304-4d4c-bf69-1b2472263cea',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11811%20-%20diag_mp_gibraltar_glad_tauntValentines_02_3p.wav?alt=media&token=7201242b-68ef-49bc-84b5-adfaa91d7f1c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11814%20-%20diag_mp_gibraltar_glad_tauntWinter_01_3p.wav?alt=media&token=a837b410-acd2-4c38-8a61-215afb5a50b8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/11817%20-%20diag_mp_gibraltar_glad_tauntWinter_02_3p.wav?alt=media&token=cc4946b3-1c6b-4b8a-a920-f6761917419c',
  ];

  final List<String> quipnames = [
    "We all change for the better my brother (NEW)",
    "I used to run with a bad crowd but atleast mine knew how to fight",
    "Eh! I used to run with a bad crowd",
    "Now that's some good moves from the new girl,Nice work",
    "Gotta save your life didn't it",
    "I'm always keeping my eye on you brother",
    "Don't like how you dealt with forge but you are still squad for now",
    "Don't think I'm letting you out of my sight doc",
    "Gibraltar talks about Skull Town ",
    "Turn that frown,upside down ",
    "Coming from you bruh,that's down right polite ",
    "Looking for the piece brothers ",
    "All right got a piece to find brother,get in get out,that's how we do ",
    "All right there's the piece,eh just like a rescuev",
    "Grabbed the piece,better get back to safeground ",
    "Grabbed the piece,let's get back to safeground ",
    "Skydive laugh ",
    "I'm not like you,I will never be like you ",
    "Thanks for not stabbing me in the back like you did forge ",
    "All right Gibraltar is up ready to go ",
    "Eh and Gibralatar's up ready to go ",
    'Knock! Knock! Gibraltar\'s at the door',
    'You push I slam',
    'I just do the job',
    'What can I say, I love what I do',
    'I\'m ready are you',
    'My shield My life',
    'Try to move me it will be fun',
    'Good Luck Brothers',
    'Try what you want,It won\'t make a diffrence',
    'Hey,It\'s a beautiul day',
    'I\'m like a rock but rocks don\'t hit back',
    'Here we go better hope you are with me',
    'Hey Brother watch out here I Come',
    'Just Another day and Another Title',
    'C\'mon Brother Step up',
    'All right brother gibraltar\'s coming for ya',
    'You see me you are finished',
    'I\'m either with you are you are done POW',
    'Woho,Great,Good,Wonderful',
    'You better run from Gibraltar',
    'I\'m not hard to miss and i don\'t miss',
    'This is gonna hurt you more than me',
    'It\'s opening season lets do this brothers',
    'EH Brother not today maybe tommorow',
    'Good try bruh! MAybe try harder next time',
    'Ah yes Gibraltar wins again',
    'That\'s what you get for messing with gibraltar',
    'That was a good match brother',
    'Just Gibraltar getting the job done',
    'It\'s just my skill can\'t help it',
    'Looks like today is my day brother',
    'Never turn your back on gibraltar',
    'Some call it luck I call it skill',
    'This is Gibraltar\'s match',
    'Too Slow Too Weak whatever the case I got you',
    'Not too bad but not too goood either brother',
    'Looks like my training paid off',
    'I can\'t help but to compliment myself',
    'That\'s how you change your life',
    'I brought it and you did it',
    'The Sun is shining bright on me today',
    'Thank you for the kill brudda',
    'Goodbye brudda',
    'Brudda,This just wasn\'t your fight',
    'That didn\'t work out too well for you pal',
    'You have some skill keep at it,so I can beat you again',
    'I got you',
    'The pleasure is all yours',
    'You tried you died',
    'You didn\'t fight horribly that\'s a good thing',
    'That was fun for me',
    'That was all I needed brother',
    'You should be proud to be defeated by gibraltar',
    'This is my favourite part',
    'Gotta admit,that was pretty good right',
    'It\'s all in the attitude and I got a lot of it',
    'I said it and I believe it,I\'m winning today',
    'I really know how to bring the fun into this',
    'Thanks for pushing me my brudda',
    'Awesome battle may be next time',
    'It is an awesome feeling to win',
    'Hey brudda,you lost this time',
    'you just got it handed to you brother,nice try',
    'What did you think you were gonna do,win against me?',
    'Maybe you should take off that costume brother',
    'Don\'t be scared it\'s just gibraltar',
    'Don\'t feel bad gibraltar stil loves you',
    'Roses are red and you will be dead',
    'Look at the bright side atleast you wont freeze to death',
    'Better warm up,it\'s gonna be a long winter',
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
            'Gibraltar Quips',
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
                          child: Image.asset("assets/images/gibby.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Gibraltar Quips",
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
