import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggerProvider extends ProviderObserver{

  /**
   * provider의 값을 업데이트 한 후
   */
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    debugPrint('[Provider Updated] provider: $provider / pv: $previousValue / nv: $newValue');
  }

  /**
   * provider가 추가되었을 때
   */
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    debugPrint('[Provider Added] provider: $provider / value: $value');
  }

  /**
   * provider가 삭제 됬을 때
   */
  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    debugPrint('[Provider Disposed] provider: $provider');
  }
}