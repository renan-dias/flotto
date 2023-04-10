// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PostsRecord> _$postsRecordSerializer = new _$PostsRecordSerializer();

class _$PostsRecordSerializer implements StructuredSerializer<PostsRecord> {
  @override
  final Iterable<Type> types = const [PostsRecord, _$PostsRecord];
  @override
  final String wireName = 'PostsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, PostsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.postPhoto;
    if (value != null) {
      result
        ..add('post_photo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postUser;
    if (value != null) {
      result
        ..add('post_user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.timePosted;
    if (value != null) {
      result
        ..add('time_posted')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.likes;
    if (value != null) {
      result
        ..add('likes')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.numComments;
    if (value != null) {
      result
        ..add('num_comments')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.postCaption;
    if (value != null) {
      result
        ..add('post_caption')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.allowComments;
    if (value != null) {
      result
        ..add('allow_comments')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.allowLikes;
    if (value != null) {
      result
        ..add('allow_likes')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.callToActionEnabled;
    if (value != null) {
      result
        ..add('call_to_action_enabled')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.callToActionText;
    if (value != null) {
      result
        ..add('call_to_action_text')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.callToActionLink;
    if (value != null) {
      result
        ..add('call_to_action_link')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.taggedUsers;
    if (value != null) {
      result
        ..add('tagged_users')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.labels;
    if (value != null) {
      result
        ..add('labels')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.deleted;
    if (value != null) {
      result
        ..add('deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
  PostsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PostsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'post_photo':
          result.postPhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'post_user':
          result.postUser = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'time_posted':
          result.timePosted = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'likes':
          result.likes.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'num_comments':
          result.numComments = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'post_caption':
          result.postCaption = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'allow_comments':
          result.allowComments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'allow_likes':
          result.allowLikes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'call_to_action_enabled':
          result.callToActionEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'call_to_action_text':
          result.callToActionText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'call_to_action_link':
          result.callToActionLink = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tagged_users':
          result.taggedUsers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'labels':
          result.labels = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'deleted':
          result.deleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
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

class _$PostsRecord extends PostsRecord {
  @override
  final String? postPhoto;
  @override
  final DocumentReference<Object?>? postUser;
  @override
  final DateTime? timePosted;
  @override
  final BuiltList<DocumentReference<Object?>>? likes;
  @override
  final int? numComments;
  @override
  final String? postCaption;
  @override
  final bool? allowComments;
  @override
  final bool? allowLikes;
  @override
  final String? location;
  @override
  final bool? callToActionEnabled;
  @override
  final String? callToActionText;
  @override
  final String? callToActionLink;
  @override
  final BuiltList<DocumentReference<Object?>>? taggedUsers;
  @override
  final String? labels;
  @override
  final bool? deleted;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$PostsRecord([void Function(PostsRecordBuilder)? updates]) =>
      (new PostsRecordBuilder()..update(updates))._build();

  _$PostsRecord._(
      {this.postPhoto,
      this.postUser,
      this.timePosted,
      this.likes,
      this.numComments,
      this.postCaption,
      this.allowComments,
      this.allowLikes,
      this.location,
      this.callToActionEnabled,
      this.callToActionText,
      this.callToActionLink,
      this.taggedUsers,
      this.labels,
      this.deleted,
      this.ffRef})
      : super._();

  @override
  PostsRecord rebuild(void Function(PostsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostsRecordBuilder toBuilder() => new PostsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostsRecord &&
        postPhoto == other.postPhoto &&
        postUser == other.postUser &&
        timePosted == other.timePosted &&
        likes == other.likes &&
        numComments == other.numComments &&
        postCaption == other.postCaption &&
        allowComments == other.allowComments &&
        allowLikes == other.allowLikes &&
        location == other.location &&
        callToActionEnabled == other.callToActionEnabled &&
        callToActionText == other.callToActionText &&
        callToActionLink == other.callToActionLink &&
        taggedUsers == other.taggedUsers &&
        labels == other.labels &&
        deleted == other.deleted &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    postPhoto
                                                                        .hashCode),
                                                                postUser
                                                                    .hashCode),
                                                            timePosted
                                                                .hashCode),
                                                        likes.hashCode),
                                                    numComments.hashCode),
                                                postCaption.hashCode),
                                            allowComments.hashCode),
                                        allowLikes.hashCode),
                                    location.hashCode),
                                callToActionEnabled.hashCode),
                            callToActionText.hashCode),
                        callToActionLink.hashCode),
                    taggedUsers.hashCode),
                labels.hashCode),
            deleted.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PostsRecord')
          ..add('postPhoto', postPhoto)
          ..add('postUser', postUser)
          ..add('timePosted', timePosted)
          ..add('likes', likes)
          ..add('numComments', numComments)
          ..add('postCaption', postCaption)
          ..add('allowComments', allowComments)
          ..add('allowLikes', allowLikes)
          ..add('location', location)
          ..add('callToActionEnabled', callToActionEnabled)
          ..add('callToActionText', callToActionText)
          ..add('callToActionLink', callToActionLink)
          ..add('taggedUsers', taggedUsers)
          ..add('labels', labels)
          ..add('deleted', deleted)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class PostsRecordBuilder implements Builder<PostsRecord, PostsRecordBuilder> {
  _$PostsRecord? _$v;

  String? _postPhoto;
  String? get postPhoto => _$this._postPhoto;
  set postPhoto(String? postPhoto) => _$this._postPhoto = postPhoto;

  DocumentReference<Object?>? _postUser;
  DocumentReference<Object?>? get postUser => _$this._postUser;
  set postUser(DocumentReference<Object?>? postUser) =>
      _$this._postUser = postUser;

  DateTime? _timePosted;
  DateTime? get timePosted => _$this._timePosted;
  set timePosted(DateTime? timePosted) => _$this._timePosted = timePosted;

  ListBuilder<DocumentReference<Object?>>? _likes;
  ListBuilder<DocumentReference<Object?>> get likes =>
      _$this._likes ??= new ListBuilder<DocumentReference<Object?>>();
  set likes(ListBuilder<DocumentReference<Object?>>? likes) =>
      _$this._likes = likes;

  int? _numComments;
  int? get numComments => _$this._numComments;
  set numComments(int? numComments) => _$this._numComments = numComments;

  String? _postCaption;
  String? get postCaption => _$this._postCaption;
  set postCaption(String? postCaption) => _$this._postCaption = postCaption;

  bool? _allowComments;
  bool? get allowComments => _$this._allowComments;
  set allowComments(bool? allowComments) =>
      _$this._allowComments = allowComments;

  bool? _allowLikes;
  bool? get allowLikes => _$this._allowLikes;
  set allowLikes(bool? allowLikes) => _$this._allowLikes = allowLikes;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  bool? _callToActionEnabled;
  bool? get callToActionEnabled => _$this._callToActionEnabled;
  set callToActionEnabled(bool? callToActionEnabled) =>
      _$this._callToActionEnabled = callToActionEnabled;

  String? _callToActionText;
  String? get callToActionText => _$this._callToActionText;
  set callToActionText(String? callToActionText) =>
      _$this._callToActionText = callToActionText;

  String? _callToActionLink;
  String? get callToActionLink => _$this._callToActionLink;
  set callToActionLink(String? callToActionLink) =>
      _$this._callToActionLink = callToActionLink;

  ListBuilder<DocumentReference<Object?>>? _taggedUsers;
  ListBuilder<DocumentReference<Object?>> get taggedUsers =>
      _$this._taggedUsers ??= new ListBuilder<DocumentReference<Object?>>();
  set taggedUsers(ListBuilder<DocumentReference<Object?>>? taggedUsers) =>
      _$this._taggedUsers = taggedUsers;

  String? _labels;
  String? get labels => _$this._labels;
  set labels(String? labels) => _$this._labels = labels;

  bool? _deleted;
  bool? get deleted => _$this._deleted;
  set deleted(bool? deleted) => _$this._deleted = deleted;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  PostsRecordBuilder() {
    PostsRecord._initializeBuilder(this);
  }

  PostsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postPhoto = $v.postPhoto;
      _postUser = $v.postUser;
      _timePosted = $v.timePosted;
      _likes = $v.likes?.toBuilder();
      _numComments = $v.numComments;
      _postCaption = $v.postCaption;
      _allowComments = $v.allowComments;
      _allowLikes = $v.allowLikes;
      _location = $v.location;
      _callToActionEnabled = $v.callToActionEnabled;
      _callToActionText = $v.callToActionText;
      _callToActionLink = $v.callToActionLink;
      _taggedUsers = $v.taggedUsers?.toBuilder();
      _labels = $v.labels;
      _deleted = $v.deleted;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PostsRecord;
  }

  @override
  void update(void Function(PostsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PostsRecord build() => _build();

  _$PostsRecord _build() {
    _$PostsRecord _$result;
    try {
      _$result = _$v ??
          new _$PostsRecord._(
              postPhoto: postPhoto,
              postUser: postUser,
              timePosted: timePosted,
              likes: _likes?.build(),
              numComments: numComments,
              postCaption: postCaption,
              allowComments: allowComments,
              allowLikes: allowLikes,
              location: location,
              callToActionEnabled: callToActionEnabled,
              callToActionText: callToActionText,
              callToActionLink: callToActionLink,
              taggedUsers: _taggedUsers?.build(),
              labels: labels,
              deleted: deleted,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'likes';
        _likes?.build();

        _$failedField = 'taggedUsers';
        _taggedUsers?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PostsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
