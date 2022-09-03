// ignore_for_file: deprecated_member_use, file_names, depend_on_referenced_packages, avoid_void_async, always_declare_return_types, type_annotate_public_apis, unnecessary_statements, unrelated_type_equality_checks

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:game_app/constants/index.dart';

import 'package:mime/mime.dart';
import 'package:game_app/models/user_models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:video_player/video_player.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  File? selectedImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        selectedImage = imageTemporary;
      });
    } catch (error) {
      showSnackBar("noConnection3", "$error", Colors.red);
      // print("error: $error");
    }
  }

  FlickManager? flickManager;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  File? selectedVideo;
  Future pickVideo() async {
    try {
      XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery, maxDuration: const Duration(seconds: 30));
      if (video == null) return;
      final imageTemporary = File(video.path);
      VideoPlayerController testLengthController = VideoPlayerController.file(
        File(video.path),
      ); //Your file here
      await testLengthController.initialize();
      if (testLengthController.value.duration.inSeconds > 60) {
        showSnackBar("noConnection3", "video_upload_subtitle_error", Colors.red);
        video = null;
      } else {
        setState(() {
          selectedVideo = imageTemporary;
          _controller = VideoPlayerController.file(imageTemporary);
          _initializeVideoPlayerFuture = _controller!.initialize();
          _controller!.setLooping(true);
          flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.file(imageTemporary),
          );
        });
      }
    } catch (error) {
      showSnackBar("noConnection3", "$error", Colors.red);
    }
  }

  @override
  void dispose() {
    super.dispose();
    flickManager!.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColorBlack,
        appBar: const MyAppBar(fontSize: 20, backArrow: true, iconRemove: false, name: "videoUpload", elevationWhite: true),
        body: Container(
            color: kPrimaryColorBlack,
            width: Get.size.width,
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "video_upload_title".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // selectedImage != null
              //     ? GestureDetector(
              //         onTap: () {
              //           pickImage();
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.all(5),
              //           decoration: const BoxDecoration(borderRadius: borderRadius10),
              //           child: Material(
              //             elevation: 2,
              //             borderRadius: borderRadius10,
              //             child: ClipRRect(
              //               borderRadius: borderRadius10,
              //               child: Image.file(selectedImage!, fit: BoxFit.cover),
              //             ),
              //           ),
              //         ),
              //       )
              //     : GestureDetector(
              //         onTap: () async {
              //           await Permission.camera.request();
              //           await Permission.photos.request();
              //           pickImage();
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.all(10),
              //           child: DottedBorder(
              //             borderType: BorderType.RRect,
              //             radius: const Radius.circular(12),
              //             padding: const EdgeInsets.all(6),
              //             strokeWidth: 2,
              //             color: kPrimaryColor,
              //             child: Center(
              //               child: Row(
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: const [
              //                   Text(
              //                     "Poster",
              //                     style: TextStyle(color: kPrimaryColor),
              //                   ),
              //                   Icon(
              //                     Icons.add,
              //                     color: kPrimaryColor,
              //                     size: 50,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),

              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      height: 250,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      child: FlickVideoPlayer(
                          flickVideoWithControls: FlickVideoWithControls(
                            controls: FlickPortraitControls(
                              progressBarSettings: FlickProgressBarSettings(),
                            ),
                            videoFit: BoxFit.fitHeight,
                          ),
                          preferredDeviceOrientation: const [
                            DeviceOrientation.portraitDown,
                            DeviceOrientation.portraitUp,
                          ],
                          preferredDeviceOrientationFullscreen: const [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
                          flickManager: flickManager!),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        pickVideo();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 25, right: 10, top: 10),
                        height: 150,
                        width: double.infinity,
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
              ),
              AgreeButton(onTap: () async {
                final token = await Auth().getToken();
                var headers = {'Authorization': 'Bearer $token'};
                var request = http.MultipartRequest('POST', Uri.parse('$serverURL/api/accounts/upload-video/'));
                request.headers.addAll(headers);

                // final imageTemporary = File(selectedVideo!.path);
                // final uint8list = await VideoThumbnail.thumbnailData(
                //   video: imageTemporary.path,
                //   imageFormat: ImageFormat.JPEG,
                //   maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                //   quality: 100,
                // );

                final String fileName = selectedImage!.path.split("/").last;
                final stream = http.ByteStream(DelegatingStream.typed(selectedImage!.openRead()));
                final length = await selectedImage!.length();
                final mimeTypeData = lookupMimeType(selectedImage!.path, headerBytes: [0xFF, 0xD8])!.split('/');
                final multipartFileSign = http.MultipartFile('poster', stream, length, filename: fileName, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
                request.files.add(multipartFileSign);

                final String fileName1 = selectedVideo!.path.split("/").last;
                final stream1 = http.ByteStream(DelegatingStream.typed(selectedVideo!.openRead()));
                final length1 = await selectedVideo!.length();
                final mimeTypeData1 = lookupMimeType(selectedVideo!.path, headerBytes: [0xFF, 0xD8])!.split('/');
                final multipartFileSign1 = http.MultipartFile('video', stream1, length1, filename: fileName1, contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));
                request.files.add(multipartFileSign1);

                http.StreamedResponse response = await request.send();
                // print(response.stream);
                // print(response.statusCode);
                // print(response.reasonPhrase);
                // print(response.isRedirect);

                // print(response.stream);
                // print(response.stream);
                if (response.statusCode == 200) {
                  // print(await response.stream.bytesToString());
                } else {
                  // print(response.reasonPhrase);
                }
              })
            ])),
      ),
    );
  }
}
