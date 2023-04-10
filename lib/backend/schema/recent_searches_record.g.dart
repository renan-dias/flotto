// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_searches_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RecentSearchesRecord> _$recentSearchesRecordSerializer =
    new _$RecentSearchesRecordSerializer();

class _$RecentSearchesRecordSerializer
    implements StructuredSerializer<RecentSearchesRecord> {
  @override
  final Iterable<Type> types = const [
    RecentSearchesRecord,
    _$RecentSearchesRecord
  ];
  @override
  final String wireName = 'RecentSearchesRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, RecentSearchesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.userRef;
    if (value != null) {
      result
        ..add('userRef')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.timeSearched;
    if (value != null) {
      result
        ..add('time_searched')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
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
  RecentSearchesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecentSearchesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userRef':
          result.userRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'time_searched':
          result.timeSearched = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
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

class _$RecentSearchesRecord extends RecentSearchesRecord {
  @override
  final DocumentReference<Object?>? userRef;
  @override
  final DateTime? timeSearched;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$RecentSearchesRecord(
          [void Function(RecentSearchesRecordBuilder)? updates]) =>
      (new RecentSearchesRecordBuilder()..update(updates))._build();

  _$RecentSearchesRecord._({this.userRef, this.timeSearched, this.ffRef})
      : super._();

  @override
  RecentSearchesRecord rebuild(
          void Function(RecentSearchesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecentSearchesRecordBuilder toBuilder() =>
      new RecentSearchesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecentSearchesRecord &&
        userRef == other.userRef &&
        timeSearched == other.timeSearched &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, userRef.hashCode), timeSearched.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecentSearchesRecord')
          ..add('userRef', userRef)
          ..add('timeSearched', timeSearched)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class RecentSearchesRecordBuilder
    implements Builder<RecentSearchesRecord, RecentSearchesRecordBuilder> {
  _$RecentSearchesRecord? _$v;

  DocumentReference<Object?>? _userRef;
  DocumentReference<Object?>? get userRef => _$this._userRef;
  set userRef(DocumentReference<Object?>? userRef) => _$this._userRef = userRef;

  DateTime? _timeSearched;
  DateTime? get timeSearched => _$this._timeSearched;
  set timeSearched(DateTime? timeSearched) =>
      _$this._timeSearched = timeSearched;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  RecentSearchesRecordBuilder() {
    RecentSearchesRecord._initializeBuilder(this);
  }

  RecentSearchesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userRef = $v.userRef;
      _timeSearched = $v.timeSearched;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecentSearchesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RecentSearchesRecord;
  }

  @override
  void update(void Function(RecentSearchesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecentSearchesRecord build() => _build();

  _$RecentSearchesRecord _build() {
    final _$result = _$v ??
        new _$RecentSearchesRecord._(
            userRef: userRef, timeSearched: timeSearched, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
