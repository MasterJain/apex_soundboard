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

class CryptoIOS extends StatefulWidget {
  @override
  _CryptoIOSState createState() => _CryptoIOSState();
}

class _CryptoIOSState extends State<CryptoIOS> {
  final List<String> audio = [
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/mayupdate%2Forigins%2Fdiag_mp_crypto_glad_tauntOrigin_01_01_1p.wav?alt=media&token=f84bd455-b96f-42af-9be8-1a08e9c2f605",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F9998%20-%20diag_mp_crypto_bc_revivingPlayer_condWattson_3p.wav?alt=media&token=007b44db-51e3-4104-af11-0747e81dd3ab",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F9993%20-%20diag_mp_crypto_bc_revivingPlayer_condCaustic_1p.wav?alt=media&token=a47c4084-bbd5-45e1-a383-27444c83229a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F9990%20-%20diag_mp_crypto_bc_reviveThanks_condWattson_3p.wav?alt=media&token=3460321d-7408-4d36-8fd4-971581f31adf",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/august%2Frampart%20%2F9985%20-%20diag_mp_crypto_bc_reviveThanks_condCaustic_1p.wav?alt=media&token=73def295-f5f5-4eb5-b9df-b2528196f8c2",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F11333%20-%20diag_mp_crypto_ping_youreWelcome_calm_condRevenant_1p.wav?alt=media&token=b788089e-54ae-476b-8dbe-7178c59ca438",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F11334%20-%20diag_mp_crypto_ping_youreWelcome_calm_condRevenant_3p.wav?alt=media&token=d617eaf5-34eb-4a75-95ab-a732f451f8c7",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9657%20-%20diag_mp_crypto_bc_iBecomeKillLeader_condMirage_1p.wav?alt=media&token=2039a256-3881-41d5-a549-1b09ba46344a",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9692%20-%20diag_mp_crypto_bc_objectiveHaveSelf_1p.wav?alt=media&token=e8bf1487-bee6-4266-8885-eb33a20f7e1d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9694%20-%20diag_mp_crypto_bc_objectiveHaveSquad_1p.wav?alt=media&token=d2139abc-d9b6-4861-a8da-0c7826e1ef06",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9697%20-%20diag_mp_crypto_bc_objectiveLostSelf_3p.wav?alt=media&token=ea4b025f-4b96-43ad-9953-573a8d77cf37",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9699%20-%20diag_mp_crypto_bc_objectiveLostSquad_3p.wav?alt=media&token=b88f3e6a-f954-412d-892a-1e6f2fdf3dc6",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9710%20-%20diag_mp_crypto_bc_reviveSelf_1p.wav?alt=media&token=4219a650-e443-4c60-a2e2-dc3892f9f26d",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9711%20-%20diag_mp_crypto_bc_reviveSelf_3p.wav?alt=media&token=71a8ec1f-0202-4e50-a52d-f48c04f97fc4",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9715%20-%20diag_mp_crypto_bc_reviveThanks_condMirage_3p.wav?alt=media&token=54135281-bc1d-4e5b-ac23-74ca37fe738c",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9719%20-%20diag_mp_crypto_bc_revivingPlayer_condMirage_3p.wav?alt=media&token=0848b94e-5f9e-4b38-9303-f0ce747aa7cc",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9729%20-%20diag_mp_crypto_bc_squadKill_condMirage_3p.wav?alt=media&token=9a0915b2-64ac-4048-963e-190850df3f44",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9756%20-%20diag_mp_crypto_bc_thCompleted_3p.wav?alt=media&token=e3342e36-343d-46ff-8c7b-148f3ea9adc5",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9768%20-%20diag_mp_crypto_bc_thIntro_3p.wav?alt=media&token=ef1a9dfa-d1fd-4acf-98b0-faf450372322",
    "https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/june%2Fcrypto%2F9769%20-%20diag_mp_crypto_bc_thIntro_solo.wav?alt=media&token=da290f49-0fa4-4c9a-88d6-b1b8ffcff53b",
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9803%20-%20diag_mp_crypto_glad_introHalloween_01_qw_1p.wav?alt=media&token=3bb930db-c6b3-4ef7-a44d-155cf10d7f6a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9807%20-%20diag_mp_crypto_glad_introSeq_01_qw_1p.wav?alt=media&token=4e7a68bc-45d5-4bb1-a70b-d9db52c31348',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9814%20-%20diag_mp_crypto_glad_introSeq_02_qw_3p.wav?alt=media&token=7345d6cb-b268-4550-8860-7be46d74df54',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9817%20-%20diag_mp_crypto_glad_introSeq_03_qw_3p.wav?alt=media&token=64740ddd-a739-47a3-a6d3-3f89c65579ac',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9819%20-%20diag_mp_crypto_glad_introSeq_04_qw_1p.wav?alt=media&token=40981b1d-e0bd-4bb9-ada1-b8c09c0a30fa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9822%20-%20diag_mp_crypto_glad_introSeq_05_qw_1p.wav?alt=media&token=d81e30f4-c7bb-426e-b920-83a89a20b12d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9825%20-%20diag_mp_crypto_glad_introSeq_06_qw_1p.wav?alt=media&token=b23c8ff3-9c0e-415d-8497-7ece8206a892',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9829%20-%20diag_mp_crypto_glad_introSeq_07_qw_3p.wav?alt=media&token=55106d69-1921-4d9f-a3d3-83817f9d2f86',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9832%20-%20diag_mp_crypto_glad_introSeq_08_qw_3p.wav?alt=media&token=5e6e91f8-6f81-445d-a6bb-7c4e48353cc0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9835%20-%20diag_mp_crypto_glad_introSeq_09_qw_3p.wav?alt=media&token=e8e228d0-2aee-4f6b-b12e-211928d068b2',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9837%20-%20diag_mp_crypto_glad_introSeq_10_qw_1p.wav?alt=media&token=48c20a5e-f492-454d-a1d4-ef989b6d3d62',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9841%20-%20diag_mp_crypto_glad_introSeq_11_qw_3p.wav?alt=media&token=c5c2507f-992e-4700-a501-6f72d1c19b26',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9844%20-%20diag_mp_crypto_glad_introSeq_12_qw_3p.wav?alt=media&token=763f942c-a5ae-44fd-b151-bff8abe634d5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9847%20-%20diag_mp_crypto_glad_introSeq_13_qw_3p.wav?alt=media&token=885ab946-8e37-4463-99bb-c61b809d9327',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9850%20-%20diag_mp_crypto_glad_introSeq_14_qw_3p.wav?alt=media&token=7857403e-dbda-4b58-bc91-f879617621e5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9852%20-%20diag_mp_crypto_glad_introSeq_15_qw_1p.wav?alt=media&token=8b50104e-d8cb-4aab-a186-e1f9bc8fd46f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9856%20-%20diag_mp_crypto_glad_introSeq_16_qw_3p.wav?alt=media&token=19b346dd-1087-4db6-97e2-e0937159ea34',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9859%20-%20diag_mp_crypto_glad_introSeq_17_qw_3p.wav?alt=media&token=14c5457d-3a29-4b90-943d-bab14fa090f9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9862%20-%20diag_mp_crypto_glad_introSeq_18_qw_3p.wav?alt=media&token=a81f1196-791a-4b79-839c-e1f0f4e33c33',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9865%20-%20diag_mp_crypto_glad_introSeq_19_qw_3p.wav?alt=media&token=e82233d3-8fe5-4d87-9bf2-72fc811bb4e7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9868%20-%20diag_mp_crypto_glad_introSeq_20_qw_3p.wav?alt=media&token=493bbba1-3571-4972-a2ab-13ade4180828',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9871%20-%20diag_mp_crypto_glad_introSeq_21_qw_3p.wav?alt=media&token=59080ea7-3c89-41c7-91d7-8f4780d1bef6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9884%20-%20diag_mp_crypto_glad_seasonOpen_qw_1p.wav?alt=media&token=cab1cc5b-e20b-4453-b48a-14c622fc527b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9886%20-%20diag_mp_crypto_glad_taunt_01_1p.wav?alt=media&token=344d691d-abdb-4d58-a6f7-f14ad3b0924c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9892%20-%20diag_mp_crypto_glad_taunt_02_1p.wav?alt=media&token=8eff39a7-2688-468f-b3fa-4fa1c54d1a75',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9895%20-%20diag_mp_crypto_glad_taunt_03_1p.wav?alt=media&token=2b7d4cce-e525-47ab-8fb4-f7d3ed7ce1e0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9898%20-%20diag_mp_crypto_glad_taunt_04_1p.wav?alt=media&token=9e3f1466-6594-48b4-9f52-477b5483307f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9901%20-%20diag_mp_crypto_glad_taunt_05_1p.wav?alt=media&token=5c616cac-8df8-43bd-8e33-e967786bf744',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9904%20-%20diag_mp_crypto_glad_taunt_06_1p.wav?alt=media&token=1f305c78-7541-49ec-80c7-ff528d5ceec5',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9907%20-%20diag_mp_crypto_glad_taunt_07_1p.wav?alt=media&token=3f97b31e-d857-44e2-bb32-1782940a448c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9911%20-%20diag_mp_crypto_glad_taunt_08_3p.wav?alt=media&token=870a5b53-aed6-4e94-887c-1435708cabbf',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9914%20-%20diag_mp_crypto_glad_taunt_09_3p.wav?alt=media&token=c7a7cebf-685b-4e54-a601-04061ff04c0a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9916%20-%20diag_mp_crypto_glad_taunt_10_1p.wav?alt=media&token=fcb96a0c-877d-49d8-a34f-6116f91c965c',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9919%20-%20diag_mp_crypto_glad_taunt_11_1p.wav?alt=media&token=a8ab28ad-7f39-4f12-ac8d-88a03bf114fc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9922%20-%20diag_mp_crypto_glad_taunt_12_1p.wav?alt=media&token=6f0dee94-2d13-40bd-8db7-5708440286de',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9926%20-%20diag_mp_crypto_glad_taunt_13_3p.wav?alt=media&token=348ada84-ca8f-464d-b6ae-54fcbf9a9098',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9928%20-%20diag_mp_crypto_glad_taunt_14_1p.wav?alt=media&token=2afc1c3f-d88f-4ffc-8ae7-6f571d7142dc',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9931%20-%20diag_mp_crypto_glad_taunt_15_1p.wav?alt=media&token=ca033b7a-6c1a-44c8-bb96-03acb87cd03b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9934%20-%20diag_mp_crypto_glad_taunt_16_1p.wav?alt=media&token=fc170805-44ec-49be-9a1e-0707f2ba2f86',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9937%20-%20diag_mp_crypto_glad_taunt_17_1p.wav?alt=media&token=0bda4ce4-c561-4741-a43c-cac84539c2a8',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9940%20-%20diag_mp_crypto_glad_taunt_18_1p.wav?alt=media&token=cee73c2e-e8e6-4d8b-ad22-3c159aeafd44',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9943%20-%20diag_mp_crypto_glad_taunt_19_1p.wav?alt=media&token=4e7340b3-8b0b-4d84-a8f5-fc95242c0aaa',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9947%20-%20diag_mp_crypto_glad_taunt_20_3p.wav?alt=media&token=165fa70a-8d10-44aa-af43-8c5129ba2a2b',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9950%20-%20diag_mp_crypto_glad_taunt_21_3p.wav?alt=media&token=b57d98f4-7483-44bc-bd97-f0df8bcddce3',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9953%20-%20diag_mp_crypto_glad_taunt_22_3p.wav?alt=media&token=7e280aac-e786-4605-976b-68b70bd5101f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9955%20-%20diag_mp_crypto_glad_taunt_23_1p.wav?alt=media&token=a940c13b-d205-49e2-a380-8597b78b9215',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9958%20-%20diag_mp_crypto_glad_taunt_24_1p.wav?alt=media&token=f026543c-0b16-46c6-8e03-dd3e7530b4a6',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9961%20-%20diag_mp_crypto_glad_taunt_25_1p.wav?alt=media&token=377c5d37-e031-4c42-b954-14b865ba2997',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9964%20-%20diag_mp_crypto_glad_taunt_26_1p.wav?alt=media&token=03f82f47-5c82-4efd-ba70-1877c44c52d7',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9967%20-%20diag_mp_crypto_glad_taunt_27_1p.wav?alt=media&token=ebaacde0-d7eb-40e8-8de8-0097c720f5be',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9970%20-%20diag_mp_crypto_glad_taunt_28_1p.wav?alt=media&token=91bd3b64-3f25-4f97-801a-af54581154f9',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9974%20-%20diag_mp_crypto_glad_taunt_29_3p.wav?alt=media&token=fac4e708-8d2e-4e92-8b4b-9275bdef8512',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9976%20-%20diag_mp_crypto_glad_taunt_30_1p.wav?alt=media&token=9b82771a-f113-402c-83d8-135e3688e856',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9981%20-%20diag_mp_crypto_glad_taunt_31_3p_victim.wav?alt=media&token=67b6ca5a-11b9-427c-bc1d-879b7fbcbd7a',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9985%20-%20diag_mp_crypto_glad_taunt_33_1p.wav?alt=media&token=376325b9-8494-40a8-bbda-66755bc9029d',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9991%20-%20diag_mp_crypto_glad_taunt_35_1p.wav?alt=media&token=b56e66d5-4f76-4dbc-883a-19b65b63284e',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9995%20-%20diag_mp_crypto_glad_taunt_36_3p.wav?alt=media&token=9501bc66-5e89-47d9-b93f-d11fa409d3f0',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/9997%20-%20diag_mp_crypto_glad_taunt_37_1p.wav?alt=media&token=4913c4ab-f8b8-4f50-bf1b-360834fb2bca',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10000%20-%20diag_mp_crypto_glad_taunt_38_1p.wav?alt=media&token=2452fba4-b9dd-470f-9b1f-f91029a4d370',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10004%20-%20diag_mp_crypto_glad_taunt_39_3p.wav?alt=media&token=fbd461ba-80e6-42a1-b1b5-608b1b061547',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10007%20-%20diag_mp_crypto_glad_taunt_40_3p.wav?alt=media&token=459a75d3-1e7a-4bf1-b556-0fcb0074b667',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10009%20-%20diag_mp_crypto_glad_taunt_41_1p.wav?alt=media&token=af21aa18-80b8-4f52-b704-20f9a7e12060',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10013%20-%20diag_mp_crypto_glad_taunt_45_3p.wav?alt=media&token=72be374c-bc09-49bf-96a3-4724da2cb513',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10017%20-%20diag_mp_crypto_glad_tauntHalloween_01_1p.wav?alt=media&token=bcd46231-9bfc-40f3-a823-ca69b3ef1287',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10020%20-%20diag_mp_crypto_glad_tauntHalloween_02_1p.wav?alt=media&token=2cfda284-e6d6-40d4-be26-18c2bed3ab34',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10023%20-%20diag_mp_crypto_glad_tauntValentines_01_1p.wav?alt=media&token=a3f433dc-f231-4a68-9685-ad5d43ee5528',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10027%20-%20diag_mp_crypto_glad_tauntValentines_02_3p.wav?alt=media&token=093a41c0-574d-4cc7-a67b-28226fad529f',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10030%20-%20diag_mp_crypto_glad_tauntWinter_01_3p.wav?alt=media&token=c727590e-e639-4221-8a81-d757a9a96817',
    'https://firebasestorage.googleapis.com/v0/b/apexsounds-6711f.appspot.com/o/10033%20-%20diag_mp_crypto_glad_tauntWinter_02_3p.wav?alt=media&token=9d2ea276-84ce-4d5d-82c2-950925c87397',
  ];

