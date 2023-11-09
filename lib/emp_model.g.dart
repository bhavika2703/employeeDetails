// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpModel _$EmpModelFromJson(Map<String, dynamic> json) => EmpModel(
      json['empId'] as String,
      json['empName'] as String,
      json['empRole'] as String,
      DateTime.parse(json['startDate'] as String),
      DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$EmpModelToJson(EmpModel instance) => <String, dynamic>{
      'empId': instance.empId,
      'empName': instance.empName,
      'empRole': instance.empRole,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
