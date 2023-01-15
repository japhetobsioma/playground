import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) debugPrint('${bloc.runtimeType} Created');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) debugPrint('${bloc.runtimeType} $transition');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    if (kDebugMode) debugPrint('${bloc.runtimeType} Closed');
    super.onClose(bloc);
  }
}
