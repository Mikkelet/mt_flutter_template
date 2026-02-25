import 'dart:io';

import 'update_bundle_id.dart';
import 'update_package_name.dart';

void main(List<String> args) async {
  print(
    """
    
    Welcome to your new project. 
    This setup guide will cover project name, bundle id, and package name.
    
    """
        .trim(),
  );
  await Future.delayed(Duration(milliseconds: 500));
  final appName = await getAppName();
  final bundleId = await getBundleId();
  final packageName = await getPackageName();
  print("Confirm registered data:");
  print("App name:\t\t$appName");
  print("Bundle identifier:\t$bundleId.$packageName");
  print("Package name:\t\t$packageName");
  print("Confirm? [Y/n]");
  final confirmInput = stdin.readLineSync() ?? "y";
  if (confirmInput.toLowerCase() != "n") {
    print("Yes");
    await Process.run("fvm", [
      "flutter",
      "create",
      "--platforms=android,ios",
      "--org",
      bundleId,
      "--project-name",
      packageName,
      "."
    ]);
    await updatePackageName();
    await updateFlavorizr(appName, bundleId);
  }

  print("Run generator and flavorizr now? [Y/n]");
  final confirmInit = stdin.readLineSync() ?? "y";
  if (confirmInit.toLowerCase() == "y") {
    print("Yes");
    await Process.run("sh", ["scripts/gen.sh"]);
    await Process.run("fvm", ["dart", "pub", "run", "flutter_flavorizr"]);
  }
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
  print("Please enter your organization identifier (eg. com.coolcompany");
  print("The project's flavors will be updated to:");
  print("- \"develop: com.coolcompany.{package_name}.dev\"");
  print("- \"production: com.coolcompany.{package_name}\"");
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
