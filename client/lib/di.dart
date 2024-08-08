import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton<AuthRemoteRepository>(() => AuthRemoteRepository());
}
