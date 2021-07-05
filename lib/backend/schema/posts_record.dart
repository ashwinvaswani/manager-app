import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  @nullable
  String get contact;

  @nullable
  String get date;

  @nullable
  String get description;

  @nullable
  DateTime get firestoreTimestamp;

  @nullable
  bool get isValidated;

  @nullable
  String get location;

  @nullable
  String get name;

  @nullable
  String get reporterAuthEmail;

  @nullable
  int get status;

  @nullable
  int get urgency;

  @nullable
  BuiltList<String> get images;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..contact = ''
    ..date = ''
    ..description = ''
    ..isValidated = false
    ..location = ''
    ..name = ''
    ..reporterAuthEmail = ''
    ..status = 0
    ..urgency = 0
    ..images = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PostsRecord._();
  factory PostsRecord([void Function(PostsRecordBuilder) updates]) =
      _$PostsRecord;

  static PostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createPostsRecordData({
  String contact,
  String date,
  String description,
  DateTime firestoreTimestamp,
  bool isValidated,
  String location,
  String name,
  String reporterAuthEmail,
  int status,
  int urgency,
}) =>
    serializers.toFirestore(
        PostsRecord.serializer,
        PostsRecord((p) => p
          ..contact = contact
          ..date = date
          ..description = description
          ..firestoreTimestamp = firestoreTimestamp
          ..isValidated = isValidated
          ..location = location
          ..name = name
          ..reporterAuthEmail = reporterAuthEmail
          ..status = status
          ..urgency = urgency
          ..images = null));
