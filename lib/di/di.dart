import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import '../data/repository/AppRepository.dart';
import '../data/repository/impl/AppRepositoryImpl.dart';
import '../data/scource/remote/api/detail_api.dart';
import '../data/scource/remote/api/special_categories_api.dart';

final getIt = GetIt.instance;

void setup() {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://gw.texnomart.uz/api/',
  ));

  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        // All http responses enabled for console logging
        printResponseData: true,
        // All http requests disabled for console logging
        printRequestData: false,
        // Response logs including http - headers
        printResponseHeaders: true,
        // Request logs without http - headers
        printRequestHeaders: false,
      ),
    ),
  );

  getIt.registerSingleton<Dio>(dio);

  /*getIt.registerSingleton<Dio>(Dio(BaseOptions(
    baseUrl: 'https://gw.texnomart.uz/api/web/v1/',
  )));*/
  getIt.registerSingleton<SpecialCategoriesApi>(SpecialCategoriesApi(getIt<Dio>()));
  getIt.registerSingleton<DetailApi>(DetailApi(getIt<Dio>()));

  getIt.registerSingleton<AppRepository>(AppRepositoryImpl());
}

//popup menu catalog categoeyda
// hits products
// sliy
// intersting products
