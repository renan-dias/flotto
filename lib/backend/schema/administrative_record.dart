import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'administrative_record.g.dart';

abstract class AdministrativeRecord
    implements Built<AdministrativeRecord, AdministrativeRecordBuilder> {
  static Serializer<AdministrativeRecord> get serializer =>
      _$administrativeRecordSerializer;

  BuiltList<String>? get usernames;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(AdministrativeRecordBuilder builder) =>
      builder..usernames = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('administrative');

  static Stream<AdministrativeRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<AdministrativeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  AdministrativeRecord._();
  factory AdministrativeRecord(
          [void Function(AdministrativeRecordBuilder) updates]) =
      _$AdministrativeRecord;

  static AdministrativeRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createAdministrativeRecordData() {
  final firestoreData = serializers.toFirestore(
    AdministrativeRecord.serializer,
    AdministrativeRecord(
      (a) => a..usernames = null,
    ),
  );

  return firestoreData;
}
