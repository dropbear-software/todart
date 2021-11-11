import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = StateNotifierProvider<RouterStateNotifier, String>(
    (_) => RouterStateNotifier());

class RouterStateNotifier extends StateNotifier<String> {
  RouterStateNotifier() : super('');

  void setRouteName(String routeName) {
    state = routeName;
  }
}
