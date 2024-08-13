import 'package:client/core/providers/current_user_provider.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:client/features/home/repositories/home_remote_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(),
  );

  getIt.registerSingletonAsync<AuthLocalRepository>(() async {
    final authLocalRepository = AuthLocalRepository();
    await authLocalRepository.init();
    return authLocalRepository;
  });

  getIt.registerLazySingleton<CurrentUserProvider>(() => CurrentUserProvider());

  getIt.registerLazySingleton<HomeRemoteRepository>(
      () => HomeRemoteRepository());
  getIt.registerLazySingleton<HomeLocalRepository>(() => HomeLocalRepository());
}
