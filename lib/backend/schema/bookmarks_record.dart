import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'bookmarks_record.g.dart';

abstract class BookmarksRecord
    implements Built<BookmarksRecord, BookmarksRecordBuilder> {
  static Serializer<BookmarksRecord> get serializer =>
      _$bookmarksRecordSerializer;

  BuiltList<DocumentReference>? get postRefs;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(BookmarksRecordBuilder builder) =>
      builder..postRefs = ListBuilder();

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('bookmarks')
          : FirebaseFirestore.instance.collectionGroup('bookmarks');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('bookmarks').doc();

  static Stream<BookmarksRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<BookmarksRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  BookmarksRecord._();
  factory BookmarksRecord([void Function(BookmarksRecordBuilder) updates]) =
      _$BookmarksRecord;

  static BookmarksRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createBookmarksRecordData() {
  final firestoreData = serializers.toFirestore(
    BookmarksRecord.serializer,
    BookmarksRecord(
      (b) => b..postRefs = null,
    ),
  );

  return firestoreData;
}
