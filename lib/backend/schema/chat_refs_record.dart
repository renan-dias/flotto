import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'chat_refs_record.g.dart';

abstract class ChatRefsRecord
    implements Built<ChatRefsRecord, ChatRefsRecordBuilder> {
  static Serializer<ChatRefsRecord> get serializer =>
      _$chatRefsRecordSerializer;

  DocumentReference? get userRef;

  DocumentReference? get chatRef;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(ChatRefsRecordBuilder builder) => builder;

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('chatRefs')
          : FirebaseFirestore.instance.collectionGroup('chatRefs');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('chatRefs').doc();

  static Stream<ChatRefsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ChatRefsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ChatRefsRecord._();
  factory ChatRefsRecord([void Function(ChatRefsRecordBuilder) updates]) =
      _$ChatRefsRecord;

  static ChatRefsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createChatRefsRecordData({
  DocumentReference? userRef,
  DocumentReference? chatRef,
}) {
  final firestoreData = serializers.toFirestore(
    ChatRefsRecord.serializer,
    ChatRefsRecord(
      (c) => c
        ..userRef = userRef
        ..chatRef = chatRef,
    ),
  );

  return firestoreData;
}
