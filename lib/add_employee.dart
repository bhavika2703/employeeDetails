// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovations_assignment2/constants/colors.dart';
import 'package:realtime_innovations_assignment2/emp_model.dart';
import 'package:realtime_innovations_assignment2/firestore_database.dart';
import 'package:realtime_innovations_assignment2/utils/calendar_widget.dart';
import 'package:realtime_innovations_assignment2/utils/device.dart';
import 'package:uuid/uuid.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({Key? key, this.empData, this.isUpdatedView = false})
      : super(key: key);
  bool isUpdatedView;
  final EmpModel? empData;

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _selectedRoleController = TextEditingController();
  List<String> selectedBottomSheetList = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  DateTime? selectedDate;
  DateTime? noDateSelected;
  bool noDate = true;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdatedView) {
      _nameController.text = widget.empData!.empName;
      _selectedRoleController.text = widget.empData!.empRole;
      selectedDate = widget.empData!.startDate;
      noDateSelected = widget.empData!.endDate;
      noDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        automaticallyImplyLeading: false,
        title: const Text('Add Employee Details',
            style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          nameFormFiledView(),
          roleFormFiledView(context),
          calenderDateSelectionView(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
              color: AppColors.lightGrayColor,
              width: 1,
            )),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColorTransparent,
                  elevation: 0,
                  shadowColor: Colors.transparent.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // <-- Radius
                  ),
                ),
                child: const Text('Cancel',
                    style: TextStyle(color: AppColors.themeColor)),
              ),
              const SizedBox(
                width: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isNotEmpty &&
                        _selectedRoleController.text.isNotEmpty &&
                        selectedDate != null &&
                        noDateSelected != null) {
                      if (widget.isUpdatedView && widget.empData != null) {
                        final data = EmpModel(
                            widget.empData!.empId,
                            _nameController.text,
                            _selectedRoleController.text,
                            selectedDate!,
                            noDateSelected!);
                        await FireStoreServices().updateEmpData(
                            id: widget.empData!.empId, empData: data);
                      } else {
                        final data = EmpModel(
                            empUniqueId(),
                            _nameController.text,
                            _selectedRoleController.text,
                            selectedDate!,
                            noDateSelected!);
                        await FireStoreServices().addEmpData(data, context);
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } else {
                      const SnackBar(
                          content: Text('Please fill All Details'),
                          backgroundColor: Colors.grey);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    elevation: 0,
                    shadowColor: Colors.transparent.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // <-- Radius
                    ),
                  ),
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String empUniqueId() => const Uuid().v4();

  Widget nameFormFiledView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: TextFormField(
        controller: _nameController,
        autofillHints: const [AutofillHints.name],
        cursorColor: Colors.black,
        decoration: inputDecoration(
          hintText: 'Employee name',
          leadingIcon: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.themeColor,
          ),
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please enter Employee name';
          } else if (value.length <= 2) {
            return 'Your name must be at least 2 characters long';
          }
          return null;
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget roleFormFiledView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _modalBottomSheetMenu(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: TextFormField(
          onTap: () {
            _modalBottomSheetMenu(context);
          },
          controller: _selectedRoleController,
          readOnly: true,
          decoration: inputDecoration(
            hintText: 'Select role',
            leadingIcon: Image.asset(
              "assets/image/bag_icon.png",
              color: AppColors.themeColor,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  _modalBottomSheetMenu(context);
                },
                icon: const Icon(Icons.arrow_drop_down_rounded,
                    color: AppColors.themeColor, size: 33)),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please enter Employee name';
            } else if (value.length <= 2) {
              return 'Your name must be at least 2 characters long';
            }
            return null;
          },
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(
      {required String hintText,
      required Widget leadingIcon,
      Widget? suffixIcon}) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintGrayColor),
        prefixIcon:
            Padding(padding: const EdgeInsets.all(0.0), child: leadingIcon),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.only(left: 6),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrayColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGrayColor,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGrayColor,
          ),
        ),
        disabledBorder: const OutlineInputBorder());
  }

  calenderDateSelectionView() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12, right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          todayCalenderContainer(
            calenderText: Text(
                selectedDate != null
                    ? DateFormat('dd MMM yy').format(selectedDate!).toString()
                    : 'Today',
                style: const TextStyle()),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Image.asset(
              "assets/image/arrow_icon.png",
              color: AppColors.themeColor,
              height: 26,
            ),
          ),
          noDataContainerView(
            calenderText: Text(
                noDate == false && noDateSelected != null
                    ? DateFormat('dd MMM yy').format(noDateSelected!).toString()
                    : 'No date',
                style: TextStyle(
                    color: noDateSelected != null
                        ? Colors.black
                        : AppColors.lightGrayColor)),
          ),
        ],
      ),
    );
  }

  Widget todayCalenderContainer({required Widget calenderText}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  insetPadding: const EdgeInsets.only(right: 10, left: 10),
                  surfaceTintColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  content: SizedBox(
                    height: DeviceUtils.getDeviceHeight(context) / 1.8,
                    width: DeviceUtils.getDeviceWidth(context),
                    child: CalendarWidget(
                      onDaySelected: (DateTime pickedDate) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        });

                        return selectedDate;
                      },
                      noDateDaySelected: (bool dateTime) {},
                    ),
                  ),
                ));
      },
      child: Container(
          alignment: Alignment.center,
          height: 45,
          width: DeviceUtils.getDeviceWidth(context) / 2.4,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrayColor),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: Image.asset(
                  "assets/image/calender_today_icon.png",
                  color: AppColors.themeColor,
                  height: 26,
                ),
              ),
              calenderText,
            ],
          )),
    );
  }

  ElevatedButton elevatedButtonView(
      {required String text,
      required VoidCallback onButtonTap,
      Color? bgColor,
      Color? textColor}) {
    return ElevatedButton(
      onPressed: onButtonTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.themeColorTransparent,
        elevation: 0,
        shadowColor: Colors.transparent.withOpacity(0.1),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // <-- Radius
        ),
      ),
      child: Text(text,
          style: TextStyle(color: textColor ?? AppColors.themeColor)),
    );
  }

  Widget noDataContainerView({required Widget calenderText}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  insetPadding: const EdgeInsets.only(right: 10, left: 10),
                  surfaceTintColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  content: SizedBox(
                    height: DeviceUtils.getDeviceHeight(context) / 1.8,
                    width: DeviceUtils.getDeviceWidth(context),
                    child: CalendarWidget(
                      onDaySelected: (DateTime pickedDate) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            noDateSelected = pickedDate;
                          });
                        });
                      },
                      noDateDaySelected: (bool noDateValue) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            noDate = noDateValue;
                          });
                        });
                        return noDate;
                      },
                      noDaySelectedView: true,
                    ),
                  ),
                ));
      },
      child: Container(
          alignment: Alignment.center,
          height: 45,
          width: DeviceUtils.getDeviceWidth(context) / 2.4,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrayColor),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: Image.asset(
                  "assets/image/calender_today_icon.png",
                  color: AppColors.themeColor,
                  height: 26,
                ),
              ),
              calenderText,
            ],
          )),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            width: double.infinity,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14.0),
                        topRight: Radius.circular(14.0))),
                child: Container(
                    //margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListView.builder(
                      itemCount: selectedBottomSheetList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selectedBottomSheetList[index],
                              ),
                              divider(),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _selectedRoleController.text =
                                  selectedBottomSheetList[index];
                            });
                          },
                        );
                      },
                    ))),
          );
        });
  }

  Divider divider() =>
      Divider(thickness: 0.5, color: AppColors.lightGrayColor.withOpacity(0.5));

  TextStyle getTodayTextStyle() => const TextStyle(color: AppColors.themeColor);
}

TextStyle getTodayTextStyle() => const TextStyle(color: AppColors.themeColor);