  final List<String> quipnames = [
    "In my old life all I saw was 0's and 1's (NEW)",
    "You are not done yet we need you",
    "You are necessary get up",
    "Hmm Right",
    "Ookine",
    "Quiet,I must focus ",
    "I don't care ",
    "Sorry Elliot,But the kill leader goes to the best and that's me ",
    "The objective is Mine ",
    "Chuva,We have the Objective ",
    "The objective is gone,I wasn't prepared ",
    "We have failed,the objective is gone ",
    "They will not remove me today ",
    "I will give up when I'm dead ",
    "Thank you,Maybe you are not the fool I took you as for now ",
    "Yaa,I got you old man,you are welcome ",
    "Took out a full squad,try and keep up old man ",
    "Got the piece,time to be anywhere but here ",
    "Get the piece, get out quick and quiet ",
    "I have a piece to find,they could have atleast given me a challenge ",
    'We all wear costumes to hide who we are',
    'You found me,Now come and get me?',
    'Think you can surprise me?',
    'It\'s easy to get here harder to walk away',
    'You should be careful',
    'You better hope I find you before they do',
    'Truth is coming and I won\'t be stopped',
    'We are all just data waiting to be deleted',
    'You think you are not being watched right now',
    'If I know who you are so did they break the rules and you are gone',
    'When you have nothing else to loose,it\'s easy to win',
    'This is only the begining',
    'I\'m not a pawn,I\'m here to break the game',
    'Do not trust what you think you know',
    'I\'m here because I have to be,What\'s your excuse?',
    'It\'s easy to run away but you gain nothing',
    'This maybe the last time you compete',
    'I have been through hell to get here',
    'I used to fear many things but that man is gone',
    'It\'s only one thing you need to know to survive',
    'Korean Mumbling',
    'It\'s very simple,I know more than each of you can possibly imagine',
    'It\'s hard to give up,When you have already given up so much',
    'They,They did this to both of us',
    'Don\'t take it personally they would have gotten to you one way or another',
    'You got to watch your back',
    'I don\'t know who you are and I don\'t really care',
    'Only fight the battles you know you can win',
    'Legend sometimes we are all someone we are not',
    'You are just a messenger i get that',
    'Access Denied',
    'You should have been more prepared',
    'I knew you would come after me',
    'Sometimes it\'s hard to run when I\'m watching your every move',
    'I cracked your securities and your face',
    'A lot of people run from something that\'s not after them',
    'You can\'t hide from your mistakes',
    'You can only hide from the inevitable for so long',
    'It\'s not your fault,I get it.',
    'You can run You can hide but you can\'t escape yourself',
    'You got a bug,lemme fix it',
    'You really messed up but what do I know',
    'They don\'t know everything but me',
    'I make this simple,It\'s all about the information you have',
    'I never heard of you and now no one ever will',
    'Korean Mumbling',
    'I\'m sure you were looking for me',
    'Seems you should have been a bit more careful',
    'I knew you were coming',
    'I know you wish you knew what I know',
    'I bet you, you want to know who I am?',
    'They say knowledge is power but what you do with it,That\'s what important',
    'Sometimes they catch upto you,Sometimes they loose',
    'I have been watching you,you are not bad',
    'You found me good eyes',
    'It appears that intelligence is just a word to you',
    'I don\'t know if you are bad or just idiot,either way you are gone',
    'No one will find you',
    'Sorry,It had to be this way,you are not the one I\'m after',
    'I have seen target dummy\'s smarter than you',
    'It wasn\'t personal,you are just in my way',
    'Seems like you zigged when you should have quit and gone home',
    'You thought you were better than me',
    'How do you know this isn\'t my mask',
    'We don\'t know who we are until we are faced with the loss of life',
    'Love is blind and so are you',
    'They say you are most alive when you are in love',
    'Joy,Cheer,They took that away from me',
    'Winter may be long but this journey that\'s cut short for you',
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
            'Crypto' + ' Quips',
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
                          child: Image.asset("assets/images/crypto.png"),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          quipnames[index],
                          style: const TextStyle(fontFamily: 'Raleway'),
                        ),
                        subtitle: const Text(
                          "Crypto Quips",
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
