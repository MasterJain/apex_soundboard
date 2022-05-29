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

class ValkIOS extends StatefulWidget {
  @override
  _ValkIOSState createState() => _ValkIOSState();
}

class _ValkIOSState extends State<ValkIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Fseer%2Fdiag_mp_valkyrie_glad_tauntMutation_01_01_1p.wav?alt=media&token=9a6db256-7ed8-4e75-a8de-8d3a6da9e3ea",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_menu_mapChangeKC_01_01_3p.wav?alt=media&token=e2e8fc34-f0d7-4ee5-bd96-18610b7a797b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_menu_mapChangeKC_02_02_3p.wav?alt=media&token=4b073a58-09a0-4619-85b0-5bf15bce88c2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_menu_mapChangeOL_02_02_3p.wav?alt=media&token=9acd9e27-b553-4245-bb19-5b079a6241bc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_menu_mapChangeWE_02_02_3p.wav?alt=media&token=92953ce4-64d8-477e-b3fd-f66db076cd11",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_ping_youreWelcome_calm_condLoba_01_01_3p.wav?alt=media&token=3346bc9c-399e-4be0-a4a5-c1070eadd21b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_ping_youreWelcome_calm_condLoba_02_02_3p.wav?alt=media&token=31c4ab5d-1425-4976-b5db-f1ed7a36389e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_revivingPlayer_condRampart_01_02_3p.wav?alt=media&token=242fd6e4-59d1-4ed8-bab7-6e50303c0c41",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_revivingPlayer_condRampart_02_01_1p.wav?alt=media&token=8f9201e5-4943-465d-9fbc-2f816ba50a7d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_seasonalTrickOrTreat_01_01_1p.wav?alt=media&token=4a8df275-037e-4309-9452-ac1b7cb81d32",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_skydive_02_03_3p.wav?alt=media&token=c584c3ca-eb14-4fe0-8cce-7c7280d74d36",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_revivingPlayer_condLoba_01_02_1p.wav?alt=media&token=c6fc594d-b1ff-4acd-9079-8e8ab8ba2e55",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_revivingPlayer_condLoba_02_01_1p.wav?alt=media&token=a1080fcb-da59-49c9-a6e6-8801c911611a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_reviveSelf_01_03_3p.wav?alt=media&token=658c6e13-8bbb-4bdb-8e2d-64cf42fb017c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_firstBlood_02_01_3p_L2.wav?alt=media&token=e40244da-62c0-4cd4-b039-33ab2bb2f115",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_congratsKill_07_03_3p.wav?alt=media&token=8836febc-454e-4021-a78d-827a7115b34c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_arenasFlawless_02_02_1p.wav?alt=media&token=07c7b109-569a-45d5-912e-28b8bebd2bf1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_bc_arenasClutch_02_02_1p.wav?alt=media&token=cd62ae44-2011-4c0d-b389-47f224c0e5b0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_tauntOrigin_01_01_1p.wav?alt=media&token=5c9aff7b-2188-4484-96a9-41478e3fe742",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_01_01_3p.wav?alt=media&token=48fdae5c-4b6f-4dde-80b9-15e50e8bff2d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_02_02_3p.wav?alt=media&token=44f1b134-97a7-443b-9dc0-d3ecb1a65d91",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_03_01_qw_1p.wav?alt=media&token=8b7f7d69-e53e-4ea4-aa04-d138171e39eb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_04_01_3p.wav?alt=media&token=40de2ec0-881e-460e-aa69-cf6b9d4fded1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_05_01_3p.wav?alt=media&token=1c9dfcfb-a361-41cb-aa48-5726f9606dbc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_06_01_3p.wav?alt=media&token=198248e4-6368-4694-9563-2af5ae5955d0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_07_01_3p.wav?alt=media&token=b00d8be6-9ace-4b18-bdc0-c2782aa1c65f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_08_01_3p.wav?alt=media&token=69483ce0-2458-4366-a342-783aa63ca9c4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_09_01_3p.wav?alt=media&token=c9029d9d-1eb7-4942-a940-7ceb1e43f88c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_10_01_3p.wav?alt=media&token=b8cfd60a-49ed-4044-817c-dc2fa5ee5a4a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_11_01_3p.wav?alt=media&token=a6075474-d392-4e63-8a08-20536b86ea6d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_12_01_3p.wav?alt=media&token=d6169871-0da5-4c60-89e5-05c0d5036bff",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_13_01_3p.wav?alt=media&token=19f8ca9a-ce9d-4aa3-9a5b-c60a85bd06d5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_14_01_3p.wav?alt=media&token=b9c3aacf-0bbc-4df5-aa2b-2c0eb96c855b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_15_01_3p.wav?alt=media&token=265e3e0a-d4c7-418d-9bf3-948c96d9461c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_16_01_3p.wav?alt=media&token=9247f377-13fd-488e-a806-d10b2623c3f6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_17_01_3p.wav?alt=media&token=7f7293e8-95bb-4a86-85c7-b049d7e93f1d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_18_01_3p.wav?alt=media&token=a25f2513-528c-4a29-a70d-08f8f66393d5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_19_01_3p.wav?alt=media&token=f28a7265-e718-4cd9-872e-27590300b664",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_20_01_3p.wav?alt=media&token=e35edab4-9f15-4b37-a5dc-f53e70253c14",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_introSeq_21_01_3p.wav?alt=media&token=3da51c87-2d41-47e4-9943-60d07c4ba1db",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_rankUp_01_01_3p.wav?alt=media&token=5b064cff-d12a-422b-ae8c-31bc2d4493ca",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_rankDown_01_01_3p.wav?alt=media&token=a2d78b08-ecd1-4e74-b95f-af9f686008d8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_rankNewSeason_01_01_3p.wav?alt=media&token=2012464c-d8f6-42ae-b3f1-531423dfdbf6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_rankNewSeries_01_01_3p.wav?alt=media&token=5c325a0e-cdf2-456e-a22c-367d2d519f33",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_rankNewSplit_01_01_3p.wav?alt=media&token=5f2abb29-e84e-452b-b3ac-609eb886cc3e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_01_01_1p.wav?alt=media&token=38095f74-12c1-4831-85e2-07f031b3e069",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_02_01_1p.wav?alt=media&token=f395d1fa-f4c5-4266-aa1d-37b791d4a485",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_03_01_1p.wav?alt=media&token=404e7095-ebad-4464-a4c8-ac826e51d5ac",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_04_01_1p.wav?alt=media&token=33dc65e5-ec0c-41c1-a7f4-54cc3166b240",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_05_01_1p.wav?alt=media&token=a35733ad-fac5-4d70-a958-46cc40510e98",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_06_01_3p.wav?alt=media&token=3f62e30f-a527-40c3-a518-55ee83be85ab",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_07_01_1p.wav?alt=media&token=5a2d2165-d460-4498-8323-f525e779f5bc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_08_01_1p.wav?alt=media&token=fc52b8b1-54ef-46e3-8cee-2b543efa6301",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_09_01_1p.wav?alt=media&token=2fe2245b-4320-4e06-865f-e983fd8695a2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_10_01_1p.wav?alt=media&token=5c503481-0db0-4191-80a2-2521246d0b06",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_11_01_1p.wav?alt=media&token=a8ac79bf-230b-46e8-bd70-3d8009dc9ac5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_12_01_1p.wav?alt=media&token=18f8a9c5-96a3-44cf-9e2b-379f39efe8ea",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_13_01_1p.wav?alt=media&token=73710e71-674d-47df-a7ae-4c546023053c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_14_01_1p.wav?alt=media&token=e9eb51b9-bb0e-43ed-89c3-a2b9b6f9a17d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_15_01_1p.wav?alt=media&token=2e4775bc-e99d-4102-8c9e-7fc1f285b4fe",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_16_01_1p.wav?alt=media&token=86f2747c-cb4a-4b20-9ef4-1899c4e89a97",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_17_01_1p.wav?alt=media&token=9d7a145b-630b-48a8-b727-d0cdc7f70c93",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_18_01_1p.wav?alt=media&token=b1f539e0-7461-4d1f-a550-c333d9eeedb2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_19b_01_1p.wav?alt=media&token=d0c6ddfa-4f78-4b95-99b9-ce98fcf36774",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_20_01_1p.wav?alt=media&token=ad6353cb-1a73-4f06-8527-dce2fdac8572",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_21b_01_1p.wav?alt=media&token=2fb6920a-bcac-4c4e-8f85-ee024bc609ed",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_22_01_1p.wav?alt=media&token=86e883fd-2f5c-4140-b996-79f4358dc3e1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_23_01_1p.wav?alt=media&token=8f092061-ea6f-4218-85a0-17bab23f698f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_24_01_1p.wav?alt=media&token=bc5083f5-31fa-48c0-9b0c-29c251b7563e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_25_01_1p.wav?alt=media&token=59b14226-064c-416a-afe4-7b5a39818496",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_26_01_1p.wav?alt=media&token=05bd8033-1ff6-4f6a-9c98-758beb363cd2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_27b_01_1p.wav?alt=media&token=2482bc67-e296-4b30-ba39-9b5666fc506a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_28_01_1p.wav?alt=media&token=6e59dd7d-0f1c-4a70-bcea-1d9b68ea18a4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_29_01_1p.wav?alt=media&token=1c44b9a9-f839-462e-9533-9112c6c83954",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_30_01_1p.wav?alt=media&token=ed2436da-6df7-497e-9304-965363dd1043",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_31_01_1p.wav?alt=media&token=a48e34fe-3131-463f-96bc-3a8b8f47e321",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_32b_01_1p.wav?alt=media&token=35b3fbf8-8f07-4a62-9515-369637ab653f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_33_01_1p.wav?alt=media&token=6b92185a-6d85-4a3d-b40a-32c988dbdfe9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_34_01_1p.wav?alt=media&token=3eb7205a-90d3-44b2-aad3-a096d20faf5c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_35_01_1p.wav?alt=media&token=92376068-5807-4699-aed3-4f833e30b63b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_36_01_1p.wav?alt=media&token=f0140662-b127-47b0-8470-84a4dbd11000",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_37_01_1p.wav?alt=media&token=9c725b67-223b-4701-9176-6e3be7c8bd4b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_38_01_1p.wav?alt=media&token=6c369163-4066-412e-a7b1-9cb96e211126",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_39_01_1p.wav?alt=media&token=a980d41c-c290-456f-89aa-01aa1f7e788c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_40_01_1p.wav?alt=media&token=a7c40c36-180b-4f01-aca2-0c860cf7f1b8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Fvalk%2Fdiag_mp_valkyrie_glad_taunt_41_01_1p.wav?alt=media&token=86b77e51-ef20-497c-be20-5539ce1fd038",
  ];

  final List<String> quipnames = [
    "What can I say this bloodsport really changes a girl (NEW)",
    "Back in king's canyon",
    "Looking forward to fighting in king's canyon again",
    "Game's are back in Olympus",
    "Hey World's edge",
    "I've got an eye for this things",
    "I told ya I got ya",
    "You drop the name shiela, deal?",
    "Quit calling that thing sheila",
    "Trick or Treat",
    "Comin in Hot",
    "We gotta stop meeting like this",
    "Got ya can't have you going into a tailspin",
    "Sorry dad no family reunion yet I got a match to win",
    "First Blood",
    "Hell yeah",
    "Flawless",
    "Clutch Victory",
    "Hey I shot at the commissioner too",
    "A lot of you are gonna wake up tommorow with sore necks",
    "Atleast half of you were looking down at the ground",
    "No one gives a crap whose better",
    "Didn't I see some of you in last match",
    "Sucks aiming at the target with the sun on your eyes",
    "Your journey ends here legends",
    "Valkyrie's got",
    "Then I will introduce you to ground",
    "I always pay my respects to your families",
    "I'm starving",
    "So my place is a little sloppy",
    "Jumpads, Gravity Lifts, Geysers",
    "I strike swift and deadly like my dad",
    "I was flying Titans",
    "Enjoy the dropship ride",
    "Don't see wings on any of you",
    "You got this just look in front of you behind you",
    "Oh here's a good news",
    "I once shot someone",
    "I like my women like I like my sake",
    "I swore I will never waste my life on a vendetta again",
    "Moving up in the ranks",
    "Damn Ranked down",
    "A new ranked season starts today",
    "New Ranked series starts today",
    "New Ranked split starts today",
    "How many times do i have to say look up Unreal",
    "Go home",
    "You are beated up",
    "But not everyone is me",
    "You were bingo fuel and you didn'nt even know it",
    "Your girl's gonna be heartbroken when she hears the news",
    "I saw it coming my own way",
    "What?? expected me to bow first",
    "Do you love a good hot mess",
    "And if all this wasn't bad enough you are gonna miss a killer sunset",
    "I'm not even sure you have teeth",
    "Jumpad gravity lifts geysers",
    "You don't mind if i take your lunch do ya",
    "Forced landing don't you hate those",
    "Somebody strapped their",
    "That was embarrassing",
    "You definitly in this spaghetti now",
    "Blame it on the chemtrails",
    "Too aggressive?",
    "Oh so sorry",
    "Don't beat yourself up",
    "Thanks I really appreciate  how easy you made that look for me ",
    "Boots on the ground",
    "I always say",
    "Just so we are clear",
    "Another one bites the dust",
    "The question is Do I care?",
    "Should have punched out when you had the chance",
    "Oh even I puckered up when you got shot down",
    "I know that look",
    "Yes hahaha eat it sucker",
    "I hear slobs are creative geniuses",
    "Hey first round's on you",
    "You lost let it go",
    "It's school",
    "You got no wings",
    "This is just your final approach buddy",
    "Bandit eliminated",
    "Somebody's grounded",
    "Real Talk",
    "Wait that actually worked",
    "Buddy here's a tip",
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
            'Valkyrie Quips',
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
                          child: Image.asset("assets/images/valk.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Valk Quips",
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
