import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/feature/auth/infrastructure/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
IAuthRepository authRepository(Ref ref) {
  return AuthRepository(ref: ref);
}
