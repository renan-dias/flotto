// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrative_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AdministrativeRecord> _$administrativeRecordSerializer =
    new _$AdministrativeRecordSerializer();

class _$AdministrativeRecordSerializer
    implements StructuredSerializer<AdministrativeRecord> {
  @override
  final Iterable<Type> types = const [
    AdministrativeRecord,
    _$AdministrativeRecord
  ];
  @override
  final String wireName = 'AdministrativeRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AdministrativeRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.usernames;
    if (value != null) {
      result
        ..add('usernames')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
  AdministrativeRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdministrativeRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'usernames':
          result.usernames.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$AdministrativeRecord extends AdministrativeRecord {
  @override
  final BuiltList<String>? usernames;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$AdministrativeRecord(
          [void Function(AdministrativeRecordBuilder)? updates]) =>
      (new AdministrativeRecordBuilder()..update(updates))._build();

  _$AdministrativeRecord._({this.usernames, this.ffRef}) : super._();

  @override
  AdministrativeRecord rebuild(
          void Function(AdministrativeRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdministrativeRecordBuilder toBuilder() =>
      new AdministrativeRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdministrativeRecord &&
        usernames == other.usernames &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, usernames.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdministrativeRecord')
          ..add('usernames', usernames)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class AdministrativeRecordBuilder
    implements Builder<AdministrativeRecord, AdministrativeRecordBuilder> {
  _$AdministrativeRecord? _$v;

  ListBuilder<String>? _usernames;
  ListBuilder<String> get usernames =>
      _$this._usernames ??= new ListBuilder<String>();
  set usernames(ListBuilder<String>? usernames) =>
      _$this._usernames = usernames;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  AdministrativeRecordBuilder() {
    AdministrativeRecord._initializeBuilder(this);
  }

  AdministrativeRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _usernames = $v.usernames?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdministrativeRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdministrativeRecord;
  }

  @override
  void update(void Function(AdministrativeRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdministrativeRecord build() => _build();

  _$AdministrativeRecord _build() {
    _$AdministrativeRecord _$result;
    try {
      _$result = _$v ??
          new _$AdministrativeRecord._(
              usernames: _usernames?.build(), ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'usernames';
        _usernames?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AdministrativeRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
