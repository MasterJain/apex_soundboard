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

class Wraiths extends StatefulWidget {
  @override
  _WraithsState createState() => _WraithsState();
}

class _WraithsState extends State<Wraiths> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_wraith_glad_tauntOrigin_01_01_1p.wav?alt=media&token=b9384774-bd51-443f-ab02-f8a284f723d8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2FWraith%20Talks%20about%20charge%20Towers.mp3?alt=media&token=a223006b-4539-43b3-86b4-d748b534da07",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2Fwattson%20sees%20ghost.mp3?alt=media&token=ced36964-cd88-4cf8-8040-75b59642def8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F27564%20-%20diag_mp_wraith_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=c9c28e9a-12e7-4fe1-8aa0-0a15288dd08b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F27563%20-%20diag_mp_wraith_ping_youreWelcome_calm_condRevenant_1p.wav?alt=media&token=8b2a81c6-515e-434d-95d0-d5210a9359f0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F26017%20-%20diag_mp_wraith_bc_thIntro_1p.wav?alt=media&token=f2e0e6e0-23c8-462f-a332-388b329cb8e5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F26010%20-%20diag_mp_wraith_bc_thCompletedCombat_solo.wav?alt=media&token=aff844f4-ea26-41f9-ab67-7eaea936d86b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F26009%20-%20diag_mp_wraith_bc_thCompletedCombat_3p.wav?alt=media&token=1d0529bf-e0f8-4315-b8bb-f983ff8be4f7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25977%20-%20diag_mp_wraith_bc_skydive_3p.wav?alt=media&token=91983e77-13c1-4d10-9803-222c825b08a4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25976%20-%20diag_mp_wraith_bc_skydive_1p.wav?alt=media&token=b54217b6-6327-4112-b038-924f41068a5e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25967%20-%20diag_mp_wraith_bc_reviveSelf_3p.wav?alt=media&token=98648825-1f15-4153-a8f9-686ffa753982",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25966%20-%20diag_mp_wraith_bc_reviveSelf_1p.wav?alt=media&token=b8bb665b-0c30-4689-a073-ec4d2fa7864a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25953%20-%20diag_mp_wraith_bc_objectiveLostSquad_3p.wav?alt=media&token=96dd5767-10d4-4d22-9ca3-6c798f87ea8a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25952%20-%20diag_mp_wraith_bc_objectiveLostSquad_1p.wav?alt=media&token=b7112891-e268-4769-80ec-4ade270b2104",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25951%20-%20diag_mp_wraith_bc_objectiveLostSelf_3p.wav?alt=media&token=cbf82c69-a835-414d-b541-51e2e3234d78",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25949%20-%20diag_mp_wraith_bc_objectiveHaveSquad_3p.wav?alt=media&token=2509faad-945b-4c51-8eed-9fb3bf288d85",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25948%20-%20diag_mp_wraith_bc_objectiveHaveSquad_1p.wav?alt=media&token=59ca68dc-2510-4693-a0f0-5ff0549977f8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2F25947%20-%20diag_mp_wraith_bc_objectiveHaveSelf_3p.wav?alt=media&token=0288bb23-ebef-4ac4-895c-69bf398602f3",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26061%20-%20diag_mp_wraith_glad_introHalloween_01_qw_3p.wav?alt=media&token=6d186f75-9ff3-43f5-b40b-04338f801600',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26062%20-%20diag_mp_wraith_glad_introMythic_01_qw_1p.wav?alt=media&token=54b58470-2303-4a4c-9ca0-5104a3cdb42d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26063%20-%20diag_mp_wraith_glad_introMythic_02_qw_1p.wav?alt=media&token=97f315c4-3eec-4661-a15f-ac052673d314',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26065%20-%20diag_mp_wraith_glad_introSeq_01_qw_1p.wav?alt=media&token=0e5335f0-559c-4da5-8109-c66e1830552c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26071%20-%20diag_mp_wraith_glad_introSeq_02_qw_1p.wav?alt=media&token=67e9da92-557e-4d67-a817-8e8a1322dabc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26076%20-%20diag_mp_wraith_glad_introSeq_03_qw_3p.wav?alt=media&token=0eb6ec6e-19ae-4742-9772-5e7551ed5ec9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26079%20-%20diag_mp_wraith_glad_introSeq_04_qw_3p.wav?alt=media&token=9106b1a8-c032-4ac2-9917-a03b0c61b196',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26082%20-%20diag_mp_wraith_glad_introSeq_05_qw_3p.wav?alt=media&token=dbc2975b-e96e-437f-94d0-7b6ddb010d45',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26085%20-%20diag_mp_wraith_glad_introSeq_06_qw_3p.wav?alt=media&token=17b605c2-569d-4ce6-9642-3bb0853d3c8f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26088%20-%20diag_mp_wraith_glad_introSeq_07_qw_3p.wav?alt=media&token=234a1e8f-62f1-4e8f-8948-51827798b21e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26091%20-%20diag_mp_wraith_glad_introSeq_08_qw_3p.wav?alt=media&token=440f89da-3ac3-4ce5-b533-29be5e0ebed9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26094%20-%20diag_mp_wraith_glad_introSeq_09_qw_3p.wav?alt=media&token=ebf8f41a-3697-425e-befc-927e7c54cf94',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26097%20-%20diag_mp_wraith_glad_introSeq_10_qw_3p.wav?alt=media&token=7e08621c-cb02-4154-b6be-245681c00a80',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26099%20-%20diag_mp_wraith_glad_introSeq_11_qw_1p.wav?alt=media&token=25e64a60-c5fc-4389-a41e-b19246f1f724',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26102%20-%20diag_mp_wraith_glad_introSeq_12_qw_1p.wav?alt=media&token=8826c67f-800f-40c5-8698-bef86e23cf38',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26105%20-%20diag_mp_wraith_glad_introSeq_13_qw_1p.wav?alt=media&token=053cab74-e43a-4331-86ee-bfffec341fcf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26108%20-%20diag_mp_wraith_glad_introSeq_14_qw_1p.wav?alt=media&token=dd60ccae-d339-4c76-bf46-64addb6537df',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26111%20-%20diag_mp_wraith_glad_introSeq_15_qw_1p.wav?alt=media&token=6b68cacd-ac60-420c-9f46-763b4e2c1c89',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2Fwraith2.mp3?alt=media&token=84e01c89-84de-4a95-9087-6bc20d72cff4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26117%20-%20diag_mp_wraith_glad_introSeq_17_qw_1p.wav?alt=media&token=fb8ead7b-4e79-4de4-a3de-d8c18291d1a3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26120%20-%20diag_mp_wraith_glad_introSeq_18_qw_1p.wav?alt=media&token=8e0dc952-58a4-401f-81e5-82ad6ebe458b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26124%20-%20diag_mp_wraith_glad_introSeq_19_qw_3p.wav?alt=media&token=17d076a3-1562-4933-a651-0757cf7761fd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26127%20-%20diag_mp_wraith_glad_introSeq_20_qw_3p.wav?alt=media&token=ec8fadfa-4f81-4744-91a2-ac38e0da484b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26129%20-%20diag_mp_wraith_glad_introSeq_21_qw_1p.wav?alt=media&token=0a6b2fdc-b3b9-40a4-87d1-9e3a94b79e58',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26143%20-%20diag_mp_wraith_glad_seasonOpen_qw_1p.wav?alt=media&token=8fb0a011-2a1e-4644-96f3-c174f30fb725',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26145%20-%20diag_mp_wraith_glad_taunt_01_1p.wav?alt=media&token=d79cfc6b-2bae-4b78-80f3-4ac2f0937752',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26151%20-%20diag_mp_wraith_glad_taunt_02_1p.wav?alt=media&token=81d0a2dc-b7e9-425c-97d7-acafbe5db48d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26154%20-%20diag_mp_wraith_glad_taunt_03_1p.wav?alt=media&token=403325de-b3ba-4e4a-8e96-f0231f4a174e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26157%20-%20diag_mp_wraith_glad_taunt_04_1p.wav?alt=media&token=dceffdd0-6789-4bdd-aecf-d9f86b970768',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2Fwraith3.mp3?alt=media&token=3da4c5aa-f051-41c0-9d70-f710e0f78215',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26164%20-%20diag_mp_wraith_glad_taunt_06_3p.wav?alt=media&token=03a97a9a-88ff-4db3-95f9-8419fc7ce710',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26167%20-%20diag_mp_wraith_glad_taunt_07_3p.wav?alt=media&token=01db9831-6c98-40fb-ae6f-067ab2c3f96a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2Fwraith1.mp3?alt=media&token=f82d56f1-4619-418a-83aa-a55f26ddfdf4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26173%20-%20diag_mp_wraith_glad_taunt_09_3p.wav?alt=media&token=07768cd9-1cd9-4b10-a5ce-d15cec7d6c55',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26176%20-%20diag_mp_wraith_glad_taunt_10_3p.wav?alt=media&token=ab3452a4-6d8e-4da5-b225-c99bd9df0bcb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26178%20-%20diag_mp_wraith_glad_taunt_11_1p.wav?alt=media&token=c9726724-81a7-4817-b2ad-1172ceec12ed',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26182%20-%20diag_mp_wraith_glad_taunt_12_3p.wav?alt=media&token=216de368-3472-4ddc-b508-51752ac56353',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26185%20-%20diag_mp_wraith_glad_taunt_13_3p.wav?alt=media&token=d115321a-2730-40ab-bcc7-a7b62e837b3d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26188%20-%20diag_mp_wraith_glad_taunt_14_3p.wav?alt=media&token=187b7d65-ea00-492f-bfbe-1783ef2cf963',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26190%20-%20diag_mp_wraith_glad_taunt_15_1p.wav?alt=media&token=54cf37bc-a85b-478e-af18-f2c27d2be52d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26193%20-%20diag_mp_wraith_glad_taunt_16_1p.wav?alt=media&token=cabab9ee-e5a7-486b-8a74-3781fdcee777',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26196%20-%20diag_mp_wraith_glad_taunt_17_1p.wav?alt=media&token=d0b0a68b-52c3-4293-833a-28dc905fe418',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26199%20-%20diag_mp_wraith_glad_taunt_18_1p.wav?alt=media&token=1d7d12d6-2263-4856-bbae-4f858fc2bf3f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26202%20-%20diag_mp_wraith_glad_taunt_19_1p.wav?alt=media&token=cf4ea563-c8b3-4455-8f42-78119d27a2cd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26206%20-%20diag_mp_wraith_glad_taunt_20_3p.wav?alt=media&token=08cff029-51ef-456e-b392-464ffb8b4bdd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26208%20-%20diag_mp_wraith_glad_taunt_21_1p.wav?alt=media&token=5536d835-db87-41c1-b9b7-e551049e3240',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26212%20-%20diag_mp_wraith_glad_taunt_22_3p.wav?alt=media&token=3745b2e3-5529-4d08-8a19-aa43dfd6158c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26215%20-%20diag_mp_wraith_glad_taunt_23_3p.wav?alt=media&token=06dedbd5-923c-4ba4-9494-95e7fac8b982',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26218%20-%20diag_mp_wraith_glad_taunt_24_3p.wav?alt=media&token=e385150d-32e2-4a47-b2fa-dc85d346f30f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26221%20-%20diag_mp_wraith_glad_taunt_25_3p.wav?alt=media&token=e918b5a9-515d-4381-9bf7-4dfa0c0c1e14',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26224%20-%20diag_mp_wraith_glad_taunt_26_3p.wav?alt=media&token=62b9d348-4f00-4454-a230-334e8a097aae',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26226%20-%20diag_mp_wraith_glad_taunt_27_1p.wav?alt=media&token=d35e4488-d2bb-4fe4-8276-20d3b8ae8a3e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26229%20-%20diag_mp_wraith_glad_taunt_28_1p.wav?alt=media&token=ae0bf441-d105-415a-aeb7-820466e5cb30',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26232%20-%20diag_mp_wraith_glad_taunt_29_1p.wav?alt=media&token=06f67c3a-61fe-45b4-9433-685c6435e291',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26235%20-%20diag_mp_wraith_glad_taunt_30_1p.wav?alt=media&token=c31687ff-14eb-4f05-87a6-9a9f2c171796',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26238%20-%20diag_mp_wraith_glad_taunt_31_1p.wav?alt=media&token=24ab13ef-c549-4685-9b39-466ddfc152ef',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26241%20-%20diag_mp_wraith_glad_taunt_32_1p.wav?alt=media&token=1978bf27-a6c6-4171-b0be-b67ccd56c7b3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26244%20-%20diag_mp_wraith_glad_taunt_33_1p.wav?alt=media&token=e5e12c32-683f-4733-ba85-adc4247cf89c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26247%20-%20diag_mp_wraith_glad_taunt_34_1p.wav?alt=media&token=3078751e-6a90-43f1-b247-f2618d297f37',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26253%20-%20diag_mp_wraith_glad_taunt_36_1p.wav?alt=media&token=99f3a39d-a424-42ba-a636-8e66204eca6f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26250%20-%20diag_mp_wraith_glad_taunt_35_1p.wav?alt=media&token=32a8615a-a77f-46f4-9ed8-f64eed57c72b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26256%20-%20diag_mp_wraith_glad_taunt_37_1p.wav?alt=media&token=891feb26-11eb-479b-a86c-8b0ef822f122',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26261%20-%20diag_mp_wraith_glad_taunt_38_3p_victim.wav?alt=media&token=d859f1da-4671-4890-875a-5cb3d3e9c582',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26263%20-%20diag_mp_wraith_glad_taunt_39_3p.wav?alt=media&token=0d120fda-f38e-4420-ab01-a4a2e555ba49',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26266%20-%20diag_mp_wraith_glad_taunt_40_3p.wav?alt=media&token=5ea3d0e3-bf79-4fc4-b81c-3e6c241889d4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26268%20-%20diag_mp_wraith_glad_taunt_41_1p.wav?alt=media&token=1b9d9d04-1693-465c-84b2-19d257f56030',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26271%20-%20diag_mp_wraith_glad_tauntHalloween_01_1p.wav?alt=media&token=a2ca06dd-820a-4353-ad3a-66f1cd42f7ca',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26274%20-%20diag_mp_wraith_glad_tauntHalloween_02_1p.wav?alt=media&token=c49d3a21-e66e-4f0c-82cb-2fcce8cf0a39',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fwraith%2Fwraithvoid.mp3?alt=media&token=6ff5d00d-542f-43e3-a633-73700b9c6106',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26281%20-%20diag_mp_wraith_glad_tauntValentines_02_3p.wav?alt=media&token=1c4bb7fc-34a3-4222-ad06-9e50fa1de060',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26283%20-%20diag_mp_wraith_glad_tauntWinter_01_1p.wav?alt=media&token=da6237de-2fca-4e23-9f38-045bbe4f7390',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/26287%20-%20diag_mp_wraith_glad_tauntWinter_02_3p.wav?alt=media&token=af155a96-47a1-475f-a574-21feb6d89f90',
  ];

  final List<String> quipnames = [
    "I used to go by the name hope",
    "Wraith Talks about charge towers ",
    "Wattson sees Ghost in the Labs ",
    "Nobody asked ",
    "I didn't ask ",
    "The piece is nearby follow me ",
    "This time the piece is mine",
    "We made the right choices we got the piece ",
    "here goes nothing  ",
    "Let's do this ",
    "Someone died today but not me not now  ",
    "I have made my choice and I'm not done  ",
    "Listen up we lost the objective  ",
    "We lost the objective  ",
    "I lost it  ",
    "That's it we took the objective  ",
    "The objective is ours  ",
    "I got the objective  ",
    'I will travel every road',
    'My name is Renne',
    'The name is senior science pilot',
    'Good Choice for me',
    'Another day another road',
    'Try not to blink',
    'I saw this coming',
    'Follow my path to win',
    'Wanna win do what i do',
    'Every decision counts',
    'Let\'s do this',
    'I\'m quick and i will finish this',
    'Trust just your eyes',
    'I have been here one to many times',
    'I will take you down more than once',
    'Just a step in the right direction',
    'Something wrong with your head if you fight me',
    'I know more than you will ever know',
    'I dont fear anything',
    'Pain death nothing phases me',
    'There is a thin line',
    'You dont get here by sitting around doing nothing',
    'You know what i look like come find me',
    'It\'s my turn this time',
    'It\'s opening season',
    'The road you chose has ended here',
    'Suprise',
    'Don\'t worry i would have gotten you',
    'I saw this coming in my own way',
    'Maybe in another time or space you killed me',
    'This is where it ends',
    'This was the outcome this time',
    'There were multiple ways this could end',
    'Be honest',
    'We all have our reasons',
    'In Another life',
    'Don\'t blame yourself',
    'A match like this is much more than shooting a gun',
    'You lost this time',
    'Don\'t worry there was no way out of this',
    'I caught the win this time',
    'I guess i was one step ahead of you',
    'Not today',
    'This is what happens when you are not focused',
    'Listen to everything',
    'Your choice is pointless',
    'Too slow',
    'Caught you',
    'Looking for me',
    'I have seen this all before',
    'It\'s deja vu with you fighters',
    'Shoot this',
    'Now you see me',
    'Knowledge is power and pain',
    'Sometime\'s you loose sometimes you dont',
    'I knew your every move',
    'Let\'s just say a little birdie told me all about you',
    'You challenged the wrong person',
    'Can' 't catch what you can\'t see',
    'Each win gets me on step closer',
    'Every decision counts',
    'Step quiter next time',
    'I would say try better',
    'I knew this end would come',
    'This didn\'t have to happen',
    'I knew if we fought together',
    'You choose the wrong door',
    'The scariest thing is knowing',
    'There is a void in your heart',
    'Your path has lead to heartbreak',
    'Think its cold spend time in the void',
    'Death like winter is unavoidable',
  ];

  final List<String> quipcategory = [
    'Legend Interactions',
    'Quest quips'
        'Wraith Quips',
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
            'Wraith Quips',
            style: TextStyle(fontFamily: 'Raleway'),
          )),
          body: ListView.builder(
              itemCount: audio.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100.0,
                  height: 90.0,
                  child: Slidable(
                    key: ValueKey(index),
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset("assets/images/wraith.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Wraith Quips",
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
