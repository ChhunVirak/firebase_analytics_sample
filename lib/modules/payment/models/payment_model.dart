import 'package:flutter/material.dart' show IconData, Icons;

class PaymentModel {
  final String name;
  final String description;
  final IconData iconData;
  final double cost;
  PaymentModel({
    required this.name,
    required this.description,
    required this.iconData,
    required this.cost,
  });
}

final paymentData = [
  PaymentModel(
    name: 'Electric',
    description: 'Pay your electric bill online.',
    iconData: Icons.electrical_services,
    cost: 75.50,
  ),
  PaymentModel(
    name: 'Water Supply',
    description: 'Pay your water bill online.',
    iconData: Icons.water,
    cost: 30.25,
  ),
  PaymentModel(
    name: 'Internet',
    description: 'Pay your internet bill online.',
    iconData: Icons.wifi,
    cost: 50.00,
  ),
  PaymentModel(
    name: 'Gas',
    description: 'Pay your gas bill online.',
    iconData: Icons.local_fire_department,
    cost: 45.75,
  ),
  PaymentModel(
    name: 'Phone Bill',
    description: 'Pay your phone bill online.',
    iconData: Icons.phone,
    cost: 60.20,
  ),
  PaymentModel(
    name: 'Cable TV',
    description: 'Pay your cable TV bill online.',
    iconData: Icons.tv,
    cost: 35.80,
  ),
  PaymentModel(
    name: 'Rent',
    description: 'Pay your rent online.',
    iconData: Icons.home,
    cost: 1200.00,
  ),
  PaymentModel(
    name: 'Mortgage',
    description: 'Pay your mortgage online.',
    iconData: Icons.account_balance,
    cost: 1500.00,
  ),
  PaymentModel(
    name: 'Health Insurance',
    description: 'Pay your health insurance premium.',
    iconData: Icons.local_hospital,
    cost: 200.00,
  ),
  PaymentModel(
    name: 'Car Loan',
    description: 'Pay your car loan installment.',
    iconData: Icons.directions_car,
    cost: 250.00,
  ),
  PaymentModel(
    name: 'Property Tax',
    description: 'Pay your property tax online.',
    iconData: Icons.home_work,
    cost: 500.00,
  ),
  PaymentModel(
    name: 'Student Loan',
    description: 'Pay your student loan installment.',
    iconData: Icons.school,
    cost: 180.00,
  ),
];
