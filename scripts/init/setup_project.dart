import 'dart:io';

import 'package:args/args.dart';
import 'package:change_case/change_case.dart';

import 'update_bundle_id.dart';
import 'update_package_name.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser();
  parser.addOption("appName", mandatory: true);
  parser.addOption("package", mandatory: true);

  final results = parser.parse(args);
  final appName = results.option("appName");
  final package = results.option("package");

  print("appName=$appName, package=$package");

  final (org, packageName) = parsePackage(package!);
  print(
    """
    
    Welcome to your new project. 
    This setup guide will cover project name, bundle id, and package name.
    
    """
        .trim(),
  );
  await Future.delayed(Duration(milliseconds: 500));
  print("App name:\t\t$appName");
  print("Bundle identifier:\t$org.$packageName");
  print("Package name:\t\t$packageName");
  await Future.delayed(Duration(milliseconds: 500));
  await Process.run("fvm", [
    "flutter",
    "create",
    "--platforms=android,ios",
    "--org",
    org,
    "--project-name",
    packageName,
    ".",
  ]);
  await updatePackageName();
  await updateFlavorizr(appName!, package);
  await Process.run("sh", ["scripts/gen.sh"]);
  await Process.run("fvm", [
    "dart",
    "pub",
    "run",
    "flutter_flavorizr",
    "-f",
    "-p assets:download,assets:extract,android:androidManifest,android:flavorizrGradle,android:buildGradle,android:dummyAssets,android:icons,flutter:flavors,flutter:app,flutter:pages,flutter:main,ios:podfile,ios:xcconfig,ios:buildTargets,ios:schema,ios:dummyAssets,ios:icons,ios:plist,ios:launchScreen,macos:podfile,macos:xcconfig,macos:configs,macos:buildTargets,macos:schema,macos:dummyAssets,macos:icons,macos:plist,google:firebase,assets:clean,ide:config,",
  ]);
}

(String, String) parsePackage(String package) {
  final split = package.split(".");
  final org = split.take(split.length - 1).reduce((a, b) => "$a.$b");
  return (org, split.last.toSnakeCase());
}
