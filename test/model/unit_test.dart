import 'package:realtime_innovations_assignment2/emp_model.dart';
import 'package:test/test.dart';


void main() {
  group('Testing App Provider', () {
    var favorites = EmpModel;

    test('A new item should be added', () {
      var number = 'Bhavika';
      favorites.toString();
      expect(EmpModel.fromJson(number as Map<String, dynamic>).empName, true);
    });
  });
}