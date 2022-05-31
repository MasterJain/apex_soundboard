import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class Octane extends StatefulWidget {
  @override
  _OctaneState createState() => _OctaneState();
}

class _OctaneState extends State<Octane> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_octane_glad_tauntOrigin_01_01_3p.wav?alt=media&token=0c7838f8-2b09-4633-88d0-385470c71eca",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F19270%20-%20diag_mp_octane_bc_revivingPlayer_condBangalore_1p.wav?alt=media&token=0ebfb3cf-0de5-40ae-9762-3a5470c2db54",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F20334%20-%20diag_mp_octane_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=cb9f7615-7ac5-41ec-9cf9-2c64015329ab",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2Foctane2.mp3?alt=media&token=966c36f7-4d14-481d-9739-144cbe7fb1e5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F20108%20-%20diag_mp_octane_ping_supplyBinExtended_calm_condLifeline_3p.wav?alt=media&token=e7bde71f-c2a7-4795-9333-e87285ee0846",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18781%20-%20diag_mp_octane_bc_twoSquaddiesLeft_condLifeline_3p.wav?alt=media&token=44d50d31-145e-4cdc-ba43-47a9b734d08f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18770%20-%20diag_mp_octane_bc_thIntro_solo.wav?alt=media&token=3576471c-c70a-4cc8-b5b9-edfb26a82376",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18769%20-%20diag_mp_octane_bc_thIntro_3p.wav?alt=media&token=2c8e3f46-7496-432b-8b1f-942cc602161e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18768%20-%20diag_mp_octane_bc_thIntro_1p.wav?alt=media&token=4f75c6a5-424b-4968-8f9c-41990e71513d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18758%20-%20diag_mp_octane_bc_thCompleted_solo.wav?alt=media&token=e677860d-882e-413f-bd55-93bae4612c4d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18756%20-%20diag_mp_octane_bc_thCompleted_1p.wav?alt=media&token=24c35a6f-d539-4d2f-9921-d9fbbeb15ed9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18735%20-%20diag_mp_octane_bc_squadmateBecomesKillLeader_condLifeline_3p.wav?alt=media&token=c5db042e-6a09-482e-b961-28c0a5e6613a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18734%20-%20diag_mp_octane_bc_squadmateBecomesKillLeader_condLifeline_1p.wav?alt=media&token=46c272fe-472a-46d4-bde9-13e4e7323916",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18723%20-%20diag_mp_octane_bc_revivingPlayer_condLifeline_3p.wav?alt=media&token=930c3f43-0af6-4d28-a288-c1876761cd0c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18722%20-%20diag_mp_octane_bc_revivingPlayer_condLifeline_1p.wav?alt=media&token=c98752ca-572c-4795-9e90-6c605f770746",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18718%20-%20diag_mp_octane_bc_reviveThanks_condLifeline_1p.wav?alt=media&token=14c09276-bebf-405b-bf3b-cf4d797c11a5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18715%20-%20diag_mp_octane_bc_reviveSelf_3p.wav?alt=media&token=ee578ace-e583-418e-be5b-89034e66d14b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18714%20-%20diag_mp_octane_bc_reviveSelf_1p.wav?alt=media&token=09ed711d-85be-410b-bed0-4a229ad1fa2e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18706%20-%20diag_mp_octane_bc_podLeaderLaunch_3p.wav?alt=media&token=0db43828-c5d2-4b0e-89e9-ac4cc31610c7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18705%20-%20diag_mp_octane_bc_podLeaderLaunch_1p_template.wav?alt=media&token=be535119-4277-4613-8a2e-30b9d0f3f261",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18704%20-%20diag_mp_octane_bc_podLeaderLaunch_1p.wav?alt=media&token=eca10cd6-a1c1-4a12-a7d6-3989b475ae9b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18699%20-%20diag_mp_octane_bc_objectiveLostSelf_3p.wav?alt=media&token=f925f7e0-5d36-49ac-860c-ac4f21fee8c6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18697%20-%20diag_mp_octane_bc_objectiveHaveSquad_3p.wav?alt=media&token=cdd9c101-1cd8-4f50-bd59-c170c3cae60d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18695%20-%20diag_mp_octane_bc_objectiveHaveSelf_3p.wav?alt=media&token=f423918d-eb9b-4e69-afd0-54532d16d7bc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18668%20-%20diag_mp_octane_bc_iKilledAnEnemyWithHeirloom_3p.wav?alt=media&token=6da29124-3ea1-4747-807b-8b39960fd900",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18667%20-%20diag_mp_octane_bc_iKilledAnEnemyWithHeirloom_1p.wav?alt=media&token=3b358f49-b742-4a4b-b52c-f180772f17b4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18656%20-%20diag_mp_octane_bc_iBecomeKillLeader_condLifeline_3p.wav?alt=media&token=526287d9-8440-4449-834e-2614268305ad",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Foctane%2F18652%20-%20diag_mp_octane_bc_healing_condLifeline_3p.wav?alt=media&token=3c9c96fb-c186-43a1-8f28-d46a67018153",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18813%20-%20diag_mp_octane_glad_introHalloween_01_qw_1p.wav?alt=media&token=90df9426-4c05-41eb-acde-4c28772fd026',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18816%20-%20diag_mp_octane_glad_introHeirloom_01_qw_1p.wav?alt=media&token=52f7eb92-0c09-487a-af56-3545ba1698b5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18822%20-%20diag_mp_octane_glad_introSeq_01_qw_3p.wav?alt=media&token=10d21445-3a38-4a9d-a8d7-9b6911d03aeb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18826%20-%20diag_mp_octane_glad_introSeq_02_qw_1p.wav?alt=media&token=5c22aa58-ac1d-498a-ae24-98109a9abfef',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18830%20-%20diag_mp_octane_glad_introSeq_03_qw_3p.wav?alt=media&token=16e77c70-210d-4ee2-a03c-becc8c9fdf67',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18832%20-%20diag_mp_octane_glad_introSeq_04_qw_1p.wav?alt=media&token=063efe43-546b-4a57-864b-cda61a0d9a12',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18835%20-%20diag_mp_octane_glad_introSeq_05_qw_1p.wav?alt=media&token=68d6f232-4c63-4479-b56e-db8b29bd47a9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18838%20-%20diag_mp_octane_glad_introSeq_06_qw_1p.wav?alt=media&token=3576b065-bb8c-41a8-91bd-b037919c3fd5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18841%20-%20diag_mp_octane_glad_introSeq_07_qw_1p.wav?alt=media&token=91a7c051-e161-4c8a-b476-9a600a110bf9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18845%20-%20diag_mp_octane_glad_introSeq_08_qw_3p.wav?alt=media&token=aeb83fbe-2baf-413d-a774-c641196b35b7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18847%20-%20diag_mp_octane_glad_introSeq_09_qw_1p.wav?alt=media&token=fc453bd4-fec0-4111-b5dc-566536c84ba1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18850%20-%20diag_mp_octane_glad_introSeq_10_qw_1p.wav?alt=media&token=3eefbf38-000c-4276-8cd3-b48045c5881e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18854%20-%20diag_mp_octane_glad_introSeq_11_qw_3p.wav?alt=media&token=d999589f-4035-4680-bc7a-ec560c0833ba',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18856%20-%20diag_mp_octane_glad_introSeq_12_qw_1p.wav?alt=media&token=57f922b8-20a1-4c01-aa95-948b089ee407',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18860%20-%20diag_mp_octane_glad_introSeq_13_qw_3p.wav?alt=media&token=45d61a0d-3d68-4c52-b19f-deafde029009',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18863%20-%20diag_mp_octane_glad_introSeq_14_qw_3p.wav?alt=media&token=f9673b1e-31f6-4fb3-b00e-a0049e3944cc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18866%20-%20diag_mp_octane_glad_introSeq_15_qw_3p.wav?alt=media&token=0f3a41e9-68d1-4b43-b664-c51a8e1cc884',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18869%20-%20diag_mp_octane_glad_introSeq_16_qw_3p.wav?alt=media&token=554341d8-5747-4370-ad70-f4b002555a94',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18871%20-%20diag_mp_octane_glad_introSeq_17_qw_1p.wav?alt=media&token=31522a48-309f-40d4-8b45-b46179fca14f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18874%20-%20diag_mp_octane_glad_introSeq_18_qw_1p.wav?alt=media&token=1ef05f68-10ba-41ed-851b-be3c6edff47e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18878%20-%20diag_mp_octane_glad_introSeq_19_qw_3p.wav?alt=media&token=ab60d511-0651-4584-9ee8-6eff3a2720db',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18881%20-%20diag_mp_octane_glad_introSeq_20_qw_3p.wav?alt=media&token=8dbbefed-f3ea-42f4-a216-7568a979cc0f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18884%20-%20diag_mp_octane_glad_introSeq_21_qw_3p.wav?alt=media&token=38b23ebf-9f87-4ef2-bf6f-742cd62d339d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18897%20-%20diag_mp_octane_glad_seasonOpen_qw_1p.wav?alt=media&token=87b958c3-b0e4-45d7-a52a-8a3bddab73b7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18899%20-%20diag_mp_octane_glad_taunt_01_1p.wav?alt=media&token=e1186c25-d398-4ab1-8fa8-807101567e61',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18905%20-%20diag_mp_octane_glad_taunt_02_1p.wav?alt=media&token=6626cb3e-81bf-4dc5-a7d4-b4204b1e8e90',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18908%20-%20diag_mp_octane_glad_taunt_03_1p.wav?alt=media&token=d106c976-c65e-4ea2-aad5-8f1319f8e9fc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18912%20-%20diag_mp_octane_glad_taunt_04_3p.wav?alt=media&token=bc2ecd91-d0f7-4d5b-8a7f-fa8da9e56fef',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18914%20-%20diag_mp_octane_glad_taunt_05_1p.wav?alt=media&token=79dc6623-5b87-4e0c-a2d6-8e3fddbebfcb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18917%20-%20diag_mp_octane_glad_taunt_06_1p.wav?alt=media&token=ca2beb26-7ee6-4a8d-a018-65718f5b1904',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18920%20-%20diag_mp_octane_glad_taunt_07_1p.wav?alt=media&token=6aef817c-b064-4804-877a-b144eba7198c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18924%20-%20diag_mp_octane_glad_taunt_08_3p.wav?alt=media&token=f85d319d-d4f7-4485-a1e0-678dfee3bbbe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18926%20-%20diag_mp_octane_glad_taunt_09_1p.wav?alt=media&token=82d3e921-807e-4fc9-a9bb-5408bc12baa2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18929%20-%20diag_mp_octane_glad_taunt_10_1p.wav?alt=media&token=c2afcdbb-ede9-4589-b68d-d7e4b62e47b5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18933%20-%20diag_mp_octane_glad_taunt_11_3p.wav?alt=media&token=9673863e-2057-497d-b8f6-6ee89bea286a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18935%20-%20diag_mp_octane_glad_taunt_12_1p.wav?alt=media&token=53824067-e451-466e-8560-b2e571f275a0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18939%20-%20diag_mp_octane_glad_taunt_13_3p.wav?alt=media&token=f11340f4-1370-44eb-b297-1964f3eff91a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18941%20-%20diag_mp_octane_glad_taunt_14_1p.wav?alt=media&token=fea80400-ccc0-48fb-bdcb-d438cfb0491e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18945%20-%20diag_mp_octane_glad_taunt_15_3p.wav?alt=media&token=2d9c1443-ceb6-47bb-a667-ed11befa0277',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18947%20-%20diag_mp_octane_glad_taunt_16_1p.wav?alt=media&token=a7a8e100-c255-49ea-883d-084efb3b36b5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18950%20-%20diag_mp_octane_glad_taunt_17_1p.wav?alt=media&token=90289326-9364-46b2-94f8-b94b565a40b3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18953%20-%20diag_mp_octane_glad_taunt_18_1p.wav?alt=media&token=48008f9c-f534-471f-8645-963a321fed1a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18956%20-%20diag_mp_octane_glad_taunt_19_1p.wav?alt=media&token=e72f4b2d-2375-44c9-9b5d-7641efd0bbfb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18960%20-%20diag_mp_octane_glad_taunt_20_3p.wav?alt=media&token=1a7aaca0-cae3-4332-b26b-da231cf23961',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18962%20-%20diag_mp_octane_glad_taunt_21_1p.wav?alt=media&token=a709d35b-e2c7-46b9-95ef-4ec8b4044601',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18966%20-%20diag_mp_octane_glad_taunt_22_3p.wav?alt=media&token=f9c11ab3-1258-4f2f-a3d5-2542c7272afd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18969%20-%20diag_mp_octane_glad_taunt_23_3p.wav?alt=media&token=59372d56-5c28-4611-8244-409b630c9ed6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18972%20-%20diag_mp_octane_glad_taunt_24_3p.wav?alt=media&token=241d4085-a45f-4251-a494-831e5d608a6a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18974%20-%20diag_mp_octane_glad_taunt_25_1p.wav?alt=media&token=4e6bad78-6893-4851-b468-66dca8caeb4c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18977%20-%20diag_mp_octane_glad_taunt_26_1p.wav?alt=media&token=a359bc18-3a32-484c-9982-cf01df7c8bb8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18980%20-%20diag_mp_octane_glad_taunt_27_1p.wav?alt=media&token=212cd19b-b58d-499e-b4b5-89c271bfdfba',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18983%20-%20diag_mp_octane_glad_taunt_28_1p.wav?alt=media&token=38bfb148-9da1-4f87-83c6-ab4eac11b371',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18986%20-%20diag_mp_octane_glad_taunt_29_1p.wav?alt=media&token=a8437119-474a-46b7-b73a-b7a94853f26c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18990%20-%20diag_mp_octane_glad_taunt_30_3p.wav?alt=media&token=7c6ea529-8323-4428-bd7e-c717f664a64e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18992%20-%20diag_mp_octane_glad_taunt_31_1p.wav?alt=media&token=bccf8423-2b52-47da-b132-9cb41676f89f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18995%20-%20diag_mp_octane_glad_taunt_32_1p.wav?alt=media&token=23c05415-5a7d-492d-a147-24ba189ead7d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/18998%20-%20diag_mp_octane_glad_taunt_33_1p.wav?alt=media&token=2df6acf3-64cc-4a51-a356-c91e32dcf8ea',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19001%20-%20diag_mp_octane_glad_taunt_34_1p.wav?alt=media&token=030b905b-c4d5-40cb-9784-5deb5ce03f90',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19004%20-%20diag_mp_octane_glad_taunt_35_1p.wav?alt=media&token=747e1987-4de5-43ed-8910-5a6bae89c465',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19007%20-%20diag_mp_octane_glad_taunt_36_1p.wav?alt=media&token=4395b480-0f15-4cd8-9f17-0a3561a582b2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19010%20-%20diag_mp_octane_glad_taunt_37_1p.wav?alt=media&token=a9927a2e-4f03-46a1-82b6-f79c29f00f02',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19013%20-%20diag_mp_octane_glad_taunt_38_1p.wav?alt=media&token=d3e1c9db-fb7d-4f59-a096-2f7dda9f7c55',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19016%20-%20diag_mp_octane_glad_taunt_39_1p.wav?alt=media&token=7d789bbc-e9a8-4cac-8eb1-21ecd8d38ea3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19020%20-%20diag_mp_octane_glad_taunt_40_3p.wav?alt=media&token=87b7b1ad-a958-47e1-8918-0b1af31285e7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19022%20-%20diag_mp_octane_glad_taunt_41_1p.wav?alt=media&token=94b462dc-0a05-48f0-bb05-a2296d4de96b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19025%20-%20diag_mp_octane_glad_tauntHalloween_01_1p.wav?alt=media&token=156b3a97-f2a8-46d4-ad4f-c98963c715ec',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19028%20-%20diag_mp_octane_glad_tauntHalloween_02_1p.wav?alt=media&token=5c303e74-781b-4cb9-b408-3d6d5db31bfb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19032%20-%20diag_mp_octane_glad_tauntValentines_01_3p.wav?alt=media&token=0dd67fa8-b30b-498d-8712-deec672d35a1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19034%20-%20diag_mp_octane_glad_tauntValentines_02_1p.wav?alt=media&token=947aff36-ab37-41c8-a8c2-f6a53a26c4d1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19037%20-%20diag_mp_octane_glad_tauntWinter_01_1p.wav?alt=media&token=e662a64b-3c82-4fb8-8884-5d28f34bf4f7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/19040%20-%20diag_mp_octane_glad_tauntWinter_02_1p.wav?alt=media&token=c0c3067b-192a-488e-beb5-3a747ac10b15',
  ];

  final List<String> quipnames = [
    "I would have kicked your ass without better legs (NEW)",
    "Call me Oscar Mike because I got you lady",
    "Hey,you and Che should be together it will be like two sticks in the mud ",
    "Piece of advice amigo,Wanna go faster loose the loin cloth ",
    "Extended Supply Bin here,Che Chica come do that thing you do ",
    "Just you and me now Heremana,It's like old times ",
    "Gotta find that piece or i could just keep running till I trip on it ",
    "All right we got a piece to find,bet I get there first ",
    "Let's see how fast we can find that piece,compadres ",
    "Got the piece and I'm already bored ",
    "Got the piece go go go ",
    "Oh Chica! You are the new kill leader,I didn't new you had it in you ",
    "Mira! Che is the new Kill Leader ",
    "Anything broken Chica? I got a guy who can give you some upgrades ",
    "Hey Heramana,Shouldn't you be the one picking me up",
    "Knew I could count on you Chica ",
    "And I'm back in the game ",
    "Naptimes over ",
    "Can you feel the speed yeah baby ",
    "Non terre plus ultra ",
    "Spanish Mumble ",
    "Oh hells no I lost the obejctive ",
    "Objective is ours,Woohoo ",
    "I got it,If the enemy wants the objective they will have to catch me first ",
    "Octane kills with heirloom and mumbles in spanish ",
    "They thought they could get the jump on me ",
    "You are looking at the new kill leader,Che check it out I'm good at this ",
    "Using meds,see that Che Still alive ",
    'You think I look cool now you should see me with a sugarrush',
    'Run Fast Hit Fast Win Fast',
    'Catch me if you can',
    'Mira Check out that giant banner of me',
    'Haven\'t we landed yet what\'s the hold up',
    'Time is flying and I\'m too',
    'I can see all of you in the rearview mirror',
    'See that blur right before you bite it that\'s me',
    'I do this for the rush',
    'My legs are ready to go',
    'They say death catches upto everyone,he can certainly try',
    'You are ready for the octrain',
    'The good news is that with me,everything will be over quick',
    'I like the wind in my hair bugs in my teeth',
    'I\'m going up and you are going down',
    'Come by Casa\'de Octane for a cold one',
    'Just wanna give a shoutout to all my fans watching',
    'By the time you see me coming i will be going',
    'Don\'t worry about my legs getting tired',
    'Better watch your front,I\'m always in the lead',
    'You think I\'m afraid of you',
    'I make it look easy but I\'m still the champ',
    'You better run make it interesting',
    'The seasons open amigos here we go',
    'Downlo too slow',
    'Never saw me coming did\'ya?',
    'I would say eat my dust but you are already dead Amigo',
    'Say cheese for all my followers',
    'Why does it have to be over so soon',
    'That was crazy fun whose next',
    'Do you feel that aderniline surging through your veins',
    'Dude,you should totaly go respawn so we could do that again',
    'Oh that was incredible!',
    'Don\'t worry i got a prosthetic guy',
    'Man you even die slow,Hurry up',
    'Next time give me a challenge',
    'You need to move faster than that amigo speed is life',
    'That looked like it hurt but what a rush',
    'The stories got it wrong,hare crushes tortoise everytime',
    'You didn\'t even look like you were having fun,Lighten up Amigo',
    'We should do that again only next time even faster',
    'Wow that was intense',
    'How awesome was that rush for me I mean,for you?Not so much',
    'Mira,It\'s a lot easier to stay alive if you actually run',
    'You are quicker than i thought too bad I\'m quickerer',
    'Piece of advice',
    'You can\'t outrun the Octrain',
    'Why so slow break a leg or something?',
    'Sorry about that Amigo',
    'I hope I got all that on camera',
    'Death keeps chasing me',
    'Not to quick on the uptake or you?',
    'Non terre plus ultra',
    'Nouve morre Nouve Marre',
    'Mira Amigo maybe lay off caffiene',
    'I could do this all day',
    'I\'m quick and you are dead',
    'Sick death dude',
    'That was intense',
    'I could run circles around you allday',
    'That sucks for you compadre',
    'That\'s a win for me Amigo',
    'That wasn\'t you life flashing before your eyes,That was me',
    'And that\'s what you get for trying to outrun me',
    'Mira it\'s not about how hard you tried,It\'s about who wins',
    'No treats for you compadre better luck next time',
    'It was this or',
    'That got my heart pounding,did you feel it too?',
    'That was Amazing',
    'Cold Compadre,You will warmup in the respawn chamber if you are lucky',
    'When you hit black eyes',
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

        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
              title: const Text(
            'Octane Quips',
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
                          child: Image.asset("assets/images/octane.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Octane Quips",
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
