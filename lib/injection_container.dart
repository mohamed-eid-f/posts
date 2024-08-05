import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/internet_info.dart';
import 'features/posts/data/datasources/post_local_data_source.dart';
import 'features/posts/data/datasources/post_remote_data_source.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/domain/usecases/create_post_usecase.dart';
import 'features/posts/domain/usecases/delete_post_usecase.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post_usecase.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/bloc/posts_crud/posts_crud_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! feature: posts

  // Bloc
  sl.registerFactory(() => PostsBloc(getAllPostsUsecase: sl()));
  sl.registerFactory(
    () => PostsCrudBloc(
      createPostUsecase: sl(),
      updatePostUsecase: sl(),
      deletePostUsecase: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetAllPostsUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreatePostUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      internetInfo: sl(),
    ),
  );

  // Datasources
  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostRemoteDataSourceWithHttp(client: sl()));

  //! CORE
  sl.registerLazySingleton<InternetInfo>(
      () => InternetInfoImp(connectionChecker: sl()));

  //! EXTERNAL
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
