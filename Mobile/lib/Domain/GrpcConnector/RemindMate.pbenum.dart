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

import 'package:protobuf/protobuf.dart' as $pb;

class ReminderType extends $pb.ProtobufEnum {
  static const ReminderType EVENT = ReminderType._(0, _omitEnumNames ? '' : 'EVENT');

  static const $core.List<ReminderType> values = <ReminderType> [
    EVENT,
  ];

  static final $core.Map<$core.int, ReminderType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ReminderType? valueOf($core.int value) => _byValue[value];

  const ReminderType._($core.int v, $core.String n) : super(v, n);
}

class RelationshipType extends $pb.ProtobufEnum {
  static const RelationshipType FRIEND = RelationshipType._(0, _omitEnumNames ? '' : 'FRIEND');

  static const $core.List<RelationshipType> values = <RelationshipType> [
    FRIEND,
  ];

  static final $core.Map<$core.int, RelationshipType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RelationshipType? valueOf($core.int value) => _byValue[value];

  const RelationshipType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
