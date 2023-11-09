import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovations_assignment2/add_employee.dart';
import 'package:realtime_innovations_assignment2/constants/colors.dart';
import 'package:realtime_innovations_assignment2/cubit/cubit.dart';
import 'package:realtime_innovations_assignment2/cubit/cubit_state.dart';
import 'package:realtime_innovations_assignment2/emp_model.dart';
import 'package:realtime_innovations_assignment2/firestore_database.dart';
import 'package:realtime_innovations_assignment2/utils/device.dart';

class EmpList extends StatefulWidget {
  const EmpList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<EmpList> createState() => _EmpListState();
}

class _EmpListState extends State<EmpList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseState) {
            return Column(
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12),
                  width: DeviceUtils.getDeviceWidth(context),
                  color: AppColors.lightGrayColor,
                  child: const Text('Current employees',
                      style:
                      TextStyle(color: AppColors.themeColor, fontSize: 17),
                      textAlign: TextAlign.left),
                ),
                Flexible(
                  child: StreamBuilder(
                    stream: FireStoreServices().listenEmpData(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        var  now= DateTime.now();
                    var startingDate  = snapshot.data!.last.startDate;
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final empDetails = snapshot.data![index];

                                  return Dismissible(
                                    key: Key(empDetails.empId),
                                    background: Container(color: Colors.red),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) async {
                                      await FireStoreServices()
                                          .removeEmpData(empDetails.empId, context);
                                    },
                                    child: ListTile(
                                      onTap: () {
                                        startingDate =   empDetails.startDate;
                                        var empModelData = EmpModel(
                                            empDetails.empId,
                                            empDetails.empName,
                                            empDetails.empRole,
                                            empDetails.startDate,
                                            empDetails.endDate);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                                builder: (_) => AddEmployee(
                                                      empData: empModelData,
                                                      isUpdatedView: true,
                                                    )));
                                      },
                                      title: Text(
                                        empDetails.empName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(empDetails.empRole,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.hintGrayColor)),
                                          Row(
                                            children: [
                                              Text(
                                                  'From ${DateFormat('dd MMM, yy').format(empDetails.endDate).toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColors.hintGrayColor)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if(startingDate.isAfter(DateTime.now()))...<Widget>[
                              Container(
                                height: 60,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 12),
                                width: DeviceUtils.getDeviceWidth(context),
                                color: AppColors.lightGrayColor,
                                child: const Text('Previous employees',
                                    style:
                                    TextStyle(color: AppColors.themeColor, fontSize: 17),
                                    textAlign: TextAlign.left),
                              ),
                            ],


                          ],
                        );
                      } else {
                        return noEmpRecodFoundView(context);
                      }
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 70,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12),
                  width: DeviceUtils.getDeviceWidth(context),
                  color: AppColors.lightGrayColor,
                  child: const Text('Swipe left to delete',
                      style: TextStyle(
                          color: AppColors.hintGrayColor, fontSize: 14),
                      textAlign: TextAlign.left),
                ),
              ],
            );
          } else {
            return noEmpRecodFoundView(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (_) => AddEmployee()));
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Center noEmpRecodFoundView(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/image/img.png",
        height: DeviceUtils.getDeviceHeight(context) / 1.5,
        width: DeviceUtils.getDeviceWidth(context) / 1.5,
      ),
    );
  }
}
