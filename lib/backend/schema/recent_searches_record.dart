import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'recent_searches_record.g.dart';

abstract class RecentSearchesRecord
    implements Built<RecentSearchesRecord, RecentSearchesRecordBuilder> {
  static Serializer<RecentSearchesRecord> get serializer =>
      _$recentSearchesRecordSerializer;

  DocumentReference? get userRef;

  @BuiltValueField(wireName: 'time_searched')
  DateTime? get timeSearched;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(RecentSearchesRecordBuilder builder) =>
      builder;

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('recent_searches')
          : FirebaseFirestore.instance.collectionGroup('recent_searches');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('recent_searches').doc();

  static Stream<RecentSearchesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<RecentSearchesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  RecentSearchesRecord._();
  factory RecentSearchesRecord(
          [void Function(RecentSearchesRecordBuilder) updates]) =
      _$RecentSearchesRecord;

  static RecentSearchesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createRecentSearchesRecordData({
  DocumentReference? userRef,
  DateTime? timeSearched,
}) {
  final firestoreData = serializers.toFirestore(
    RecentSearchesRecord.serializer,
    RecentSearchesRecord(
      (r) => r
        ..userRef = userRef
        ..timeSearched = timeSearched,
    ),
  );

  return firestoreData;
}
