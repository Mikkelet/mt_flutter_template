import 'dart:io';

final _templateAppName = "My Example app";
final _templateBundleId = "com.example.app";

Future<void> updateFlavorizr(String appName, String bundleId) async {
  final pubSpecFile = File("flavorizr.yaml");
  final content = await pubSpecFile.readAsString();
  final updated = content
      .replaceAll(_templateAppName, appName)
      .replaceAll(_templateBundleId, bundleId);
  await pubSpecFile.writeAsString(updated);
}
