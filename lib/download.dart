import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDownloaderApp extends StatefulWidget {
  const ImageDownloaderApp({super.key});

  @override
  _ImageDownloaderAppState createState() => _ImageDownloaderAppState();
}

class _ImageDownloaderAppState extends State<ImageDownloaderApp> {
  final List<String> imageUrls = [
    'https://img.freepik.com/free-vector/thank-you-lettering-with-curls_1262-6964.jpg',
    'https://via.placeholder.com/400.png',
    'https://via.placeholder.com/500.png',
    'https://via.placeholder.com/600.png',
  ];

  // final MethodChannel _channel = const MethodChannel('download_image');
  //
  // FutureOr<dynamic> saveImage(Uint8List imageBytes,
  //     {int quality = 80,
  //     String? name,
  //     bool isReturnImagePathOfIOS = false}) async {
  //   final result =
  //       await _channel.invokeMethod('download_image', <String, dynamic>{
  //     'imageBytes': imageBytes,
  //     'quality': quality,
  //     'name': name,
  //     'isReturnImagePathOfIOS': isReturnImagePathOfIOS
  //   });
  //   return result;
  // }

  Future<File?> downloadFile(String url, String fileName) async {
    try {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello",
      );
      print(result);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Downloaded, Check Gallery'),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return null;
    }
    var file = File('/storage/emulated/0/Download/$fileName');
    // await Permission.photos.request();
    // await Permission.storage.request();
    //
    // // Check if the photos permission is granted
    // var status = await Permission.photos.status;
    // var status2 = await Permission.storage.status;
    //
    // if (status.isGranted || status2.isGranted) {
    //   try {
    //
    //
    //     // final raf = file.openSync(mode: FileMode.write);
    //     // raf.writeFromSync(response.data);
    //     // await raf.close();
    //
    //     // Notify the Media Scanner to make the image immediately visible
    //     // if (Platform.isAndroid) {
    //     //   try {
    //     //     await const MethodChannel('channel_name').invokeMethod('scanFile', {
    //     //       'path': file.path,
    //     //       'mimeType':
    //     //           'image/jpeg/png/jpg', // You can adjust the mime type as needed
    //     //     });
    //     //   } catch (e) {
    //     //     print('Error scanning file: $e');
    //     //   }
    //     // }
    //
    //     // final params = SaveFileDialogParams(sourceFilePath: file.path);
    //     // final finalPath = await FlutterFileDialog.saveFile(params: params);
    //
    //     print('Downloaded');
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('Downloaded, Check Gallery'),
    //     ));
    //     return file;
    //   } catch (e) {
    //     print(e);
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(e.toString()),
    //     ));
    //     return null; // Handle the error more gracefully if needed.
    //   }
    // } else {
    //   // Permission is not granted, request it.
    //   await Permission.photos.request();
    //   await Permission.storage.request();
    //   // You may want to handle the user's response to the permission request here.
    //   // After the user grants or denies the permission, you can decide how to proceed.
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Downloader App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                downloadFile(
                    'https://img.freepik.com/free-vector/thank-you-lettering-with-curls_1262-6964.jpg',
                    'pic1.jpg');
              },
              child: Text('Download Image 1'),
            ),
            ElevatedButton(
              onPressed: () {
                downloadFile(
                    'https://images.unsplash.com/photo-1608389168343-ba8aa0cb3a63?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dGhhbmtzfGVufDB8fDB8fHww&w=1000&q=80',
                    'pic2.jpg');
              },
              child: Text('Download Image 2'),
            ),
            ElevatedButton(
              onPressed: () {
                downloadFile(
                    'https://play-lh.googleusercontent.com/QcW8jaoZMPeLdbguA8Ia45KJqQSunb3BTCblwoSji1AJaTalT-7UFQzWpzBY44ffjeRa',
                    'pic3.jpg');
              },
              child: Text('Download Image 3'),
            ),
            ElevatedButton(
              onPressed: () {
                downloadFile('https://www.w3schools.com/w3css/img_lights.jpg',
                    'pic4.jpg');
              },
              child: Text('Download Image 4'),
            ),
          ],
        ),
      ),
    );
  }
}
