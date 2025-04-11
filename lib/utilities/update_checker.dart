// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:open_file/open_file.dart';

// class UpdateService {
//   static const String githubRepo = "NyanLinHtet07/xnova_public";

//   static Future<void> checkForUpdate() async {
//     final response = await http.get(
//       Uri.parse('https://api.github.com/repos/$githubRepo/releases/latest'),
//       headers: {'Accept': 'application/vnd.github.v3+json'},
//     );

//     if (response.statusCode == 200) {
//       final latestRelease = jsonDecode(response.body);
//       final latestVersion = latestRelease['tag_name']; // Example: "v1.2.0"
//       final apkUrl =
//           latestRelease['assets'][0]['browser_download_url']; // APK URL

//       final packageInfo = await PackageInfo.fromPlatform();
//       final currentVersion = "v${packageInfo.version}";

//       if (latestVersion != currentVersion) {
//         print("New update available: $latestVersion");
//         _downloadAndInstall(apkUrl);
//       } else {
//         print("No updates available");
//       }
//     }
//   }

//   static Future<void> _downloadAndInstall(String apkUrl) async {
//     final taskId = await FlutterDownloader.enqueue(
//       url: apkUrl,
//       savedDir: '/storage/emulated/0/Download',
//       fileName: 'app-latest.apk',
//       showNotification: true,
//       openFileFromNotification: true,
//     );

//     FlutterDownloader.registerCallback((id, status, progress) {
//       if (status == DownloadTaskStatus.complete) {
//         OpenFile.open('/storage/emulated/0/Download/app-latest.apk');
//       }
//     });
//   }
// }
