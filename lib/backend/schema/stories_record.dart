import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'stories_record.g.dart';

abstract class StoriesRecord
    implements Built<StoriesRecord, StoriesRecordBuilder> {
  static Serializer<StoriesRecord> get serializer => _$storiesRecordSerializer;

  DocumentReference? get user;

  String? get storyPhoto;

  String? get storyVideo;

  @BuiltValueField(wireName: 'time_created')
  DateTime? get timeCreated;

  BuiltList<DocumentReference>? get views;

  @BuiltValueField(wireName: 'expire_time')
  DateTime? get expireTime;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(StoriesRecordBuilder builder) => builder
    ..storyPhoto = ''
    ..storyVideo = ''
    ..views = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('stories');

  static Stream<StoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<StoriesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  StoriesRecord._();
  factory StoriesRecord([void Function(StoriesRecordBuilder) updates]) =
      _$StoriesRecord;

  static StoriesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createStoriesRecordData({
  DocumentReference? user,
  String? storyPhoto,
  String? storyVideo,
  DateTime? timeCreated,
  DateTime? expireTime,
}) {
  final firestoreData = serializers.toFirestore(
    StoriesRecord.serializer,
    StoriesRecord(
      (s) => s
        ..user = user
        ..storyPhoto = storyPhoto
        ..storyVideo = storyVideo
        ..timeCreated = timeCreated
        ..views = null
        ..expireTime = expireTime,
    ),
  );

  return firestoreData;
}
