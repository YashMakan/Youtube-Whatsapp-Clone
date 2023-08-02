import 'package:hive_flutter/hive_flutter.dart';
import 'local_db_routes.dart';

class LocalDB {

  static void initialize() async {
    await Hive.initFlutter();
    await Future.wait(LocalDBRoutes.routes.map((e) => Hive.openBox(e)));
  }

  static bool get isUserLoggedIn =>
      Hive.box(LocalDBRoutes.userRoute).get('isLoggedIn') ?? false;
}
