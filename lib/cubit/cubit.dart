import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_assignment2/cubit/cubit_state.dart';
import 'package:realtime_innovations_assignment2/emp_model.dart';
import 'package:realtime_innovations_assignment2/firestore_database.dart';

class AppCubits extends Cubit<CubitStates> {
  final FireStoreServices _repository;

  AppCubits(this._repository) : super(InitialState()) {
    emit(WelcomeState());
  }

  Future<void> fetchEmp() async {
    emit(LoadingState());
    try {
      final List<EmpModel>? response = await _repository.getEmpData();

      emit(ResponseState(employee: response ?? []));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
