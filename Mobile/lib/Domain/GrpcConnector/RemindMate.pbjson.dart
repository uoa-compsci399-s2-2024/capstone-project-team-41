//
//  Generated code. Do not modify.
//  source: RemindMate.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use reminderTypeDescriptor instead')
const ReminderType$json = {
  '1': 'ReminderType',
  '2': [
    {'1': 'EVENT', '2': 0},
  ],
};

/// Descriptor for `ReminderType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List reminderTypeDescriptor = $convert.base64Decode(
    'CgxSZW1pbmRlclR5cGUSCQoFRVZFTlQQAA==');

@$core.Deprecated('Use relationshipTypeDescriptor instead')
const RelationshipType$json = {
  '1': 'RelationshipType',
  '2': [
    {'1': 'FRIEND', '2': 0},
  ],
};

/// Descriptor for `RelationshipType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List relationshipTypeDescriptor = $convert.base64Decode(
    'ChBSZWxhdGlvbnNoaXBUeXBlEgoKBkZSSUVORBAA');

@$core.Deprecated('Use getMyDataRequestDescriptor instead')
const GetMyDataRequest$json = {
  '1': 'GetMyDataRequest',
};

/// Descriptor for `GetMyDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyDataRequestDescriptor = $convert.base64Decode(
    'ChBHZXRNeURhdGFSZXF1ZXN0');

@$core.Deprecated('Use getMyDataResponseDescriptor instead')
const GetMyDataResponse$json = {
  '1': 'GetMyDataResponse',
  '2': [
    {'1': 'friends', '3': 1, '4': 3, '5': 11, '6': '.remind.mate.grpc.Friend', '10': 'friends'},
  ],
};

/// Descriptor for `GetMyDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyDataResponseDescriptor = $convert.base64Decode(
    'ChFHZXRNeURhdGFSZXNwb25zZRIyCgdmcmllbmRzGAEgAygLMhgucmVtaW5kLm1hdGUuZ3JwYy'
    '5GcmllbmRSB2ZyaWVuZHM=');

@$core.Deprecated('Use friendRemindersDescriptor instead')
const FriendReminders$json = {
  '1': 'FriendReminders',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'startDateTime', '3': 2, '4': 1, '5': 3, '10': 'startDateTime'},
    {'1': 'endDateTime', '3': 3, '4': 1, '5': 3, '10': 'endDateTime'},
    {'1': 'showTime', '3': 4, '4': 1, '5': 8, '10': 'showTime'},
    {'1': 'reminderType', '3': 5, '4': 1, '5': 14, '6': '.remind.mate.grpc.ReminderType', '10': 'reminderType'},
    {'1': 'reminderId', '3': 6, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'recurringReminder', '3': 7, '4': 1, '5': 8, '10': 'recurringReminder'},
    {'1': 'intervalUnit', '3': 8, '4': 1, '5': 9, '10': 'intervalUnit'},
    {'1': 'interval', '3': 9, '4': 1, '5': 3, '10': 'interval'},
  ],
};

/// Descriptor for `FriendReminders`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendRemindersDescriptor = $convert.base64Decode(
    'Cg9GcmllbmRSZW1pbmRlcnMSFAoFdGl0bGUYASABKAlSBXRpdGxlEiQKDXN0YXJ0RGF0ZVRpbW'
    'UYAiABKANSDXN0YXJ0RGF0ZVRpbWUSIAoLZW5kRGF0ZVRpbWUYAyABKANSC2VuZERhdGVUaW1l'
    'EhoKCHNob3dUaW1lGAQgASgIUghzaG93VGltZRJCCgxyZW1pbmRlclR5cGUYBSABKA4yHi5yZW'
    '1pbmQubWF0ZS5ncnBjLlJlbWluZGVyVHlwZVIMcmVtaW5kZXJUeXBlEh4KCnJlbWluZGVySWQY'
    'BiABKAlSCnJlbWluZGVySWQSLAoRcmVjdXJyaW5nUmVtaW5kZXIYByABKAhSEXJlY3VycmluZ1'
    'JlbWluZGVyEiIKDGludGVydmFsVW5pdBgIIAEoCVIMaW50ZXJ2YWxVbml0EhoKCGludGVydmFs'
    'GAkgASgDUghpbnRlcnZhbA==');

