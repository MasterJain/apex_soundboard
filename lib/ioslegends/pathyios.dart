import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class PathfinderIOS extends StatefulWidget {
  @override
  _PathfinderIOSState createState() => _PathfinderIOSState();
}

class _PathfinderIOSState extends State<PathfinderIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_pathfinder_glad_tauntMutation_01_01_1p.wav?alt=media&token=8cc903a1-207c-4500-a4d5-50782bcf95a6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_pathfinder_glad_tauntOrigin_01_02_1p.wav?alt=media&token=ff2449b8-fe3f-442c-95b9-62f883838f21",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2Fpathemote.mp3?alt=media&token=d89c5caf-066e-473a-be04-850b15aa2fba",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F21906%20-%20diag_mp_pathfinder_ping_thanks_condRevenant_3p.wav?alt=media&token=033a7708-77ae-4f42-9e28-6835fe61b1e5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F21905%20-%20diag_mp_pathfinder_ping_thanks_condRevenant_1p.wav?alt=media&token=ff6074dd-276e-4eb1-a10b-fc33a224e0b4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20522%20-%20diag_mp_pathfinder_bc_thIntro_1p.wav?alt=media&token=3cedff2f-5374-4c21-aeb8-240a80618d3b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20513%20-%20diag_mp_pathfinder_bc_thCompletedCombat_1p.wav?alt=media&token=97902374-3d11-47cd-a820-4f12be291a06",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20511%20-%20diag_mp_pathfinder_bc_thCompleted_3p.wav?alt=media&token=b45a5975-713e-4739-9a99-8f1898635915",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20475%20-%20diag_mp_pathfinder_bc_reviveThanks_condMirage_1p.wav?alt=media&token=b4e9e9ac-30e8-4756-91c9-a701eddc339b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20472%20-%20diag_mp_pathfinder_bc_reviveSelf_3p.wav?alt=media&token=5b230380-d921-412b-8abd-1a936812f9af",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20471%20-%20diag_mp_pathfinder_bc_reviveSelf_1p.wav?alt=media&token=bf9288d9-8ada-4db5-911c-677e60d482e5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20464%20-%20diag_mp_pathfinder_bc_podLeaderLaunch_condMirage_3p.wav?alt=media&token=4b42cb12-4cc9-4196-9586-28381da064fb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20461%20-%20diag_mp_pathfinder_bc_podLeaderLaunch_3p.wav?alt=media&token=4c3e2952-66b0-481e-bc03-f1b3d3ea4b3e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20459%20-%20diag_mp_pathfinder_bc_podLeaderLaunch_1p.wav?alt=media&token=39b49083-b65e-40a6-a454-363f7a51c73a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20452%20-%20diag_mp_pathfinder_bc_objectiveLostSelf_3p.wav?alt=media&token=cfe6ee44-ecfe-4944-8c94-90f0a5f0b411",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20450%20-%20diag_mp_pathfinder_bc_objectiveHaveSquad_3p.wav?alt=media&token=1cdf52e1-294f-4e1b-b420-f9f13b717e44",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fpathfinder%2F20448%20-%20diag_mp_pathfinder_bc_objectiveHaveSelf_3p.wav?alt=media&token=0e47e706-ed37-4541-be67-98e8b78b9b25",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20565%20-%20diag_mp_pathfinder_glad_introHalloween_01_qw_1p.wav?alt=media&token=46033448-d560-466c-9fc7-ed517003e7db',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20569%20-%20diag_mp_pathfinder_glad_introSeq_01_qw_1p.wav?alt=media&token=f86b5390-c8d5-4a54-b224-4ee215b86f68',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20575%20-%20diag_mp_pathfinder_glad_introSeq_02_qw_1p.wav?alt=media&token=5895cec9-4ddc-44f4-bc01-a452a283d417',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20578%20-%20diag_mp_pathfinder_glad_introSeq_03_qw_1p.wav?alt=media&token=81d780aa-ad91-47c0-8404-c89bcc41549d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20582%20-%20diag_mp_pathfinder_glad_introSeq_04_qw_3p.wav?alt=media&token=915535d0-7ed6-4841-9bed-47004e13686c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20584%20-%20diag_mp_pathfinder_glad_introSeq_05_qw_1p.wav?alt=media&token=c7a7933d-67e0-48dd-ae64-b2bb222ceb94',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20586%20-%20diag_mp_pathfinder_glad_introSeq_06.wav?alt=media&token=9f2fffd5-599b-4260-855d-2f0b796c0d93',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20590%20-%20diag_mp_pathfinder_glad_introSeq_07_qw_1p.wav?alt=media&token=8013c04f-cde9-4c8a-92b2-5cfc0d583f1f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20593%20-%20diag_mp_pathfinder_glad_introSeq_08_qw_1p.wav?alt=media&token=7031db6b-a3a4-4af9-9bca-ae8b141ec167',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20597%20-%20diag_mp_pathfinder_glad_introSeq_09_qw_3p.wav?alt=media&token=c28a0a40-09cc-46fe-b7f4-cdbf66013a94',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20599%20-%20diag_mp_pathfinder_glad_introSeq_10_qw_1p.wav?alt=media&token=b9e3f74f-043a-4dfd-bab1-c863d70f1af6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20602%20-%20diag_mp_pathfinder_glad_introSeq_11_qw_1p.wav?alt=media&token=ded5dee9-659e-4708-9d32-8bf607c2d8ed',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20606%20-%20diag_mp_pathfinder_glad_introSeq_12_qw_3p.wav?alt=media&token=bcc02d67-6059-43c8-91a3-896e9711c05b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20608%20-%20diag_mp_pathfinder_glad_introSeq_13_qw_1p.wav?alt=media&token=3c5fc2eb-16d3-4678-8122-cb181fd0aea3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20611%20-%20diag_mp_pathfinder_glad_introSeq_14_qw_1p.wav?alt=media&token=3f7dafb6-3ad1-4633-a5ee-a9a852c5f076',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20614%20-%20diag_mp_pathfinder_glad_introSeq_15_qw_1p.wav?alt=media&token=feffa9da-f06c-476d-8994-f8027ce71519',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20617%20-%20diag_mp_pathfinder_glad_introSeq_16_qw_1p.wav?alt=media&token=28b31a26-2287-44d2-9da5-cbe23dd01721',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20621%20-%20diag_mp_pathfinder_glad_introSeq_17_qw_3p.wav?alt=media&token=b7efafe3-1da3-4471-a626-8aeb0fbd477f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20624%20-%20diag_mp_pathfinder_glad_introSeq_18_qw_3p.wav?alt=media&token=b33abbfa-6e05-40c8-b5c5-d959e9fce3d6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20626%20-%20diag_mp_pathfinder_glad_introSeq_19_qw_1p.wav?alt=media&token=024ea134-93aa-4d80-a156-c8f386338194',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20630%20-%20diag_mp_pathfinder_glad_introSeq_20_qw_3p.wav?alt=media&token=8505086b-16a7-4885-a5a8-82cff0363231',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20633%20-%20diag_mp_pathfinder_glad_introSeq_21_qw_3p.wav?alt=media&token=2ba63f7f-8d50-431b-9f1b-7fdb6c9080',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20646%20-%20diag_mp_pathfinder_glad_seasonOpen_qw_1p.wav?alt=media&token=af7e58ff-ff19-40fd-973b-9c895947f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20650%20-%20diag_mp_pathfinder_glad_taunt_01_3p.wav?alt=media&token=fa388787-dbd5-45e9-b1fb-0e79be8bf59b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20658%20-%20diag_mp_pathfinder_glad_taunt_03_3p.wav?alt=media&token=8c121474-1d78-48d2-8018-d756f91d64ce',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20660%20-%20diag_mp_pathfinder_glad_taunt_04_1p.wav?alt=media&token=98663a5a-1512-4c57-a40a-460fb8c076c5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20664%20-%20diag_mp_pathfinder_glad_taunt_05_3p.wav?alt=media&token=2f826dfe-dd30-46ae-b030-e0d9a7b323c0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20667%20-%20diag_mp_pathfinder_glad_taunt_06_3p.wav?alt=media&token=ab0776f8-d99b-487f-9c60-968426cb1a29',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20670%20-%20diag_mp_pathfinder_glad_taunt_07_3p.wav?alt=media&token=6356ca5f-5246-4fb7-917a-f451a7fd0da5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20672%20-%20diag_mp_pathfinder_glad_taunt_08_1p.wav?alt=media&token=c6adee4e-41aa-4d07-80e3-b2226fa5a4f4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20676%20-%20diag_mp_pathfinder_glad_taunt_09_3p.wav?alt=media&token=3a8a5dcc-d438-419a-afa6-a05e95dfb410',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20679%20-%20diag_mp_pathfinder_glad_taunt_10_3p.wav?alt=media&token=f91cd6fe-54b9-40b3-ae33-0cc3015186dc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20681%20-%20diag_mp_pathfinder_glad_taunt_11_1p.wav?alt=media&token=f839f8e2-88a3-4c32-948d-9abfde8f735d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20685%20-%20diag_mp_pathfinder_glad_taunt_12_3p.wav?alt=media&token=ca9560d8-b377-4f63-b6c8-6829eba03bfd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20688%20-%20diag_mp_pathfinder_glad_taunt_13_3p.wav?alt=media&token=08ae22ea-7d84-429c-ba60-c8b0c37ff632',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20690%20-%20diag_mp_pathfinder_glad_taunt_14_1p.wav?alt=media&token=b4926591-507e-4a47-8f1b-5855300aeaae',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20693%20-%20diag_mp_pathfinder_glad_taunt_15_1p.wav?alt=media&token=3a5a67ba-7414-460a-88f9-fa413d89df77',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20697%20-%20diag_mp_pathfinder_glad_taunt_16_3p.wav?alt=media&token=fad38a31-9cd5-4122-91ae-74965575fade',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20700%20-%20diag_mp_pathfinder_glad_taunt_17_3p.wav?alt=media&token=4f2be25a-9d8a-4e38-b9d4-f08130ad560f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20703%20-%20diag_mp_pathfinder_glad_taunt_18_3p.wav?alt=media&token=e1d274fe-0404-4446-8f44-73f616451aff',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20706%20-%20diag_mp_pathfinder_glad_taunt_19_3p.wav?alt=media&token=b4f8688b-3845-4ece-aae9-f62bb4dc886f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20709%20-%20diag_mp_pathfinder_glad_taunt_20_3p.wav?alt=media&token=eb472c3d-fd9f-4646-b545-f65d3f9ddb1b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20711%20-%20diag_mp_pathfinder_glad_taunt_21_1p.wav?alt=media&token=bc3f8649-123d-485d-a0ef-9a1bd5cd4227',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20714%20-%20diag_mp_pathfinder_glad_taunt_22_1p.wav?alt=media&token=a26c234b-af02-4990-9493-861274d2d61c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20718%20-%20diag_mp_pathfinder_glad_taunt_23_3p.wav?alt=media&token=f75aa27f-cc07-47f4-9c79-227013002751',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20721%20-%20diag_mp_pathfinder_glad_taunt_24_3p.wav?alt=media&token=37982ece-cf24-45c5-a58b-3983040fd30d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20724%20-%20diag_mp_pathfinder_glad_taunt_25_3p.wav?alt=media&token=1166ed1a-9b30-4251-9723-f5c11d191b29',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20726%20-%20diag_mp_pathfinder_glad_taunt_26_1p.wav?alt=media&token=752bde4a-6859-4658-b937-3ab108701222',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20729%20-%20diag_mp_pathfinder_glad_taunt_27_1p.wav?alt=media&token=0e503188-45cb-46e5-96e3-2fa95ee48cfa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20733%20-%20diag_mp_pathfinder_glad_taunt_28_3p.wav?alt=media&token=0d4554d0-5d4d-4123-b822-154e1606068b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20736%20-%20diag_mp_pathfinder_glad_taunt_29_3p.wav?alt=media&token=b49924ea-74f3-482c-a0fd-7190563aa237',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20739%20-%20diag_mp_pathfinder_glad_taunt_30_3p.wav?alt=media&token=554dc60b-6589-4337-b865-37dc509b824f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20742%20-%20diag_mp_pathfinder_glad_taunt_31_3p.wav?alt=media&token=1905e58e-78ac-4e03-829e-21bbff44a8c6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20745%20-%20diag_mp_pathfinder_glad_taunt_32_3p.wav?alt=media&token=d9a862ad-6410-45c1-8390-3e64caaa6802',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20748%20-%20diag_mp_pathfinder_glad_taunt_33_3p.wav?alt=media&token=96b7cf71-4ac8-4c39-b852-62b00dcfe955',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20750%20-%20diag_mp_pathfinder_glad_taunt_34_1p.wav?alt=media&token=d086ddbe-6cfe-4dc4-9434-98123f5ebdc3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20753%20-%20diag_mp_pathfinder_glad_taunt_35_1p.wav?alt=media&token=38cdb88b-51fd-4269-bc68-766d10c51e24',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20757%20-%20diag_mp_pathfinder_glad_taunt_36_3p.wav?alt=media&token=1b7ee2b1-d35c-48ff-a740-159ae4227fcb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20760%20-%20diag_mp_pathfinder_glad_taunt_37_3p.wav?alt=media&token=2fbca27e-961c-4f76-be2c-69b8788b10a8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20763%20-%20diag_mp_pathfinder_glad_taunt_38_3p.wav?alt=media&token=7b8abe85-9f85-4c7d-b4fe-68624c81e17c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20765%20-%20diag_mp_pathfinder_glad_taunt_39_1p.wav?alt=media&token=01b214df-9180-48a9-af0a-2a020ebb2ced',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20768%20-%20diag_mp_pathfinder_glad_taunt_40_1p.wav?alt=media&token=174ccc5b-51e0-4bd6-80d2-1649f60bb0d3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20771%20-%20diag_mp_pathfinder_glad_taunt_41_1p.wav?alt=media&token=47c2fd05-370b-4477-8016-2ea4e9143f50',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20775%20-%20diag_mp_pathfinder_glad_taunt_42_3p.wav?alt=media&token=3a85f1f6-d6f9-4a34-a850-63d3e46cd31b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20777%20-%20diag_mp_pathfinder_glad_tauntAnni1_01_1p.wav?alt=media&token=281168f7-3a1d-4408-b734-ca0ecb0935f0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20780%20-%20diag_mp_pathfinder_glad_tauntAnni1_02_1p.wav?alt=media&token=e21fbbe8-bfa0-49b8-a9c6-809375b25b65',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20783%20-%20diag_mp_pathfinder_glad_tauntAnni1_03_1p.wav?alt=media&token=22d81ac6-65ae-47a6-bb98-1ce9e13adb0d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20786%20-%20diag_mp_pathfinder_glad_tauntAnni1_04_1p.wav?alt=media&token=b5e170e9-a83b-4a93-b13e-f43146ee73e7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20790%20-%20diag_mp_pathfinder_glad_tauntHalloween_01_3p.wav?alt=media&token=02d10879-13fc-404a-b32b-dbee4d06ee7e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20793%20-%20diag_mp_pathfinder_glad_tauntHalloween_02_3p.wav?alt=media&token=497823bb-93be-4595-8cbb-c1a56b0e1be6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20796%20-%20diag_mp_pathfinder_glad_tauntValentines_01_3p.wav?alt=media&token=78f1833e-b8aa-467a-9c77-e7f59ea374fe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20798%20-%20diag_mp_pathfinder_glad_tauntValentines_02_1p.wav?alt=media&token=347a949e-35e4-4c8d-8f31-30e416144567',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20804%20-%20diag_mp_pathfinder_glad_tauntWinter_02_1p.wav?alt=media&token=42eb5a4f-68ba-4a1d-8954-a1bc16a18d54',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/20802%20-%20diag_mp_pathfinder_glad_tauntWinter_01_3p.wav?alt=media&token=8962f83d-326c-4329-b203-e1f40e10dcbf',
  ];

  final List<String> quipnames = [
    "I was a computer now I'm a legend",
    "You have the same expressions as my customers (NEW)",
    "Pathfinder Skydive Noise ",
    "Thanks lets be brothers ",
    "Thanks where is your happy face friend ",
    "Let's find a piece,Hide and seek is a fun game as long as you don 't die ",
    "Good Job team we found the piece ",
    "Yipee Zippie We got the piece ",
    "Thanks Elliot,I owe you a drink in your bar ",
    "Not Putting on the red light today ",
    "Ye I'm still alive go me ",
    "Hold on to your holograms that's a mirage joke ",
    "Here we go It's a long drop fun ",
    "Hold your breath if you have a respiratory sysytem ",
    "Oops I lost the objective ",
    "The objective is mine, Awesome! ",
    'This is my costume,I\'m Octane\'s legs',
    'Hey That\'s me',
    'This will be fun can\'t wait to win',
    'Remember me friends, I may kill you',
    'Hii Friends',
    'It\'s fun to zipline you should try it',
    'Wow they chose me,the odds are full of all kinds of math',
    'Watch out or I will grapple you literally',
    'I\'m really good at this you should be too',
    'My squad must be very proud',
    'I will Hi-five you all when I see you',
    'In case you didn\'t know you get here by winning',
    'After this we should hang out',
    'I swung to this position',
    'I\'m excited to fight you',
    'I wish all of you could fight tommorow too',
    'Get ready I\'m coming for you friend',
    'Loosing isn\'t fun thats why i dont do it',
    'I may be smiling but that also means that I\'m happy',
    'I work hard for the money',
    'Oh am I supossed to talk?',
    'This sounds like it will be fun',
    'It\'s the season opening',
    'That was fun sorry you died',
    'Maybe next time you will do really good',
    'I won congratulations to me',
    'Thank you for the fun fight',
    'That was exciting,I hope you had fun',
    'Did you like my moves?',
    'If I had a heart,It would be racing right now',
    'I will never forget this match',
    'Did you have as much fun as me',
    'Watch out I\'m very skilled with this grapple',
    'Hii I\'m MARVN,I\'m a Pathfinder',
    'My accuracy is getting better everyday,right?',
    'You tried and that\'s all the matters also winning',
    'That was close',
    'You don\'t know where my creator is do you',
    'Sorry I beat you I\'m only looking for my creator',
    'Surprise!!,I hope I didn\'t scare you',
    'Good Work,Let\'s remain friends',
    'If we were on the same team you would be happy about this',
    'You were tough friend',
    'Don\'t blame yourself blame me',
    'The crowd love you and they really love me',
    'I\'m sorry but you could have killed my friends',
    'I only beat you because I want to win',
    'If I didn\'t beat you someone else could have',
    'This is my favourite part',
    'I did really good today,I can\'t wait to tell my creator',
    'Now this is very fun when you win',
    'Look at that,I beat you',
    'It\'s okay friend,I was just better this time',
    'Don\'t beat yourself up,Leave that to me',
    'Sometimes luck is involved,but this time it was skill',
    'I feel good',
    'That was impressive,I hope my creator saw it',
    'Don\'t worry,you wont be the only person I beat today',
    'Grappling makes things much easier,Try it sometimes',
    'Great moves friend,Sorry you lost',
    'I may win this thing today keep rooting for me',
    'Trying is fiftyfive point five percent of the battle',
    'Looks like I beat you hi-five',
    'Did you see how great I was?',
    'Didn\'t know you were that bad?',
    'Stay Frosty Friend',
    'Hey are you sleeping Hello?',
    'I love the smell of eggs bacon,hashbrowns,coffee in the morning',
    'I don\'t concern my self with the ambition of insects,Just Kidding',
    'I\'m sorry friend but you are goung to become a skeleton now',
    'I\'m just a robot standing in front of a looser',
    'Such sweet sorrow that I shall say goodnight till it be morrow friend',
    'I killed you and it\'s the winter',
    'Winter can be fun but also cold,wet,dark',
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
            'Pathfinder Quips',
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
                          child: Image.asset("assets/images/path.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Pathfinder Quips",
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
