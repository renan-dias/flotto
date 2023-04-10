// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_refs_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChatRefsRecord> _$chatRefsRecordSerializer =
    new _$ChatRefsRecordSerializer();

class _$ChatRefsRecordSerializer
    implements StructuredSerializer<ChatRefsRecord> {
  @override
  final Iterable<Type> types = const [ChatRefsRecord, _$ChatRefsRecord];
  @override
  final String wireName = 'ChatRefsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatRefsRecord object,
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
    value = object.chatRef;
    if (value != null) {
      result
        ..add('chatRef')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
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
  ChatRefsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatRefsRecordBuilder();

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
        case 'chatRef':
          result.chatRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
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

class _$ChatRefsRecord extends ChatRefsRecord {
  @override
  final DocumentReference<Object?>? userRef;
  @override
  final DocumentReference<Object?>? chatRef;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ChatRefsRecord([void Function(ChatRefsRecordBuilder)? updates]) =>
      (new ChatRefsRecordBuilder()..update(updates))._build();

  _$ChatRefsRecord._({this.userRef, this.chatRef, this.ffRef}) : super._();

  @override
  ChatRefsRecord rebuild(void Function(ChatRefsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatRefsRecordBuilder toBuilder() =>
      new ChatRefsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRefsRecord &&
        userRef == other.userRef &&
        chatRef == other.chatRef &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, userRef.hashCode), chatRef.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatRefsRecord')
          ..add('userRef', userRef)
          ..add('chatRef', chatRef)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ChatRefsRecordBuilder
    implements Builder<ChatRefsRecord, ChatRefsRecordBuilder> {
  _$ChatRefsRecord? _$v;

  DocumentReference<Object?>? _userRef;
  DocumentReference<Object?>? get userRef => _$this._userRef;
  set userRef(DocumentReference<Object?>? userRef) => _$this._userRef = userRef;

  DocumentReference<Object?>? _chatRef;
  DocumentReference<Object?>? get chatRef => _$this._chatRef;
  set chatRef(DocumentReference<Object?>? chatRef) => _$this._chatRef = chatRef;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ChatRefsRecordBuilder() {
    ChatRefsRecord._initializeBuilder(this);
  }

  ChatRefsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userRef = $v.userRef;
      _chatRef = $v.chatRef;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatRefsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatRefsRecord;
  }

  @override
  void update(void Function(ChatRefsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatRefsRecord build() => _build();

  _$ChatRefsRecord _build() {
    final _$result = _$v ??
        new _$ChatRefsRecord._(
            userRef: userRef, chatRef: chatRef, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
