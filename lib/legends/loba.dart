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

class Loba extends StatefulWidget {
  @override
  _LobaState createState() => _LobaState();
}

class _LobaState extends State<Loba> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_loba_glad_tauntOrigin_01_01_3p.wav?alt=media&token=1ff8d0c0-b354-4133-830d-cd7a3896bd1e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2Flobarevenent%20talk.mp3?alt=media&token=22799c5a-979a-48a2-8829-c7be45386aba",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16584%20-%20diag_mp_loba_ping_youreWelcome_calm_condWraith_3p.wav?alt=media&token=d42a3021-7783-4e61-95c0-60c8a1caf3f1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16582%20-%20diag_mp_loba_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=d9153c84-216d-444e-9d73-d0c9b60e6b7f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16580%20-%20diag_mp_loba_ping_youreWelcome_calm_condPathfinder_3p.wav?alt=media&token=60901fae-6b6d-420a-854a-3fa7de15d4de",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16577%20-%20diag_mp_loba_ping_youreWelcome_calm_condCrypto_1p.wav?alt=media&token=0cadcba7-006a-4cdb-a793-ae27ecf73df5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16576%20-%20diag_mp_loba_ping_youreWelcome_calm_condBangalore_3p.wav?alt=media&token=eaa82653-05f9-47ee-8588-ccb9925ece35",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16410%20-%20diag_mp_loba_ping_thanks_condPathfinder_3p.wav?alt=media&token=f390e4e0-8279-4a53-bf8c-1b3408a59c8f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16044%20-%20diag_mp_loba_ping_markerComingToHelp_urgent_condRevenant_3p.wav?alt=media&token=437d5a16-c16e-4f4f-a140-998d83a38ff3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16040%20-%20diag_mp_loba_ping_markerComingToHelp_calm_condRevenant_3p.wav?alt=media&token=a13f3d65-f97d-4929-96b0-19e437d9c21d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F16039%20-%20diag_mp_loba_ping_markerComingToHelp_calm_condRevenant_1p.wav?alt=media&token=dcf24fc0-c10f-4cf3-ad24-652a21cfc088",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15070%20-%20diag_mp_loba_bc_twoSquaddiesLeft_condRevenant_3p.wav?alt=media&token=16318dee-9a71-464d-93e5-fafa695e67e8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15069%20-%20diag_mp_loba_bc_twoSquaddiesLeft_condRevenant_1p.wav?alt=media&token=f5e2c666-5dcf-45bb-b6b2-6e61d4430951",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15058%20-%20diag_mp_loba_bc_thIntro_3p.wav?alt=media&token=8e3c04e4-5717-40ee-a0ac-a316d939d98c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15057%20-%20diag_mp_loba_bc_thIntro_1p.wav?alt=media&token=2ecd6fe4-21ea-481d-99e6-08620b94527d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15045%20-%20diag_mp_loba_bc_thCompleted_1p.wav?alt=media&token=4ef0b8b7-0f35-4ce0-b7a8-c1898506dd4a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15022%20-%20diag_mp_loba_bc_squadmateBecomesKillLeader_condRevenant_3p.wav?alt=media&token=b13a530c-ce35-41a0-b1a0-bc77882cd518",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15021%20-%20diag_mp_loba_bc_squadmateBecomesKillLeader_condRevenant_1p.wav?alt=media&token=5fff79e0-d885-439e-8811-a5181032b202",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15016%20-%20diag_mp_loba_bc_skydive_3p.wav?alt=media&token=0f5aa36f-c892-407c-b07f-a21c18ce75c0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15015%20-%20diag_mp_loba_bc_skydive_1p.wav?alt=media&token=ca8f6ad5-d7e0-409d-a02b-8f66cb43ce89",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15014%20-%20diag_mp_loba_bc_seasonalTrickOrTreat_3p.wav?alt=media&token=016d38cf-5bab-4c5c-b033-039467a7d153",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15008%20-%20diag_mp_loba_bc_revivingPlayer_condRevenant_3p.wav?alt=media&token=29783de6-5f5d-4d43-af71-af748dc111c1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15004%20-%20diag_mp_loba_bc_reviveThanks_condRevenant_3p.wav?alt=media&token=503346d2-96b8-40a9-869a-da5532e78371",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15003%20-%20diag_mp_loba_bc_reviveThanks_condRevenant_1p.wav?alt=media&token=c62b6de4-348b-44f5-bbf4-cc213d72454b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15002%20-%20diag_mp_loba_bc_reviveThanks_condMirage_3p.wav?alt=media&token=0af5f6c1-33a1-4813-a348-774c67c83730",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F15000%20-%20diag_mp_loba_bc_reviveThanks_condBloodhound_3p.wav?alt=media&token=d3a8525d-9980-40fb-acf5-65a782daf305",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14996%20-%20diag_mp_loba_bc_reviveSelf_3p.wav?alt=media&token=9c2993bc-175d-45d4-a969-8d7319e349d1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14984%20-%20diag_mp_loba_bc_objectiveLostSquad_3p.wav?alt=media&token=ecfc772d-453b-4bf5-a5bf-fef1f3e573a1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14981%20-%20diag_mp_loba_bc_objectiveLostSelf_1p.wav?alt=media&token=5f5b6374-d88a-439c-958f-6bbf014a66e4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14979%20-%20diag_mp_loba_bc_objectiveHaveSquad_1p.wav?alt=media&token=b58ee544-ef25-40a6-8d4a-9aa80309c9a5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14977%20-%20diag_mp_loba_bc_objectiveHaveSelf_1p.wav?alt=media&token=05ebe432-754b-4f93-8769-29c03af07fab",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14933%20-%20diag_mp_loba_bc_gotFriendlyBanner_condRevenant_3p.wav?alt=media&token=f6e38463-e103-4a3d-884b-b7b74cf84b29",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14909%20-%20diag_mp_loba_bc_congratsKill_condRevenant_3p.wav?alt=media&token=d80ac0ba-4380-45c0-93fd-88742986ce1e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Floba%2F14867%20-%20diag_mp_loba_bc_blackMarketSquadLoot_condRevenant_1p.wav?alt=media&token=e0d18e71-b3ec-49e7-8e6b-7d4b184cdc38",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15096%20-%20diag_mp_loba_glad_finisher_01_1p.wav?alt=media&token=b4bd044c-295e-403b-b4c8-e887e25c8d06',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15101%20-%20diag_mp_loba_glad_introSeq_01_qw_1p.wav?alt=media&token=19b01dfc-2b2c-408a-a38f-c1b943ef28f8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15107%20-%20diag_mp_loba_glad_introSeq_02_qw_1p.wav?alt=media&token=27c6a417-213e-4263-89d3-d07bf6898650',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15110%20-%20diag_mp_loba_glad_introSeq_03_qw_1p.wav?alt=media&token=5383e9db-b991-4191-b2b5-964abf64e762',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15113%20-%20diag_mp_loba_glad_introSeq_04_qw_1p.wav?alt=media&token=79021fc0-3e67-4071-91fa-9ca37c1f7282',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15116%20-%20diag_mp_loba_glad_introSeq_05_qw_1p.wav?alt=media&token=96d187f7-5976-4d69-b355-6837e430f888',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15119%20-%20diag_mp_loba_glad_introSeq_06_qw_1p.wav?alt=media&token=97328117-523f-4d67-ae8a-e71bd2f02220',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15122%20-%20diag_mp_loba_glad_introSeq_07_qw_1p.wav?alt=media&token=9b2690b0-0d0b-41cf-a1dc-b35eef2f13f1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15126%20-%20diag_mp_loba_glad_introSeq_08_qw_3p.wav?alt=media&token=de9e7945-e357-4538-967f-9c11bda69081',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15128%20-%20diag_mp_loba_glad_introSeq_09_qw_1p.wav?alt=media&token=40f8001d-ece6-4263-8319-bcff5ce8f79c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15132%20-%20diag_mp_loba_glad_introSeq_10_qw_3p.wav?alt=media&token=27979a52-9632-447e-86aa-ec1d51492966',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15135%20-%20diag_mp_loba_glad_introSeq_11_qw_3p.wav?alt=media&token=741780c2-5ce1-449d-81b6-0336dbae3a9b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15137%20-%20diag_mp_loba_glad_introSeq_12_qw_1p.wav?alt=media&token=5e460e11-1ed5-4501-825d-4ebca4622b98',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15140%20-%20diag_mp_loba_glad_introSeq_13_qw_1p.wav?alt=media&token=7ba94910-fb84-4618-804c-e299d4f57676',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15143%20-%20diag_mp_loba_glad_introSeq_14_qw_1p.wav?alt=media&token=5ad8772e-a907-4b19-a245-cf2f6572794f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15147%20-%20diag_mp_loba_glad_introSeq_15_qw_3p.wav?alt=media&token=76535b76-b842-4d8a-8761-40ad0b337e5c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15149%20-%20diag_mp_loba_glad_introSeq_16_qw_1p.wav?alt=media&token=9a2b1948-9c8e-4cb7-a0dc-211609b57acb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15153%20-%20diag_mp_loba_glad_introSeq_17_qw_3p.wav?alt=media&token=daff263b-a58b-4d89-adae-b9677749f5f9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15155%20-%20diag_mp_loba_glad_introSeq_18_qw_1p.wav?alt=media&token=d6c439e8-bde8-4501-a227-a512b5f41dfc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15158%20-%20diag_mp_loba_glad_introSeq_19_qw_1p.wav?alt=media&token=ff7642c7-970a-453e-b8d3-253f39e7f92f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15161%20-%20diag_mp_loba_glad_introSeq_20_qw_1p.wav?alt=media&token=7ce3ecb8-da81-4463-876a-3d5a2b57230b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15164%20-%20diag_mp_loba_glad_introSeq_21_qw_1p.wav?alt=media&token=dee72074-7e1a-4d02-8ccd-358ad67fdbc9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15179%20-%20diag_mp_loba_glad_seasonOpen_qw_1p.wav?alt=media&token=3c669f0c-a4fb-4324-a7ae-da7b37aadd9d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15181%20-%20diag_mp_loba_glad_taunt_01_1p.wav?alt=media&token=97871529-fd6a-45a2-beee-d5b1e22ba354',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15187%20-%20diag_mp_loba_glad_taunt_02_1p.wav?alt=media&token=4b4712a4-6029-4364-bd5a-e0d21943d820',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15191%20-%20diag_mp_loba_glad_taunt_03_3p.wav?alt=media&token=a33ab50b-ea85-4f3f-b1d3-88c0af444530',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15193%20-%20diag_mp_loba_glad_taunt_04_1p.wav?alt=media&token=6252828c-d716-450d-a611-c2fd00a2d328',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15196%20-%20diag_mp_loba_glad_taunt_05_1p.wav?alt=media&token=1ae40086-548d-4123-a9cb-cec070c75b7e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15199%20-%20diag_mp_loba_glad_taunt_06_1p.wav?alt=media&token=396db8d5-daac-49b6-9d9a-0ab38400c64b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15202%20-%20diag_mp_loba_glad_taunt_07_1p.wav?alt=media&token=d4673907-c260-4bb6-afb1-20cf579ed940',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15205%20-%20diag_mp_loba_glad_taunt_08_1p.wav?alt=media&token=4ef44819-77e9-4117-add8-6f464c09757e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15208%20-%20diag_mp_loba_glad_taunt_09_1p.wav?alt=media&token=f741835e-fe91-440a-a60d-84534b379158',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15211%20-%20diag_mp_loba_glad_taunt_10_1p.wav?alt=media&token=e4c67196-b25c-4151-a3c6-6586dd2264d0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15214%20-%20diag_mp_loba_glad_taunt_11_1p.wav?alt=media&token=98357fa5-2a40-4dc1-a863-daae07cf0813',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15217%20-%20diag_mp_loba_glad_taunt_12_1p.wav?alt=media&token=f066f359-bca3-4135-a239-d907e6fdf595',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15220%20-%20diag_mp_loba_glad_taunt_13_1p.wav?alt=media&token=2356b6b6-74d4-434f-b798-1f7908361413',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15223%20-%20diag_mp_loba_glad_taunt_14_1p.wav?alt=media&token=1f0aa49f-7235-4dc5-9352-dca65719c946',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15226%20-%20diag_mp_loba_glad_taunt_15_1p.wav?alt=media&token=1f2cd1bf-febf-4a3c-8159-4b4a0cac085e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15229%20-%20diag_mp_loba_glad_taunt_16_1p.wav?alt=media&token=b8e3b7e0-2bd8-4763-8bf3-45239d4e2dc4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15232%20-%20diag_mp_loba_glad_taunt_17_1p.wav?alt=media&token=cb8f48d9-94a6-4b28-a1ab-e8fb92533df5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15235%20-%20diag_mp_loba_glad_taunt_18_1p.wav?alt=media&token=6e97f84b-f6d2-4528-8156-74629ef54ad4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15239%20-%20diag_mp_loba_glad_taunt_19_3p.wav?alt=media&token=eda46305-f6ca-4dfd-86a8-b0c83188640e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15242%20-%20diag_mp_loba_glad_taunt_20_3p.wav?alt=media&token=d5d67008-ae9f-41ac-b24f-94f3949b9221',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15244%20-%20diag_mp_loba_glad_taunt_21_1p.wav?alt=media&token=9a3bcf09-a111-4bf4-a473-ad83dac97eb4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15247%20-%20diag_mp_loba_glad_taunt_22_1p.wav?alt=media&token=22af4089-4e2f-4b85-9c3f-dc47400ca905',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15251%20-%20diag_mp_loba_glad_taunt_23_3p.wav?alt=media&token=962ea81a-bc03-4089-8075-23457bee3f93',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15253%20-%20diag_mp_loba_glad_taunt_24_1p.wav?alt=media&token=3304ed55-986e-45d0-beb3-9405e2cec195',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15256%20-%20diag_mp_loba_glad_taunt_25_1p.wav?alt=media&token=b0e3f57a-8403-4c39-a874-a949ac280cff',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15259%20-%20diag_mp_loba_glad_taunt_26_1p.wav?alt=media&token=46f62662-32db-43c2-8983-a96b99e6e29a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15263%20-%20diag_mp_loba_glad_taunt_27_3p.wav?alt=media&token=e761d192-16fd-4cef-a68a-0fedb9d946c6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15265%20-%20diag_mp_loba_glad_taunt_28_1p.wav?alt=media&token=b30d3eac-3296-429c-8f90-5e2c1ed736e3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15269%20-%20diag_mp_loba_glad_taunt_29_3p.wav?alt=media&token=32813799-c93c-475f-84f1-f804abe19034',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15272%20-%20diag_mp_loba_glad_taunt_30_3p.wav?alt=media&token=2a6c7e32-0af9-40e8-8ea1-0451154e6e5d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15275%20-%20diag_mp_loba_glad_taunt_31_3p.wav?alt=media&token=4bdf67a6-4ac8-445c-9162-d610b2b71a05',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15277%20-%20diag_mp_loba_glad_taunt_32_1p.wav?alt=media&token=fd21d4ce-b5f1-4b2e-a27b-ecea5470f5f3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15280%20-%20diag_mp_loba_glad_taunt_33_1p.wav?alt=media&token=e5e0d3bf-a36e-4ff8-abde-fdf1f04adf3b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15283%20-%20diag_mp_loba_glad_taunt_34_1p.wav?alt=media&token=2feb6f8d-375b-452a-ad9e-6ff3e7a18e8c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15286%20-%20diag_mp_loba_glad_taunt_35_1p.wav?alt=media&token=32e0b4ae-560d-4382-8eb7-c2bc29adb150',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15289%20-%20diag_mp_loba_glad_taunt_36_1p.wav?alt=media&token=da86fcf3-aee7-4a18-885f-fc8bf74f5072',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15292%20-%20diag_mp_loba_glad_taunt_37_1p.wav?alt=media&token=65328f82-e1ce-41cc-bd85-fb18b7262278',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15295%20-%20diag_mp_loba_glad_taunt_38_1p.wav?alt=media&token=8c2b4e7c-cfe7-48e6-8ea1-fa187ccaaa6e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15298%20-%20diag_mp_loba_glad_taunt_39_1p.wav?alt=media&token=4fef7ddc-ba35-40f8-99ac-add47be7cbd0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15302%20-%20diag_mp_loba_glad_taunt_40_3p.wav?alt=media&token=3344c61b-dc61-4cd6-a931-4e87aaadae92',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15304%20-%20diag_mp_loba_glad_taunt_41_1p.wav?alt=media&token=21875892-c6a0-40ec-a151-59c9fca5986d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/15307%20-%20diag_mp_loba_glad_tauntValentines_01_1p.wav?alt=media&token=84adb4d2-0ca2-4f47-87de-be9dbac6a45b',
  ];

  final List<String> quipnames = [
    "I had humble beginings you had a humble end (NEW)",
    "Loba and Revenant speak in suspended skull",
    "I could say the same to you ",
    "Shut up your voice is grating ",
    "Look no offense,but the only thing I trust ",
    "I could say the same thing about yours ",
    "My pleasure, I tell you everything about it but how boring would that be ",
    "Thanks! But don't forget I'm keeping an eye on you robot ",
    "If only i could let you die,we need that firepower ",
    "I'm coming for you,you bastard ",
    "If I thought this would really kill you,I will let you die ",
    "We lost a teammate,It should have been you demonio ",
    "Lost one,Now I'm stuck with a demon ",
    "Eyes peeled boys and girls,We got a piece to find ",
    "A treasure hunt,how adorable ",
    "The piece is ours,time to disappear ",
    "And you are the new kill leader,It's like you were made for this ",
    "The demon is our kill leader,of course it's all he knows ",
    "Skydive Laugh ",
    "Skydive Laugh ",
    "Trick or Treat ",
    "Die Later,We need more firepower ",
    "Get your claws off me ",
    "Talk about them again, I dare you ",
    "Thanks handsome but breathe ",
    "We understand each other,this boys and girls don't know what we know ",
    "They underestimated me,Perfect ",
    "Damn it we lost the objective ",
    "No I lost the objective ",
    "We have the objective ",
    "I have the objective,When I see something I like I don't let go ",
    "Speak of the devil,I have his banner ",
    "I guess you have to be good at killing what else do you have ",
    "You don't deserve my help,Demon ",
    'You should smile more',
    'You think you are tough?Try fighting in six inch heeels',
    'There is a certain elegance to combat,I will show you',
    'I don\'t want to kill you but you are in my way',
    'I know what you are looking for come see me',
    'I will take your life and your loot',
    'Riches make the man,I can\'t wait to see what you are made of',
    'Pick out something nice for me,Won\'t you?',
    'I know what i came for,I will get it one way or another',
    'A Powerful women knows what she wants',
    'I\'m the diamond you are the rough',
    'C\'mon lets see if we are a match',
    'I will break your heart and then I will break everything else',
    'Beauty is Pain',
    'Careful,I will steal more than just your heart',
    'I fought nightmares all my life,None of you scare me',
    'You can\'t be overdressed or overarmed',
    'I know what I like and I know how to get it',
    'Time to break some hearts',
    'I\'m a man eater and a lady killer',
    'Wait until you see what I have in store',
    'Most beautiful things are fragile,Not me',
    'New Season New treasures',
    'A lady never kills and tells',
    'Brought to your knees by a beautiful women,don\'t be so surprised',
    'All that loot looks heavy let me help you with that',
    'It was fun while it lasted',
    'All this for me,You definitly should have',
    'Now for the best part',
    'To the victor go the spoils',
    'What lovely treasures,I think i will take them',
    'What can I say,You were in my way',
    'It\'s nothing personal,maybe we will be friends next time',
    'You made the mistake of taking what I wanted',
    'What\'s mine is mine and what\'s your is mine',
    'You can\'t take it with you',
    'Quickest way to man\'s heart is through his chest',
    'I had to claw my way to the top',
    'I make it look easy don\'t I',
    'One little fight is no reason to loose your composure',
    'You were just going to spray and pray',
    'Beauty before whatever you are',
    'Would you like a kiss to make it better?',
    'Thanks for holding my things beautiful',
    'Don\'t be embarassed,It happens to everyone sometimes',
    'The most beautiful creatures have the deadliest venom',
    'It\'s been a pleasure doing buisness with you',
    'Learn the steps befor you try to',
    'This was a match made in heaven well maybe not for you',
    'And here\'s whats left of your legacy',
    'A gun is like a beautiful women,Hold her tight or someone else will',
    'You got blood on my shoes',
    'Let\'s see what treasures you have for me',
    'I could sell the clothes of your back but I\'m in a bit of a hurry',
    'A fool and the treasures are soon barted',
    'You had me in your sights and couldn\'t close the deal typical',
    'I Stopped being afraid a long time ago,You should give it a try',
    'When you have been chased by nightmares nothing scares you',
    'Even nightmares aren\'t so frightning in the light of day',
    'A Faint heart never want a Lady Like me',
    'It\'s not just about having it,It\'s about taking it',
    'What did I distract you?',
    'Goodnight beautiful',
    'You drive a hard bargain,I\'m glad we can come to an agreement',
    'Sorry beautiful It\'s not you it\'s me',
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
            'Loba Quips',
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
                          child: Image.asset("assets/images/loba.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Loba Quips",
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
