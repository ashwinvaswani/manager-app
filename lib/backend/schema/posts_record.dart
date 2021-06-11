import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  @nullable
  String get title;

  @nullable
  String get description;

  @nullable
  String get priority;

  @nullable
  String get location;

  @nullable
  @BuiltValueField(wireName: 'image_url')
  String get imageUrl;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  Timestamp get createdAt;

  @nullable
  @BuiltValueField(wireName: 'is_validation')
  int get isValidation;

  @nullable
  @BuiltValueField(wireName: 'in_progress')
  int get inProgress;

  @nullable
  @BuiltValueField(wireName: 'is_complete')
  int get isComplete;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..title = ''
    ..description = ''
    ..priority = ''
    ..location = ''
    ..imageUrl = ''
    ..isValidation = 0
    ..inProgress = 0
    ..isComplete = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PostsRecord._();
  factory PostsRecord([void Function(PostsRecordBuilder) updates]) =
      _$PostsRecord;
}

Map<String, dynamic> createPostsRecordData({
  String title,
  String description,
  String priority,
  String location,
  String imageUrl,
  DocumentReference user,
  Timestamp createdAt,
  int isValidation,
  int inProgress,
  int isComplete,
}) =>
    serializers.serializeWith(
        PostsRecord.serializer,
        PostsRecord((p) => p
          ..title = title
          ..description = description
          ..priority = priority
          ..location = location
          ..imageUrl = imageUrl
          ..user = user
          ..createdAt = createdAt
          ..isValidation = isValidation
          ..inProgress = inProgress
          ..isComplete = isComplete));

PostsRecord get dummyPostsRecord {
  final builder = PostsRecordBuilder()
    ..title = dummyString
    ..description = dummyString
    ..priority = dummyString
    ..location = dummyString
    ..imageUrl = dummyImagePath
    ..createdAt = dummyTimestamp
    ..isValidation = dummyInteger
    ..inProgress = dummyInteger
    ..isComplete = dummyInteger;
  return builder.build();
}

List<PostsRecord> createDummyPostsRecord({int count}) =>
    List.generate(count, (_) => dummyPostsRecord);
