import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'followers_record.g.dart';

abstract class FollowersRecord
    implements Built<FollowersRecord, FollowersRecordBuilder> {
  static Serializer<FollowersRecord> get serializer =>
      _$followersRecordSerializer;

  BuiltList<DocumentReference>? get userRefs;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(FollowersRecordBuilder builder) =>
      builder..userRefs = ListBuilder();

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('followers')
          : FirebaseFirestore.instance.collectionGroup('followers');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('followers').doc();

  static Stream<FollowersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<FollowersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  FollowersRecord._();
  factory FollowersRecord([void Function(FollowersRecordBuilder) updates]) =
      _$FollowersRecord;

  static FollowersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createFollowersRecordData() {
  final firestoreData = serializers.toFirestore(
    FollowersRecord.serializer,
    FollowersRecord(
      (f) => f..userRefs = null,
    ),
  );

  return firestoreData;
}
