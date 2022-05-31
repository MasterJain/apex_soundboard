import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class Revenant extends StatefulWidget {
  @override
  _RevenantState createState() => _RevenantState();
}

class _RevenantState extends State<Revenant> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_revenant_glad_tauntOrigin_01_01_3p.wav?alt=media&token=8226d550-86a5-4655-820c-83a8346376d6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2Flobarevenent%20talk.mp3?alt=media&token=22799c5a-979a-48a2-8829-c7be45386aba",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F24800%20-%20diag_mp_revenant_bc_iKilledAnEnemyWithHeirloom_1p.wav?alt=media&token=67bdab26-6105-40bc-abcd-156951df9cbc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F24801%20-%20diag_mp_revenant_bc_iKilledAnEnemyWithHeirloom_3p.wav?alt=media&token=d1ef9c0f-ec2e-47ee-9541-34658277d172",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22464%20-%20diag_mp_revenant_bc_twoSquaddiesLeft_condLoba_3p.wav?alt=media&token=41fd460f-b3a5-4ad6-b149-527e8145c5a6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22458%20-%20diag_mp_revenant_bc_totemDestroyed_3p.wav?alt=media&token=3e6b44b1-d94a-4d4b-ba80-a3a886d3aac7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22451%20-%20diag_mp_revenant_bc_thIntro_1p.wav?alt=media&token=dcbffb05-ce86-4042-96b0-92c33f289dec",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22443%20-%20diag_mp_revenant_bc_thCompletedCombat_3p.wav?alt=media&token=23ff1660-8a34-4014-9c19-1fd84b1e4328",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22418%20-%20diag_mp_revenant_bc_squadmateBecomesKillLeader_condLoba_3p.wav?alt=media&token=b40c9474-1129-4bf9-b401-48c9e081ebb0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22412%20-%20diag_mp_revenant_bc_skydive_3p.wav?alt=media&token=9026dd59-9eff-4203-a9ac-7d7385d84713",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22411%20-%20diag_mp_revenant_bc_skydive_1p.wav?alt=media&token=9e85e56d-e17d-4a97-977c-2281e7ddbe81",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22406%20-%20diag_mp_revenant_bc_revivingPlayer_condLoba_3p.wav?alt=media&token=f6d069ab-a639-45a3-a47d-6aa9ae6f926a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22402%20-%20diag_mp_revenant_bc_reviveThanks_condLoba_3p.wav?alt=media&token=b903040a-949e-4b47-b035-6296cf91117b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22401%20-%20diag_mp_revenant_bc_reviveThanks_condLoba_1p.wav?alt=media&token=c8e7c235-922a-4bab-9019-bf6028f621e7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22390%20-%20diag_mp_revenant_bc_podLeaderLaunch_3p_template.wav?alt=media&token=010f91f0-65e0-439d-aefe-c3131955d9c4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22389%20-%20diag_mp_revenant_bc_podLeaderLaunch_3p.wav?alt=media&token=497078d2-63a3-46a7-bcd8-9352aea1e75e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22385%20-%20diag_mp_revenant_bc_objectiveLostSquad_1p.wav?alt=media&token=908ce95c-9473-4eb9-b093-e7500b9c7943",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Frevenant%2F22382%20-%20diag_mp_revenant_bc_objectiveHaveSquad_3p.wav?alt=media&token=b79f7111-86f9-40a8-b8f3-416a2ea25f7c",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22490%20-%20diag_mp_revenant_glad_introSeq_01_qw_1p.wav?alt=media&token=5bec7161-bb25-45ca-bdcc-63f6ec6459fe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22496%20-%20diag_mp_revenant_glad_introSeq_02_qw_1p.wav?alt=media&token=1941bf50-5059-449b-8eeb-52d6ddbf0b0e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22499%20-%20diag_mp_revenant_glad_introSeq_03_qw_1p.wav?alt=media&token=a40d92f0-6127-4a1b-adfc-fb7e82bd1b5d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22502%20-%20diag_mp_revenant_glad_introSeq_04_qw_1p.wav?alt=media&token=d31d29d1-700d-4ada-8d7c-754ecd87c05d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22505%20-%20diag_mp_revenant_glad_introSeq_05_qw_1p.wav?alt=media&token=14fa2d3a-f7a4-417c-aa12-b0949f247c2a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22509%20-%20diag_mp_revenant_glad_introSeq_06_qw_3p.wav?alt=media&token=369915a9-6028-4e51-8926-3de906bd4b11',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22511%20-%20diag_mp_revenant_glad_introSeq_07_qw_1p.wav?alt=media&token=2d2b2d29-8ca9-4d48-a6d3-c88b1fc3663f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22514%20-%20diag_mp_revenant_glad_introSeq_08_qw_1p.wav?alt=media&token=89637055-b828-47da-8be9-730242d78581',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22518%20-%20diag_mp_revenant_glad_introSeq_09_qw_3p.wav?alt=media&token=73cfad87-cfd4-44ce-acfe-1e7406cd8e3a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22521%20-%20diag_mp_revenant_glad_introSeq_10_qw_3p.wav?alt=media&token=167ae1de-9ee7-48fa-82c8-399d05f2ba8b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22524%20-%20diag_mp_revenant_glad_introSeq_11_qw_3p.wav?alt=media&token=0c91e0ec-2d31-40a9-a1aa-52944f58a34c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22526%20-%20diag_mp_revenant_glad_introSeq_12_qw_1p.wav?alt=media&token=1765f8d6-1627-4f59-9a4d-acf570dfa7d5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22530%20-%20diag_mp_revenant_glad_introSeq_13_qw_3p.wav?alt=media&token=e489d472-f24a-450c-baec-72ad9d9cebd7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22532%20-%20diag_mp_revenant_glad_introSeq_14_qw_1p.wav?alt=media&token=e7a733ab-f252-4684-8b4c-33702c11330f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22536%20-%20diag_mp_revenant_glad_introSeq_15_qw_3p.wav?alt=media&token=1b8f73f9-23ee-40de-a599-bb45f9a1c2fa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22539%20-%20diag_mp_revenant_glad_introSeq_16_qw_3p.wav?alt=media&token=e1aeeca9-32f4-4842-9b65-49af4d26bf30',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22542%20-%20diag_mp_revenant_glad_introSeq_17_qw_3p.wav?alt=media&token=e11c3513-3770-4479-88a3-8178e2504b46',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22544%20-%20diag_mp_revenant_glad_introSeq_18_qw_1p.wav?alt=media&token=06eca2ac-3246-452c-9fd9-cd02f6c2b955',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22547%20-%20diag_mp_revenant_glad_introSeq_19_qw_1p.wav?alt=media&token=0623e1a0-9061-47d4-accb-7a56d8d9dae5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22550%20-%20diag_mp_revenant_glad_introSeq_20_qw_1p.wav?alt=media&token=4e376735-8986-4a76-8372-b4fd0ffd7916',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22553%20-%20diag_mp_revenant_glad_introSeq_21_qw_1p.wav?alt=media&token=4d8de32b-172b-460a-a458-69577d3322fa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22568%20-%20diag_mp_revenant_glad_seasonOpen_qw_1p.wav?alt=media&token=f4e7e066-acff-4114-b968-f510bf5095d8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22570%20-%20diag_mp_revenant_glad_taunt_01_1p.wav?alt=media&token=a125108f-708f-44bc-a781-3b81f7b3af17',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22576%20-%20diag_mp_revenant_glad_taunt_02_1p.wav?alt=media&token=7ff03ce6-fb1d-49d1-993b-5ab25d7d2f18',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22580%20-%20diag_mp_revenant_glad_taunt_03_3p.wav?alt=media&token=e6130df1-6b75-4292-8738-3265ff1e510d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22583%20-%20diag_mp_revenant_glad_taunt_04_3p.wav?alt=media&token=3cc983ae-c3e8-4e47-9be8-e0df72f50efd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22585%20-%20diag_mp_revenant_glad_taunt_05_1p.wav?alt=media&token=ff3d4854-bdd2-44c7-b8fa-d3623ce768c1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22589%20-%20diag_mp_revenant_glad_taunt_06_3p.wav?alt=media&token=c2eede31-eb28-4961-afa4-5bd4550df3ef',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22591%20-%20diag_mp_revenant_glad_taunt_07_1p.wav?alt=media&token=5acbe001-5ce5-47e4-9a31-c4ba188ab596',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22594%20-%20diag_mp_revenant_glad_taunt_08_1p.wav?alt=media&token=ebf5d8ee-3140-471e-8abd-0273e6432a0f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22598%20-%20diag_mp_revenant_glad_taunt_09_3p.wav?alt=media&token=f9ef7eff-d6bd-4e66-8282-158a24bb5491',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22600%20-%20diag_mp_revenant_glad_taunt_10_1p.wav?alt=media&token=6347d9fa-5c78-440c-81d6-855d857f8d8e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22603%20-%20diag_mp_revenant_glad_taunt_11_1p.wav?alt=media&token=ee3f77f1-c1f8-45fb-9846-11949acd221f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22606%20-%20diag_mp_revenant_glad_taunt_12_1p.wav?alt=media&token=2a2adab1-a1e0-4551-b598-1b79fde1cdcd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22609%20-%20diag_mp_revenant_glad_taunt_13_1p.wav?alt=media&token=c1a13698-052d-401c-9783-047b1b83f3d8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22612%20-%20diag_mp_revenant_glad_taunt_14_1p.wav?alt=media&token=5ab71e3f-d048-407b-bf85-779a8499ca87',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22616%20-%20diag_mp_revenant_glad_taunt_15_3p.wav?alt=media&token=53947b8a-45c7-4118-b738-39727bfcb6c0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22619%20-%20diag_mp_revenant_glad_taunt_16_3p.wav?alt=media&token=a3636e0f-5bd0-40ee-a81b-18b658a29f22',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22622%20-%20diag_mp_revenant_glad_taunt_17_3p.wav?alt=media&token=cad794a2-7fec-4597-ace8-8ba1927f30a0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22625%20-%20diag_mp_revenant_glad_taunt_18_3p.wav?alt=media&token=d54f4bd9-f8fe-4c17-8f20-d39b6959a3e0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22627%20-%20diag_mp_revenant_glad_taunt_19_1p.wav?alt=media&token=ef81a59c-e4d3-46d1-a68e-a62501ff3c5b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22630%20-%20diag_mp_revenant_glad_taunt_20_1p.wav?alt=media&token=1b8e9916-11c5-42b1-8e85-66dd88ff4592',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22634%20-%20diag_mp_revenant_glad_taunt_21_3p.wav?alt=media&token=850f5d7c-1315-4cb5-8253-128922ea177d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22637%20-%20diag_mp_revenant_glad_taunt_22_3p.wav?alt=media&token=db11aab9-2540-4fa0-968c-6d3e5d2fc6cc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22640%20-%20diag_mp_revenant_glad_taunt_23_3p.wav?alt=media&token=42cf5f44-2870-4e51-923e-203e64a77aec',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22642%20-%20diag_mp_revenant_glad_taunt_24_1p.wav?alt=media&token=8ccdb4e0-632d-402f-87d1-debac32777bd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22646%20-%20diag_mp_revenant_glad_taunt_25_3p.wav?alt=media&token=7ec5156a-085c-48e0-9576-28e13d1ae1cb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22649%20-%20diag_mp_revenant_glad_taunt_26_3p.wav?alt=media&token=5cb24151-e5c8-48ff-a7b9-1ccf991228e9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22652%20-%20diag_mp_revenant_glad_taunt_27_3p.wav?alt=media&token=917d2827-5835-4122-8894-67f224895219',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22655%20-%20diag_mp_revenant_glad_taunt_28_3p.wav?alt=media&token=473f2388-1fe0-4107-b227-c15eb74c18f7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22658%20-%20diag_mp_revenant_glad_taunt_29_3p.wav?alt=media&token=8433585f-87ab-4309-b01f-73676c4d274b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22661%20-%20diag_mp_revenant_glad_taunt_30_3p.wav?alt=media&token=4a340e66-494a-4ef6-9896-bec9e466a84d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22664%20-%20diag_mp_revenant_glad_taunt_31_3p.wav?alt=media&token=84d1586e-84a1-4fdf-844b-b240b619e35f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22667%20-%20diag_mp_revenant_glad_taunt_32_3p.wav?alt=media&token=34490134-b927-4da6-b396-552f80c072c4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22670%20-%20diag_mp_revenant_glad_taunt_33_3p.wav?alt=media&token=97c83ba7-1ffd-44e9-92a6-b83fe9674f94',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22673%20-%20diag_mp_revenant_glad_taunt_34_3p.wav?alt=media&token=a5540fd8-8706-474a-8968-6f413c6b1cfa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22676%20-%20diag_mp_revenant_glad_taunt_35_3p.wav?alt=media&token=7b1821d3-243d-4e7f-8f40-e95af7ffe140',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22679%20-%20diag_mp_revenant_glad_taunt_36_3p.wav?alt=media&token=69a99523-ed42-4483-be03-34cdb89fff63',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22681%20-%20diag_mp_revenant_glad_taunt_37_1p.wav?alt=media&token=53f7948b-9e52-4a64-a243-9a1fb101f228',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22685%20-%20diag_mp_revenant_glad_taunt_38_3p.wav?alt=media&token=d1f12bb9-5346-4375-9079-0046da6d824c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22688%20-%20diag_mp_revenant_glad_taunt_39_3p.wav?alt=media&token=75d3da14-8a91-40a8-9e51-7fe216f925cb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22691%20-%20diag_mp_revenant_glad_taunt_40_3p.wav?alt=media&token=b5186a0a-6ec9-4203-b891-f80b024a44f4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22694%20-%20diag_mp_revenant_glad_taunt_41_3p.wav?alt=media&token=6da53404-100c-4f0b-8fc7-27427f6ccc6e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22697%20-%20diag_mp_revenant_glad_taunt_43_3p.wav?alt=media&token=b2df880e-b675-494d-9a64-482515ff67b4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22700%20-%20diag_mp_revenant_glad_tauntValentines_01_3p.wav?alt=media&token=38969655-1ccb-44e6-95df-11d4cc391f64',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/22702%20-%20diag_mp_revenant_glad_tauntValentines_02_1p.wav?alt=media&token=135da220-33ac-4787-a7ae-8d79e8f26a89',
  ];

  final List<String> quipnames = [
    "It's too late to kill the people who made me (NEW)",
    "Loba and Revenant speak in suspended skull",
    "The real pleasure is in the reaction (Heirloom Quip)",
    "I enjoyed every moment of that (Heirloom Quip)",
    "Just you and me girlie what will people say ",
    "My totem is destroyed,whoever did that will learn true suffering ",
    "Grab the piece and we are gone,although I kinda like it here ",
    "I have the piece move it now ",
    "You are kill leader Loba,I have atleast two kills over ya, Mommy and Daddy ",
    "Everyone dies ",
    "You are all dead ",
    "Isn't this interesting,wish your parents can see this now ",
    "You saved me careful people will talk ",
    "Does this mean we are friends now ",
    "Time to kill ",
    "Stay ouuta my way ",
    "We don't have the objective anymore ",
    "We have the objective ",
    'Your championships are as meaningless as you are',
    'That\'s the sweet aroma of fear',
    'Look at all the skin suits they don\'t stand a chance',
    'You all think you will make it out if this alive',
    'Last group of legends I slaughtered looked hopeful too',
    'You have all been marked for death',
    'I don\'t need souveniers,Every scream is encoded',
    'You all are like lambs to the slaughter',
    'Look at all the new editions to my list',
    'I look forward to meeting you all',
    'I plan on getting under your skin',
    'First it\'s looting and then comes my favourite part the screaming',
    'Have you said your goodbyes?',
    'Like cattle being hearded into the slaughter house',
    'Don\'t bother trying to find me, I will find you',
    'There is still time to run',
    'Get a good look,It\'s the last time you will see me',
    'You already know,I\'m gonna kill you today',
    'Now you will understand why you fear the dark',
    'Ever get the feeling you are not aloone in the room?',
    'I\'m not gonna make it quick,That would spoil all the fun',
    'Welcome to the new season,have a good death',
    'You are already dead',
    'I have seen the other side,its nothing',
    'Lemme watch your face while you go',
    'They have already forgotten you',
    'Look into my eyes,I want to remember this',
    'Face death with dignity or dont',
    'That little voice saying there\'s still hope,It\'s lying',
    'It just ends',
    'Hoping your teammates bring you back,so I can find you again',
    'You are nothing but a name on a list waiting to be crossed off',
    'This part never gets old',
    'Maybe I will let you live to tell the tale,Maybe not',
    'You should thank me,You can rest now',
    'I just like watching skinsuits suffer',
    'Any Last words,I must know',
    'Now this,This is worth living for',
    'Scream,Make sure everyone can hear you',
    'Now is when i wear your face as a mask',
    'What\'s your name,I have to know',
    'Tell me,What do you miss the most',
    'It\'s just a bad dream it will be over soon',
    'Beg for your life,It\'s good for both of us',
    'This is the last face you will ever see',
    'I wish there was more time to spend with you',
    'You can beg for mercy',
    'You are just another mark on my list',
    'They say there\'s honour in death',
    'The sheer terror that comes with dying,I remember it well',
    'Hoping to meet your maker,they don\'t exist',
    'No one is coming to save you',
    'You were marked for death you just didn\'t know it',
    'Your death will be in vain and I like that',
    'You are going to spend eternity as maggot food',
    'If i can be honest, I just like the killing',
    'Do you know how many millions of times,I have done this',
    'You should have stayed home today',
    'What makes you think you were special',
    'When all goes dark,you don\'t wake up anywhere else',
    'I find no pleasure in taking life that doesn\'t appericiate it',
    'Go On It\'s ok to be afraid',
    'Just another worthless skinbag',
    'Are your friends nearby?',
    'I want your heart,I can slice it up for a snack',
    'Your loved ones won\'t miss you,they will move on',
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
            'Revenant Quips',
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
                          child: Image.asset("assets/images/revy.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Revenant Quips",
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
