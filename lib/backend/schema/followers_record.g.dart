// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FollowersRecord> _$followersRecordSerializer =
    new _$FollowersRecordSerializer();

class _$FollowersRecordSerializer
    implements StructuredSerializer<FollowersRecord> {
  @override
  final Iterable<Type> types = const [FollowersRecord, _$FollowersRecord];
  @override
  final String wireName = 'FollowersRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, FollowersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.userRefs;
    if (value != null) {
      result
        ..add('userRefs')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  FollowersRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FollowersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userRefs':
          result.userRefs.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$FollowersRecord extends FollowersRecord {
  @override
  final BuiltList<DocumentReference<Object?>>? userRefs;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$FollowersRecord([void Function(FollowersRecordBuilder)? updates]) =>
      (new FollowersRecordBuilder()..update(updates))._build();

  _$FollowersRecord._({this.userRefs, this.ffRef}) : super._();

  @override
  FollowersRecord rebuild(void Function(FollowersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FollowersRecordBuilder toBuilder() =>
      new FollowersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowersRecord &&
        userRefs == other.userRefs &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, userRefs.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FollowersRecord')
          ..add('userRefs', userRefs)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class FollowersRecordBuilder
    implements Builder<FollowersRecord, FollowersRecordBuilder> {
  _$FollowersRecord? _$v;

  ListBuilder<DocumentReference<Object?>>? _userRefs;
  ListBuilder<DocumentReference<Object?>> get userRefs =>
      _$this._userRefs ??= new ListBuilder<DocumentReference<Object?>>();
  set userRefs(ListBuilder<DocumentReference<Object?>>? userRefs) =>
      _$this._userRefs = userRefs;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  FollowersRecordBuilder() {
    FollowersRecord._initializeBuilder(this);
  }

  FollowersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userRefs = $v.userRefs?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FollowersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FollowersRecord;
  }

  @override
  void update(void Function(FollowersRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FollowersRecord build() => _build();

  _$FollowersRecord _build() {
    _$FollowersRecord _$result;
    try {
      _$result = _$v ??
          new _$FollowersRecord._(userRefs: _userRefs?.build(), ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userRefs';
        _userRefs?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FollowersRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
