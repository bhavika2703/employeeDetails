import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'emp_model.dart';

class FireStoreServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String?> addEmpData(
      EmpModel empData, BuildContext context) async {
    try {
      await _firestore
          .collection("emp")
          .doc(empData.empId)
          .set(empData.toJson(), SetOptions(merge: true));
    } on Exception catch (e) {
      log('Exception $e');
    }
    return empData.empId;
  }


   Future<List<EmpModel>?> getEmpData()  async {
    try {
      final QuerySnapshot<Map<String, dynamic>> doc = (await _firestore
          .collection('emp')
          .get());

      if (doc.docs.isNotEmpty) {
        final List<EmpModel> empModel = doc.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
            EmpModel.fromJson(e.data()))
            .toList();
        return empModel;
      } else {
        throw "Something went wrong ";
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<EmpModel>> listenEmpData() {
    final Query<Map<String, dynamic>> query =
    FirebaseFirestore.instance.collection('emp');
    return query.snapshots().map(
          (QuerySnapshot<Map<String, dynamic>> event) {
        return event.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
            EmpModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      },
    );
  }


  Future<void> removeEmpData(String empID, BuildContext context) async {
    _firestore.collection('emp').doc(empID).delete();
  }

  Future<void> updateEmpData({
    String? id,
    EmpModel? empData,
  }) async {
    try {
      _firestore.collection('emp').doc(id).update(empData!.toJson());
    } catch (e) {
      print(e);
    }
  }
}