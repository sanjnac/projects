// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../model/employee.dart';
import '../services/api_service.dart';

class EmployeeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Employee> _employees = [];

  List<Employee> get employees => _employees;

  Future<void> fetchEmployees() async {
    try {
      final data = await _apiService.getEmployees();
      _employees = data.map((e) => Employee.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  Future<void> addEmployee(Map<String, dynamic> employee) async {
    try {
      await _apiService.addEmployee(employee);
      await fetchEmployees(); // Refresh the list after adding a new employee
    } catch (e) {
      print('Error adding employee: $e');
    }
  }
}
