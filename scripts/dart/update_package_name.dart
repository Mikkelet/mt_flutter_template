import 'dart:io';

const _templatePackageName = "mt_template";

void main(List<String> args) async {
  if (args.isEmpty) throw Exception("Missing arg");
  final packageName = args.first;
  final libPath = Directory("./lib/");
  await _findFiles(libPath, packageName);
}

Future<void> _findFiles(Directory root, String packageName) async {
  final list = await root.list(recursive: true).toList();
  for (final file in list) {
    if (file.uri.toString().startsWith("lib/_")) continue;
    await _updatePackageName(file.uri, packageName);
  }
}

Future<void> _updatePackageName(Uri uri, String packageName) async {
  final file = File(uri.toString());
  final content = await file.readAsString();
  final updated = content.replaceAll(_templatePackageName, packageName);
  await file.writeAsString(updated);
}
