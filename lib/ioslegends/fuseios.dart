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

class FuseIOS extends StatefulWidget {
  @override
  _FuseIOSState createState() => _FuseIOSState();
}

class _FuseIOSState extends State<FuseIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_fuse_glad_tauntOrigin_01_01_1p.wav?alt=media&token=7bb49f4e-7c67-4b25-ac3e-c6eeb0a3fae0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_menu_mapChangeWE_02_01_3p.wav?alt=media&token=68c9625c-80df-4a2d-81cf-f4594437f705",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_menu_mapChangeWE_01_02_3p.wav?alt=media&token=4a2158da-1e4f-4ee4-92e4-60c9144a6963",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_menu_mapChangeWE_01_02_3p.wav?alt=media&token=4a2158da-1e4f-4ee4-92e4-60c9144a6963",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_menu_mapChangeOL_01_02_3p.wav?alt=media&token=1f133288-127b-4168-b38a-3c6b86d57adc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_menu_mapChangeKC_02_01_3p.wav?alt=media&token=2bd742a5-7ae4-4ce8-9029-6c004d3502f5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_menu_mapChangeKC_01_01_3p.wav?alt=media&token=2b29d757-9156-451b-bce1-d551ae3863dc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_superReact_07_03_3p.wav?alt=media&token=e821120e-c54e-4a91-b837-5ef825738e5c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_superReact_08_03_1p.wav?alt=media&token=8f9af20a-39a1-4eff-8e54-55f7d54429cd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_superReact_09_03_3p.wav?alt=media&token=3605383b-57e0-439e-b88f-9e8e334043c3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_superReact_10_01_1p.wav?alt=media&token=482d07ee-c307-4bf6-b8d3-55b5262a950e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_super_01_01_1p.wav?alt=media&token=c7c5387c-d46b-48af-9d7f-712ca2d4b45c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_super_02_01_3p.wav?alt=media&token=a46fffa3-0a6a-4dba-97b0-d1d85b1cd215",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_super_03_01_1p.wav?alt=media&token=dc1311c6-7d44-4dfb-ad7e-64d6fceb5082",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_bc_super_05_01_1p.wav?alt=media&token=1847e6a9-30c7-4ba9-9a11-d02ac382ff15",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_01_01_3p.wav?alt=media&token=4fd47897-d3a0-4c4d-b80f-84db7f541f68",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_02_01_3p.wav?alt=media&token=cbcf2a7d-92d3-422b-9c79-35a2b7554aae",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_03_01_3p.wav?alt=media&token=e6dd0fff-49f7-4a45-98f3-ede55738c6fe",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_04_01_3p.wav?alt=media&token=18c70cf2-4e92-447f-bc96-d159d8ec9796",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_05_01_3p.wav?alt=media&token=0ff903cf-6b8a-498e-b48c-18d7f8375310",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_06_01_3p.wav?alt=media&token=e4943e22-50aa-45fb-959e-164a5e5ae7e9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_07_01_3p.wav?alt=media&token=92f4b4ed-bd3c-4095-8971-4fd5cf15838b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_08_01_3p.wav?alt=media&token=a6712aae-2900-4ce2-a067-66eab02fa31d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_09_01_3p.wav?alt=media&token=1f8952e8-c26f-4e5b-9f0f-c9426ee600bb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_10_01_3p.wav?alt=media&token=9c3e9f66-b845-401b-a380-867b17d6434d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_11_01_3p.wav?alt=media&token=e667856f-76c7-4c1c-b177-98e83718e54b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_12_01_3p.wav?alt=media&token=a680449b-1e82-4731-9153-bb4c06ca2230",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_13_01_3p.wav?alt=media&token=3fe4c0ab-9d6c-4e15-8f4c-7ffe93ee0db5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_14_01_3p.wav?alt=media&token=7cbfdb7b-3cc3-4353-b7e2-1c2ba8fe53ea",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_15_01_3p.wav?alt=media&token=e7fa8a6a-16ff-42b3-bb8c-910983568099",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_16_01_3p.wav?alt=media&token=139eeccd-a227-485b-ac4b-51d61cddbda5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_17_01_3p.wav?alt=media&token=a6313bf9-faf4-4337-96a0-c8453603377c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_18_01_3p.wav?alt=media&token=b59edfae-dc5b-40cf-817b-8a70ef695630",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_19_01_1p.wav?alt=media&token=eb7dfbda-17b5-4f99-83b2-ce7847266314",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_20_01_3p.wav?alt=media&token=9d8d01f8-2d4d-4dd2-9bf3-ebf9ad5f77cf",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_21_01_3p.wav?alt=media&token=a3e11a86-2238-421c-bb4f-9278b8bb5a34",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_22_01_3p.wav?alt=media&token=190541a5-b0d4-4cfa-bb5d-d615596919b3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_seasonOpen_01_01_3p.wav?alt=media&token=f864cf44-00ef-4814-888c-ec5a57c0754e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_01_01_1p.wav?alt=media&token=e24e4844-93d9-4472-9206-8076a362f1e1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_02_01_1p.wav?alt=media&token=a775b2cb-6cae-4770-8aee-3f098890a0bb",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_03_01_1p.wav?alt=media&token=ae5abd3f-b9b7-45d9-af40-fde3976369a6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_04_01_1p.wav?alt=media&token=470a8eb8-df00-448a-bca9-df1a653a2c60",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_05_01_1p.wav?alt=media&token=ba64cceb-89bf-4b99-8b86-4268903368a5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_06_01_1p.wav?alt=media&token=0b613a60-98e2-485d-b070-a1eb165c4a8f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_07_01_1p.wav?alt=media&token=80429610-032a-47fd-9c7a-130372519c6a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_introSeq_08_01_3p.wav?alt=media&token=a6712aae-2900-4ce2-a067-66eab02fa31d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_09_01_1p.wav?alt=media&token=27b2b5f0-2f07-4766-8982-8cfa8d4e4159",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_10_01_1p.wav?alt=media&token=7f43a996-53a0-4bd9-889d-d3f003628609",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_11_01_1p.wav?alt=media&token=03eabd37-93b7-4a50-8c69-62277e06b92b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_12_01_1p.wav?alt=media&token=cdbe981d-3596-4010-9776-a726ebfaa5a2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_13_01_3p.wav?alt=media&token=81b8d2a4-fc99-4665-93b7-be8cf22a90f2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_14_01_1p.wav?alt=media&token=6dc95938-34be-4e92-a193-494bd9890c4f",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_15_01_1p.wav?alt=media&token=48c348ab-c2ad-4674-8157-2cc94092d687",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_16_01_1p.wav?alt=media&token=df147776-d3a1-4afc-94ec-51c6f13d664b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_17_01_1p.wav?alt=media&token=de0431f7-53ad-4e96-b2c2-ea17e61ea8e0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_18_01_3p.wav?alt=media&token=13a8f5b2-272e-47e4-8d5f-10ee17445034",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_20_01_1p.wav?alt=media&token=d55c61d7-b1a1-4bf6-9a31-9fe798c6210a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_21_01_1p.wav?alt=media&token=4c55ccf0-9037-40b1-83bb-dc085c24f929",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_22_01_1p.wav?alt=media&token=45261e06-ec8c-40b5-90db-57f10beb9675",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_23_01_1p.wav?alt=media&token=fadedc9a-e236-403b-a926-cfa291274125",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_24_01_1p.wav?alt=media&token=da530396-81e4-463e-a7b8-079d94056772",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_25_01_1p.wav?alt=media&token=25a93de7-d33e-419d-b566-e9b8feb21503",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_26_01_1p.wav?alt=media&token=8f0e7eeb-a0f4-4fdd-893b-e3a33e5f2ad4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_27_01_1p.wav?alt=media&token=e64ca209-9f19-41f7-86e4-d0fbf68ddd99",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_28_01_1p.wav?alt=media&token=3ed6d688-e570-4c42-ba70-d10dfab3195d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_29_01_1p.wav?alt=media&token=5f2dee57-6d95-4c89-934a-d0780f409bf1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_30_01_1p.wav?alt=media&token=b91ca380-f0c9-414d-9bd7-09132b353c23",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_31_01_1p.wav?alt=media&token=453b1399-9109-4601-b6f7-cfb2fafc1acd",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_32_01_1p.wav?alt=media&token=a0f21d0a-76e5-43c5-88ce-7d23767ed95b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_33_01_1p.wav?alt=media&token=750e4bb5-7e66-4cdc-b187-0b4e562742a8",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_34_01_1p.wav?alt=media&token=f147f996-588a-49e7-bf7f-12eca8af7e1b",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_35_01_1p.wav?alt=media&token=41738dd3-d0aa-420e-ab01-ac6c27b68eb3",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_36_01_1p.wav?alt=media&token=ead3c967-192e-4493-9ae1-3b1e43be6994",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_37_01_1p.wav?alt=media&token=b271b93a-a224-4dac-9ed0-7e3f3d2da87c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_38_01_1p.wav?alt=media&token=cea7e5a2-7db0-4f0b-aaa7-3fdf5234c067",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_39_02_3p.wav?alt=media&token=70d7bb14-89f7-49cc-8fb7-3a4ba40e12c9",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_40_01_1p.wav?alt=media&token=f49265e6-8f46-4a5e-a543-6e9c8e46c26c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_41_01_1p.wav?alt=media&token=71618446-e6da-44bf-97cf-559c1e614e9c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/feb2021%2Ffuse%2Fdiag_mp_fuse_glad_taunt_42_01_3p.wav?alt=media&token=e2f9a08a-1115-4ebf-9c9e-9f83dfa4a3fc",
  ];

  final List<String> quipnames = [
    "You remind me of meself (NEW)",
    "World's edge a wild untammable land surrounded by endless ocean of lava",
    "Off to world's edge",
    "Next stop Olympus",
    "Olympus eyy let's blow this little city out of the sky",
    "King canyon eyy always felt a bit like home",
    "King's bloody canyon here we go fellas",
    "boom down haha",
    "bloody",
    "you little ripper",
    "you beauty",
    "dropping the motherlode",
    "motherlode's dropping",
    "motherlode's dropping hold on to your hats",
    "motherlode incoming",
    "back on salvo they call me the grenado tornado",
    "lets fill this bloody world with",
    "here comes  a little old school",
    "any of you lads up for a campfire sing song after",
    "taking orders after the games fellas",
    "It's about to get a little loud fellas",
    "let old man fusey show you",
    "all this bloody games need is a bit of old school",
    "bring in the noise bois",
    "nothing like a little chaos eyy",
    "combust to bust",
    "time for a little shock and awesome",
    "what's a few concusions between mates eyy",
    "drinking cold ones before the match making cold ones during the match",
    "it's just you all made fuse",
    "she's bound to get messy",
    "see what an old dog can do",
    "in my experience kids you get more out of life if you dont follow the rules",
    "it's just winge winge bloody winge with you isn't it?",
    "here come's the ",
    "anyone kills me you bloody dead",
    "let's go crack this bloody arena in half",
    "new season's opeing smells like thermite",
    "dont come the rule with me",
    "you lucky we got medbase here mate",
    "don't chucke wobbly",
    "i wouldn't have gone so easy on you",
    "couldn't mind your own",
    "you signed up for this the second you stepped up to the ring with fuse",
    "i know a fella who is great at replacing spines",
    "all these bloody games need is a bit of an old school",
    "terrific mate next round's on me",
    "you were bloody dreaming mate",
    "word of advice young pup",
    "mate you are the very essence of foolish",
    "oh you are a first class waste of bloody time",
    "atleast you died doing what you love ",
    "yeah no know you best maybe next time kid",
    "don't step in the game with fuse",
    "oh don't look at me like that we were just playing around mate",
    "oh you are not feeling so good kid",
    "well don't take it so seriously mate the word game is literally in the title",
    "I always thought you were",
    "Oh C'mon mate",
    "crushing tinis and taking life",
    "didn't you hear mate these games take years of your life",
    "don't be such a bloody soke",
    "don't spit the dummy mate",
    "got a copy of the dental records gonna need em",
    "walk it off mate",
    "you had to lie to bloody fuse didn't ya ",
    "just wasn't your moment kid",
    "tell the devil fuse sent ya",
    "feels like we sorted that out eyy",
    "nothing like a bit of",
    "cold one's after the game",
    "winners are grinners mate",
    "told you mate you were crusing for a bruising",
    "you best not miss",
    "no hard feelings kid what happens in the arena stays in the arena",
    "oh you got bloody smashed mate",
    "you having a winge mate",
    "go on then have a good soke",
    "bloody hell you look like bloody hell",
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
            'Fuse Quips',
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
                          child: Image.asset("assets/images/fuse.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Fuse Quips",
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
