import 'package:equatable/equatable.dart';
import 'package:realtime_innovations_assignment2/emp_model.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object> get props => throw UnimplementedError();
}

class WelcomeState extends CubitStates {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadingState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class ErrorState extends CubitStates {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ResponseState extends CubitStates {
  final List<EmpModel> employee;

  ResponseState({
    required this.employee,
  });

  @override
  List<Object?> get props => [employee];
}
