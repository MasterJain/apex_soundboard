import 'dart:io';

import 'package:apex_soundboard/main.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';
import 'package:apex_soundboard/abouthelpers/downloadalert.dart';

import 'package:http/http.dart' as http;

class BangaloreIOS extends StatefulWidget {
  @override
  _BangaloreIOSState createState() => _BangaloreIOSState();
}

class _BangaloreIOSState extends State<BangaloreIOS> {
  final String iosinterstitial = "ca-app-pub-8443733844039169/6182951856";

  final String androidintertitial = "ca-app-pub-8443733844039169/7172885302";

  final List<String> zones = [
    "vz60deb25cb37c47c6ad",
  ];

  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_bangalore_glad_tauntOrigin_01_01_1p.wav?alt=media&token=73472cde-0200-4521-b288-de256bbf687b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F4402%20-%20diag_mp_bangalore_bc_reviveThanks_condOctane_1p.wav?alt=media&token=f5ec7109-56f6-4453-aec6-502aab625894",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F5573%20-%20diag_mp_bangalore_ping_markerNo_calm_condLoba_1p.wav?alt=media&token=b1d8c8ce-837c-4bd7-b597-490c9be27548",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F5591%20-%20diag_mp_bangalore_ping_markerYes_calm_condLoba_1p.wav?alt=media&token=7bc46993-4779-4eac-8e8e-1dd7a985bafd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F5952%20-%20diag_mp_bangalore_ping_thanks_condLoba_3p.wav?alt=media&token=867dfeb6-dfea-4b5f-9dfb-e0a56740383a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F5954%20-%20diag_mp_bangalore_ping_thanks_condRevenant_3p.wav?alt=media&token=b36d88f6-49ba-4885-b6ff-5a2e1a3e2451",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F6147%20-%20diag_mp_bangalore_ping_youreWelcome_calm_condRampart_1p.wav?alt=media&token=1652933c-26c1-4c51-a7e5-0387a3241297",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2Fbangalore%20thoughts%20about%20IMC.mp3?alt=media&token=53b9c163-14d7-42fb-b436-0ed8dd3d41d7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2Fbangalore%20thoughts%20on%20capacitor.mp3?alt=media&token=b2326b75-7b68-41ab-b01b-97b477f21c4f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F5998%20-%20diag_mp_bangalore_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=62a69518-4e09-4622-8cb1-289422f46da4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F5997%20-%20diag_mp_bangalore_ping_youreWelcome_calm_condRevenant_1p.wav?alt=media&token=23c0689f-feb0-4f53-9f80-6c0974598ebf",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4352%20-%20diag_mp_bangalore_bc_thIntro_solo.wav?alt=media&token=6f5a57b3-a220-4857-a006-9089c861f85c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4350%20-%20diag_mp_bangalore_bc_thIntro_1p.wav?alt=media&token=a826e02b-104d-49cb-87db-03d99c07257b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4340%20-%20diag_mp_bangalore_bc_thCompleted_solo.wav?alt=media&token=5a566fd6-f576-4196-b434-20c266044164",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4338%20-%20diag_mp_bangalore_bc_thCompleted_1p.wav?alt=media&token=ae6f51e1-9520-4af8-8a64-40d3c9612385",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4329%20-%20diag_mp_bangalore_bc_super_3p.wav?alt=media&token=da862d60-d274-4a2e-b3f2-2075a4b647dd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4328%20-%20diag_mp_bangalore_bc_super_1p.wav?alt=media&token=985021bb-a78c-4ac0-b044-de2ed2cc983f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4311%20-%20diag_mp_bangalore_bc_skydive_3p.wav?alt=media&token=686804a0-9a00-43fe-b7c1-3be663e905a1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4310%20-%20diag_mp_bangalore_bc_skydive_1p.wav?alt=media&token=284166ca-5457-415f-9a6b-4df13351d3eb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4300%20-%20diag_mp_bangalore_bc_reviveSelf_1p.wav?alt=media&token=a50f13f8-b28d-4647-9843-77a706fa37ea",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbangalore%2F4301%20-%20diag_mp_bangalore_bc_reviveSelf_3p.wav?alt=media&token=0a65d026-6b8e-46ac-9038-f46fc7aa3e9b",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4394%20-%20diag_mp_bangalore_glad_introHalloween_01_qw_1p_template.wav?alt=media&token=be0679ec-ecd7-4875-b032-ae2e922fa5ab',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4399%20-%20diag_mp_bangalore_glad_introSeq_01_qw_1p.wav?alt=media&token=f338ae92-0b2a-41a3-a47f-ffd9d6976928,'
        'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4406%20-%20diag_mp_bangalore_glad_introSeq_02_qw_3p.wav?alt=media&token=00f7a795-25c0-4aaa-8eb5-e883ba256e45',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4410%20-%20diag_mp_bangalore_glad_introSeq_03_qw_3p.wav?alt=media&token=71796158-5560-4553-b4c7-ea79d082f520,'
        'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4413%20-%20diag_mp_bangalore_glad_introSeq_04_qw_3p.wav?alt=media&token=bdef62b2-1443-425c-b678-9412227b4d60',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4416%20-%20diag_mp_bangalore_glad_introSeq_05_qw_3p.wav?alt=media&token=b21c9bb2-971c-49bc-9587-887e898accd0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4418%20-%20diag_mp_bangalore_glad_introSeq_06_qw_1p.wav?alt=media&token=4c1fa2ac-2266-4fc5-bfcd-ccd4393f5441',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4422%20-%20diag_mp_bangalore_glad_introSeq_07_qw_3p.wav?alt=media&token=685c177f-bd5e-4e90-ba3c-e7e69555c60a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4424%20-%20diag_mp_bangalore_glad_introSeq_08_qw_1p.wav?alt=media&token=1cee96a4-d196-4d8d-9681-c964c849daaf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4428%20-%20diag_mp_bangalore_glad_introSeq_09_qw_3p.wav?alt=media&token=0be790b6-a183-4062-8d0b-451d3ffa1ae7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4430%20-%20diag_mp_bangalore_glad_introSeq_10_qw_1p.wav?alt=media&token=4981b572-6ef7-4169-83ea-c5807f4394bd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4434%20-%20diag_mp_bangalore_glad_introSeq_11_qw_3p.wav?alt=media&token=ffc4eb07-c361-44eb-9996-8dbb2d8c0b3b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4437%20-%20diag_mp_bangalore_glad_introSeq_12_qw_3p.wav?alt=media&token=47a09b79-15b6-43b6-8b12-6a91bbb44910',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4440%20-%20diag_mp_bangalore_glad_introSeq_13_qw_3p.wav?alt=media&token=0473cc2e-dc65-452a-af2b-98885284e902',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4443%20-%20diag_mp_bangalore_glad_introSeq_14_qw_3p.wav?alt=media&token=801d0140-fe47-4169-a00e-635b6135d293',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4446%20-%20diag_mp_bangalore_glad_introSeq_15_qw_3p.wav?alt=media&token=0393e0f9-adcf-4e09-a7aa-1abb7dbcb450',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4449%20-%20diag_mp_bangalore_glad_introSeq_16_qw_3p.wav?alt=media&token=0db4b95d-2f2d-4129-8222-112d2c06eada',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4452%20-%20diag_mp_bangalore_glad_introSeq_17_qw_3p.wav?alt=media&token=87d4c7b7-41a5-40fc-a1b8-cf8bd7612334',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4454%20-%20diag_mp_bangalore_glad_introSeq_18_qw_1p.wav?alt=media&token=d181f30b-4e13-4300-9903-62f7a1950fac',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4458%20-%20diag_mp_bangalore_glad_introSeq_19_qw_3p.wav?alt=media&token=a31f6c76-19c3-48a6-823c-a94fa258c4aa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4461%20-%20diag_mp_bangalore_glad_introSeq_20_qw_3p.wav?alt=media&token=771db6be-4b45-4d3c-a46c-feac701af47e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4467%20-%20diag_mp_bangalore_glad_introSeq_TEMPLATE.wav?alt=media&token=3b2287fc-8949-4234-ba32-45b571061ee3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4479%20-%20diag_mp_bangalore_glad_seasonOpen_qw_1p.wav?alt=media&token=d0eff45a-de19-4dba-a8fe-9dee781bbc38',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4481%20-%20diag_mp_bangalore_glad_taunt_01_1p.wav?alt=media&token=c24c0779-a07b-4f18-8f31-3137ff1fc3f9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4488%20-%20diag_mp_bangalore_glad_taunt_02_3p.wav?alt=media&token=40a674ac-3d61-4e55-9717-53edad936e6c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4491%20-%20diag_mp_bangalore_glad_taunt_03_3p.wav?alt=media&token=1d80d5fa-aae3-4303-af86-5bcbc16ac634',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4493%20-%20diag_mp_bangalore_glad_taunt_04_1p.wav?alt=media&token=b679d3cd-9b84-4dc8-8ce7-945e2299c13c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4497%20-%20diag_mp_bangalore_glad_taunt_05_3p.wav?alt=media&token=168e6d01-3f13-4d80-be53-16d0a5babb9d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4499%20-%20diag_mp_bangalore_glad_taunt_06_1p.wav?alt=media&token=28add9a5-248b-49b6-a1f3-da77087008d6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4503%20-%20diag_mp_bangalore_glad_taunt_07_3p.wav?alt=media&token=75110373-4fd8-4c9d-899d-a52f4523e156',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4505%20-%20diag_mp_bangalore_glad_taunt_08_1p.wav?alt=media&token=cecf1358-1758-4148-9d46-64e77fc9ca21',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4508%20-%20diag_mp_bangalore_glad_taunt_09_1p.wav?alt=media&token=adc7d352-106e-4b68-b31b-a8f22e56d762',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4511%20-%20diag_mp_bangalore_glad_taunt_10_1p.wav?alt=media&token=8b8ce895-76e5-46ef-9eb9-eaa605507407',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4515%20-%20diag_mp_bangalore_glad_taunt_11_3p.wav?alt=media&token=5fab7202-d283-4e55-9f4e-9982f1ac8884',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4517%20-%20diag_mp_bangalore_glad_taunt_12_1p.wav?alt=media&token=43a7fe67-70a7-46f6-876c-ce3407d8f2be',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4520%20-%20diag_mp_bangalore_glad_taunt_13_1p.wav?alt=media&token=15c3960d-9ec4-4546-b02e-3ba202966b7c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4523%20-%20diag_mp_bangalore_glad_taunt_14_1p.wav?alt=media&token=3151e50a-eaf6-4c73-899d-7306bff092ad',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4527%20-%20diag_mp_bangalore_glad_taunt_15_3p.wav?alt=media&token=a510a3da-7fe1-4f6d-86a5-81765fdbf8d9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4529%20-%20diag_mp_bangalore_glad_taunt_16_1p.wav?alt=media&token=be3323f4-453d-4ab6-9178-f5eef5c1aa29',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4533%20-%20diag_mp_bangalore_glad_taunt_17_3p.wav?alt=media&token=c05096a1-676f-4219-9be5-6b60a3cef1ea',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4536%20-%20diag_mp_bangalore_glad_taunt_18_3p.wav?alt=media&token=50d440dd-cfd0-4876-8579-d64c345ccf51',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4539%20-%20diag_mp_bangalore_glad_taunt_19_3p.wav?alt=media&token=89bdfe6e-3ab2-4a23-a2cb-503fb2e174d4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4541%20-%20diag_mp_bangalore_glad_taunt_20_1p.wav?alt=media&token=3be63588-7cf5-43dd-b4b1-cc906a679b65',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4545%20-%20diag_mp_bangalore_glad_taunt_21_3p.wav?alt=media&token=39259e15-d366-40da-9998-45c2417b6d90',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4548%20-%20diag_mp_bangalore_glad_taunt_22_3p.wav?alt=media&token=a0dd96ab-ea76-4e4b-b1fd-52bbc5f21f73',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4550%20-%20diag_mp_bangalore_glad_taunt_23_1p.wav?alt=media&token=b7a8b8c6-5f07-4f8c-9b76-9946f34d2b76',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4553%20-%20diag_mp_bangalore_glad_taunt_24_1p.wav?alt=media&token=7a588830-b4df-47a7-a507-ba6f34a76483',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4556%20-%20diag_mp_bangalore_glad_taunt_25_1p.wav?alt=media&token=03bdd4c9-8303-4fc7-bd5e-3b00aa0ccb1f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4559%20-%20diag_mp_bangalore_glad_taunt_26_1p.wav?alt=media&token=f69a9e16-02b1-427f-866e-7afdae888658',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4562%20-%20diag_mp_bangalore_glad_taunt_27_1p.wav?alt=media&token=d55cb645-e82c-4ee7-be2b-c4ab32d73fd5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4565%20-%20diag_mp_bangalore_glad_taunt_28_1p.wav?alt=media&token=93026a58-7554-491a-8840-2411472a509b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4568%20-%20diag_mp_bangalore_glad_taunt_29_1p.wav?alt=media&token=c8a7fb46-18d8-49ae-be3a-26f76c1c39c5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4571%20-%20diag_mp_bangalore_glad_taunt_30_1p.wav?alt=media&token=7ae94f3a-f2f1-43e1-b7a8-1dfd116264df',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4575%20-%20diag_mp_bangalore_glad_taunt_31_3p.wav?alt=media&token=9478b6e3-ec74-4751-a12c-9d8abe3095da',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4577%20-%20diag_mp_bangalore_glad_taunt_32_1p.wav?alt=media&token=c113434d-b443-4d8f-a227-a43e5fea5a9d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4581%20-%20diag_mp_bangalore_glad_taunt_33_3p.wav?alt=media&token=ecf21062-552a-44fb-954d-4bee12bf9a05',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4583%20-%20diag_mp_bangalore_glad_taunt_34_1p.wav?alt=media&token=0e18a009-6db0-4c01-be7b-ff693bf11fd4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4587%20-%20diag_mp_bangalore_glad_taunt_35_3p.wav?alt=media&token=ee92990a-c768-4e06-b74d-ddf6a19a76ac',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4590%20-%20diag_mp_bangalore_glad_taunt_36_3p.wav?alt=media&token=af094d75-5c37-4ec3-bb7a-44f50365252b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4592%20-%20diag_mp_bangalore_glad_taunt_37_1p.wav?alt=media&token=fe43c358-2263-442d-b8ba-76068681bf53',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4596%20-%20diag_mp_bangalore_glad_taunt_38_3p.wav?alt=media&token=50ec9500-ad32-40d5-a3bf-301d7842c488',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4598%20-%20diag_mp_bangalore_glad_taunt_39_1p.wav?alt=media&token=571d5c3c-a688-4eca-a902-8fbd7b760c3f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4601%20-%20diag_mp_bangalore_glad_taunt_40_1p.wav?alt=media&token=3315022f-02a3-4f1d-b223-9ec331890a79',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4604%20-%20diag_mp_bangalore_glad_taunt_41_1p.wav?alt=media&token=eb216583-8907-4691-95c7-25dff1d015da',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4608%20-%20diag_mp_bangalore_glad_tauntHalloween_01_3p.wav?alt=media&token=39dab273-feb9-4087-8024-27901bccbaf3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4611%20-%20diag_mp_bangalore_glad_tauntHalloween_02_3p.wav?alt=media&token=c6712478-a9fd-489a-82e4-9f4e0ec7a49f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4613%20-%20diag_mp_bangalore_glad_tauntValentines_01_1p.wav?alt=media&token=13c7a878-3f59-45b3-9dc5-f970ea27b6eb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4617%20-%20diag_mp_bangalore_glad_tauntValentines_02_3p.wav?alt=media&token=6b4cc8fd-a51e-456e-a3fb-868d2c00d126',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4620%20-%20diag_mp_bangalore_glad_tauntWinter_01_3p.wav?alt=media&token=5ac97170-bfec-454c-9641-017fb1266c89',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/4622%20-%20diag_mp_bangalore_glad_tauntWinter_02_1p.wav?alt=media&token=75f0d31e-87b1-4101-a462-f42e8da401f1',
  ];

  final List<String> quipnames = [
    "Five generations of IMC Military training in my blood (NEW)",
    "Call me lady again and I will break your jaw",
    "No thanks girl I'm good ",
    "Beautiful",
    "Hey thanks didn't expect a thief to spread the wealth",
    "Thanks you should't have",
    "Welcome and kid Idk where you got that turret but damn",
    "Bangalore thoughts on IMC ",
    "Bangalore thoughts on Capacitor ",
    "yeah jackass  you made that clear ",
    "I can't belive this guy is actually making me side with forge ",
    "Simple In and Out,You got this Anita ",
    "Simple In and Out Ladies,We need that piece let's go ",
    "Piece is secured time to finish this thing ",
    "Piece is secured now let's finish this things ",
    "Heads up dropping the pain ",
    "Come on In Old painless is waiting ",
    "Hell yeah ",
    "Yeahh ",
    'Seargent first class Anita Williams',
    'Don\'t pull me on the list of casualties yet',
    'This isn\'t a costume its an uniform',
    'Better find me before i find you',
    'Locked and Loaded',
    'Want a tip',
    'Get ready for a world to hurt',
    'Make each round count',
    'Maybe this time i will open both eyes',
    'Don\'t bring an pistol to an artiliery fight',
    'You make contact you better finish the job',
    'Get ready for a lightshow',
    'Artilery sounds like music to me',
    'Name the weapon i will still beat you',
    'No matter what you run',
    'No such thing as',
    'I\'m not hard to understand',
    'Don\'t miss i wont',
    'Pistols to artilery i can do it all you call',
    'Bigger the ordinance the bigger my smile',
    'Heads up for a pucker factor',
    'Better find me before I find you',
    'Opening season no time for an FNG',
    'This what happens when your unit goes',
    'Too slow on the draw',
    'Did you think that the trigger would pull itself',
    'I said danger close weren\'t you listening',
    'You played dead like a pro',
    'Drop Shocked and Rocked',
    'Big small don\'t matter',
    'No substitute for real steel',
    'You are just a KIA on my resume',
    'You can\'t dodge heavy artilery',
    'First you loose your cool than you loose your head',
    'Good initiative bad judgment try again',
    'Bad effect on target rook',
    'You sure you didn\'t make it out of basic training',
    'You just caught on the wrong end of my muzzle',
    'Don\'t knock yourself',
    'First one through the door',
    'You need to hit the range more',
    'Im quicker than you think',
    'Not gonna say this was too easy but',
    'Not your day shooter',
    'I got the best of you today',
    'So that\'s what fear smells like',
    'You lost this one',
    'You bleed you sweat you get what you put in',
    'Take a breather you lost this one',
    'Here\'s a tip',
    'Like a deer in the headlights',
    'What happened your weapon malfunctioned',
    'On this field you gotta be prepared',
    'You ain' 't no operator',
    'Kill Confirmed',
    'Looks like aiming isn\'t your strong suit',
    'You shooting blanks',
    'Training dummy\'s move faster than you',
    'You are in my house now',
    'Ever heard of a stock barrel stabilizer',
    'What happened recoil hit you in the face',
    'Rate of fire means nothing when you miss all the time',
    'You are not even worth to chart the tally',
    'What are you the FNG',
    'Here\'s your candy',
    'You should fear me',
    'I didn\t say i mended broken hearts',
    'I will send followers',
    'They say there is nothing harsher than a long winter',
    'Gonna feel a lot colder in a second',
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
            'Bangalore' ' Quips',
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
                          child: Image.asset("assets/images/bangalore.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Bangalore Quips",
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

startDownload(BuildContext context, String url, String filename) async {
  Directory? appDocDir = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();
  if (Platform.isAndroid) {
    Directory(appDocDir!.path.split("Android")[0] + MyHomePage.appName)
        .create();
  }

  String path = Platform.isIOS
      ? appDocDir!.path + "/$filename.mp3"
      : appDocDir!.path.split("Android")[0] +
          "${MyHomePage.appName}/$filename.mp3";
  print(path);
  File file = File(path);
  if (!await file.exists()) {
    await file.create();
  } else {
    await file.delete();
    await file.create();
  }

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => DownloadAlert(
      url: url,
      path: path,
    ),
  );
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

Future downloadFile(BuildContext context, String url, String filename) async {
  await Permission.storage.request().then((_) async {
    if (await Permission.storage.status == PermissionStatus.granted) {
      startDownload(context, url, filename);
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
