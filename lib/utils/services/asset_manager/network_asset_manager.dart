import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NetworkAssetManager {
  NetworkAssetManager._();
  static final _instance = NetworkAssetManager._();
  factory NetworkAssetManager() => _instance;

  late final Directory? _directory;

  Future<void> init() async {
    _directory = await getExternalStorageDirectory();
  }

  File fileFromName(String name) {
    return File('${_directory?.path}/$name');
  }

  Future<String> saveImage({
    required String imageUrl,
    required String imageName,
  }) async {
    final imagePath = '${_directory?.path}/$imageName';

    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      final img = await File(imagePath).create(recursive: true);
      await img.writeAsBytes(bytes);
      debugPrint('Done Path : $imagePath');
    }
    return imagePath;
  }
}
