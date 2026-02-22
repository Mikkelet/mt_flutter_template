import 'dart:io';

import 'update_bundle_id.dart';
import 'update_package_name.dart';

void main() async {
  print(
    """ Welcome to your new project. This setup guide will cover project name, bundle id, and package name.""",
  );
  await Future.delayed(Duration(milliseconds: 500));
  final appName = await getAppName();
  final bundleId = await getBundleId();
  final packageName = await getPackageName();
  print("Confirm registered data:");
  print("App name:\t\t$appName");
  print("Bundle identifier:\t$bundleId");
  print("Package name:\t\t$packageName");
  print("Confirm? [y/N]");
  final confirm = stdin.readLineSync() ?? "";
  if (confirm.toLowerCase() == "y") {
    await updatePackageName();
    await updateFlavorizr(appName, bundleId);
  }
  // await Process.run("sh", ["scripts/gen.sh"]);
  // await Process.run("fvm", ["dart", "pub", "run", "flutter_flavorizr"]);
}

Future<String> getAppName() async {
  print("Please enter your app's name");
  print("The project's flavors will be updated to:");
  print("- \"develop: My App [DEV]\"");
  print("- \"production: My App\"");
  final appName = stdin.readLineSync() ?? "";
  await Future.delayed(Duration(milliseconds: 200));
  if (appName.isEmpty) return getAppName();
  return appName;
}

Future<String> getBundleId() async {
  print("Please enter your app's bundle id (eg. com.coolcompany.myapp");
  print("The project's flavors will be updated to:");
  print("- \"develop: com.coolcompany.myapp.dev\"");
  print("- \"production: com.coolcompany.myapp\"");
  final bundleId = stdin.readLineSync() ?? "";
  await Future.delayed(Duration(milliseconds: 200));
  if (bundleId.isEmpty) return getBundleId();
  return bundleId;
}

Future<String> getPackageName() async {
  await Future.delayed(Duration(milliseconds: 200));
  print("Registered package name is \"$packageName\"");
  print("If this is incorrect, please cancel the setup and rename the root folder.");
  await Future.delayed(Duration(milliseconds: 200));
  return packageName;
}
