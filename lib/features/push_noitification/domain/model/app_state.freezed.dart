// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppState {
  AppStatus? get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppStatus? status) initial,
    required TResult Function(AppStatus? status) loading,
    required TResult Function(dynamic data, AppStatus? status) success,
    required TResult Function(Failure failure, AppStatus? status) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppStatus? status)? initial,
    TResult? Function(AppStatus? status)? loading,
    TResult? Function(dynamic data, AppStatus? status)? success,
    TResult? Function(Failure failure, AppStatus? status)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppStatus? status)? initial,
    TResult Function(AppStatus? status)? loading,
    TResult Function(dynamic data, AppStatus? status)? success,
    TResult Function(Failure failure, AppStatus? status)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppInitial value) initial,
    required TResult Function(_AppLoading value) loading,
    required TResult Function(_AppSucess value) success,
    required TResult Function(_AppFailed value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppInitial value)? initial,
    TResult? Function(_AppLoading value)? loading,
    TResult? Function(_AppSucess value)? success,
    TResult? Function(_AppFailed value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppInitial value)? initial,
    TResult Function(_AppLoading value)? loading,
    TResult Function(_AppSucess value)? success,
    TResult Function(_AppFailed value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call({AppStatus? status});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppInitialImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppInitialImplCopyWith(
          _$AppInitialImpl value, $Res Function(_$AppInitialImpl) then) =
      __$$AppInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppStatus? status});
}

/// @nodoc
class __$$AppInitialImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppInitialImpl>
    implements _$$AppInitialImplCopyWith<$Res> {
  __$$AppInitialImplCopyWithImpl(
      _$AppInitialImpl _value, $Res Function(_$AppInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$AppInitialImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus?,
    ));
  }
}

/// @nodoc

class _$AppInitialImpl extends _AppInitial {
  const _$AppInitialImpl({this.status = AppStatus.idle}) : super._();

  @override
  @JsonKey()
  final AppStatus? status;

  @override
  String toString() {
    return 'AppState.initial(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInitialImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInitialImplCopyWith<_$AppInitialImpl> get copyWith =>
      __$$AppInitialImplCopyWithImpl<_$AppInitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppStatus? status) initial,
    required TResult Function(AppStatus? status) loading,
    required TResult Function(dynamic data, AppStatus? status) success,
    required TResult Function(Failure failure, AppStatus? status) failure,
  }) {
    return initial(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppStatus? status)? initial,
    TResult? Function(AppStatus? status)? loading,
    TResult? Function(dynamic data, AppStatus? status)? success,
    TResult? Function(Failure failure, AppStatus? status)? failure,
  }) {
    return initial?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppStatus? status)? initial,
    TResult Function(AppStatus? status)? loading,
    TResult Function(dynamic data, AppStatus? status)? success,
    TResult Function(Failure failure, AppStatus? status)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppInitial value) initial,
    required TResult Function(_AppLoading value) loading,
    required TResult Function(_AppSucess value) success,
    required TResult Function(_AppFailed value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppInitial value)? initial,
    TResult? Function(_AppLoading value)? loading,
    TResult? Function(_AppSucess value)? success,
    TResult? Function(_AppFailed value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppInitial value)? initial,
    TResult Function(_AppLoading value)? loading,
    TResult Function(_AppSucess value)? success,
    TResult Function(_AppFailed value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _AppInitial extends AppState {
  const factory _AppInitial({final AppStatus? status}) = _$AppInitialImpl;
  const _AppInitial._() : super._();

  @override
  AppStatus? get status;
  @override
  @JsonKey(ignore: true)
  _$$AppInitialImplCopyWith<_$AppInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppLoadingImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppLoadingImplCopyWith(
          _$AppLoadingImpl value, $Res Function(_$AppLoadingImpl) then) =
      __$$AppLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppStatus? status});
}

/// @nodoc
class __$$AppLoadingImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppLoadingImpl>
    implements _$$AppLoadingImplCopyWith<$Res> {
  __$$AppLoadingImplCopyWithImpl(
      _$AppLoadingImpl _value, $Res Function(_$AppLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$AppLoadingImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus?,
    ));
  }
}

/// @nodoc

class _$AppLoadingImpl extends _AppLoading {
  const _$AppLoadingImpl({this.status = AppStatus.idle}) : super._();

  @override
  @JsonKey()
  final AppStatus? status;

  @override
  String toString() {
    return 'AppState.loading(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLoadingImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppLoadingImplCopyWith<_$AppLoadingImpl> get copyWith =>
      __$$AppLoadingImplCopyWithImpl<_$AppLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppStatus? status) initial,
    required TResult Function(AppStatus? status) loading,
    required TResult Function(dynamic data, AppStatus? status) success,
    required TResult Function(Failure failure, AppStatus? status) failure,
  }) {
    return loading(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppStatus? status)? initial,
    TResult? Function(AppStatus? status)? loading,
    TResult? Function(dynamic data, AppStatus? status)? success,
    TResult? Function(Failure failure, AppStatus? status)? failure,
  }) {
    return loading?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppStatus? status)? initial,
    TResult Function(AppStatus? status)? loading,
    TResult Function(dynamic data, AppStatus? status)? success,
    TResult Function(Failure failure, AppStatus? status)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppInitial value) initial,
    required TResult Function(_AppLoading value) loading,
    required TResult Function(_AppSucess value) success,
    required TResult Function(_AppFailed value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppInitial value)? initial,
    TResult? Function(_AppLoading value)? loading,
    TResult? Function(_AppSucess value)? success,
    TResult? Function(_AppFailed value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppInitial value)? initial,
    TResult Function(_AppLoading value)? loading,
    TResult Function(_AppSucess value)? success,
    TResult Function(_AppFailed value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AppLoading extends AppState {
  const factory _AppLoading({final AppStatus? status}) = _$AppLoadingImpl;
  const _AppLoading._() : super._();

  @override
  AppStatus? get status;
  @override
  @JsonKey(ignore: true)
  _$$AppLoadingImplCopyWith<_$AppLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppSucessImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppSucessImplCopyWith(
          _$AppSucessImpl value, $Res Function(_$AppSucessImpl) then) =
      __$$AppSucessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic data, AppStatus? status});
}

