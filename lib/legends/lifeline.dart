import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class Lifeline extends StatefulWidget {
  @override
  _LifelineState createState() => _LifelineState();
}

class _LifelineState extends State<Lifeline> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_lifeline_glad_tauntMutation_01_01_1p.wav?alt=media&token=48c5bd9e-5e7d-480a-a797-7d6635f2f621",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_lifeline_glad_taunt_50_02_3p.wav?alt=media&token=a1b4091f-64a7-4b65-85b4-986bf658ce5b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_lifeline_glad_tauntOrigin_01_01_1p.wav?alt=media&token=e4e12e77-eff9-4d80-b422-e97ea4cab369",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F14846%20-%20diag_mp_lifeline_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=ea6c9d98-38ac-4340-9ca1-e3ab6f1dc709",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2Flifeline2.mp3?alt=media&token=1f4c81a1-81f1-49fd-b5a4-9156e7b3606d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F14212%20-%20diag_mp_lifeline_ping_jumpPad_calm_condOctane_3p.wav?alt=media&token=804f7e41-9143-4783-bd21-772d451fb0dc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F14205%20-%20diag_mp_lifeline_ping_iWillJoin_calm_condOctane_1p.wav?alt=media&token=fcba3c5b-dcc2-40b1-a4ad-7d555bb1e0ce",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13298%20-%20diag_mp_lifeline_bc_twoSquaddiesLeft_condOctane_3p.wav?alt=media&token=042994d1-a5a9-45fe-8c7b-629ac1bf4c14",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13287%20-%20diag_mp_lifeline_bc_thIntro_solo.wav?alt=media&token=e82b95c9-384e-4de4-b532-5966f6729422",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13286%20-%20diag_mp_lifeline_bc_thIntro_3p.wav?alt=media&token=39bea9f3-e51a-492e-8e48-7c4868cb0e80",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13285%20-%20diag_mp_lifeline_bc_thIntro_1p.wav?alt=media&token=a41a7c08-4d3e-4a55-9819-669a839474eb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13275%20-%20diag_mp_lifeline_bc_thCompleted_solo.wav?alt=media&token=ff6776e3-5a4c-44dd-9895-78aaa60db6fd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13274%20-%20diag_mp_lifeline_bc_thCompleted_3p.wav?alt=media&token=f359696c-4b4e-47e2-a420-d3b27d4120f8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13245%20-%20diag_mp_lifeline_bc_skydive_1p.wav?alt=media&token=64c7405c-bafa-4a42-89d1-8640b252efe3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13236%20-%20diag_mp_lifeline_bc_reviveThanks_condOctane_3p.wav?alt=media&token=901a8ccb-bdda-42f5-9767-a10db64fddd5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13232%20-%20diag_mp_lifeline_bc_reviveSelf_3p.wav?alt=media&token=be3b251c-0414-430c-b62f-e92551063bd5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13216%20-%20diag_mp_lifeline_bc_objectiveLostSquad_3p.wav?alt=media&token=5bf9e5a3-99cc-4703-9a65-ee067d87573f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13213%20-%20diag_mp_lifeline_bc_objectiveLostSelf_1p.wav?alt=media&token=ed2c620c-cb68-4ee3-bdcb-8256ee5bbdaf",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13212%20-%20diag_mp_lifeline_bc_objectiveHaveSquad_3p.wav?alt=media&token=93b65c02-8265-4b79-81f6-63b96caab25b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13209%20-%20diag_mp_lifeline_bc_objectiveHaveSelf_1p.wav?alt=media&token=6fa1660a-2394-4c8a-bf2c-5fb045964208",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13185%20-%20diag_mp_lifeline_bc_iKilledAnEnemyWithheirloom_3p.wav?alt=media&token=84546b74-d241-4b2d-8689-1a9baf2be499",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13184%20-%20diag_mp_lifeline_bc_iKilledAnEnemyWithheirloom_1p.wav?alt=media&token=565a9877-eb9b-4c18-bc98-30affab01618",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13167%20-%20diag_mp_lifeline_bc_frag_condOctane_3p.wav?alt=media&token=76d4e43e-e6d2-4daf-bbbe-1a8c45e9c06b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Flifeline%2F13166%20-%20diag_mp_lifeline_bc_frag_condOctane_1p.wav?alt=media&token=d1702d2f-db9b-4fad-ae38-5f13a1ab065d",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/moz.mp3?alt=media&token=6e912e69-9944-4ef7-8f6f-0a05f78c936b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13330%20-%20diag_mp_lifeline_glad_introHalloween_01_qw_1p.wav?alt=media&token=1933c491-da15-44f4-84d3-ac8d104e5941',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13333%20-%20diag_mp_lifeline_glad_introHeirloom_01_qw_1p.wav?alt=media&token=98e706b9-3bf2-4984-9832-41f1fd8c30d3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13338%20-%20diag_mp_lifeline_glad_introSeq_01_qw_1p_template.wav?alt=media&token=878c72e3-1ae6-4a34-80f1-70b4c2b97f42',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13343%20-%20diag_mp_lifeline_glad_introSeq_02_qw_1p.wav?alt=media&token=5e801ff8-ec54-403f-a2be-478597ed324b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13346%20-%20diag_mp_lifeline_glad_introSeq_03_qw_1p.wav?alt=media&token=8bb8a745-079b-431a-b0a6-3063f07a1045',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13349%20-%20diag_mp_lifeline_glad_introSeq_04_qw_1p.wav?alt=media&token=8a576918-00fd-4b16-b748-c68d52318945',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13352%20-%20diag_mp_lifeline_glad_introSeq_05_qw_1p.wav?alt=media&token=77eaa8c9-9c3a-4a75-94ae-5bad387f018b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13356%20-%20diag_mp_lifeline_glad_introSeq_06_qw_3p.wav?alt=media&token=81641583-664d-4964-9956-f2a391cfea2e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13359%20-%20diag_mp_lifeline_glad_introSeq_07_qw_3p.wav?alt=media&token=00b4f5b3-a390-4c6e-b04e-d7952171e8c2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13361%20-%20diag_mp_lifeline_glad_introSeq_08_qw_1p.wav?alt=media&token=bd2a8f30-b4ba-4827-958f-7fde4bb05e2e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13365%20-%20diag_mp_lifeline_glad_introSeq_09_qw_3p.wav?alt=media&token=f9ffaeec-de2b-46b9-9a5b-cd43948a6c02',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13367%20-%20diag_mp_lifeline_glad_introSeq_10_qw_1p.wav?alt=media&token=19f8289f-d2b5-4ba8-9109-ef8f2a101411',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13370%20-%20diag_mp_lifeline_glad_introSeq_11_qw_1p.wav?alt=media&token=0b098776-3e3e-4745-9fcb-eb3ba60325ee',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13373%20-%20diag_mp_lifeline_glad_introSeq_12_qw_1p.wav?alt=media&token=9b36d720-4af2-4c31-9dfe-df53660d7a2e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13376%20-%20diag_mp_lifeline_glad_introSeq_13_qw_1p.wav?alt=media&token=77e03c5b-4b7e-4e9f-9ae1-6634a63565ac',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13379%20-%20diag_mp_lifeline_glad_introSeq_14_qw_1p.wav?alt=media&token=1a3097f1-1bdb-431a-82de-2066f19ac3ad',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13382%20-%20diag_mp_lifeline_glad_introSeq_15_qw_1p.wav?alt=media&token=c886cb95-db0c-4958-9e91-2755942f762d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13386%20-%20diag_mp_lifeline_glad_introSeq_16_qw_3p.wav?alt=media&token=cf04bc5b-2eda-44e8-b64e-ad21757c9e4f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13388%20-%20diag_mp_lifeline_glad_introSeq_17_qw_1p.wav?alt=media&token=0b6fafab-859c-4040-a14a-43a079b83249',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13392%20-%20diag_mp_lifeline_glad_introSeq_18_qw_3p.wav?alt=media&token=44df4906-7658-4132-be24-289c4474711e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13395%20-%20diag_mp_lifeline_glad_introSeq_19_qw_3p.wav?alt=media&token=a24fa41f-5237-448f-bd5d-d1b5013815f6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13398%20-%20diag_mp_lifeline_glad_introSeq_20_qw_3p.wav?alt=media&token=08ac4308-304d-439c-a24f-75fb462a3afd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13400%20-%20diag_mp_lifeline_glad_introSeq_21_qw_1p.wav?alt=media&token=638613db-7383-43b3-937b-e1468a276536',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13413%20-%20diag_mp_lifeline_glad_seasonOpen.wav?alt=media&token=ed43cbe7-726b-4df9-93e8-a6f107b4361d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13415%20-%20diag_mp_lifeline_glad_seasonOpen_qw_3p.wav?alt=media&token=ae1cf76c-ce51-492b-a700-c3906bb21951',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13417%20-%20diag_mp_lifeline_glad_taunt_01_1p_template.wav?alt=media&token=addf0f53-17fa-483b-aa4a-7156e46a7b26',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13423%20-%20diag_mp_lifeline_glad_taunt_02_3p.wav?alt=media&token=6566b295-6220-44b4-be46-16b1132d3565',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13426%20-%20diag_mp_lifeline_glad_taunt_03_3p.wav?alt=media&token=16926ffb-899b-42a6-bea3-83c1142f01f1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13429%20-%20diag_mp_lifeline_glad_taunt_04_3p.wav?alt=media&token=0681e243-279c-4321-bc19-4e65f4068bf8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13431%20-%20diag_mp_lifeline_glad_taunt_05_1p.wav?alt=media&token=c6a39cf2-8769-437f-bc54-35c2f895854e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13435%20-%20diag_mp_lifeline_glad_taunt_06_3p.wav?alt=media&token=245f02ba-c58e-405c-aa69-3652aaad4797',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13437%20-%20diag_mp_lifeline_glad_taunt_07_1p.wav?alt=media&token=02dfcaaf-f5f7-47ea-b9b9-2c917155c3d4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13441%20-%20diag_mp_lifeline_glad_taunt_08_3p.wav?alt=media&token=1fab359c-624b-4a03-93c9-a96d5cae1b65',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13444%20-%20diag_mp_lifeline_glad_taunt_09_3p.wav?alt=media&token=e39d06ce-c8d6-4813-af54-d7595677cfe5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13447%20-%20diag_mp_lifeline_glad_taunt_10_3p.wav?alt=media&token=feb81f84-60f5-425b-851e-11b7b39140ef',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13449%20-%20diag_mp_lifeline_glad_taunt_11_1p.wav?alt=media&token=731dc422-7c42-41d2-bbf1-a35acb543e4b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13452%20-%20diag_mp_lifeline_glad_taunt_12_1p.wav?alt=media&token=e0e236d1-abc7-4ef8-8035-2cf8c3ed1810',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13455%20-%20diag_mp_lifeline_glad_taunt_13_1p.wav?alt=media&token=8e9cd2b1-d42c-4970-980e-852e750ec0b6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13458%20-%20diag_mp_lifeline_glad_taunt_14_1p.wav?alt=media&token=a81cadb1-27d5-4a65-b423-db4882fb16c3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13461%20-%20diag_mp_lifeline_glad_taunt_15_1p.wav?alt=media&token=094e11da-4e3a-48d7-be62-0584de9237be',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13465%20-%20diag_mp_lifeline_glad_taunt_16_3p.wav?alt=media&token=9d432dbb-8b76-44a6-99b4-49650d3daf25',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13467%20-%20diag_mp_lifeline_glad_taunt_17_1p.wav?alt=media&token=a3e1cc9a-9431-4b2f-bced-edd73979978b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13471%20-%20diag_mp_lifeline_glad_taunt_18_3p.wav?alt=media&token=59baa556-039e-4c99-b32a-9bbc34c62323',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13474%20-%20diag_mp_lifeline_glad_taunt_19_3p.wav?alt=media&token=f3468c51-48f3-4600-83b7-11febc3afaf3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13476%20-%20diag_mp_lifeline_glad_taunt_20_1p.wav?alt=media&token=d183ebf3-d9ce-4b9c-8373-90f105d71544',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13480%20-%20diag_mp_lifeline_glad_taunt_21_3p.wav?alt=media&token=db7e167a-5fb4-42b5-9d73-093bf9daab10',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13483%20-%20diag_mp_lifeline_glad_taunt_22_3p.wav?alt=media&token=4e89bc3e-f85e-43ae-bd40-6d48564dc783',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13485%20-%20diag_mp_lifeline_glad_taunt_23_1p.wav?alt=media&token=dc0fecab-f21b-4c97-98f6-4ee784ad4934',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13489%20-%20diag_mp_lifeline_glad_taunt_24_3p.wav?alt=media&token=5bba1718-f735-45f2-9173-231b60894382',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13492%20-%20diag_mp_lifeline_glad_taunt_25_3p.wav?alt=media&token=c217e2c3-bda1-4068-96e7-c25766527c78',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13494%20-%20diag_mp_lifeline_glad_taunt_26_1p.wav?alt=media&token=cabc66f7-6a59-4a9c-86e1-fb727c7978d4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13497%20-%20diag_mp_lifeline_glad_taunt_27_1p.wav?alt=media&token=29cfe1fb-05d0-43e5-baf7-0206bc0bec78',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13500%20-%20diag_mp_lifeline_glad_taunt_28_1p.wav?alt=media&token=c6f4c043-2246-4fea-8a88-0ab63cfa1236',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13503%20-%20diag_mp_lifeline_glad_taunt_29_1p.wav?alt=media&token=0ceddc80-8d04-461c-8c57-dac45cca3007',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13506%20-%20diag_mp_lifeline_glad_taunt_30_1p.wav?alt=media&token=a2fd3d54-6141-4de3-b07a-97e3b2acbcfb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13509%20-%20diag_mp_lifeline_glad_taunt_31_1p.wav?alt=media&token=48cba15e-8b2c-4319-880b-50048436415b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13513%20-%20diag_mp_lifeline_glad_taunt_32_3p.wav?alt=media&token=8b2af9e4-6e6a-4724-aee1-5f8f54d7304f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13516%20-%20diag_mp_lifeline_glad_taunt_33_3p.wav?alt=media&token=a9506306-bb44-476f-9d64-f4dcb511da7c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13519%20-%20diag_mp_lifeline_glad_taunt_34_3p.wav?alt=media&token=5fe02953-3631-46d3-a67e-ac18a8e4445d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13521%20-%20diag_mp_lifeline_glad_taunt_35_1p.wav?alt=media&token=0c97cfba-7335-4e0c-ad5f-a390f6fad7af',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13525%20-%20diag_mp_lifeline_glad_taunt_36_3p.wav?alt=media&token=5b9b5a03-354e-4eb4-99ab-a2c27b18c733',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13527%20-%20diag_mp_lifeline_glad_taunt_37_1p.wav?alt=media&token=423e8cde-0152-4a12-b770-00a5d4e4c0fe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13530%20-%20diag_mp_lifeline_glad_taunt_38_1p.wav?alt=media&token=89c65a02-f8da-413a-ba6f-f974b617c616',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13533%20-%20diag_mp_lifeline_glad_taunt_39_1p.wav?alt=media&token=2cadc9d9-0846-4673-b3da-28cca044a5c3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13537%20-%20diag_mp_lifeline_glad_taunt_40_3p.wav?alt=media&token=5379e237-4729-43fe-92d1-f74e5a454e0d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13539%20-%20diag_mp_lifeline_glad_taunt_41_1p.wav?alt=media&token=76a417b0-e92d-49e1-add5-6b9e2809de0f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13543%20-%20diag_mp_lifeline_glad_taunt_42_3p.wav?alt=media&token=df6e4173-1de5-4028-bea0-2598e1ecf270',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13547%20-%20diag_mp_lifeline_glad_tauntHalloween_01_1p.wav?alt=media&token=4a56295b-1f69-4147-9240-7344569144e6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13550%20-%20diag_mp_lifeline_glad_tauntHalloween_02_1p.wav?alt=media&token=7f433bf7-658d-4d69-886a-061568a61196',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13553%20-%20diag_mp_lifeline_glad_tauntValentines_01_1p.wav?alt=media&token=c484d894-15ac-4178-bf4f-0cb646f07aab',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13557%20-%20diag_mp_lifeline_glad_tauntValentines_02_3p.wav?alt=media&token=7828e230-ad95-4b22-bee4-5392291cd108',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13560%20-%20diag_mp_lifeline_glad_tauntWinter_01_3p.wav?alt=media&token=485073aa-42e9-4780-86f1-3db687e2a654',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/13563%20-%20diag_mp_lifeline_glad_tauntWinter_02_3p.wav?alt=media&token=4ab33edc-d767-41af-98c1-1b4d6fc30c25',
  ];

  final List<String> quipnames = [
    "Change will do you good (NEW)",
    "Looking for a rythm I got your beat"
        "I take out the trash myself",
    "That's how you gonna be eh,fire fire ",
    "This boy drop out why don't ya ",
    "Jumpad over here wonder who left that lying around ",
    "You will probably blow yourself up if I leave you alone ",
    "Lost one,Siliva I told you ",
    "Something good waiting for me,If i can find all this pieces ",
    "Might be something good if I find all this pieces let's go ",
    "Quit liming about,we got a piece to find ",
    "I got a piece ",
    "Say what we got a piece ",
    "Skydive Laugh ",
    "Siliva!Why you like this? ",
    "I have come too far to give up now ",
    "Lost it objective's gone ",
    "Objective just slipped out my hands ",
    "We got the objective now ",
    "Got my hands on the objective ",
    "You got flatlined ",
    "So sorry you outta lifelines ",
    "Frag out! Back yourself up siliva ",
    "Frag out! Siliva don't stand on this one ",
    'Mozambque Here',
    'You know what\'s scary',
    'Check yourself or wreck yourself',
    'You better no romp with me',
    'Ain\'t afraid of you',
    'Move it or quit',
    'A win don\'t come easy for you',
    'Remember this face it\'s coming for ya',
    'Quit your winging and fight',
    'You better hope you are with me',
    'Wanna be here take me out',
    'All good for me',
    'Accept it I\'m here you are not',
    'Don\'t worry it\'s easy',
    'Want advice stay outta my way',
    'You looking at a fighter what am i looking at',
    'If you wanna take me on',
    'Small up yourself Ajay Che is coming through',
    'Today no diffrent',
    'I would watch out for my squad',
    'It takes a lot to take me out',
    'We all got each other',
    'Champion Challenger means little if you die',
    'C\'mon now bring it',
    'Open Season let\'s go',
    'It\'s a new season small up yourself',
    'Your team let you down bretheren',
    'This is just how it is',
    'This is not my first time',
    'You got a whole squad that failed you',
    'Next time Next time you will do better',
    'Breathe easy you lost this one',
    'In the future pay more attention',
    'Skill wasn\'t that bad remember that',
    'It\'s our skill',
    'I had a job to do',
    'I won this one',
    'Your time has ended',
    'The skill takes experience and strength',
    'Brush it off you lost this one',
    'No romp with me not today',
    'Now that\'s a good feeling',
    'No Support that\'s a shame',
    'Good Match',
    'They don\'t just call me lifeline because i save a life',
    'Take this as motivation',
    'Not your day',
    'This is my win remember that',
    'I came to win you didn\'t',
    'Quit your winging',
    'What happens to you happens to you that good for you',
    'I\'m the one you should have concerns about',
    'This good for you',
    'Loosing,that\'s a drag',
    'It\'s over for you',
    'Take this loss with pride',
    'It\'s just a loss take it',
    'C\'mon use your head',
    'Don\'t bes shocked I know I\'m doing',
    'Never quit that\'s how you win',
    'You gonna need to work a bit harder next time',
    'Thank you, you made me just a little bit better',
    'Use the pressure,it\'s the only way to survive',
    'Giving up is not thing i would do',
    'You lost take it',
    'It\'s a big up feeling to win',
    'You listen to me it\'s over',
    'I don\'t even think you tryin',
    'Looser puts on a skeleton costume',
    'Looks like you got yourself a little spooked eh!',
    'There ain\'t no cure for a broken heart',
    'Lifeline\'s to blame',
    'I see you shakin and it ain\'t cuz it\'s cold',
    'This year is your last winter',
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
            'Lifeline' + ' Quips',
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
                          child: Image.asset("assets/images/lifeline.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Lifeline Quips",
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
