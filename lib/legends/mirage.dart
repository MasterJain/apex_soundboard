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

class Mirage extends StatefulWidget {
  @override
  _MirageState createState() => _MirageState();
}

class _MirageState extends State<Mirage> {
  final List<String> audio = [
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_mirage_glad_tauntOrigin_01_02_3p.wav?alt=media&token=c832b249-c8e8-489a-b4fc-ddab37437e73',
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F17237%20-%20diag_mp_mirage_bc_squadmateBecomesKillLeader_condRampart_1p.wav?alt=media&token=346174b9-159a-4630-9fa6-f1de9c7093db",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F17251%20-%20diag_mp_mirage_bc_squadTeamWipe_condRampart_3p.wav?alt=media&token=0202ea06-644e-437b-b81f-540fd0b120eb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F17287%20-%20diag_mp_mirage_bc_twoSquaddiesLeft_condRampart_1p.wav?alt=media&token=abb3c88a-e4ac-4f35-ae34-46625281ddd6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F18006%20-%20diag_mp_mirage_ping_exploreGoPlayer_calm_condCrypto_1p.wav?alt=media&token=7653df7e-72a5-4d35-b97d-905541e9806e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F18542%20-%20diag_mp_mirage_ping_markerNo_calm_condRampart_1p.wav?alt=media&token=0128a1b8-519e-4818-af84-10f85e5a614e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F18555%20-%20diag_mp_mirage_ping_markerWait_calm_condRampart_3p.wav?alt=media&token=a923dab8-2e24-43ac-84be-14c276561b6e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F18556%20-%20diag_mp_mirage_ping_markerWait_urgent_1p.wav?alt=media&token=2d8f6f94-c957-4f74-ba59-5727a1b2d611",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F18566%20-%20diag_mp_mirage_ping_markerYes_calm_condRampart_1p.wav?alt=media&token=b60bfeef-45b8-42bd-8e0a-8de7d7a4094c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16757%20-%20diag_mp_mirage_bc_iKilledAnEnemyWithHeirloom_3p.wav?alt=media&token=cd54e7c5-95e3-44b8-88d6-9cdd4db41edd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16756%20-%20diag_mp_mirage_bc_iKilledAnEnemyWithHeirloom_1p.wav?alt=media&token=b3760fc1-e698-41fb-aad0-a0b6733aa5c3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16753%20-%20diag_mp_mirage_bc_iHitAnEnemyWithHeirloom_3p.wav?alt=media&token=0574c189-91d3-4e19-b0b9-b0141efde670",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F18574%20-%20diag_mp_mirage_ping_youreWelcome_calm_condRevenant_1p.wav?alt=media&token=3e7d6aaa-f227-40db-88e2-4b697511fe1e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2Fmirage2.mp3?alt=media&token=e1c41489-b0ad-4102-9ac4-65107c6878ac",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16790%20-%20diag_mp_mirage_bc_thIntro_solo.wav?alt=media&token=1e5a2334-9086-4a47-bd2c-db22f64cf9f0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16788%20-%20diag_mp_mirage_bc_thIntro_1p.wav?alt=media&token=0e6bb2a0-0d31-4a26-9298-2de0ae13ccf8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16778%20-%20diag_mp_mirage_bc_thCompleted_solo.wav?alt=media&token=89384c04-9db7-4dca-ab35-5648e9584336",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16777%20-%20diag_mp_mirage_bc_thCompleted_3p.wav?alt=media&token=0399d3a2-d648-4f8d-8d47-4a91ec8be38c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16770%20-%20diag_mp_mirage_bc_tacticalTaunt_1p.wav?alt=media&token=8a2e1099-3444-480f-b577-c8c848fd6cb8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16768%20-%20diag_mp_mirage_bc_tactical_1p.wav?alt=media&token=c60434f1-9ec6-4794-868d-a08727f0d480",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16752%20-%20diag_mp_mirage_bc_squadmateBecomesKillLeader_condPathfinder_1p.wav?alt=media&token=80436fc3-ce5f-40d5-a44b-bb8ab2ad9504",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16747%20-%20diag_mp_mirage_bc_skydive_3p.wav?alt=media&token=b83a0ef8-d8b9-4f0f-a141-c75aadc4e7df",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16746%20-%20diag_mp_mirage_bc_skydive_1p.wav?alt=media&token=9d5db0ae-6fdf-4469-a534-37a079f5d9e8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16740%20-%20diag_mp_mirage_bc_revivingPlayer_condPathfinder_1p.wav?alt=media&token=48d9c579-846a-44c8-b20d-eb06ba1ada92",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16739%20-%20diag_mp_mirage_bc_revivingPlayer_condLoba_3p.wav?alt=media&token=d0f9207f-624b-4c60-9833-1f59863a8c38",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16738%20-%20diag_mp_mirage_bc_revivingPlayer_condLoba_1p.wav?alt=media&token=83275a1a-2dd0-4e15-a0c0-4cc66a499f24",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16737%20-%20diag_mp_mirage_bc_revivingPlayer_condCrypto_3p.wav?alt=media&token=afab01a0-9090-474e-ac4c-7d6ba4f11e82",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16733%20-%20diag_mp_mirage_bc_reviveThanks_condPathfinder_3p.wav?alt=media&token=2574deb5-84b9-49f1-856c-08361d88884b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16731%20-%20diag_mp_mirage_bc_reviveThanks_condCrypto_3p.wav?alt=media&token=aa5084cd-a088-4194-98c7-838f5a4a5659",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16727%20-%20diag_mp_mirage_bc_reviveSelf_3p.wav?alt=media&token=40461263-1881-45a2-a999-333cfa155ce8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16726%20-%20diag_mp_mirage_bc_reviveSelf_1p.wav?alt=media&token=e27914cc-2e10-45f1-bfd4-0054613f72d3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16711%20-%20diag_mp_mirage_bc_objectiveLostSquad_condPathfinder_3p.wav?alt=media&token=0a5dccbc-4a32-43e5-833a-d9bdb1b9b404",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16709%20-%20diag_mp_mirage_bc_objectiveLostSquad_3p.wav?alt=media&token=97a34d36-cc93-480b-afd8-ff9e80524ee6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16707%20-%20diag_mp_mirage_bc_objectiveLostSelf_3p.wav?alt=media&token=5722a2c2-24ee-445f-ac0e-4fdd6b56aa7c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16704%20-%20diag_mp_mirage_bc_objectiveHaveSquad_1p.wav?alt=media&token=e0232683-df82-491c-afc2-8d5c745c77c7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16702%20-%20diag_mp_mirage_bc_objectiveHaveSelf_1p.wav?alt=media&token=363bd493-c885-4570-8d44-c436c8bcefb4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16667%20-%20diag_mp_mirage_bc_iBecomeKillLeader_condCrypto_1p.wav?alt=media&token=348b0f41-86c8-4b26-aba5-14c374f682f1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16645%20-%20diag_mp_mirage_bc_droppingCarePack_condCrypto_1p.wav?alt=media&token=16f8dd02-ab8e-4915-921c-cf9f11d7142a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fmirage%2F16605%20-%20diag_mp_mirage_bc_cargoBotDamaged_condPathfinder_1p.wav?alt=media&token=2d2dabf2-28ac-42c0-8aee-3ffc52496018",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17067%20-%20diag_mp_mirage_glad_introHalloween_01_qw_1p.wav?alt=media&token=f3bf3bfb-3841-44b0-8d48-2e302c346aef',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17073%20-%20diag_mp_mirage_glad_introSeq_01_qw_3p.wav?alt=media&token=5782aece-aebf-4c56-82ec-252edfbc6d25',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17077%20-%20diag_mp_mirage_glad_introSeq_02_qw_1p.wav?alt=media&token=dec1d60e-ab7f-4053-8c04-d745dd1b7cdd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17080%20-%20diag_mp_mirage_glad_introSeq_03_qw_1p.wav?alt=media&token=d76bdf33-1352-4e20-bf02-75b82cd9bd8d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17083%20-%20diag_mp_mirage_glad_introSeq_04_qw_1p.wav?alt=media&token=276f648e-88c0-49f0-af0e-a2ab9ae17a8a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17086%20-%20diag_mp_mirage_glad_introSeq_05_qw_1p.wav?alt=media&token=933fda98-17d1-4ead-8d40-e5f2869ae051',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17089%20-%20diag_mp_mirage_glad_introSeq_06_qw_1p.wav?alt=media&token=a9b073a2-fad6-4e6a-8aa2-4bdf03a5da72',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17093%20-%20diag_mp_mirage_glad_introSeq_07_qw_3p.wav?alt=media&token=a5e99d09-37e7-44ba-a483-b9f1a8e94b06',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17095%20-%20diag_mp_mirage_glad_introSeq_08_qw_1p.wav?alt=media&token=0283dd4c-291c-419b-b723-196fc8be1d1b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17098%20-%20diag_mp_mirage_glad_introSeq_09_qw_1p.wav?alt=media&token=bd24e84f-5979-4559-a03a-8f2a2b9d293b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17102%20-%20diag_mp_mirage_glad_introSeq_10_qw_3p.wav?alt=media&token=5c7a0760-ee21-42a4-ba9d-dfc19330db88',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17105%20-%20diag_mp_mirage_glad_introSeq_11_qw_3p.wav?alt=media&token=b172a6a8-fa6f-4c1c-81f1-f3a1301d5fd8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17107%20-%20diag_mp_mirage_glad_introSeq_12_qw_1p.wav?alt=media&token=541ab38b-e80d-45f8-956a-46e611012181',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17110%20-%20diag_mp_mirage_glad_introSeq_13_qw_1p.wav?alt=media&token=bafa75e2-38bc-4ea9-97aa-7412b6c6d05d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17113%20-%20diag_mp_mirage_glad_introSeq_14_qw_1p.wav?alt=media&token=ff6cf703-9a80-4d8d-b1b3-f1d7328e1ed8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17116%20-%20diag_mp_mirage_glad_introSeq_15_qw_1p.wav?alt=media&token=fafe41de-0bbe-4390-bca7-4aff74e070e3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17120%20-%20diag_mp_mirage_glad_introSeq_16_qw_3p.wav?alt=media&token=d77f1d3d-5ee8-445c-b3d7-bcd7ee806a30',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17122%20-%20diag_mp_mirage_glad_introSeq_17_qw_1p.wav?alt=media&token=0512c761-e8b8-44cc-8466-cd6c0a6ff0d3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17125%20-%20diag_mp_mirage_glad_introSeq_18_qw_1p.wav?alt=media&token=c67fed91-9921-466f-8af4-6cc995f8f76e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17128%20-%20diag_mp_mirage_glad_introSeq_19_qw_1p.wav?alt=media&token=bd482dce-2141-4029-9fc4-57f5ab4c047a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17132%20-%20diag_mp_mirage_glad_introSeq_20_qw_3p.wav?alt=media&token=82bf0dbe-f9f8-42fa-9b90-399d88f92065',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17135%20-%20diag_mp_mirage_glad_introSeq_21_qw_3p.wav?alt=media&token=7fe9393c-065f-4610-86de-d800ff811067',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17148%20-%20diag_mp_mirage_glad_seasonOpen_qw_1p.wav?alt=media&token=d2383766-9728-40f8-8751-534ee529bea8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17150%20-%20diag_mp_mirage_glad_taunt_01_1p.wav?alt=media&token=a4e995e7-7f28-4690-9719-48f8158112aa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17156%20-%20diag_mp_mirage_glad_taunt_02_1p.wav?alt=media&token=80dcf0e7-9726-451b-83ba-a3889ff5a9cd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17159%20-%20diag_mp_mirage_glad_taunt_03_1p.wav?alt=media&token=fb64bf1a-c807-4c25-8c5e-a78e94eedb55',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17162%20-%20diag_mp_mirage_glad_taunt_04_1p.wav?alt=media&token=2efc49e7-6fcc-444b-afe0-05089f1fc55b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17165%20-%20diag_mp_mirage_glad_taunt_05_1p.wav?alt=media&token=e37f743c-6539-4d93-b76d-1b6d5eb31f77',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17168%20-%20diag_mp_mirage_glad_taunt_06_1p.wav?alt=media&token=17cb3993-74b2-42c9-b2e9-35ee4aefff5c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17171%20-%20diag_mp_mirage_glad_taunt_07_1p.wav?alt=media&token=9d746832-8e43-4a1d-b78a-e111ef89c337',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17175%20-%20diag_mp_mirage_glad_taunt_08_3p.wav?alt=media&token=37a786bb-08fc-4130-a192-106332c97028',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17177%20-%20diag_mp_mirage_glad_taunt_09_1p.wav?alt=media&token=8cc12eaa-8b60-4694-ab73-c03a053b7d81',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17180%20-%20diag_mp_mirage_glad_taunt_10_1p.wav?alt=media&token=2313aa4d-ff38-4a86-b668-f715f1b61930',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17183%20-%20diag_mp_mirage_glad_taunt_11_1p.wav?alt=media&token=7b3e494b-76d8-423b-aca5-5374d4d80535',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17186%20-%20diag_mp_mirage_glad_taunt_12_1p.wav?alt=media&token=197ab040-71cb-42b2-abd0-2dbca5c9ecbe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17189%20-%20diag_mp_mirage_glad_taunt_13_1p.wav?alt=media&token=5f8330cc-e57a-4c54-b269-e3be00783593',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17192%20-%20diag_mp_mirage_glad_taunt_14_1p.wav?alt=media&token=4af3940b-321c-4627-9539-7875952c6e92',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17195%20-%20diag_mp_mirage_glad_taunt_15_1p.wav?alt=media&token=e59ec5f9-b421-4f01-9146-a74ffbbc2674',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17198%20-%20diag_mp_mirage_glad_taunt_16_1p.wav?alt=media&token=4317d2b6-2c00-4417-bf67-747041fa8abc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17201%20-%20diag_mp_mirage_glad_taunt_17_1p.wav?alt=media&token=e81869ef-3d95-44cb-9627-3e5ce84c3c05',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17204%20-%20diag_mp_mirage_glad_taunt_18_1p.wav?alt=media&token=328e8beb-2663-451f-842f-4230c99af194',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17207%20-%20diag_mp_mirage_glad_taunt_19_1p.wav?alt=media&token=fd5faced-cfc1-4f49-a9e0-fe893f7076d2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17211%20-%20diag_mp_mirage_glad_taunt_20_3p.wav?alt=media&token=9013fc5b-0c2b-4f86-9939-4fd1db28baa1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17213%20-%20diag_mp_mirage_glad_taunt_21_1p.wav?alt=media&token=b5c6d0ab-96bc-49dc-8c96-c9ce3324d784',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17217%20-%20diag_mp_mirage_glad_taunt_22_3p.wav?alt=media&token=8ff49372-3171-45f3-91e5-8ac3facacfdc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17219%20-%20diag_mp_mirage_glad_taunt_23_1p.wav?alt=media&token=9cd08ea6-5833-4b59-a346-62cbbc499286',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17222%20-%20diag_mp_mirage_glad_taunt_24_1p.wav?alt=media&token=fbc16f5c-5ef1-4ed1-8e0b-35eb205468fb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17226%20-%20diag_mp_mirage_glad_taunt_25_3p.wav?alt=media&token=55ad75ad-b472-4a60-8a7f-f6a2b5e93c61',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17229%20-%20diag_mp_mirage_glad_taunt_26_3p.wav?alt=media&token=ff4b364b-6d98-46e9-b247-632ad2414e54',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17231%20-%20diag_mp_mirage_glad_taunt_27_1p.wav?alt=media&token=8d87570c-a268-4549-be8c-019278a8332e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17234%20-%20diag_mp_mirage_glad_taunt_28_1p.wav?alt=media&token=7dc9dc3f-6e5f-4970-9ec0-e90831fec0a0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17237%20-%20diag_mp_mirage_glad_taunt_29_1p.wav?alt=media&token=f0183c78-2e21-4d71-98e6-fb9f692006a5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17241%20-%20diag_mp_mirage_glad_taunt_30_3p.wav?alt=media&token=48d1bc1d-a02f-40e6-ae80-5bf01b9ff4c9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17246%20-%20diag_mp_mirage_glad_taunt_32_1p.wav?alt=media&token=78ac90e2-f1bb-4dd3-a42d-559492f9fbca',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17250%20-%20diag_mp_mirage_glad_taunt_33_3p.wav?alt=media&token=96897f55-c5da-49e6-b9fa-8a3d2bb876c2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17252%20-%20diag_mp_mirage_glad_taunt_34_1p.wav?alt=media&token=0716bf62-0d6e-49e9-b74b-14066d28cce2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17255%20-%20diag_mp_mirage_glad_taunt_35_1p.wav?alt=media&token=1e7bd5a2-dab0-4074-8e50-cb6162901e63',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17259%20-%20diag_mp_mirage_glad_taunt_36_3p.wav?alt=media&token=58ec9315-ce0f-42ac-8a43-e1b1734f33dd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17261%20-%20diag_mp_mirage_glad_taunt_37_1p.wav?alt=media&token=6d13fe25-4a9f-4f6a-9b2c-eaa80b6aa291',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17264%20-%20diag_mp_mirage_glad_taunt_38_1p.wav?alt=media&token=d23ee3d8-c45f-4e35-a0ad-5764fc5d5345',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17270%20-%20diag_mp_mirage_glad_taunt_40_1p.wav?alt=media&token=b053e724-26de-46d8-b0f0-e3883fa430bc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17273%20-%20diag_mp_mirage_glad_taunt_41_1p.wav?alt=media&token=cd2b2480-4536-4fd0-9dd8-282420891cdb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17276%20-%20diag_mp_mirage_glad_tauntHalloween_01_1p.wav?alt=media&token=2e0b4793-51d0-4bdd-85eb-5fed776c6ee4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17280%20-%20diag_mp_mirage_glad_tauntHalloween_02_3p.wav?alt=media&token=076db04b-fca8-4da7-8b97-a6d17a0cd000',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17282%20-%20diag_mp_mirage_glad_tauntValentines_01_1p.wav?alt=media&token=9d07783c-f34f-4eb3-8a8b-c71d85632a87',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17286%20-%20diag_mp_mirage_glad_tauntValentines_02_3p.wav?alt=media&token=198f3f26-8cce-4cad-88cf-4a4ebd998e1f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17288%20-%20diag_mp_mirage_glad_tauntWinter_01_1p.wav?alt=media&token=c70f4121-bc86-4045-9638-e1320b24bff1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/17292%20-%20diag_mp_mirage_glad_tauntWinter_02_3p.wav?alt=media&token=6ccc4ef4-c799-4f93-8d0f-26b9ea7466ce',
  ];

