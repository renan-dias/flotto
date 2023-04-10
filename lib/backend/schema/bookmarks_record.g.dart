// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BookmarksRecord> _$bookmarksRecordSerializer =
    new _$BookmarksRecordSerializer();

class _$BookmarksRecordSerializer
    implements StructuredSerializer<BookmarksRecord> {
  @override
  final Iterable<Type> types = const [BookmarksRecord, _$BookmarksRecord];
  @override
  final String wireName = 'BookmarksRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, BookmarksRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.postRefs;
    if (value != null) {
      result
        ..add('postRefs')
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
  BookmarksRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BookmarksRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'postRefs':
          result.postRefs.replace(serializers.deserialize(value,
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

class _$BookmarksRecord extends BookmarksRecord {
  @override
  final BuiltList<DocumentReference<Object?>>? postRefs;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$BookmarksRecord([void Function(BookmarksRecordBuilder)? updates]) =>
      (new BookmarksRecordBuilder()..update(updates))._build();

  _$BookmarksRecord._({this.postRefs, this.ffRef}) : super._();

  @override
  BookmarksRecord rebuild(void Function(BookmarksRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookmarksRecordBuilder toBuilder() =>
      new BookmarksRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookmarksRecord &&
        postRefs == other.postRefs &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, postRefs.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BookmarksRecord')
          ..add('postRefs', postRefs)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class BookmarksRecordBuilder
    implements Builder<BookmarksRecord, BookmarksRecordBuilder> {
  _$BookmarksRecord? _$v;

  ListBuilder<DocumentReference<Object?>>? _postRefs;
  ListBuilder<DocumentReference<Object?>> get postRefs =>
      _$this._postRefs ??= new ListBuilder<DocumentReference<Object?>>();
  set postRefs(ListBuilder<DocumentReference<Object?>>? postRefs) =>
      _$this._postRefs = postRefs;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  BookmarksRecordBuilder() {
    BookmarksRecord._initializeBuilder(this);
  }

  BookmarksRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postRefs = $v.postRefs?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookmarksRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BookmarksRecord;
  }

  @override
  void update(void Function(BookmarksRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BookmarksRecord build() => _build();

  _$BookmarksRecord _build() {
    _$BookmarksRecord _$result;
    try {
      _$result = _$v ??
          new _$BookmarksRecord._(postRefs: _postRefs?.build(), ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'postRefs';
        _postRefs?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'BookmarksRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
