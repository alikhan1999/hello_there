import 'package:empathyGenerator/repositary/user/user_api.dart';
import 'package:empathyGenerator/repositary/user/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:empathyGenerator/storage/prefs_storage.dart';
import 'package:empathyGenerator/storage/storage.dart';



final _locator = GetIt.instance;

IUserRepository get userRepository => _locator<IUserRepository>();
// ICollectionRepository get collectionRepository => _locator<ICollectionRepository>();
// IBrandRepository get brandRepository => _locator<IBrandRepository>();
// IModelRepository get modelRepository => _locator<IModelRepository>();
// IItemsRepository get itemRepository => _locator<IItemsRepository>();
// ISerialRepository get serialRepository => _locator<ISerialRepository>();
// INotificationRepository get notificationRepository => _locator<INotificationRepository>();

IStorage get storage => _locator<IStorage>();

abstract class DependencyInjectionEnvironment {
  static Future<void> setup() async {
    _locator.registerLazySingleton<IStorage>(() => PrefStorage());
    _locator.registerLazySingleton<IUserRepository>(() => UserApi());
    // _locator.registerLazySingleton<ICollectionRepository>(() => CollectionApi());
    // _locator.registerLazySingleton<IBrandRepository>(() => BrandApi());
    // _locator.registerLazySingleton<IModelRepository>(() => ModelApi());
    // _locator.registerLazySingleton<IItemsRepository>(() => ItemApi());
    // _locator.registerLazySingleton<ISerialRepository>(() => SerialApi());
    // _locator.registerLazySingleton<INotificationRepository>(() => NotificationApi());
  }
}