  final List<String> quipnames = [
    "That's what you get for stealing paradise lounge's bathroom key (NEW)",
    "First season and already kill leader",
    "That was the last one I came I saw I tried it worked",
    "Ah We lost one just you me and Shiela",
    "Gonna explore over here maybe find out Crypto's real identity",
    "Rookie Mistake thta's a big NO",
    "Would all noobie gearheads just hold their horses",
    "Wait Wait",
    "You got it gearhead",
    "Oh Sorry looks like i didn't know my own strength sorry ",
    "Guns who needs Guns I don't ",
    "Mirage hits enemy with heirloom ",
    "Eh if the scary murder bot doesn't want to say thank you scary murder bot doesn't have too ",
    "Oh you I love our banter,He is gonna eat me isn't he? ",
    "Tryna give these guys a piece of my mind and ",
    "I will take a piece of hat,piece or the whole thing,you know ",
    "You want a piece I got a piece,Now i just have to get out of here alive ",
    "You want a piece we got a piece,now let's get ot of here alive ",
    "You got bamboozled ",
    "Bam goes the boozzle ",
    "All right we are with the new kill leader,Wait it's the robot?? ",
    "Look at me Look at me ",
    "Guys look at this,Guys look look look ",
    "So I might actually feel bad if you die so let's just not do that right ",
    "You know if this were a movie,you would kiss me amdly we would fall in love and live happily ever after ",
    "It's okay I got you,you know that CPR ",
    "It's okay no need to thank me,little kid ",
    "Wow glad you were here buddy yeah ",
    "NO NO Yoou could have just let me die crypto,so so dumb ",
    "Wow that was close,like I actually died close let's not talk about this ",
    "And I'm back did everybody miss me,Yeah you did ",
    "We lost the objective,I blame the robot ",
    "Crap really we lost the objective ",
    "Oh great,I lost the objective maybe nobody will ever notice ",
    "It's ours now the obejctive the objective is ",
    "Ok got the objective no need to thank me ",
    "Look who's the kill leader you see that crypto you see ",
    "They found you Crypto run ",
    "Shot a cargobot,Sorry if that was your friend Path sorry ",
    'Come see me after for 50% off on mirage costumes',
    'I love when the spotlight\'s on me',
    'We are all having a good time, especially me',
    'C\'mon you cant forget this face',
    'I\'m even better face to face',
    'I will see you in the ring',
    'You are gonna see a lot of me',
    'Don\'t worry im just perfect',
    'Who wants to step up anyone',
    'This is such an honour',
    'I\'m here you are not',
    'This is good,This is good,Let\'s fight',
    'I\'m so proud of myself',
    'Want advice I will give some advice',
    'Good Squad  means good wins means good times',
    'Anyone wanna take me out come find me',
    'This is like a dream',
    'My squads gonna beat up your squad',
    'I\'m speechless you know what i wrote a speech',
    'I did\'nt get here alone',
    'The heart of victory is in the squad',
    'Hope you are ready for some fun',
    'It\'s opening season gotta love it',
    'You should have known that fighting me is',
    'Not bad if i didn\'t had to kill ya i will hire ya',
    'It\'s a bad situation for you',
    'Did i confuse you',
    'You did good',
    'You jumped you ran you shot a thing maybe',
    'I\'m good I\'m good',
    'Listen you chose to fight me',
    'You better not come back to haunt me',
    'Okay i wil be nice you weren\'t too bad',
    'We had fun',
    'This was just a lovely time thank you for this',
    'This is one way to make memories',
    'Gotta admit i may have tricked you',
    'You can\'t take this personally',
    'Sometimes you loose, Sometimes you me',
    'Noone had your back huh, I hate when that happens',
    'Good fight Good fight',
    'I\'m proud to have fought with you',
    'If you ever want tips just give me a call',
    'This was rough for you, next time maybe',
    'I got ya',
    'This one was really good fight',
    'Thank you for this I feel much better',
    'You should have loose to the ring',
    'This is how it goes you win you loose you die',
    'Trust me loosing ain\'t that bad',
    'Quiting is for loosers',
    'Until we meet again buddy',
    'You got bamboozled',
    'You know if you ask me',
    'Don\'t blame yourself i deserve the credit',
    'Free tip,just try a little bit harder',
    'Wasn\'t the thrill of victory in itself',
    'I\'m good but there\'s two of me so I\'m good twice',
    'It\'s not all that bad',
    'You gotta take the good with the bad',
    'I will tell you this much you did make me break a sweat',
    'Most of the time one is better than the other',
    'Ding Dong! Trick or Trick',
    'Looks like I\'m the one doing the haunting this time',
    'Come back if you are lookin for',
    'Not gonna lie this is probably the best date',
    'Long winter more like long winner',
    'Here\'s the story',
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
              title: Text(
            'Mirage' + ' Quips',
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
                          child: Image.asset("assets/images/mirage.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Mirage Quips",
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
