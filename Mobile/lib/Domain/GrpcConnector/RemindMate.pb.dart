//
//  Generated code. Do not modify.
//  source: RemindMate.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'RemindMate.pbenum.dart';

export 'RemindMate.pbenum.dart';

class GetMyDataRequest extends $pb.GeneratedMessage {
  factory GetMyDataRequest() => create();
  GetMyDataRequest._() : super();
  factory GetMyDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyDataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyDataRequest clone() => GetMyDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyDataRequest copyWith(void Function(GetMyDataRequest) updates) => super.copyWith((message) => updates(message as GetMyDataRequest)) as GetMyDataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyDataRequest create() => GetMyDataRequest._();
  GetMyDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyDataRequest> createRepeated() => $pb.PbList<GetMyDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyDataRequest>(create);
  static GetMyDataRequest? _defaultInstance;
}

class GetMyDataResponse extends $pb.GeneratedMessage {
  factory GetMyDataResponse({
    $core.Iterable<Friend>? friends,
  }) {
    final $result = create();
    if (friends != null) {
      $result.friends.addAll(friends);
    }
    return $result;
  }
  GetMyDataResponse._() : super();
  factory GetMyDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMyDataResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..pc<Friend>(1, _omitFieldNames ? '' : 'friends', $pb.PbFieldType.PM, subBuilder: Friend.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyDataResponse clone() => GetMyDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyDataResponse copyWith(void Function(GetMyDataResponse) updates) => super.copyWith((message) => updates(message as GetMyDataResponse)) as GetMyDataResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyDataResponse create() => GetMyDataResponse._();
  GetMyDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyDataResponse> createRepeated() => $pb.PbList<GetMyDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyDataResponse>(create);
  static GetMyDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Friend> get friends => $_getList(0);
}

class FriendReminders extends $pb.GeneratedMessage {
  factory FriendReminders({
    $core.String? title,
    $fixnum.Int64? startDateTime,
    $fixnum.Int64? endDateTime,
    $core.bool? showTime,
    ReminderType? reminderType,
    $core.String? reminderId,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (startDateTime != null) {
      $result.startDateTime = startDateTime;
    }
    if (endDateTime != null) {
      $result.endDateTime = endDateTime;
    }
    if (showTime != null) {
      $result.showTime = showTime;
    }
    if (reminderType != null) {
      $result.reminderType = reminderType;
    }
    if (reminderId != null) {
      $result.reminderId = reminderId;
    }
    return $result;
  }
  FriendReminders._() : super();
  factory FriendReminders.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendReminders.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendReminders', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aInt64(2, _omitFieldNames ? '' : 'startDateTime', protoName: 'startDateTime')
    ..aInt64(3, _omitFieldNames ? '' : 'endDateTime', protoName: 'endDateTime')
    ..aOB(4, _omitFieldNames ? '' : 'showTime', protoName: 'showTime')
    ..e<ReminderType>(5, _omitFieldNames ? '' : 'reminderType', $pb.PbFieldType.OE, protoName: 'reminderType', defaultOrMaker: ReminderType.EVENT, valueOf: ReminderType.valueOf, enumValues: ReminderType.values)
    ..aOS(6, _omitFieldNames ? '' : 'reminderId', protoName: 'reminderId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FriendReminders clone() => FriendReminders()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FriendReminders copyWith(void Function(FriendReminders) updates) => super.copyWith((message) => updates(message as FriendReminders)) as FriendReminders;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendReminders create() => FriendReminders._();
  FriendReminders createEmptyInstance() => create();
  static $pb.PbList<FriendReminders> createRepeated() => $pb.PbList<FriendReminders>();
  @$core.pragma('dart2js:noInline')
  static FriendReminders getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendReminders>(create);
  static FriendReminders? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get startDateTime => $_getI64(1);
  @$pb.TagNumber(2)
  set startDateTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDateTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDateTime() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get endDateTime => $_getI64(2);
  @$pb.TagNumber(3)
  set endDateTime($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDateTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDateTime() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get showTime => $_getBF(3);
  @$pb.TagNumber(4)
  set showTime($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasShowTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearShowTime() => clearField(4);

  @$pb.TagNumber(5)
  ReminderType get reminderType => $_getN(4);
  @$pb.TagNumber(5)
  set reminderType(ReminderType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasReminderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearReminderType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get reminderId => $_getSZ(5);
  @$pb.TagNumber(6)
  set reminderId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReminderId() => $_has(5);
  @$pb.TagNumber(6)
  void clearReminderId() => clearField(6);
}

class Friend extends $pb.GeneratedMessage {
  factory Friend({
    $core.String? name,
    $core.String? email,
    $core.String? phone,
    RelationshipType? relationship,
    $core.String? timezone,
    $core.String? birthday,
    $core.String? notes,
    $core.Iterable<FriendReminders>? reminders,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phone != null) {
      $result.phone = phone;
    }
    if (relationship != null) {
      $result.relationship = relationship;
    }
    if (timezone != null) {
      $result.timezone = timezone;
    }
    if (birthday != null) {
      $result.birthday = birthday;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    if (reminders != null) {
      $result.reminders.addAll(reminders);
    }
    return $result;
  }
  Friend._() : super();
  factory Friend.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Friend.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Friend', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'phone')
    ..e<RelationshipType>(4, _omitFieldNames ? '' : 'relationship', $pb.PbFieldType.OE, defaultOrMaker: RelationshipType.FRIEND, valueOf: RelationshipType.valueOf, enumValues: RelationshipType.values)
    ..aOS(5, _omitFieldNames ? '' : 'timezone')
    ..aOS(6, _omitFieldNames ? '' : 'birthday')
    ..aOS(7, _omitFieldNames ? '' : 'notes')
    ..pc<FriendReminders>(8, _omitFieldNames ? '' : 'reminders', $pb.PbFieldType.PM, subBuilder: FriendReminders.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Friend clone() => Friend()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Friend copyWith(void Function(Friend) updates) => super.copyWith((message) => updates(message as Friend)) as Friend;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Friend create() => Friend._();
  Friend createEmptyInstance() => create();
  static $pb.PbList<Friend> createRepeated() => $pb.PbList<Friend>();
  @$core.pragma('dart2js:noInline')
  static Friend getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Friend>(create);
  static Friend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => clearField(3);

  @$pb.TagNumber(4)
  RelationshipType get relationship => $_getN(3);
  @$pb.TagNumber(4)
  set relationship(RelationshipType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRelationship() => $_has(3);
  @$pb.TagNumber(4)
  void clearRelationship() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get timezone => $_getSZ(4);
  @$pb.TagNumber(5)
  set timezone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimezone() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimezone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get birthday => $_getSZ(5);
  @$pb.TagNumber(6)
  set birthday($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBirthday() => $_has(5);
  @$pb.TagNumber(6)
  void clearBirthday() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get notes => $_getSZ(6);
  @$pb.TagNumber(7)
  set notes($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNotes() => $_has(6);
  @$pb.TagNumber(7)
  void clearNotes() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<FriendReminders> get reminders => $_getList(7);
}

class UpdateMyDataRequest extends $pb.GeneratedMessage {
  factory UpdateMyDataRequest({
    $core.Iterable<Friend>? friends,
  }) {
    final $result = create();
    if (friends != null) {
      $result.friends.addAll(friends);
    }
    return $result;
  }
  UpdateMyDataRequest._() : super();
  factory UpdateMyDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMyDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateMyDataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..pc<Friend>(1, _omitFieldNames ? '' : 'friends', $pb.PbFieldType.PM, subBuilder: Friend.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMyDataRequest clone() => UpdateMyDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMyDataRequest copyWith(void Function(UpdateMyDataRequest) updates) => super.copyWith((message) => updates(message as UpdateMyDataRequest)) as UpdateMyDataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMyDataRequest create() => UpdateMyDataRequest._();
  UpdateMyDataRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMyDataRequest> createRepeated() => $pb.PbList<UpdateMyDataRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMyDataRequest>(create);
  static UpdateMyDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Friend> get friends => $_getList(0);
}

class UpdateMyDataResponse extends $pb.GeneratedMessage {
  factory UpdateMyDataResponse() => create();
  UpdateMyDataResponse._() : super();
  factory UpdateMyDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMyDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateMyDataResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMyDataResponse clone() => UpdateMyDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMyDataResponse copyWith(void Function(UpdateMyDataResponse) updates) => super.copyWith((message) => updates(message as UpdateMyDataResponse)) as UpdateMyDataResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMyDataResponse create() => UpdateMyDataResponse._();
  UpdateMyDataResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateMyDataResponse> createRepeated() => $pb.PbList<UpdateMyDataResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMyDataResponse>(create);
  static UpdateMyDataResponse? _defaultInstance;
}

class AddFcmTokenRequest extends $pb.GeneratedMessage {
  factory AddFcmTokenRequest({
    $core.String? fcmToken,
  }) {
    final $result = create();
    if (fcmToken != null) {
      $result.fcmToken = fcmToken;
    }
    return $result;
  }
  AddFcmTokenRequest._() : super();
  factory AddFcmTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFcmTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddFcmTokenRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fcmToken', protoName: 'fcmToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFcmTokenRequest clone() => AddFcmTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFcmTokenRequest copyWith(void Function(AddFcmTokenRequest) updates) => super.copyWith((message) => updates(message as AddFcmTokenRequest)) as AddFcmTokenRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFcmTokenRequest create() => AddFcmTokenRequest._();
  AddFcmTokenRequest createEmptyInstance() => create();
  static $pb.PbList<AddFcmTokenRequest> createRepeated() => $pb.PbList<AddFcmTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFcmTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFcmTokenRequest>(create);
  static AddFcmTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fcmToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set fcmToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFcmToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearFcmToken() => clearField(1);
}

class AddFcmTokenResponse extends $pb.GeneratedMessage {
  factory AddFcmTokenResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  AddFcmTokenResponse._() : super();
  factory AddFcmTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFcmTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddFcmTokenResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFcmTokenResponse clone() => AddFcmTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFcmTokenResponse copyWith(void Function(AddFcmTokenResponse) updates) => super.copyWith((message) => updates(message as AddFcmTokenResponse)) as AddFcmTokenResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFcmTokenResponse create() => AddFcmTokenResponse._();
  AddFcmTokenResponse createEmptyInstance() => create();
  static $pb.PbList<AddFcmTokenResponse> createRepeated() => $pb.PbList<AddFcmTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static AddFcmTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFcmTokenResponse>(create);
  static AddFcmTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
