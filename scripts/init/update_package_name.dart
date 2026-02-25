import 'dart:io';

const _templatePackageName = "mt_template";

String get packageName {
  final dir = Directory(".");
  final pathSegments = dir.absolute.uri.pathSegments;
  final lastNonEmpty = pathSegments.lastWhere((seg) => seg.isNotEmpty);
  return lastNonEmpty;
}

void main() async {
  print("Rename package as \"$packageName\"? [y/N]");
  final input = stdin.readLineSync() ?? "";
  if (input.toLowerCase() == "y") {
    await updatePackageName();
  }
}

Future<void> updatePackageName() async {
  final libPath = Directory("./lib/");
  await _findFiles(libPath, packageName);
  final testPath = Directory("./test/");
  await _findFiles(testPath, packageName);
  final pubSpecFile = File("pubspec.yaml");
  await _updatePackageName(pubSpecFile.uri, packageName);
}

Future<void> _findFiles(Directory root, String packageName) async {
  final list = await root.list(recursive: true).toList();
  for (final file in list) {
    final uri = file.uri.toString();
    if (uri.startsWith("lib/_")) continue;
    if (uri.startsWith("lib/.")) continue;
    if (uri.endsWith("/")) continue;
    await _updatePackageName(file.uri, packageName);
  }
}

Future<void> _updatePackageName(Uri uri, String packageName) async {
  final file = File(uri.toString());
  final content = await file.readAsString();
  final updated = content.replaceAll(_templatePackageName, packageName);
  await file.writeAsString(updated);
}
