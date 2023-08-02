import 'package:get_it/get_it.dart';
import 'package:whatsapp_redesign/provider/audio_provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AudioProvider>(AudioProvider());
}