/// @nodoc
class __$$AppSucessImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppSucessImpl>
    implements _$$AppSucessImplCopyWith<$Res> {
  __$$AppSucessImplCopyWithImpl(
      _$AppSucessImpl _value, $Res Function(_$AppSucessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? status = freezed,
  }) {
    return _then(_$AppSucessImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus?,
    ));
  }
}

/// @nodoc

class _$AppSucessImpl extends _AppSucess {
  const _$AppSucessImpl(this.data, {this.status = AppStatus.idle}) : super._();

  @override
  final dynamic data;
  @override
  @JsonKey()
  final AppStatus? status;

  @override
  String toString() {
    return 'AppState.success(data: $data, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSucessImpl &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSucessImplCopyWith<_$AppSucessImpl> get copyWith =>
      __$$AppSucessImplCopyWithImpl<_$AppSucessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppStatus? status) initial,
    required TResult Function(AppStatus? status) loading,
    required TResult Function(dynamic data, AppStatus? status) success,
    required TResult Function(Failure failure, AppStatus? status) failure,
  }) {
    return success(data, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppStatus? status)? initial,
    TResult? Function(AppStatus? status)? loading,
    TResult? Function(dynamic data, AppStatus? status)? success,
    TResult? Function(Failure failure, AppStatus? status)? failure,
  }) {
    return success?.call(data, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppStatus? status)? initial,
    TResult Function(AppStatus? status)? loading,
    TResult Function(dynamic data, AppStatus? status)? success,
    TResult Function(Failure failure, AppStatus? status)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppInitial value) initial,
    required TResult Function(_AppLoading value) loading,
    required TResult Function(_AppSucess value) success,
    required TResult Function(_AppFailed value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppInitial value)? initial,
    TResult? Function(_AppLoading value)? loading,
    TResult? Function(_AppSucess value)? success,
    TResult? Function(_AppFailed value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppInitial value)? initial,
    TResult Function(_AppLoading value)? loading,
    TResult Function(_AppSucess value)? success,
    TResult Function(_AppFailed value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _AppSucess extends AppState {
  const factory _AppSucess(final dynamic data, {final AppStatus? status}) =
      _$AppSucessImpl;
  const _AppSucess._() : super._();

  dynamic get data;
  @override
  AppStatus? get status;
  @override
  @JsonKey(ignore: true)
  _$$AppSucessImplCopyWith<_$AppSucessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppFailedImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppFailedImplCopyWith(
          _$AppFailedImpl value, $Res Function(_$AppFailedImpl) then) =
      __$$AppFailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Failure failure, AppStatus? status});
}

/// @nodoc
class __$$AppFailedImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppFailedImpl>
    implements _$$AppFailedImplCopyWith<$Res> {
  __$$AppFailedImplCopyWithImpl(
      _$AppFailedImpl _value, $Res Function(_$AppFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
    Object? status = freezed,
  }) {
    return _then(_$AppFailedImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus?,
    ));
  }
}

/// @nodoc

class _$AppFailedImpl extends _AppFailed {
  const _$AppFailedImpl(this.failure, {this.status = AppStatus.idle})
      : super._();

  @override
  final Failure failure;
  @override
  @JsonKey()
  final AppStatus? status;

  @override
  String toString() {
    return 'AppState.failure(failure: $failure, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppFailedImpl &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppFailedImplCopyWith<_$AppFailedImpl> get copyWith =>
      __$$AppFailedImplCopyWithImpl<_$AppFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppStatus? status) initial,
    required TResult Function(AppStatus? status) loading,
    required TResult Function(dynamic data, AppStatus? status) success,
    required TResult Function(Failure failure, AppStatus? status) failure,
  }) {
    return failure(this.failure, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AppStatus? status)? initial,
    TResult? Function(AppStatus? status)? loading,
    TResult? Function(dynamic data, AppStatus? status)? success,
    TResult? Function(Failure failure, AppStatus? status)? failure,
  }) {
    return failure?.call(this.failure, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppStatus? status)? initial,
    TResult Function(AppStatus? status)? loading,
    TResult Function(dynamic data, AppStatus? status)? success,
    TResult Function(Failure failure, AppStatus? status)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppInitial value) initial,
    required TResult Function(_AppLoading value) loading,
    required TResult Function(_AppSucess value) success,
    required TResult Function(_AppFailed value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppInitial value)? initial,
    TResult? Function(_AppLoading value)? loading,
    TResult? Function(_AppSucess value)? success,
    TResult? Function(_AppFailed value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppInitial value)? initial,
    TResult Function(_AppLoading value)? loading,
    TResult Function(_AppSucess value)? success,
    TResult Function(_AppFailed value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _AppFailed extends AppState {
  const factory _AppFailed(final Failure failure, {final AppStatus? status}) =
      _$AppFailedImpl;
  const _AppFailed._() : super._();

  Failure get failure;
  @override
  AppStatus? get status;
  @override
  @JsonKey(ignore: true)
  _$$AppFailedImplCopyWith<_$AppFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