@$core.Deprecated('Use friendDescriptor instead')
const Friend$json = {
  '1': 'Friend',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'relationship', '3': 4, '4': 1, '5': 14, '6': '.remind.mate.grpc.RelationshipType', '10': 'relationship'},
    {'1': 'timezone', '3': 5, '4': 1, '5': 9, '10': 'timezone'},
    {'1': 'birthday', '3': 6, '4': 1, '5': 9, '10': 'birthday'},
    {'1': 'notes', '3': 7, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'reminders', '3': 8, '4': 3, '5': 11, '6': '.remind.mate.grpc.FriendReminders', '10': 'reminders'},
  ],
};

/// Descriptor for `Friend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendDescriptor = $convert.base64Decode(
    'CgZGcmllbmQSEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgVlbWFpbBgCIAEoCVIFZW1haWwSFAoFcG'
    'hvbmUYAyABKAlSBXBob25lEkYKDHJlbGF0aW9uc2hpcBgEIAEoDjIiLnJlbWluZC5tYXRlLmdy'
    'cGMuUmVsYXRpb25zaGlwVHlwZVIMcmVsYXRpb25zaGlwEhoKCHRpbWV6b25lGAUgASgJUgh0aW'
    '1lem9uZRIaCghiaXJ0aGRheRgGIAEoCVIIYmlydGhkYXkSFAoFbm90ZXMYByABKAlSBW5vdGVz'
    'Ej8KCXJlbWluZGVycxgIIAMoCzIhLnJlbWluZC5tYXRlLmdycGMuRnJpZW5kUmVtaW5kZXJzUg'
    'lyZW1pbmRlcnM=');

@$core.Deprecated('Use updateMyDataRequestDescriptor instead')
const UpdateMyDataRequest$json = {
  '1': 'UpdateMyDataRequest',
  '2': [
    {'1': 'friends', '3': 1, '4': 3, '5': 11, '6': '.remind.mate.grpc.Friend', '10': 'friends'},
    {'1': 'fcmToken', '3': 2, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
};

/// Descriptor for `UpdateMyDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMyDataRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVNeURhdGFSZXF1ZXN0EjIKB2ZyaWVuZHMYASADKAsyGC5yZW1pbmQubWF0ZS5ncn'
    'BjLkZyaWVuZFIHZnJpZW5kcxIaCghmY21Ub2tlbhgCIAEoCVIIZmNtVG9rZW4=');

@$core.Deprecated('Use updateMyDataResponseDescriptor instead')
const UpdateMyDataResponse$json = {
  '1': 'UpdateMyDataResponse',
};

/// Descriptor for `UpdateMyDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMyDataResponseDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVNeURhdGFSZXNwb25zZQ==');

@$core.Deprecated('Use addFcmTokenRequestDescriptor instead')
const AddFcmTokenRequest$json = {
  '1': 'AddFcmTokenRequest',
  '2': [
    {'1': 'fcmToken', '3': 1, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
};

/// Descriptor for `AddFcmTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFcmTokenRequestDescriptor = $convert.base64Decode(
    'ChJBZGRGY21Ub2tlblJlcXVlc3QSGgoIZmNtVG9rZW4YASABKAlSCGZjbVRva2Vu');

@$core.Deprecated('Use addFcmTokenResponseDescriptor instead')
const AddFcmTokenResponse$json = {
  '1': 'AddFcmTokenResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `AddFcmTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFcmTokenResponseDescriptor = $convert.base64Decode(
    'ChNBZGRGY21Ub2tlblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');

