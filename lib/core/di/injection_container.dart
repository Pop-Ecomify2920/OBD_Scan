import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  
  // TODO: Register repositories, use cases, and data sources
  // Example:
  // sl.registerLazySingleton(() => AuthRepositoryImpl(
  //   remoteDataSource: sl(),
  //   localDataSource: sl(),
  // ));
}

