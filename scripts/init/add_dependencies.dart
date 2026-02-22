import 'dart:io';

enum Dependencies { drift, firebase }

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    return print(
      "No args entered, try either of: ${Dependencies.values.map((d) => d.name).toList()}",
    );
  }
  for (final arg in args) {
    if (arg.toLowerCase() == Dependencies.drift.name) {
      await installDrift();
    }
  }
  await pubGet();
}

Future<void> installDrift() async {
  final result = await Process.run("dart", [
    "pub",
    "add",
    "drift",
    "drift_flutter",
    "path_provider",
    "dev:drift_dev",
    "dev:build_runner",
  ], runInShell: true);
  print(result.stdout);
}

Future<void> pubAdd(String dependency) async {
  print("pub add $dependency...");
  await Process.run("fvm", [
    "dart",
    "pub",
    "add",
    dependency,
  ], runInShell: true);
}

Future<void> pubGet() async {
  print("pub get");
  final result = await Process.run("fvm", [
    "flutter",
    "pub",
    "get",
  ], runInShell: true);
  print(result.stdout);
}
