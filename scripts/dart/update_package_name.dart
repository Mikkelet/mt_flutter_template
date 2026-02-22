import 'dart:io';

const _templatePackageName = "mt_template";

void main(List<String> args) async {
  final dir = Directory(".");
  final pathSegments = dir.absolute.uri.pathSegments;
  final lastNonEmpty = pathSegments.lastWhere((seg) => seg.isNotEmpty);
  print("Rename package as \"$lastNonEmpty\"? [y/N]");
  final input = stdin.readLineSync() ?? "";
  if (input.toLowerCase() == "y") {
    final libPath = Directory("./lib/");
    await _findFiles(libPath, lastNonEmpty);
  }
}

Future<void> _findFiles(Directory root, String packageName) async {
  final list = await root.list(recursive: true).toList();
  for (final file in list) {
    final uri = file.uri.toString();
    if (uri.startsWith("lib/_")) continue;
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
