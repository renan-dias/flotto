import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  @BuiltValueField(wireName: 'post_photo')
  String? get postPhoto;

  @BuiltValueField(wireName: 'post_user')
  DocumentReference? get postUser;

  @BuiltValueField(wireName: 'time_posted')
  DateTime? get timePosted;

  BuiltList<DocumentReference>? get likes;

  @BuiltValueField(wireName: 'num_comments')
  int? get numComments;

  @BuiltValueField(wireName: 'post_caption')
  String? get postCaption;

  @BuiltValueField(wireName: 'allow_comments')
  bool? get allowComments;

  @BuiltValueField(wireName: 'allow_likes')
  bool? get allowLikes;

  String? get location;

  @BuiltValueField(wireName: 'call_to_action_enabled')
  bool? get callToActionEnabled;

  @BuiltValueField(wireName: 'call_to_action_text')
  String? get callToActionText;

  @BuiltValueField(wireName: 'call_to_action_link')
  String? get callToActionLink;

  @BuiltValueField(wireName: 'tagged_users')
  BuiltList<DocumentReference>? get taggedUsers;

  String? get labels;

  bool? get deleted;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..postPhoto = ''
    ..likes = ListBuilder()
    ..numComments = 0
    ..postCaption = ''
    ..allowComments = false
    ..allowLikes = false
    ..location = ''
    ..callToActionEnabled = false
    ..callToActionText = ''
    ..callToActionLink = ''
    ..taggedUsers = ListBuilder()
    ..labels = ''
    ..deleted = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  PostsRecord._();
  factory PostsRecord([void Function(PostsRecordBuilder) updates]) =
      _$PostsRecord;

  static PostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createPostsRecordData({
  String? postPhoto,
  DocumentReference? postUser,
  DateTime? timePosted,
  int? numComments,
  String? postCaption,
  bool? allowComments,
  bool? allowLikes,
  String? location,
  bool? callToActionEnabled,
  String? callToActionText,
  String? callToActionLink,
  String? labels,
  bool? deleted,
}) {
  final firestoreData = serializers.toFirestore(
    PostsRecord.serializer,
    PostsRecord(
      (p) => p
        ..postPhoto = postPhoto
        ..postUser = postUser
        ..timePosted = timePosted
        ..likes = null
        ..numComments = numComments
        ..postCaption = postCaption
        ..allowComments = allowComments
        ..allowLikes = allowLikes
        ..location = location
        ..callToActionEnabled = callToActionEnabled
        ..callToActionText = callToActionText
        ..callToActionLink = callToActionLink
        ..taggedUsers = null
        ..labels = labels
        ..deleted = deleted,
    ),
  );

  return firestoreData;
}
