import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_assignment2/cubit/cubit.dart';
import 'package:realtime_innovations_assignment2/cubit/cubit_state.dart';
import 'package:realtime_innovations_assignment2/employeeList.dart';

class CubitLogics extends StatefulWidget {
  const CubitLogics({Key? key}) : super(key: key);

  @override
  State<CubitLogics> createState() => _CubitLogicsState();
}

class _CubitLogicsState extends State<CubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits,CubitStates>(
        builder: (context, state) {
          if(state is WelcomeState) {
            return const EmpList(title: 'Employee List');
          }else{
             return Container(color: Colors.deepPurpleAccent,);
          }
        },
      ),
    );
  }
}
