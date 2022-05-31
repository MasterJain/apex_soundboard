import 'dart:io';

import 'package:apex_soundboard/abouthelpers/downloadalert.dart';
import 'package:apex_soundboard/main.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:path_provider/path_provider.dart';

import 'package:share_extend/share_extend.dart';

import 'package:http/http.dart' as http;

class CausticIOS extends StatefulWidget {
  @override
  _CausticIOSState createState() => _CausticIOSState();
}

class _CausticIOSState extends State<CausticIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_caustic_glad_tauntOrigin_01_01_1p.wav?alt=media&token=c15e6f04-a8cb-42f4-947a-f42c7bc4451e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_caustic_glad_tauntOrigin_03_01_1p.wav?alt=media&token=7c72303a-96d6-4c34-af8b-7fd4c4f66625",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F8080%20-%20diag_mp_caustic_bc_congratsKill_condGibraltar_1p.wav?alt=media&token=3eb7bd75-f04f-4e2a-9938-58511e14094a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F8168%20-%20diag_mp_caustic_bc_reviveThanks_condCrypto_3p.wav?alt=media&token=51b690b9-c85f-4412-9963-d5be2856298a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F8170%20-%20diag_mp_caustic_bc_reviveThanks_condGibraltar_3p.wav?alt=media&token=2ea8f3ec-8542-4cd7-96d9-37947667157e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F8171%20-%20diag_mp_caustic_bc_reviveThanks_condWattson_1p.wav?alt=media&token=d126ab84-f21d-4cd3-8c1c-48f151c90d9d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F8178%20-%20diag_mp_caustic_bc_revivingPlayer_condGibraltar_3p.wav?alt=media&token=ba7e0d31-38ee-49f2-9bb2-86d818944f42",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F8179%20-%20diag_mp_caustic_bc_revivingPlayer_condWattson_1p.wav?alt=media&token=9f7fc3cf-2afd-4218-b58e-af591ad5b303",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F9148%20-%20diag_mp_caustic_ping_iWillJoin_calm_condGibraltar_3p.wav?alt=media&token=4b077edc-d6b9-408d-8d23-724e5921fd4a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F9630%20-%20diag_mp_caustic_ping_thanks_condRampart_3p.wav?alt=media&token=c4b5dbb3-c211-498f-8cd7-a0037d2ec595",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F9830%20-%20diag_mp_caustic_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=e0c91ec6-85d5-4be9-9c9e-4dc325d9339e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F9631%20-%20diag_mp_caustic_ping_thanks_condRevenant_1p.wav?alt=media&token=211d34ce-f1d6-4428-97ac-b4d207bf05a0",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2Fmini%2F9828%20-%20diag_mp_caustic_ping_youreWelcome_calm_condCrypto_3p.wav?alt=media&token=890a5317-208b-4222-8c92-9b1926ad66c6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2Fcaustuc1.mp3?alt=media&token=3f87170c-7791-4546-873c-f12a0dd2608a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2Fcaustic2.mp3?alt=media&token=76981497-a244-4bb7-a10c-969f0a6c3798",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F9567%20-%20diag_mp_caustic_ping_youreWelcome_calm_condRevenant_1p.wav?alt=media&token=fe0561e0-4377-4bc9-9723-0766ab75e3d5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F8923%20-%20diag_mp_caustic_ping_interceptor_calm_condWattson_1p.wav?alt=media&token=30f2d888-d292-4bea-a44f-399c387a7a19",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F8522%20-%20diag_mp_caustic_ping_fenceNeutral_calmFar_condWattson_3p.wav?alt=media&token=cc97692a-840c-4283-8350-2a00104c35da",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F8518%20-%20diag_mp_caustic_ping_fenceNeutral_calm_condWattson_3p.wav?alt=media&token=1b519360-28a8-4f6b-a5db-c9832e77f516",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7970%20-%20diag_mp_caustic_bc_reviveThanks_condWattson_3p.wav?alt=media&token=e10c8b97-8f22-4f86-b77d-4282a8b9f5d4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7965%20-%20diag_mp_caustic_bc_reviveSelf_1p.wav?alt=media&token=68540ccf-068f-4a44-8e14-aed688de7080",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7950%20-%20diag_mp_caustic_bc_objectiveLostSquad_3p.wav?alt=media&token=fd850ec0-0de3-4dc9-ae40-570bd9b95079",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7948%20-%20diag_mp_caustic_bc_objectiveLostSelf_3p.wav?alt=media&token=079b2d0b-7638-4a67-a254-64c52e4a797e",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7945%20-%20diag_mp_caustic_bc_objectiveHaveSquad_1p.wav?alt=media&token=732e818b-cd12-4ed3-80a3-3ee5833f5b27",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7943%20-%20diag_mp_caustic_bc_objectiveHaveSelf_1p.wav?alt=media&token=0a7011f0-3b77-4d81-b1e8-96b6a4850ca1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7941%20-%20diag_mp_caustic_bc_nextCircleFar_condWattson_3p.wav?alt=media&token=0eb41d93-4dae-438d-b953-4ebe798b0ec1",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcaustic%2F7940%20-%20diag_mp_caustic_bc_nextCircleFar_condWattson_1p.wav?alt=media&token=f622a9be-5b63-4b48-9381-9c05eff5fc18",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8060%20-%20diag_mp_caustic_glad_introHalloween_01_qw_1p.wav?alt=media&token=a103dd5d-f0eb-4796-93d9-035f24a10b5e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8068%20-%20diag_mp_caustic_glad_introSeq_01_reg_template.wav?alt=media&token=f996a234-05ae-4275-a0f6-e23f12577e3e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8070%20-%20diag_mp_caustic_glad_introSeq_02_qw_1p.wav?alt=media&token=be5f8a67-7190-44fa-bca2-f2e398f9440a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8074%20-%20diag_mp_caustic_glad_introSeq_03_qw_3p.wav?alt=media&token=616d82b8-a162-4154-9fee-2f1eea0efc8f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8076%20-%20diag_mp_caustic_glad_introSeq_04_qw_1p.wav?alt=media&token=84fec855-f1ee-4b2f-9a55-7c2e2798ad62',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8080%20-%20diag_mp_caustic_glad_introSeq_05_qw_3p.wav?alt=media&token=232b5eae-3b99-44e7-9751-1c38b7892871',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8083%20-%20diag_mp_caustic_glad_introSeq_06_qw_3p.wav?alt=media&token=aa56da69-326c-477d-856d-b3359e862008',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8086%20-%20diag_mp_caustic_glad_introSeq_07_qw_3p.wav?alt=media&token=f7f2a8b0-f068-4812-b91f-695ee62ae6ff',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8089%20-%20diag_mp_caustic_glad_introSeq_08_qw_3p.wav?alt=media&token=968bc8f3-7eec-4f49-9e59-13398182c31d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8091%20-%20diag_mp_caustic_glad_introSeq_09_qw_1p.wav?alt=media&token=16a34273-3b48-47bd-82b1-d1482dcc6a32',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8094%20-%20diag_mp_caustic_glad_introSeq_10_qw_1p.wav?alt=media&token=f8bf1211-48bc-4813-8a94-64b2da6bf793',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8097%20-%20diag_mp_caustic_glad_introSeq_11_qw_1p.wav?alt=media&token=20f2d92e-3869-4523-802a-96be7f093c8c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8099%20-%20diag_mp_caustic_glad_introSeq_12.wav?alt=media&token=94d2920a-f9b1-4c12-9681-e8a0f422bd90',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8103%20-%20diag_mp_caustic_glad_introSeq_13_qw_1p.wav?alt=media&token=b5f41a76-0070-45a1-b3df-f2148f8e6ff5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8106%20-%20diag_mp_caustic_glad_introSeq_14_qw_1p.wav?alt=media&token=27fa1df8-f68c-440d-b5e8-22a52bd9f4a1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8109%20-%20diag_mp_caustic_glad_introSeq_15_qw_1p.wav?alt=media&token=d34906fe-131b-48f8-896a-3b09a8badb92',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8113%20-%20diag_mp_caustic_glad_introSeq_16_qw_3p.wav?alt=media&token=3b4e010d-fa97-4344-a406-e61ef419f916',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8115%20-%20diag_mp_caustic_glad_introSeq_17_qw_1p.wav?alt=media&token=246f2419-5eba-4753-b621-e0dddefca72b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8119%20-%20diag_mp_caustic_glad_introSeq_18_qw_3p.wav?alt=media&token=7eca7177-1443-4050-a250-bbdd1f28d0fc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8121%20-%20diag_mp_caustic_glad_introSeq_19_qw_1p.wav?alt=media&token=3e6c16b9-2b4c-4efd-89e7-e54737fb6663',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8125%20-%20diag_mp_caustic_glad_introSeq_20_qw_3p.wav?alt=media&token=ecc1ea47-692d-4970-a0df-80e41155451d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8128%20-%20diag_mp_caustic_glad_introSeq_21_qw_3p.wav?alt=media&token=264a4565-d029-41bf-a156-b2c831cbf8f9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8140%20-%20diag_mp_caustic_glad_seasonOpen.wav?alt=media&token=4f6544e7-57ee-49c8-ad52-af892c9ec73a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8145%20-%20diag_mp_caustic_glad_taunt_01_3p.wav?alt=media&token=3b82f7f4-8547-4403-86fc-2f2bd5bbbbf1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8149%20-%20diag_mp_caustic_glad_taunt_02_1p.wav?alt=media&token=9b22836c-8cb4-4c28-807a-e17699c9ce1b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8153%20-%20diag_mp_caustic_glad_taunt_03_3p.wav?alt=media&token=29d434f0-3735-4a41-a400-ea7e719de04c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8155%20-%20diag_mp_caustic_glad_taunt_04_1p.wav?alt=media&token=f1612888-669f-4832-9f47-01f40f3c9bfe',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8158%20-%20diag_mp_caustic_glad_taunt_05_1p.wav?alt=media&token=526e5e76-3238-46c5-aea2-63aa4c56ab2a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8161%20-%20diag_mp_caustic_glad_taunt_06_1p.wav?alt=media&token=a8af50e6-053e-4cdb-9708-4729f7b74649',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8164%20-%20diag_mp_caustic_glad_taunt_07_1p.wav?alt=media&token=1f4136a7-4d05-4486-9577-31bb8ca56b1a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8168%20-%20diag_mp_caustic_glad_taunt_08_3p.wav?alt=media&token=e0494124-f423-4ef2-aa11-f41c75777be1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8170%20-%20diag_mp_caustic_glad_taunt_09_1p.wav?alt=media&token=b5c153de-45bb-4f54-98a0-ec38140132e0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8174%20-%20diag_mp_caustic_glad_taunt_10_3p.wav?alt=media&token=6bba28f8-f9d5-4ff6-b18b-ce25c1850304',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8177%20-%20diag_mp_caustic_glad_taunt_11_3p.wav?alt=media&token=c93cb5a6-4ad8-44bc-a5ac-32c30a0fb159',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8183%20-%20diag_mp_caustic_glad_taunt_13_3p.wav?alt=media&token=928a16cd-4109-456b-91bd-010a61cb5ced',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8185%20-%20diag_mp_caustic_glad_taunt_14_1p.wav?alt=media&token=14bbb13a-c921-4b92-925e-45ce4530c709',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8188%20-%20diag_mp_caustic_glad_taunt_15_1p.wav?alt=media&token=69ae8714-8add-4bbb-9393-46ac58692d01',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8194%20-%20diag_mp_caustic_glad_taunt_17_1p.wav?alt=media&token=87ef5d1e-c8cf-4057-8510-ca6d74d0e98a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8197%20-%20diag_mp_caustic_glad_taunt_18_1p.wav?alt=media&token=89cb9edd-dfda-4574-88f5-0c42192306e1',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8200%20-%20diag_mp_caustic_glad_taunt_19_1p.wav?alt=media&token=8b89f365-5ec7-4dc9-acfe-e6fae81011cf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8204%20-%20diag_mp_caustic_glad_taunt_20_3p.wav?alt=media&token=f5b36135-d48a-4cca-9feb-53b02cfd4ecb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8207%20-%20diag_mp_caustic_glad_taunt_21_3p.wav?alt=media&token=3db342ea-1e86-49e0-a100-b12ec4e7a618',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8210%20-%20diag_mp_caustic_glad_taunt_22_3p.wav?alt=media&token=86f8046d-dfaf-4ca1-a1c5-b4a193c8f91d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8212%20-%20diag_mp_caustic_glad_taunt_23_1p.wav?alt=media&token=dc8708d9-b483-49fd-916e-c002e13f4e3f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8215%20-%20diag_mp_caustic_glad_taunt_24_1p.wav?alt=media&token=028ea063-a7b3-4516-a66b-da7bd6eb6c13',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8219%20-%20diag_mp_caustic_glad_taunt_25_3p.wav?alt=media&token=9b3b25f2-2a8e-42da-8099-46b8fdb0d625',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8222%20-%20diag_mp_caustic_glad_taunt_26_3p.wav?alt=media&token=4c3b7c76-1008-49a4-b1a3-f77dc68da3a6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8225%20-%20diag_mp_caustic_glad_taunt_27_3p.wav?alt=media&token=27f9f9e3-812b-491b-a824-3615c14c1e4c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8227%20-%20diag_mp_caustic_glad_taunt_28_1p.wav?alt=media&token=cb97c5cc-3593-477b-8095-6c3481c35e09',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8230%20-%20diag_mp_caustic_glad_taunt_29_1p.wav?alt=media&token=f9f12d05-6fd3-48db-9b48-f0d243772f6b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8233%20-%20diag_mp_caustic_glad_taunt_30_1p.wav?alt=media&token=60842acf-8477-4698-8e05-bbadb680307f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8236%20-%20diag_mp_caustic_glad_taunt_31_1p.wav?alt=media&token=4498215b-a027-42d9-95e0-ca533aa4a85a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8239%20-%20diag_mp_caustic_glad_taunt_32_1p.wav?alt=media&token=ae9b7d2a-722c-445c-bbef-3cf9bc195eeb',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8242%20-%20diag_mp_caustic_glad_taunt_33_1p.wav?alt=media&token=9dff136c-dcae-4217-905e-30eccf006f31',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8245%20-%20diag_mp_caustic_glad_taunt_34_1p.wav?alt=media&token=ea855ae4-c2e0-40a7-95a0-3b01a9c2e0d4',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8248%20-%20diag_mp_caustic_glad_taunt_35_1p.wav?alt=media&token=c97db0fa-89cf-414c-b140-276f8923fa43',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8251%20-%20diag_mp_caustic_glad_taunt_36_1p.wav?alt=media&token=3b1f0a4a-3211-4f82-aed2-7d53ad08f8d5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8254%20-%20diag_mp_caustic_glad_taunt_37_1p.wav?alt=media&token=b9022ebb-b12e-482c-95ce-83e1f2283cdd',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8257%20-%20diag_mp_caustic_glad_taunt_38_1p.wav?alt=media&token=e48322bb-9ded-44c1-b1bf-47e08d2c81df',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8260%20-%20diag_mp_caustic_glad_taunt_39_1p.wav?alt=media&token=8b49fa25-e95d-4634-ab4c-df8476c3a343',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8263%20-%20diag_mp_caustic_glad_taunt_40_1p.wav?alt=media&token=1e9c14f3-cec5-480c-915d-707b73a5bf1f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8266%20-%20diag_mp_caustic_glad_taunt_41_1p.wav?alt=media&token=75ada0f6-c262-4a3d-986e-6d0251bbb7d0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8269%20-%20diag_mp_caustic_glad_tauntHalloween_01_1p.wav?alt=media&token=d24ad370-97f0-4b54-9576-be3cc776afaa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8272%20-%20diag_mp_caustic_glad_tauntHalloween_02_1p.wav?alt=media&token=cbc5f4f7-8e89-4966-a459-120008f11fe9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8276%20-%20diag_mp_caustic_glad_tauntValentines_01_3p.wav?alt=media&token=6bc95d2b-9298-4187-bb0a-a8396786e267',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8278%20-%20diag_mp_caustic_glad_tauntValentines_02_1p.wav?alt=media&token=3c3603b9-6a5d-49a2-94bd-9f7b4f044438',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8282%20-%20diag_mp_caustic_glad_tauntWinter_01_3p.wav?alt=media&token=bbebab50-bc25-4eef-a3ad-878454b649ba',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/8286%20-%20diag_mp_caustic_glad_tauntWinter_02_3p_victim.wav?alt=media&token=ddf267ce-f721-4cda-983d-90ea15d366e4',
  ];

  final List<String> quipnames = [
    "If only my youngerself (NEW)",
    "Your death is fascinating (NEW)",
    "Nice job I knew you had that killer instinct",
    "This changes nothing boy",
    "Careful Gibraltar never know when you could loose that eye",
    "I realise you could have made a diffrent choice,Thank you",
    "This is what relying on humanity gets you almost killed",
    "Hate me all you want the world still needs you",
    "I will go to after you Gibraltar I Insist",
    "Thank you and if I might add modding is not an actual word",
    "You rush to her aid and you reject me",
    "We should teach loba to stay out of our affairs",
    "This isnt over gutterrat",
    "Careful simulacrum!you have touched death so often,It will be a joy to disect you ",
    "I will remember this when you are looking for allies against Miss Andrade ",
    "Very Well ",
    "Your interceptor is here Miss Paquette ",
    "Miss Paquette your fence is out there ",
    "I spot one of your previous fences Miss Paquette ",
    "My Work shall continue thanks to you Miss Paquette ",
    "Not even death can prevent me from completing my work ",
    "It seems we have concceded the objective ",
    "The obejctive is Lost,Not the Yield I was looking for ",
    "We have what we came for our primary objective ",
    "I'm in possession of the objective ",
    "You created this thing Miss Paquette,You couldn't create a backdoor to work around it ",
    "Next ring is far,you think you can give advantage Miss Paquette? ",
    'I find this celebbrations amusing',
    'Life is meant to die accept your fates',
    'Join my experiment below',
    'Watch for my traps,I will be watching you',
    'I don\'t relish the title,I relish the kill',
    'Test me I encourage this',
    'Science is precise',
    'Intelligence is a dying breed but not today',
    'It all ends the same way',
    'Deterministic end will find you below',
    'I will not apologise for simply expiditing the inevitable',
    'My methods are only controversial',
    'Patience just Patience',
    'If our paths crossed you will wish the end came sooner',
    'Marvelous! So many willing test subjects',
    'Don\'t rush to your end I linger on those final moments',
    'Know your place i know mine',
    'Close combat gets messy',
    'The kill is more important than the prize',
    'Quick death is so boring',
    'You and I are not equals',
    'I have no regrets',
    'Opening Season very well',
    'Without pain the body suffers in silence',
    'To say your death is a waste is the understatment of the century',
    'I dont concern myself with the ambitions of insects',
    'Know your place,at the bottom of the food chain',
    'It\'s a miraculous thing',
    'One more',
    'Your welcome',
    'In the end everything dies',
    'This is my favourite part',
    'It\'s simple really,I\'m just better than you',
    'I thank you',
    'The rabbits cries bring the wolf',
    'I must confess',
    'The biggest trap is your own mind',
    'Take comfort in the fact that you are now part of something grander',
    'Science demands an repetable outcome to any given experiment',
    'The results have come in you loose',
    'There is a process to everything and also a conclusion',
    'Another trial another test subject',
    'Just a taste is all you need',
    'Take notes I\'am',
    'You thought we were equals',
    'Victory is delicious',
    'The distance between life and death is measured by suffering',
    'Don\'t look for sympathy you won\'t find it',
    'Accept the process',
    'Your outcome would have been diffrent',
    'This was a failure for one of us',
    'This was an inevitable outcome',
    'My intelligence should not be underestimated',
    'You made an attempt on my life',
    'Some compounds are inert having little to no effect on the outcome',
    'Being fundemantly better souvers the taste of victory',
    'I don\'t consider death cruel but life',
    'In the end one\'s life is measured by those we changed',
    'I observe the field from a plateau you cannot even comprehend',
    'Humanity,It\'s just a word',
    'Life ends with death',
    'In time the strong will filter out the weak',
    'What\'s your costume? Subaverage intelligence',
    'The seasonal fascination with death is',
    'Saint Valentine had to beaten stoned and decapitated',
    'I think you misunderstood my intention when i asked for your heart',
    'I enjoy the winter months everything dies',
    'You are about to face the longest winter of them all',
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
            'Caustic Quips',
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
                          child: Image.asset("assets/images/caustic.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Caustic Quips",
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
