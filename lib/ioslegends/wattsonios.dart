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

class WattsonIOS extends StatefulWidget {
  @override
  _WattsonIOSState createState() => _WattsonIOSState();
}

class _WattsonIOSState extends State<WattsonIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_wattson_glad_tauntMutation_01_02_3p.wav?alt=media&token=ec457753-9d8e-44b5-87e5-95208c6c6f8a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_wattson_glad_tauntOrigin_01_02_1p.wav?alt=media&token=0501d3ca-1734-4835-978e-d558b9b867b1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F28376%20-%20diag_mp_wattson_ping_youreWelcome_calm_condWraith_3p.wav?alt=media&token=297b215c-1016-4397-84fe-5da4b5d208a2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F28374%20-%20diag_mp_wattson_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=b800f77f-b998-4a9d-845b-0ac7e3650191",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F28372%20-%20diag_mp_wattson_ping_youreWelcome_calm_condRampart_3p.wav?alt=media&token=7efb94c2-7c32-4f33-96b7-e0b8d1113655",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F28370%20-%20diag_mp_wattson_ping_youreWelcome_calm_condCrypto_3p.wav?alt=media&token=cd58d554-b204-49b4-8409-15c984551e61",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F28367%20-%20diag_mp_wattson_ping_youreWelcome_calm_condCaustic_1p.wav?alt=media&token=7c33ada4-d7f5-464b-bfb3-e69c8c055bf0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F28173%20-%20diag_mp_wattson_ping_thanks_condCrypto_1p.wav?alt=media&token=ed39e6c8-2f07-42dc-a280-6f7c11b48319",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F28171%20-%20diag_mp_wattson_ping_thanks_condCaustic_1p.wav?alt=media&token=7f7adf23-35c9-477d-9990-65ed65ff3e39",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F27625%20-%20diag_mp_wattson_ping_friendlyTrap_calm_condCaustic_1p.wav?alt=media&token=dcbe723b-9b2f-4464-bbab-f5234d50fb66",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F26747%20-%20diag_mp_wattson_bc_twoSquaddiesLeft_condCaustic_1p.wav?alt=media&token=1c24b074-e49a-4c3d-950c-3f399a273c65",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F26688%20-%20diag_mp_wattson_bc_revivingPlayer_condCrypto_3p.wav?alt=media&token=a181722e-e34c-4000-992d-cc9ff6de44e9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F26685%20-%20diag_mp_wattson_bc_revivingPlayer_condCaustic_1p.wav?alt=media&token=9a200854-84fa-4624-b62b-334a45e028de",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F26682%20-%20diag_mp_wattson_bc_reviveThanks_condWraith_3p.wav?alt=media&token=c8c2b6b1-eb47-4414-b3a4-e810df645436",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F26679%20-%20diag_mp_wattson_bc_reviveThanks_condCrypto_1p.wav?alt=media&token=a06e2003-40d8-40cf-87bc-6775629dabb9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F26677%20-%20diag_mp_wattson_bc_reviveThanks_condCaustic_1p.wav?alt=media&token=abf82459-ffc7-44a1-a458-58aa23b2dd85",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2Fwattson%20sees%20ghost.mp3?alt=media&token=ced36964-cd88-4cf8-8040-75b59642def8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Ffence%20eargasm.mp3?alt=media&token=db57b7a1-090a-4d06-9ad1-8e2164651549",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfplaying.mp3?alt=media&token=5655166a-797b-4018-839f-4c728022c352",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence1.mp3?alt=media&token=61c88ab6-1d5a-4f44-8986-b9f1b3c72a76",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence2.mp3?alt=media&token=11ba0834-dc4f-4ec2-a5a4-e88b7cd2539c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence3.mp3?alt=media&token=817959b7-26e5-4376-9db4-4cdf3c6e9a9b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence4.mp3?alt=media&token=98cea451-36cb-4a71-88a2-6656a8a94e07",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence5.mp3?alt=media&token=357cb7ee-f79a-45c1-9c4c-b0942356b653",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence6.mp3?alt=media&token=e15c8cf7-fba1-4de5-a027-6ddba0523625",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence7.mp3?alt=media&token=1cd80b01-1734-4694-adee-aa5464c97ff9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence8.mp3?alt=media&token=2676d3ef-d1a6-4a16-bdfb-3c6fae48cb9e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2Fwattfence10.mp3?alt=media&token=b02fd230-2a0c-4425-beca-9f994859d4e3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24235%20-%20diag_mp_wattson_bc_totemReturn_3p.wav?alt=media&token=7fa250af-bb84-4a65-89ec-18ecaf204c04",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24230%20-%20diag_mp_wattson_bc_thIntroHushed_3p.wav?alt=media&token=f0862ce1-665e-4cb7-b338-50fa879b3f66",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24218%20-%20diag_mp_wattson_bc_thCompletedCombat_3p.wav?alt=media&token=8de865f8-9e88-4cd8-8e96-6bea1d9758fb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24185%20-%20diag_mp_wattson_bc_skydive_3p.wav?alt=media&token=c0d59bd8-631e-47db-a2e1-f125488b9f08",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24184%20-%20diag_mp_wattson_bc_skydive_1p.wav?alt=media&token=4e7b7a2c-5e7c-4417-a580-ecc51011c02e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24182%20-%20diag_mp_wattson_bc_seasonalTrickOrTreat_1p.wav?alt=media&token=2a0de211-fb0a-40d5-82ba-a1e6fc3057a9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24174%20-%20diag_mp_wattson_bc_reviveThanks_condCaustic_1p.wav?alt=media&token=8460fd81-8b0c-4864-9f55-538b59e6ce55",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24172%20-%20diag_mp_wattson_bc_reviveThanks_1p.wav?alt=media&token=34f5f2c5-fe7a-4950-92e2-dd8b5872963d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24171%20-%20diag_mp_wattson_bc_reviveSelf_3p.wav?alt=media&token=b011be32-7ba3-4a5c-8a59-fa34cd16b6ec",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24162%20-%20diag_mp_wattson_bc_podLeaderLaunch_3p.wav?alt=media&token=ace86c33-f7ca-44a5-9365-515639225c17",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24160%20-%20diag_mp_wattson_bc_podLeaderLaunch_1p.wav?alt=media&token=8dfaaa67-e551-4296-9dae-6dcbcec5c159"
        "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24154%20-%20diag_mp_wattson_bc_objectiveLostSquad_1p.wav?alt=media&token=c2b1594b-6e0c-45e6-87bc-eef8304e16e2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24153%20-%20diag_mp_wattson_bc_objectiveLostSelf_3p.wav?alt=media&token=329f0b3c-3874-457d-9f0e-b04f62ae9c7f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwattson%2F24149%20-%20diag_mp_wattson_bc_objectiveHaveSelf_3p.wav?alt=media&token=8adec1d2-fdbd-46d9-ab1b-f128968782c5",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24178%20-%20diag_mp_wattson_bc_revivingPlayer_condCaustic_1p.wav?alt=media&token=494f2d62-7c2f-4722-8c52-2e3545f01487',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24179%20-%20diag_mp_wattson_bc_revivingPlayer_condCaustic_3p.wav?alt=media&token=57a1dffa-a245-4e71-ad25-b98050f8660c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24272%20-%20diag_mp_wattson_glad_introHalloween_01_qw_1p.wav?alt=media&token=95d559b9-10d1-4c31-b1d1-aa12ddee4af2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24276%20-%20diag_mp_wattson_glad_introSeq_01_qw_1p.wav?alt=media&token=9ef18adf-c104-4357-a03d-fe5d7f896216',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24283%20-%20diag_mp_wattson_glad_introSeq_02_qw_3p.wav?alt=media&token=be3322af-d92d-4602-9c72-331e30292a00',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24285%20-%20diag_mp_wattson_glad_introSeq_03_qw_1p.wav?alt=media&token=8d39ad12-4594-423c-a41e-09820e6d884a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24288%20-%20diag_mp_wattson_glad_introSeq_04_qw_1p.wav?alt=media&token=43be446a-11ad-42a2-b14f-d35082d10672',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24292%20-%20diag_mp_wattson_glad_introSeq_05_qw_3p.wav?alt=media&token=8fa50dcd-090c-4627-a76b-3f5f5286bfe4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24295%20-%20diag_mp_wattson_glad_introSeq_06_qw_3p.wav?alt=media&token=d8aa282c-739f-4eca-8435-aba134bfe521',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24297%20-%20diag_mp_wattson_glad_introSeq_07_qw_1p.wav?alt=media&token=fe0585ba-7f42-432d-8408-ac7e95484a23',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24301%20-%20diag_mp_wattson_glad_introSeq_08_qw_3p.wav?alt=media&token=b1334ccb-d6e4-435b-acb1-4f36eec65be0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24304%20-%20diag_mp_wattson_glad_introSeq_09_qw_3p.wav?alt=media&token=7fe56195-4069-4346-8b44-e70c3407033e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24307%20-%20diag_mp_wattson_glad_introSeq_10_qw_3p.wav?alt=media&token=a312731e-13f3-4c3a-bbb1-3489ad83389a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24310%20-%20diag_mp_wattson_glad_introSeq_11_qw_3p.wav?alt=media&token=f53394ff-87ac-46ca-b7d2-ed250ce75556',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24313%20-%20diag_mp_wattson_glad_introSeq_12_qw_3p.wav?alt=media&token=1a1d7d83-d76f-461b-b1d4-2905df28f166',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24316%20-%20diag_mp_wattson_glad_introSeq_13_qw_3p.wav?alt=media&token=35b2f1df-c53c-445d-87a5-887b76fadab3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24319%20-%20diag_mp_wattson_glad_introSeq_14_qw_3p.wav?alt=media&token=a8c89000-cf2a-464d-a913-94520f0013e4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24322%20-%20diag_mp_wattson_glad_introSeq_15_qw_3p.wav?alt=media&token=2a8fbdd9-29f3-4dfa-b05e-da878791c89d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24325%20-%20diag_mp_wattson_glad_introSeq_16_qw_3p.wav?alt=media&token=73d34ea0-d45f-4506-a0a4-6c27729ddb3b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24328%20-%20diag_mp_wattson_glad_introSeq_17_qw_3p.wav?alt=media&token=7854e730-ff9a-4c85-85a2-4e204513bd74',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24331%20-%20diag_mp_wattson_glad_introSeq_18_qw_3p.wav?alt=media&token=aa6f82ff-6697-4696-ad70-6b9c2ced0fff',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24333%20-%20diag_mp_wattson_glad_introSeq_19_qw_1p.wav?alt=media&token=c8c867aa-57ae-44f8-af60-893c17e77d38',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24337%20-%20diag_mp_wattson_glad_introSeq_20_qw_3p.wav?alt=media&token=0e6e3e20-f62e-46a7-8092-ad757133eaf7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24340%20-%20diag_mp_wattson_glad_introSeq_21_qw_3p.wav?alt=media&token=ea120bfd-c8a7-474d-87eb-e08d998f1612',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24353%20-%20diag_mp_wattson_glad_seasonOpen_qw_1p.wav?alt=media&token=c0f35b10-2100-4112-bd84-9df4c48de7c8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24357%20-%20diag_mp_wattson_glad_taunt_01_3p.wav?alt=media&token=376ba45e-92c0-4420-9786-881d522b6972',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24361%20-%20diag_mp_wattson_glad_taunt_02_1p.wav?alt=media&token=b777bd8e-7dc9-46ec-8767-8071afdc5000',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24364%20-%20diag_mp_wattson_glad_taunt_03_1p.wav?alt=media&token=995e606b-465c-4d27-bd46-16508cc5752e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24368%20-%20diag_mp_wattson_glad_taunt_04_3p.wav?alt=media&token=8524de29-88a9-410c-9bbc-812eabd813f9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24370%20-%20diag_mp_wattson_glad_taunt_05_1p.wav?alt=media&token=56a15aa8-be69-4a42-8884-1fe2636c9aec',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24374%20-%20diag_mp_wattson_glad_taunt_06_3p.wav?alt=media&token=8b901490-ffc4-461c-81a1-5ed1937400d2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24377%20-%20diag_mp_wattson_glad_taunt_07_3p.wav?alt=media&token=c2cd4b17-c5fd-4409-a9db-8f62aedd8816',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24380%20-%20diag_mp_wattson_glad_taunt_08_3p.wav?alt=media&token=389e1e4b-85dd-4035-a957-f38ea6f1d76b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24383%20-%20diag_mp_wattson_glad_taunt_09_3p.wav?alt=media&token=1410563b-65fd-43fc-80db-887a379b31d5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24386%20-%20diag_mp_wattson_glad_taunt_10_3p.wav?alt=media&token=5608f8f7-6740-45b5-8fc4-67e9c4aff536',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24388%20-%20diag_mp_wattson_glad_taunt_11_1p.wav?alt=media&token=570b070d-3fd3-4294-91d1-a9801188a847',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24392%20-%20diag_mp_wattson_glad_taunt_12_3p.wav?alt=media&token=1ec4f6dd-1f17-4971-9171-fd769f65a283',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24394%20-%20diag_mp_wattson_glad_taunt_13_1p.wav?alt=media&token=6a76df4b-2112-4366-91c1-e27fd363d29d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24398%20-%20diag_mp_wattson_glad_taunt_14_3p.wav?alt=media&token=72af183c-e0e0-46fd-beeb-9ef23d212087',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24401%20-%20diag_mp_wattson_glad_taunt_15_3p.wav?alt=media&token=20f603c8-6e25-4454-b02d-502d3f772e26',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24403%20-%20diag_mp_wattson_glad_taunt_16_1p.wav?alt=media&token=b48a6c89-449d-4e85-8e64-63bb2f788087',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24406%20-%20diag_mp_wattson_glad_taunt_17_1p.wav?alt=media&token=9894dd59-9e3d-4f83-a815-4a96f1557f1e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24410%20-%20diag_mp_wattson_glad_taunt_18_3p.wav?alt=media&token=6898b7dc-ebc9-49ef-8520-076495f07c16',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24413%20-%20diag_mp_wattson_glad_taunt_19_3p.wav?alt=media&token=3522584a-c1f3-4ea5-9cde-e99f734b8a86',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24416%20-%20diag_mp_wattson_glad_taunt_20_3p.wav?alt=media&token=2bb1b394-8886-409f-833e-eb4948952c48',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24418%20-%20diag_mp_wattson_glad_taunt_21_1p.wav?alt=media&token=4c32c9bc-1cae-4c2a-ab78-a8f46ea0a316',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24422%20-%20diag_mp_wattson_glad_taunt_22_3p.wav?alt=media&token=ce4e5346-5709-47ec-959d-ac776e0b75d4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24425%20-%20diag_mp_wattson_glad_taunt_23_3p.wav?alt=media&token=fa763067-672d-4e7d-a94f-423484f46408',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24428%20-%20diag_mp_wattson_glad_taunt_24_3p.wav?alt=media&token=40fd043a-8a77-46d9-803b-2b8784363f17',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24431%20-%20diag_mp_wattson_glad_taunt_25_3p.wav?alt=media&token=5b53f477-a94b-4636-a8b9-60dc7e3e8e2b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24434%20-%20diag_mp_wattson_glad_taunt_26_3p.wav?alt=media&token=073bdcbf-d5aa-4cfc-a0fd-9842dc24695a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24437%20-%20diag_mp_wattson_glad_taunt_27_3p.wav?alt=media&token=1bbc6d35-75cd-40a6-98bd-e12fa18b7519',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24439%20-%20diag_mp_wattson_glad_taunt_28_1p.wav?alt=media&token=5896b053-3e19-40c2-bae6-ed1891837f47',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24443%20-%20diag_mp_wattson_glad_taunt_29_3p.wav?alt=media&token=47fdc007-4d2e-43f0-b9e8-f525b0261ae5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24446%20-%20diag_mp_wattson_glad_taunt_30_3p.wav?alt=media&token=b1381bbc-352d-4662-a3ff-ae5a37a5701a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24449%20-%20diag_mp_wattson_glad_taunt_31_3p.wav?alt=media&token=6dad6611-8105-47e3-a81e-61e57e1274d8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24452%20-%20diag_mp_wattson_glad_taunt_32_3p.wav?alt=media&token=1537edc9-4b35-432b-9f1e-25145da32f39',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24455%20-%20diag_mp_wattson_glad_taunt_33_3p.wav?alt=media&token=a2a0d13e-1a42-4d27-83a2-944c29155068',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24458%20-%20diag_mp_wattson_glad_taunt_34_3p.wav?alt=media&token=915184ad-a7d4-419c-a2f7-cfd902ec0bb3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24461%20-%20diag_mp_wattson_glad_taunt_35_3p.wav?alt=media&token=1a8db501-bef9-4d11-afe2-6d124103a2c0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24464%20-%20diag_mp_wattson_glad_taunt_36_3p.wav?alt=media&token=518a1035-9f6f-4d94-bdf0-f7db7130b228',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24467%20-%20diag_mp_wattson_glad_taunt_37_3p.wav?alt=media&token=4fd4fce8-468b-41ee-84b5-31c588e014a4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24470%20-%20diag_mp_wattson_glad_taunt_38_3p.wav?alt=media&token=3e200ab9-f744-4860-9632-f420c6d3c877',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24473%20-%20diag_mp_wattson_glad_taunt_39_3p.wav?alt=media&token=631919a1-7035-4b74-8722-a7f4fa8d1dc4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24476%20-%20diag_mp_wattson_glad_taunt_40_3p.wav?alt=media&token=1e657b0b-bbdf-465c-a783-6bb81b50bdb9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24479%20-%20diag_mp_wattson_glad_taunt_41_3p.wav?alt=media&token=86f0e556-5fad-48fd-8ff9-2447b2914e30',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24482%20-%20diag_mp_wattson_glad_taunt_42_3p.wav?alt=media&token=614d6316-d144-41dc-8cc4-cd4a43709c75',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24485%20-%20diag_mp_wattson_glad_taunt_43_3p.wav?alt=media&token=b4a5093f-5dc0-4967-8c29-17f11c4bcf31',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24487%20-%20diag_mp_wattson_glad_tauntHalloween_01_1p.wav?alt=media&token=7198a13f-67dc-4a8a-89a0-65320c9d2141',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24491%20-%20diag_mp_wattson_glad_tauntHalloween_02_3p.wav?alt=media&token=bd16e5a0-0bd0-4a98-9163-938c4e763e67',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24493%20-%20diag_mp_wattson_glad_tauntQuest_30_3p.wav?alt=media&token=1c26a349-0640-4857-907b-ab32fcebae7d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24495%20-%20diag_mp_wattson_glad_tauntValentines_01_3p.wav?alt=media&token=c4f0776e-9b89-439c-905b-77b97005048d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24498%20-%20diag_mp_wattson_glad_tauntValentines_02_3p.wav?alt=media&token=2b4edc01-34c7-4fef-81e3-f7378455c07d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24501%20-%20diag_mp_wattson_glad_tauntWinter_01_3p.wav?alt=media&token=d84c43b8-bb0b-42d3-bebc-26222f65d4db',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/24504%20-%20diag_mp_wattson_glad_tauntWinter_02_3p.wav?alt=media&token=2e4701bb-d7f1-4a41-b757-195e48547d69',
  ];

  final List<String> quipnames = [
    "Your efforts were electrocute (NEW)",
    "Engineering requires patience and ingenuity",
    "Your welcome Wraith",
    "Then you are not welcome and you owe me big time",
    "I don't understand your humour,I find it rude",
    "CRYPTO!",
    "DOCTOR!",
    "Thank you crypto but this doesn't change anything",
    "Thank you good day doctor",
    "Look Doctor Caustic It's one of your gas traps",
    "It's only us now,Do not make it more unpleseant",
    "Even Traitors don't deserve to die",
    "Hold Still,I know this doesn't change anything",
    "You came for me again Wraith,Thanks",
    "You saved me,doesn't change what you did",
    "Thank you Doctor but I can take care of Myself)",
    "Wattson sees Ghost in the Labs ",
    "Fence Eargasm ;-) ",
    "Playing with fences ",
    "That's a happy fence ",
    "That's a silly fence ",
    "That's a grumpy fence ",
    "That's a pretty fence ",
    "That's an angry fence ",
    "That's a nice fence ",
    "That's a scary fence ",
    "That's a sad fence ",
    "That's a funny fence ",
    "Back at the totem and no longer a shadow what is this strange science",
    "We have a piece to find don't worry I know every hiding place",
    "We found the piece time to discharge",
    "Wattson skydive",
    "Wattson skydive",
    "Trick or Treat",
    "Thank you Dr Caustic,see you are not as inhuman as they say you are",
    "My synapses are firing again,Thank You",
    "I stepped into the light and the light sent me back ",
    "Let's go "
        "CHARGE ",
    "We lost the objective ",
    "NO NO NO How did I loose the objective? ",
    "Objective aquired this will certainly generate some buzz",
    'Hold on doctor Caustic, We Scientist must stick together',
    'I couldn\'t save papa but I can save you doctor Caustic',
    'You can\'t be afraid of the dark when you know how to control the light',
    'It\'s difficult to win, when i conduct the power',
    'I did it papa',
    'To you it\'s a gauntlet to me it\'s home',
    'You are playing in my backyard now',
    'I never say die,I fight until it hertz',
    'Wattage up! I\'m recharched and ready to go',
    'My electric fences will hurt you',
    'My adversaries are in for a shock',
    'Be careful I don\'t wear all this gear for nothing',
    'Papa would be proud of me',
    'The best offense is a strong defence',
    'I may not look like a fighter',
    'My light shines bright',
    'Power is everything',
    'Once the battle gets too noisy,I bring the silence',
    'Studying past combatants has served me well',
    'This is the only life I know',
    'Didn\'t expect to see me up here did you',
    'You may be stronger but I\'am smarter',
    'I\'m currently at the top of my game,get it',
    'Electricity I get People I don\'t',
    'The Season has opened may the smartest win',
    'Electrons are the same but propel each other',
    'Death is just a halt of electric impulses to the brain',
    'I\'m sorry sometimes the power goes out and never comes back on',
    'There are some nodes a current cannot travel through',
    'The noise will stop now',
    'You burned bright but you burned out',
    'This never gets any easier',
    'You didn\'t expect this from me which is why you lost',
    'Lights out',
    'I prefer restoring order',
    'You fought well but i grew up in this territories',
    'Don\'t confuse my kindness for weakness',
    'It\'s either you or me',
    'Look on the bright side you got beat by a legend',
    'Don\'t blow a fuse,get it?',
    'My suit is insulated you are not',
    'You can outrun me but you cannot outrun the current',
    'Think of this as a permenant black-out',
    'The legends taught me everything I know,You? not so much',
    'many legends fall,time for you to join them',
    'There is one thing i know how to do,is to cut the power',
    'That\'s the last time you charge anybody',
    'I\'m tougher than I look',
    'I guess i found your offswitch',
    'You get too close to a live wire and you pay the price',
    'Go towards the light',
    'This is the end of your electrical current',
    'this is how it has to be',
    'We are just on the diffrent sides on the fence',
    'Somebody has to loose',
    'I have been watching combatants my whole life',
    'This went exactly how I planned it too',
    'I won Papa',
    'You fought hard',
    'Sometimes careful planning wins out over might',
    'This is what happens when you cross the wrong fence',
    'Don\'t blame yourself,I knew where you would be',
    'I didn\'t see you coming but my fence did',
    'Size and Strength aren\'t everything',
    'I\'m the one with the stronger current',
    'You underestimated me',
    'Consider your circuit broken,Get It?',
    'Don\'t be afraid of the dark,find comfort in the light',
    'Your energy will return to the atmosphere',
    'This could have been avoided if you have just given me candy',
    'Somebody has to loose,that\'s just how this works',
    'Is there any better gift for someone you love than joules?',
    'Love is a form of energy that outlasts everything',
    'Time to hibernate for the winter',
    'Don\'t feel bad',
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
            'Wattson Quips',
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
                          child: Image.asset("assets/images/watt.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Wattson Quips",
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
