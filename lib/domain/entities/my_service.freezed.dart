// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyService _$MyServiceFromJson(Map<String, dynamic> json) {
  return _MyService.fromJson(json);
}

/// @nodoc
mixin _$MyService {
  String? get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get imgUrl => throw _privateConstructorUsedError;

  /// Serializes this MyService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MyService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyServiceCopyWith<MyService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyServiceCopyWith<$Res> {
  factory $MyServiceCopyWith(MyService value, $Res Function(MyService) then) =
      _$MyServiceCopyWithImpl<$Res, MyService>;
  @useResult
  $Res call({String? name, String? address, String? imgUrl});
}

/// @nodoc
class _$MyServiceCopyWithImpl<$Res, $Val extends MyService>
    implements $MyServiceCopyWith<$Res> {
  _$MyServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? address = freezed,
    Object? imgUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyServiceImplCopyWith<$Res>
    implements $MyServiceCopyWith<$Res> {
  factory _$$MyServiceImplCopyWith(
          _$MyServiceImpl value, $Res Function(_$MyServiceImpl) then) =
      __$$MyServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? address, String? imgUrl});
}

/// @nodoc
class __$$MyServiceImplCopyWithImpl<$Res>
    extends _$MyServiceCopyWithImpl<$Res, _$MyServiceImpl>
    implements _$$MyServiceImplCopyWith<$Res> {
  __$$MyServiceImplCopyWithImpl(
      _$MyServiceImpl _value, $Res Function(_$MyServiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? address = freezed,
    Object? imgUrl = freezed,
  }) {
    return _then(_$MyServiceImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyServiceImpl with DiagnosticableTreeMixin implements _MyService {
  _$MyServiceImpl({this.name, this.address, this.imgUrl});

  factory _$MyServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyServiceImplFromJson(json);

  @override
  final String? name;
  @override
  final String? address;
  @override
  final String? imgUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyService(name: $name, address: $address, imgUrl: $imgUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyService'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('imgUrl', imgUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyServiceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, address, imgUrl);

  /// Create a copy of MyService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyServiceImplCopyWith<_$MyServiceImpl> get copyWith =>
      __$$MyServiceImplCopyWithImpl<_$MyServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyServiceImplToJson(
      this,
    );
  }
}

abstract class _MyService implements MyService {
  factory _MyService(
      {final String? name,
      final String? address,
      final String? imgUrl}) = _$MyServiceImpl;

  factory _MyService.fromJson(Map<String, dynamic> json) =
      _$MyServiceImpl.fromJson;

  @override
  String? get name;
  @override
  String? get address;
  @override
  String? get imgUrl;

  /// Create a copy of MyService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyServiceImplCopyWith<_$MyServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
