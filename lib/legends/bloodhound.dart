import 'dart:io';

import 'package:apex_soundboard/abouthelpers/downloadalert.dart';
import 'package:apex_soundboard/main.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class Bloodhound extends StatefulWidget {
  @override
  _BloodhoundState createState() => _BloodhoundState();
}

class _BloodhoundState extends State<Bloodhound> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_bloodhound_glad_tauntMutation_01_02_3p.wav?alt=media&token=36d76d3d-e0ff-4383-a8d0-30f6635e6785",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_bloodhound_glad_tauntOrigin_01_01_1p.wav?alt=media&token=9569bc7f-d1eb-4b02-9a0d-8feb9ab31544",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F6303%20-%20diag_mp_bloodhound_bc_reviveThanks_condRampart_3p.wav?alt=media&token=917962b6-5224-4b7b-af64-b3a453ea10c8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F6307%20-%20diag_mp_bloodhound_bc_revivingPlayer_condRampart_3p.wav?alt=media&token=ff9c6ecd-f7af-44d9-9052-9f4d8a600fc6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2Fbloodhound%20admires%20levithan.mp3?alt=media&token=33e84bcd-8252-4eb0-84ea-e507c380bb03",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2Fblood1.mp3?alt=media&token=20d5c26c-22a6-4b88-87d3-8b915f71850f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F7769%20-%20diag_mp_bloodhound_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=e17fef30-6d76-45e4-b629-910e4a276ac6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F7811%20-%20diag_mp_bloodhound_tt_01_3p.wav?alt=media&token=d7d4a3d9-f531-4042-8069-c5bf4f96c0ff",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F7818%20-%20diag_mp_bloodhound_tt_02_1p.wav?alt=media&token=226677a0-2834-43ad-91b5-dbb937de9286",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F7826%20-%20diag_mp_bloodhound_tt_03_1p.wav?alt=media&token=71f35ec8-7406-46fb-bdc5-0677787c1cbf",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6204%20-%20diag_mp_bloodhound_bc_thIntro_3p.wav?alt=media&token=95863120-b3d9-43fe-b53d-b118173788d8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6203%20-%20diag_mp_bloodhound_bc_thIntro_1p.wav?alt=media&token=66740eef-cfe5-4243-a5f1-84df0b057b9b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6192%20-%20diag_mp_bloodhound_bc_thCompleted_3p.wav?alt=media&token=e774ea61-b3a5-4a0a-ac56-3e51e6bd1181",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6191%20-%20diag_mp_bloodhound_bc_thCompleted_1p.wav?alt=media&token=0f0e4ec5-84db-4f45-8828-f5f66e058e55",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6179%20-%20diag_mp_bloodhound_bc_super_3p.wav?alt=media&token=617437f7-9736-4a25-9bd3-23b99a0f7edb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6178%20-%20diag_mp_bloodhound_bc_super_1p.wav?alt=media&token=c1edc691-158d-4ff1-ba28-e8cc623daf55",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6160%20-%20diag_mp_bloodhound_bc_skydive_1p.wav?alt=media&token=cde62258-d67b-4b23-9ae4-2c50519987c8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6155%20-%20diag_mp_bloodhound_bc_revivingPlayer_condLoba_3p.wav?alt=media&token=428b971d-7ff1-4d8a-9eee-23c7ce35f9d0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6154%20-%20diag_mp_bloodhound_bc_revivingPlayer_condLoba_1p.wav?alt=media&token=4a87cc4a-8d2a-4970-bfa0-9ecf93ed26ef",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6149%20-%20diag_mp_bloodhound_bc_reviveSelf_3p.wav?alt=media&token=773bd0d2-552c-404d-aaeb-ed5c99e1431c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6148%20-%20diag_mp_bloodhound_bc_reviveSelf_1p.wav?alt=media&token=0ef3f2b5-787b-4dc9-885d-0df23a40b349",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6135%20-%20diag_mp_bloodhound_bc_objectiveLostSquad_3p.wav?alt=media&token=906377f6-b920-4ca5-bd12-63f7f104fdfa",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6132%20-%20diag_mp_bloodhound_bc_objectiveLostSelf_1p.wav?alt=media&token=f5d07060-e035-4b62-92e0-7dafc2e1105b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6131%20-%20diag_mp_bloodhound_bc_objectiveHaveSquad_3p.wav?alt=media&token=391ae1da-030b-4914-af94-5578b09608c0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6129%20-%20diag_mp_bloodhound_bc_objectiveHaveSelf_3p.wav?alt=media&token=0d94519a-efcf-4b1d-be9d-750d384fa47d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6088%20-%20diag_mp_bloodhound_bc_iKilledAnEnemyWithHeirloom_3p.wav?alt=media&token=db246664-49a9-4625-b963-f508c752ea4a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fbloodhound%2F6087%20-%20diag_mp_bloodhound_bc_iKilledAnEnemyWithHeirloom_1p.wav?alt=media&token=de3fead7-88ef-4c3d-bb8b-6437448f8545",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6261%20-%20diag_mp_bloodhound_glad_introHalloween_01_qw_1p.wav?alt=media&token=c1cf0399-feef-4539-8e6d-75ea430c0a9c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6265%20-%20diag_mp_bloodhound_glad_introHeirloom_01_qw_3p.wav?alt=media&token=d25d18e4-1cc5-4ec4-a336-9e1b2add4fbe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6268%20-%20diag_mp_bloodhound_glad_introSeq_01_qw_1p.wav?alt=media&token=e87dc7a3-ccde-44eb-aa81-d9856bc30ee0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6274%20-%20diag_mp_bloodhound_glad_introSeq_02_qw_1p.wav?alt=media&token=01b15fb8-1bc1-4820-8bff-6d06d4a671fa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6277%20-%20diag_mp_bloodhound_glad_introSeq_03_qw_1p.wav?alt=media&token=bb90de9b-ebc9-467d-91ed-6d32e3a85806',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6280%20-%20diag_mp_bloodhound_glad_introSeq_04_qw_1p.wav?alt=media&token=4da0599f-5efa-4050-b0bb-00be419be487',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6287%20-%20diag_mp_bloodhound_glad_introSeq_06_qw_3p.wav?alt=media&token=898360d2-9180-4255-9f7a-2d9842ca2bfe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6289%20-%20diag_mp_bloodhound_glad_introSeq_07_qw_1p.wav?alt=media&token=1127106d-e7f0-489e-afe3-5bebbb575621',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6293%20-%20diag_mp_bloodhound_glad_introSeq_08_qw_3p.wav?alt=media&token=44c72608-7784-42b2-baa3-993fd1f49118',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6295%20-%20diag_mp_bloodhound_glad_introSeq_09_qw_1p.wav?alt=media&token=c41c3fb1-fc01-495c-b3a4-7bee8bbadf08',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6298%20-%20diag_mp_bloodhound_glad_introSeq_10_qw_1p.wav?alt=media&token=edd34c3c-f065-4863-b507-b0273c0f557a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6302%20-%20diag_mp_bloodhound_glad_introSeq_11_qw_3p.wav?alt=media&token=ab1e5048-7506-4c07-a741-369b0bf62071',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6304%20-%20diag_mp_bloodhound_glad_introSeq_12_qw_1p.wav?alt=media&token=a9618ec4-c4fa-4a84-9e31-8d4d9e65c9e9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6308%20-%20diag_mp_bloodhound_glad_introSeq_13_qw_3p.wav?alt=media&token=745d0003-08e4-4a43-872a-ca5eb987fe56',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6310%20-%20diag_mp_bloodhound_glad_introSeq_14_qw_1p.wav?alt=media&token=b0374bac-4630-485e-acc5-51c2f1839c5a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6314%20-%20diag_mp_bloodhound_glad_introSeq_15_qw_3p.wav?alt=media&token=9cdce4f1-a262-48cb-be1a-87925310a221',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6316%20-%20diag_mp_bloodhound_glad_introSeq_16_qw_1p.wav?alt=media&token=8a2b5f4e-7a6e-4811-98e4-74a544ccb688',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6319%20-%20diag_mp_bloodhound_glad_introSeq_17_qw_1p.wav?alt=media&token=df9b5be6-67fc-4884-b953-220b96e825ad',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6322%20-%20diag_mp_bloodhound_glad_introSeq_18_qw_1p.wav?alt=media&token=35577824-a988-4fc0-8ce8-c555f1e7b73a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6325%20-%20diag_mp_bloodhound_glad_introSeq_19_qw_1p.wav?alt=media&token=030efa8f-bc5a-42cf-b0a2-850d02d07e8c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6328%20-%20diag_mp_bloodhound_glad_introSeq_20_qw_1p.wav?alt=media&token=3faa8d7b-bdeb-4e3a-81d8-520b63cefcab',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6331%20-%20diag_mp_bloodhound_glad_introSeq_21_qw_1p.wav?alt=media&token=df229864-78e5-47a7-8f5d-89488b3a7cb8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6345%20-%20diag_mp_bloodhound_glad_seasonOpen_qw_1p.wav?alt=media&token=65733de7-042d-4dc0-a926-e90ea15677e4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6348%20-%20diag_mp_bloodhound_glad_taunt_01_1p_template.wav?alt=media&token=00cab656-ab3c-4b2f-9cd1-9a65c5688a92',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6353%20-%20diag_mp_bloodhound_glad_taunt_02_1p.wav?alt=media&token=108abab4-1566-4b91-a555-1d279dd353cb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6356%20-%20diag_mp_bloodhound_glad_taunt_03_1p.wav?alt=media&token=99a4aff1-da57-4f51-aea8-cd2593a624cc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6360%20-%20diag_mp_bloodhound_glad_taunt_04_3p.wav?alt=media&token=a1fb0324-a730-4bbe-bc9d-1b37af42d9a2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6363%20-%20diag_mp_bloodhound_glad_taunt_05_3p.wav?alt=media&token=985f67c5-c28c-4549-babf-760a2029c828',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6365%20-%20diag_mp_bloodhound_glad_taunt_06_1p.wav?alt=media&token=795bdf7d-3d57-4bd9-b60f-4aeea9e35f48',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6368%20-%20diag_mp_bloodhound_glad_taunt_07_1p.wav?alt=media&token=527a79b7-8da8-44e8-9157-82bfbb784b9d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6372%20-%20diag_mp_bloodhound_glad_taunt_08_3p.wav?alt=media&token=9ec64b34-398c-4d24-b86d-9f91954f3b3a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6375%20-%20diag_mp_bloodhound_glad_taunt_09_3p.wav?alt=media&token=7a00adc8-a319-4454-aa9f-69545db495e3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6379%20-%20diag_mp_bloodhound_glad_taunt_10_3p_victim.wav?alt=media&token=12bdff02-7771-4a40-b720-b580d44a6928',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6380%20-%20diag_mp_bloodhound_glad_taunt_11_1p.wav?alt=media&token=6220fea6-eb00-49b6-abee-87f3fcc02999',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6384%20-%20diag_mp_bloodhound_glad_taunt_12_3p.wav?alt=media&token=a4eee48a-4b92-4d68-a6cc-9174ce0cddde',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6387%20-%20diag_mp_bloodhound_glad_taunt_13_3p.wav?alt=media&token=9c7c5b40-de12-492a-a831-5b8e3e938930',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6390%20-%20diag_mp_bloodhound_glad_taunt_14_3p.wav?alt=media&token=7b2cf57f-c82e-4e8d-ac8e-69c7758e83a0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6392%20-%20diag_mp_bloodhound_glad_taunt_15_1p.wav?alt=media&token=1ac70657-6e1e-4a10-bcd8-a76c4e690735',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6395%20-%20diag_mp_bloodhound_glad_taunt_16_1p.wav?alt=media&token=661bf67e-3efd-482b-b983-a1b2ed67cae4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6398%20-%20diag_mp_bloodhound_glad_taunt_17_1p.wav?alt=media&token=de255fa2-bb35-44ab-a4e3-c1140be33f6c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6402%20-%20diag_mp_bloodhound_glad_taunt_18_3p.wav?alt=media&token=66f2285d-ca24-435b-9f2c-5d4144ef2eef',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6404%20-%20diag_mp_bloodhound_glad_taunt_19_1p.wav?alt=media&token=4dfa9f1e-8211-402c-a461-57ff31185f49',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6408%20-%20diag_mp_bloodhound_glad_taunt_20_3p.wav?alt=media&token=631a1d29-3d59-4f2b-9486-11d11073b723',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6411%20-%20diag_mp_bloodhound_glad_taunt_21_3p.wav?alt=media&token=82f2c2ed-11d4-4cde-b1f0-fff1d69f2d81',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6413%20-%20diag_mp_bloodhound_glad_taunt_22_1p.wav?alt=media&token=7ee31075-f8f3-431a-892c-c5a8165ebabc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6416%20-%20diag_mp_bloodhound_glad_taunt_23_1p.wav?alt=media&token=d4bb08f1-2142-41b6-894b-686e1ac3ab72',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6419%20-%20diag_mp_bloodhound_glad_taunt_24_1p.wav?alt=media&token=d88cfd1b-5938-417e-b184-d3f70a127440',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6422%20-%20diag_mp_bloodhound_glad_taunt_25_1p.wav?alt=media&token=a1cd734d-1d1a-40dd-973a-b96796fa3ca0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6426%20-%20diag_mp_bloodhound_glad_taunt_26_3p.wav?alt=media&token=ad44f08d-2bc5-4380-a289-7beb130203ed',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6428%20-%20diag_mp_bloodhound_glad_taunt_27_1p.wav?alt=media&token=9a814d66-e2c6-49f3-993f-1ea26b7d6cae',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6432%20-%20diag_mp_bloodhound_glad_taunt_28_3p.wav?alt=media&token=e399ad9c-a887-4014-8e37-3f6c7585c975',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6434%20-%20diag_mp_bloodhound_glad_taunt_29_1p.wav?alt=media&token=cc0ff0db-e971-49ea-b876-54710ae182fc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6438%20-%20diag_mp_bloodhound_glad_taunt_30_3p.wav?alt=media&token=006cb0c5-1c95-4f69-896c-3c71ecaab962',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6441%20-%20diag_mp_bloodhound_glad_taunt_31_3p.wav?alt=media&token=0c2e5fe2-60c8-4bc9-b17e-c0a6c3883fdf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6444%20-%20diag_mp_bloodhound_glad_taunt_32_3p.wav?alt=media&token=430da5b4-5a75-420b-8339-ce2bc3941e3f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6446%20-%20diag_mp_bloodhound_glad_taunt_33_1p.wav?alt=media&token=2cbee186-d72f-4826-a1c6-6956984761fb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6449%20-%20diag_mp_bloodhound_glad_taunt_34_1p.wav?alt=media&token=d73e7ad5-cf49-4de0-9174-210b9befc900',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6452%20-%20diag_mp_bloodhound_glad_taunt_35_1p.wav?alt=media&token=ba6f552f-5bb3-43e2-b41f-d6f91dc0f7d9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6456%20-%20diag_mp_bloodhound_glad_taunt_36_3p.wav?alt=media&token=a65c195c-8f36-4ed9-a82c-7553aae1e125',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6459%20-%20diag_mp_bloodhound_glad_taunt_37_3p.wav?alt=media&token=921e4d7a-6c8e-442b-8eb7-35488330dcaa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6461%20-%20diag_mp_bloodhound_glad_taunt_38_1p.wav?alt=media&token=f9771ca1-0092-42cb-9d87-8f026f384975',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6465%20-%20diag_mp_bloodhound_glad_taunt_39_3p.wav?alt=media&token=77d145b6-eb79-4a01-8902-8b6665130ca6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6468%20-%20diag_mp_bloodhound_glad_taunt_40_3p.wav?alt=media&token=aef4fe00-d5b4-42af-9324-3e1d70ec47c4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6470%20-%20diag_mp_bloodhound_glad_taunt_41_1p.wav?alt=media&token=61bab8e1-b6ee-41a3-b740-432c78b09bd4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6473%20-%20diag_mp_bloodhound_glad_taunt_42_1p.wav?alt=media&token=2eea60a9-52ba-4450-8519-e7e8e758b64a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6477%20-%20diag_mp_bloodhound_glad_taunt_44_3p.wav?alt=media&token=239a616c-babf-4c20-8a16-63458fd5b6a4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6481%20-%20diag_mp_bloodhound_glad_tauntHalloween_01_1p.wav?alt=media&token=c5b144f8-f52b-4c4b-bc10-82454698e99b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6485%20-%20diag_mp_bloodhound_glad_tauntHalloween_02_3p.wav?alt=media&token=6f90cd14-3938-408d-bbbe-03e0733718f6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6488%20-%20diag_mp_bloodhound_glad_tauntValentines_01_3p.wav?alt=media&token=f49c74ce-d63f-49db-9bc6-79cdd84b4e1b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6490%20-%20diag_mp_bloodhound_glad_tauntValentines_02_1p.wav?alt=media&token=b05b34cc-62d0-49db-9ef4-4b20275a1882',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6493%20-%20diag_mp_bloodhound_glad_tauntWinter_01_1p.wav?alt=media&token=e8caba4c-18ef-41f5-a0d1-a019e1ec8ef3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/6496%20-%20diag_mp_bloodhound_glad_tauntWinter_02_1p.wav?alt=media&token=3227add1-7f4c-4023-8316-36a2664ac201',
  ];

  final List<String> quipnames = [
    "The hunter will always winna if the pray cannot adapt",
    "For my love (NEW)",
    "My thanks child of worker",
    "Rise child of worker you have much left to",
    "Bloodhound admires Levithans ",
    "I hold no gratitude,the gods however ",
    "As you Wish ",
    "The Skull of a Flyer ",
    "Through this Weapon,I learn the truth of the old ways and new ",
    "This Helm and Shield were borne by my uncle Aurthur ",
    "Use your senses the piece will not elude us ",
    "A piece awaits us,The hunt begins ",
    "We have laid claim to the piece ",
    "The gods bless us,We takka the piece ",
    "I bathe in the blood",
    "Trust in the All-father",
    "growl",
    "You have the strength of femrising battle,We need you still",
    "The Heart of the Wolf resides in you today you will not be slatra",
    "The All-father gift Me I slatra another day",
    "I'm rigor I'm Bloodhundr",
    "We lost it the objective is no longer ours",
    "The objective has slipped through my grasp",
    "The objective is ours remain strong",
    "The objective is mine",
    "Vallhalla awaits us both",
    "I grace the all father",
    'The masks we wear are part of who we are',
    'I honour those who risen not those who fallen',
    'The day is mine',
    'Blessings are upon me and bretheren',
    'I will shed blood an honour the allfather',
    'Today is a good day to fight',
    'I will never dissapoint my brethren',
    'Today\'s victory is already written',
    'Have you prepared for your end,I have',
    'Find me and we will battle',
    'The true test is before the all-father',
    'I\'m the hunter the god\'s have sent',
    'Prove your strength before the gods',
    'When we meet I will slatra',
    'The Hunt begins',
    'Honour is in the challenge,Pride in the victory',
    'It is your honour to face me',
    'I fall only when the gods will it',
    'Like my brethren before me i will slatra',
    'Fight vinna Fight again',
    'The fight honours me',
    'The battle begins may the gods bless you',
    'Open season may the gods bless us',
    'Come getta',
    'Keep your pride',
    'The gods have decided',
    'We knew this end would come',
    'The path led us here today',
    'I give a life, I don\'t takka',
    'This loss is a gift for you',
    'The pride of life calls for you',
    'Greed will eat your mortal sorrow',
    'You think yourself skilled',
    'Fight and Fall is a hep life',
    'Fear has ruled your actions today',
    'Stand by your trial,I\'m not here to judge',
    'Your Strength Showed Life',
    'Your final hour cannot be escaped,embrace it',
    'Battle is more than skill',
    'With the most vigor',
    'Pride is the true victory',
    'Your mind and spirit is the strongest weapon you have',
    'You are no coward remember that',
    'There is more honour in death than a life without test',
    'Do not regret stay hipp good faith',
    'Your journey ends today',
    'Trust yourself there is no shame in competition',
    'We fought, this makes you brave and no coward',
    'A bad begining draws a bad end',
    'The All-father graces you',
    'A Victory I will be greatful for',
    'Take your pride and cherish it',
    'Slow and Sure',
    'Don\'t let your wounds end your fate',
    'I vinna as the god\'s will it',
    'I trust the gust of the wind,that led to my vinna',
    'My rigour fate is on my side',
    'I\'m ready for my end there is no fear',
    'Focus that is how I defeated you',
    'Your poor trust led to your poor end',
    'The slatara of this battle will be remembered',
    'Never forget the eyes of bloodhundr',
    'I vinna till the end',
    'The hungry wolf always takka the vinna',
    'The hungry wolf alwats takes the win',
    'The All-father has gifted me with better strength',
    'What haunts you most is death',
    'Only those worthy of the all father are worthy of the mask',
    'It is better to fight and fall then to live without hope',
    'Your heart is open for all to see',
    'In the cold winter,only the weak sacrifice life for peace',
    'Freezing teeth of death has pierced your soul',
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
            'Bloodhound Quips',
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
                          child: Image.asset("assets/images/bloodhound.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Bloodhoubd Quips",
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
                                context, audio[index], quipnames[index]);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text('Audio saved in ApexSounds folder'),
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
                            //  downloadmp3(
                            //   'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24179%20-%20diag_mp_wattson_bc_revivingPlayer_condCaustic_3p.wav?alt=media&token=57a1dffa-a245-4e71-ad25-b98050f8660c');

                            downloadFile(
                                context, audio[index], quipnames[index]);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text('Audio saved in ApexSounds folder'),
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
