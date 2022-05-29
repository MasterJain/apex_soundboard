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

class Horizon extends StatefulWidget {
  @override
  _HorizonState createState() => _HorizonState();
}

class _HorizonState extends State<Horizon> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_horizon_glad_tauntMutation_01_02_3p.wav?alt=media&token=f1621c85-dc6d-441a-9f9f-bb6baeda7e06",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_horizon_glad_tauntOrigin_01_01_1p.wav?alt=media&token=e9232fec-4233-4278-955d-bbe090633944",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_horizon_glad_tauntOrigin_03_01_1p.wav?alt=media&token=25d5c530-9653-4d57-bf31-6c998e122b73",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_skydive_01_02_1p.wav?alt=media&token=3d041215-60f0-4ac1-b1ec-df0e02f14c94',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_01_01_3p.wav?alt=media&token=c0c7cbc1-6a72-469f-baa8-5611212aa605',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_02_01_3p.wav?alt=media&token=0be09648-ee7e-4eae-b6ee-0c7cdf95d4c1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_03_01_3p.wav?alt=media&token=50349cfc-b8d8-4e01-940c-0f49a55b2b0b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_04_01_3p.wav?alt=media&token=0bfe5e55-6092-4228-91ca-bcb2f58d77bf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_05_01_3p.wav?alt=media&token=af2baa43-626d-48df-8e6c-b00e1e38e606',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_06_01_3p.wav?alt=media&token=0ca7f796-2aba-4f30-ba35-5b6f8c632322',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_07_01_3p.wav?alt=media&token=fa3ac379-ad5e-4df3-b8a9-344d0eef8efe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_08_01_3p.wav?alt=media&token=61dd709a-6d9a-42c9-9553-bf910f1fc240',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_09_01_3p.wav?alt=media&token=3f2fa740-6912-45c9-9163-964da878ada1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_10_01_3p.wav?alt=media&token=7191e915-3767-4013-8d28-e0bc455e9886',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_11_01_3p.wav?alt=media&token=1b96cdb4-cd09-44da-aac3-4f740ce41051',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_12_01_3p.wav?alt=media&token=16fb1e85-d9ee-4f92-be41-75a00942f4b5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_13_01_3p.wav?alt=media&token=38ea5800-8b66-49ff-8f77-24117aebb061',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_14_01_3p.wav?alt=media&token=11814552-729c-44e8-aae1-df0cda39dee6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_15_01_3p.wav?alt=media&token=c1c073bb-c20c-4f7b-84c2-29fb1442818d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_16_01_3p.wav?alt=media&token=14fb71e8-f83e-44a6-b403-539b32926ef8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_17_01_3p.wav?alt=media&token=b1299275-d147-4535-b63c-dedd018fdeca',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_17_01_3p.wav?alt=media&token=b1299275-d147-4535-b63c-dedd018fdeca',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_19_01_3p.wav?alt=media&token=4c1789e4-3d06-4885-b947-c119695bf2da',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_20_01_3p.wav?alt=media&token=4f5e8910-f56e-44a3-bee7-d9ad8f707b2c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_introSeq_21_01_3p.wav?alt=media&token=28297cfd-7cb7-46d6-912d-fcccba878b95',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_seasonOpen_01_01_3p.wav?alt=media&token=287c194d-433b-4a47-84e9-6360ebbb2896',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_01_01_1p.wav?alt=media&token=9a483407-4b7a-40e3-922f-005a2d28b328',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_02_01_1p.wav?alt=media&token=a6a733d3-d38f-4b45-ae3a-03f760df3d40',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_03_01_1p.wav?alt=media&token=1aff263d-8d47-482a-9d51-8158748fc80d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_04_01_1p.wav?alt=media&token=36949e39-29b6-4aea-91b2-e8191a1f99a0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_05_01_1p.wav?alt=media&token=2454a232-7e55-45eb-aa83-abd5aecae5da',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_06_01_1p.wav?alt=media&token=5df141bd-f0dd-4a75-9d93-a046b7d3ae06',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_07_01_1p.wav?alt=media&token=36f4adba-d82d-4817-9470-d0d13513053a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_08_01_1p.wav?alt=media&token=74e415be-ad1b-44cd-80db-6be28f6d2f6e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_09_01_1p.wav?alt=media&token=c5e68deb-942d-4465-8e1a-ba91c013ebda',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_10_01_1p.wav?alt=media&token=89b1fba2-5723-4a00-87a8-ac347eab6ae8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_11_01_1p.wav?alt=media&token=c825b427-6c3c-480d-ba12-25f4e0cd6b70',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_12_01_1p.wav?alt=media&token=cc7749f7-883f-4630-8ccf-cfa9600528dd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_13_01_1p.wav?alt=media&token=c4781cff-ae47-46d6-a778-2d65b7e28565',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_14_01_1p.wav?alt=media&token=c47562fa-d14b-46c0-9f89-21c08ac01350',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_15_01_1p.wav?alt=media&token=be3a4123-c294-4b06-83f2-bc2c1d0cd850',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_16_01_1p.wav?alt=media&token=da1104fc-3bbe-4bf7-803b-753e63e9aa0b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_17_01_1p.wav?alt=media&token=fb0f42bd-a7f1-4213-888a-f82f49f33482',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_18_01_1p.wav?alt=media&token=00b4948a-9d21-48a7-9731-79c64cd19d33',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_19_01_1p.wav?alt=media&token=e4dfb8ed-bd16-45cd-b0e4-35ebd5c2d207',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_20_01_1p.wav?alt=media&token=e4d65411-b7af-4ea5-9637-ae65fcc1f64d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_21_01_1p.wav?alt=media&token=5d69e5ab-fedf-44b0-a6d1-3fc3b6ebcb14',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_22_01_1p.wav?alt=media&token=8d64a36d-ac6c-4d21-ba9a-a9c052bdabf5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_23_01_1p.wav?alt=media&token=be40d129-1e73-445a-9f65-35b7a1150dd3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_24_01_1p.wav?alt=media&token=49ec3068-1ad0-4faa-9364-878f70c2e94b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_25_01_1p.wav?alt=media&token=9a12a3bd-404d-4c74-bd9b-5cf64e3f8d2e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_26_01_1p.wav?alt=media&token=22ed6dbf-49bb-417a-bab5-df81552ee23e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_27_01_1p.wav?alt=media&token=516150e2-5cc1-4cdd-b4dc-2b6a06834c37',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_28_01_1p.wav?alt=media&token=8c63f563-3226-4deb-aa26-49ddb21187fe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_29_01_1p.wav?alt=media&token=a6035335-8354-49cc-8548-44b63a7acea0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_30_01_1p.wav?alt=media&token=3dc1e163-8b3f-4172-8657-8c5363137281',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_31_01_1p.wav?alt=media&token=11f179a6-e85a-4ebe-a624-1701c90ca572',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_32_01_1p.wav?alt=media&token=8d30e2ec-fe0f-44f3-881c-9ac72be205bc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_33_01_1p.wav?alt=media&token=d5d1ff4d-4088-462f-abf8-e52baa4c14f5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_34_01_1p.wav?alt=media&token=26d2c61d-745d-4c7e-8eba-06aaecd30f48',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_35_01_1p.wav?alt=media&token=444140cc-31cc-4686-ab15-faadee32f120',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_36_01_1p.wav?alt=media&token=78662dcd-5b43-4475-ac85-d62ea7130322',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_37_01_1p.wav?alt=media&token=f22500aa-4cfc-47a2-ad81-c3848be3a55e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_38_01_1p.wav?alt=media&token=d7e24cb7-c685-4e13-b8ca-ab473d17ae35',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_39_01_1p.wav?alt=media&token=cdd5813f-1b74-4762-8f34-73c89390a857',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_40_01_1p.wav?alt=media&token=ac6955ad-8550-435a-9921-d3cf11ae8cbd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_41_01_1p.wav?alt=media&token=9aeede1f-0ef1-4831-b59e-26124016df65',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_42_01_1p.wav?alt=media&token=ef498e89-1888-48e2-9f35-1a5674c36f51',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_glad_taunt_50_01_1p.wav?alt=media&token=76804454-a9f4-4601-b804-25cee0115cff',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeKC_01_02_3p.wav?alt=media&token=378bfe6a-19f6-4f8c-b76f-e018b9ac2b5b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeKC_02_01_3p.wav?alt=media&token=2303b131-9f98-4086-87d7-1b9279fd73db',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeOL_01_01_3p.wav?alt=media&token=e499440f-b58a-49c5-bbf2-b2d5cec54ff0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeOL_02_01_3p.wav?alt=media&token=c1d2295e-dc09-440a-a774-b85233675409',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeOL_03_01_3p.wav?alt=media&token=7cd6df9a-c08d-4612-86ab-ca2555fdcdbf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeWE_01_01_3p.wav?alt=media&token=45d23f49-9e25-41b5-86ae-3fe8940835f0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeWE_02_01_3p.wav?alt=media&token=45c34c3d-8c3b-41a2-bcc4-3c9c2457abb0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeWE_03_01_3p.wav?alt=media&token=d41b202f-298e-444a-a27c-f4f939520e3d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_menu_mapChangeWE_03_01_3p.wav?alt=media&token=d41b202f-298e-444a-a27c-f4f939520e3d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_congratsKill_condMirage_03_01_1p.wav?alt=media&token=53da2466-b892-4496-9d9c-f914e214cf2f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationOBH_01_01_1p.wav?alt=media&token=70fd21b6-8547-4a5f-b3fa-41c2bda020a9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationOFA_01_01_1p.wav?alt=media&token=dbd1dabc-fbd2-4e9d-ae9e-cef9350e0fb4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationOHF_01_01_1p.wav?alt=media&token=926efd3f-720f-4051-a8cc-0b4e380692cd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationOHL_01_01_1p.wav?alt=media&token=4bf95f1b-b3b6-4a44-863c-b547d9186cb5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationOLA_01_01_1p.wav?alt=media&token=1359045f-f202-4530-8499-8f64cdaaa487',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationOLP_01_01_1p.wav?alt=media&token=fafe6c52-8eb3-4187-863d-aeeaa50a5c3c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationORA_01_01_1p.wav?alt=media&token=e88b2cdc-2aa3-47a6-8df0-d78de028411d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_locationOSM_01_01_1p.wav?alt=media&token=7ffd31e1-f19c-48ce-90c3-a64a053906da',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_revivingPlayer_condMirage_02_03_3p.wav?alt=media&token=12f1bebc-2814-4b80-9daa-03df6e187fbc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/november2020%2Fhorizon%2Fdiag_mp_horizon_bc_seasonalTrickOrTreat_01_01_1p.wav?alt=media&token=1f1109cd-2946-4a0c-8930-cbf7c40e4182',
  ];

  final List<String> quipnames = [
    "Did you think you would be in the top forever darling",
    "Don\'t you feel so bad dear",
    "My.. beat maybe the students are surprised (NEW)",
    'zero g it\'s the only way to travel',
    'particle colliders are R3O1\'s',
    'if not even light can escape the event horizon how do you think you will escape me',
    'So just me and NEWT then',
    'Oh I\'m sorrt dear the statistics just don\'t favor you',
    'what happens in the games stays in the games',
    'violence for science',
    'anyone else wielding the unfathomade cosmic power of singularity',
    'I expect the results of this will be utterly delightful',
    'Strap in NEWTY things are about to get mighty interesting',
    'I surrvived being swallowed by the  dark heart of the universe',
    'data points often don\'t land where you expect them to best prepare yourself',
    'time to introduce a little chaos to my research',
    'me and NEWTY just need to find our way home',
    'play the large numbers',
    'Cuz I\'m the best',
    'This isn\'t between you and me',
    'It\'s not me you got to worry about',
    'Aye, I love field work',
    'Research data waiting to be collected',
    'Is anyone else here technically over hundred years old?',
    'Could get messy I\'m afraid',
    'Fire all systems NEWT it\'s the dawn of the new season',
    'Better luck next time',
    'what did you think would happen',
    'Scottish Mumble',
    'Scottish Mumble',
    'Don\'t worry',
    'Oh yeah',
    'you looking a bit',
    'between friends dear you always struck me a wee bit dim',
    'Oh no!',
    'Oh I\'m sorry love where you saying something',
    'Oh but you are so close darling',
    'Oh no don\'t feel so bad',
    'Oh dearie just wasn\'t your day',
    'Oh well sometimes it\'s just lovely to get some air right',
    'Well I suppose I would have underestimated me too',
    'I won\'t tell anyone about this',
    'Well I guess you picked a wrong time to blink',
    'Just what exactly was your name again',
    'Well that was a little',
    'That was a classic case of foolish right there I\'m afraid',
    'I mean can you really call a god complex',
    'well someone\'s a wee bit',
    'Oh well doing your best',
    'Perhaps a better choice for you may have been',
    'Oh don\'t make that face dearie',
    'I\'m not trying to say you weren\'t a challenge',
    'Oh love what made you think you would walk away from this',
    'How are we supposed to test that equipment if people keep expiring on us NEWT',
    'That wasn\'t a bad effort sometimes participation is the most important thing',
    'Don\'t you take it personal dear',
    'Fear not love',
    'Don\'t go making that face in me',
    'Oh shush dear',
    'What were you doing',
    'Shhh!! Rest now love',
    'I may help you over the horizon',
    'Oh Hushh now don\'t say a word',
    'Don\'t you fear for now you face the other side, go on rest up',
    'There\'s a vast and denesly populated universe',
    'Just a wee bit',
    'Well I suppose loosing was bold choice',
    'Oh man you give me the',
    'Oh no did that hurt darling',
    'Time to shift your orbits to king\'s canyon NEWTY',
    'Floating to king\'s canyon NEWTY',
    'Olympus always a strange sensation heading home',
    'We are going back to Olympus',
    'Olympus here we come',
    'Say hello to world\'s edge',
    'We are heading to world\'s edge',
    'World\'s edge is calling',
    'Elliot you beauty that\'s a kil',
    'Aye good kill elliot I knew you had it in you',
    'You would be surprised',
    'The number of times I would find newton hiding out here',
    'So many advances in the field of chaos over the last century',
    'Hammond Labs',
    'And here we have oh not my old apartment',
    'When newton was a wee',
    'A lassy gets lost for a wee century',
    'did he really know what any of this fancy readings actually mean',
    'Fear not Mr witt Just a flesh wound',
    'Trick or Treat',
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
            'Horizon Quips',
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
                          child: Image.asset("assets/images/horizon.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Horizon Quips",
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
