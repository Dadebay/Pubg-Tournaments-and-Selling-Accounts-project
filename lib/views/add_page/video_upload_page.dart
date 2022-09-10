// ignore_for_file: deprecated_member_use, file_names, depend_on_referenced_packages, avoid_void_async, always_declare_return_types, type_annotate_public_apis, unnecessary_statements, unrelated_type_equality_checks

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:game_app/constants/index.dart';
import 'package:game_app/controllers/settings_controller.dart';
import 'package:game_app/models/add_account_model.dart';

import 'package:mime/mime.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:video_player/video_player.dart';

class VideoUploadPage extends StatefulWidget {
  const VideoUploadPage({Key? key}) : super(key: key);

  @override
  State<VideoUploadPage> createState() => _VideoUploadPageState();
}

class _VideoUploadPageState extends State<VideoUploadPage> {
  File? selectedImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        selectedImage = imageTemporary;
      });
    } catch (error) {
      showSnackBar('noConnection3', '$error', Colors.red);
    }
  }

  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  File? selectedVideo;
  Future pickVideo() async {
    try {
      XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery, maxDuration: const Duration(seconds: 30));
      if (video == null) {
        return;
      }
      final imageTemporary = File(video.path);
      final bytes = imageTemporary.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      final VideoPlayerController testLengthController = VideoPlayerController.file(
        File(video.path),
      ); //Your file here
      await testLengthController.initialize();

      if (testLengthController.value.duration.inSeconds > 60) {
        showSnackBar('noConnection3', 'video_upload_subtitle_error', Colors.red);
        video = null;
      } else {
        if (15.0 >= mb) {
          setState(() {
            selectedVideo = imageTemporary;
            _controller = VideoPlayerController.file(selectedVideo!);
            _controller!.pause();
            _initializeVideoPlayerFuture = _controller!.initialize();
          });
        } else {
          showSnackBar('noConnection3', 'video_size_error', Colors.amber);
          video = null;
        }
      }
    } catch (error) {
      showSnackBar('noConnection3', '$error', Colors.red);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  int a = 0;
  dynamic changeLimit() {
    debugPrint('geldiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    AddAccountModel().getConsts().then((value) {
      a = value['video_limit'];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    changeLimit();
  }

  int myNumber = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(fontSize: 20, backArrow: true, iconRemove: false, name: 'videoUpload', elevationWhite: true),
        body: Container(
          color: kPrimaryColorBlack,
          width: Get.size.width,
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Text(
                  'video_upload_title'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
                ),
              ),
              Text(
                '$myNumber/$a',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
              ),
              Row(
                children: [
                  Expanded(child: selectImage()),
                  Expanded(child: videoPlayer()),
                ],
              ),
              AgreeButton(
                onTap: onTapp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic selectImage() {
    if (selectedImage != null) {
      return GestureDetector(
        onTap: () {
          pickImage();
        },
        child: Container(
          height: 170,
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          child: ClipRRect(
            borderRadius: borderRadius15,
            child: Image.file(selectedImage!, fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          pickImage();
        },
        child: Container(
          height: 170,
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(6),
            strokeWidth: 2,
            color: kPrimaryColor,
            child: const Center(
              child: Text(
                'Video Poster Image',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor, fontFamily: josefinSansSemiBold, fontSize: 20),
              ),
            ),
          ),
        ),
      );
    }
  }

  FutureBuilder<void> videoPlayer() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              pickVideo();
            },
            child: Container(
              height: 170,
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: const ClipRRect(
                borderRadius: borderRadius15,
                child: Text('asd'),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              pickVideo();
            },
            child: Container(
              height: 170,
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                strokeWidth: 2,
                color: kPrimaryColor,
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                    size: 50,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  onTapp() async {
    Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;

    final token = await Auth().getToken();
    final headers = {'Authorization': 'Bearer $token'};
    final request = http.MultipartRequest('POST', Uri.parse('$serverURL/api/accounts/upload-video/'));
    request.headers.addAll(headers);

    final String fileName = selectedImage!.path.split('/').last;
    final stream = http.ByteStream(DelegatingStream.typed(selectedImage!.openRead()));
    final length = await selectedImage!.length();
    final mimeTypeData = lookupMimeType(selectedImage!.path, headerBytes: [0xFF, 0xD8])!.split('/');
    final multipartFileSign = http.MultipartFile('poster', stream, length, filename: fileName, contentType: MediaType(mimeTypeData.first, mimeTypeData[1]));
    request.files.add(multipartFileSign);

    final String fileName1 = selectedVideo!.path.split('/').last;
    final stream1 = http.ByteStream(DelegatingStream.typed(selectedVideo!.openRead()));
    final length1 = await selectedVideo!.length();
    final mimeTypeData1 = lookupMimeType(selectedVideo!.path, headerBytes: [0xFF, 0xD8])!.split('/');
    final multipartFileSign1 = http.MultipartFile('video', stream1, length1, filename: fileName1, contentType: MediaType(mimeTypeData1.first, mimeTypeData1[1]));
    request.files.add(multipartFileSign1);

    final http.StreamedResponse response = await request.send();
    print(response.stream);
    print(response.statusCode);
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      myNumber++;
      showSnackBar('Video', '$myNumber video upload boldy', Colors.green);
      setState(() {});
      selectedImage = null;
      await selectedVideo!.delete();

      print('geeeeeeeeeeeeeeeeeeeeeeeeeeeecccccccccccccccccccddddddddddddddddddddddddddiiiiiiiiiiiiiiiiii');
    } else {
      print(response.reasonPhrase);
    }
    Get.find<SettingsController>().agreeButton.value = !Get.find<SettingsController>().agreeButton.value;
  }
}
