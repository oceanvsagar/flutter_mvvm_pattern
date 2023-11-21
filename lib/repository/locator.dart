import 'package:get_it/get_it.dart';
import 'common_repo/common_repo.dart';

void setupLocator() {
  GetIt.I.registerFactory<CommonRepository>(() => CommonRepositoryImpl());
}
