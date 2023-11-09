import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'emp_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class EmpModel {
  EmpModel(
   this.empId, this.empName, this.empRole, this.startDate, this.endDate);

  String empId;
  String empName;
  String empRole;
  DateTime startDate;
  DateTime endDate;


  @override
  List<Object?> get props => [
    empId,
    empName,
    empRole,
    startDate,
    endDate,
  ];

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory EmpModel.fromJson(Map<String, dynamic> json) =>
      _$EmpModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EmpModelToJson(this);
}
