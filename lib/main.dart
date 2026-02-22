import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mt_template/data/local/app_preferences.dart';
import 'package:mt_template/data/remote/interceptors/auth_interceptor.dart';
import 'package:mt_template/data/remote/services/template_service.dart';
import 'package:mt_template/flavors.dart';
import 'package:mt_template/presentation/app/app.dart';

void main() async {
  F.appFlavor = Flavor.values.firstWhere((element) => element.name == appFlavor);
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final appPreferences = AppPreferences();
  final authInterceptor = AuthInterceptor(appPreferences);
  final dio = Dio();
  dio.interceptors.add(authInterceptor);
  final service = TemplateService(dio, baseUrl: "https://template.com");

  await appPreferences.init();

  FlutterNativeSplash.remove();
  runApp(
    App(
      templateService: service,
      appPreferences: appPreferences,
    ),
  );
}
