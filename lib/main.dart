import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_assignment2/constants/colors.dart';
import 'package:realtime_innovations_assignment2/cubit/cubit.dart';
import 'package:realtime_innovations_assignment2/employeeList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:realtime_innovations_assignment2/firestore_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealTime-Innovation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<AppCubits>(
              create: (context) => AppCubits(FireStoreServices())..fetchEmp(),)
          ],
          child: const EmpList(title: 'Employee List')),
    );
  }
}
