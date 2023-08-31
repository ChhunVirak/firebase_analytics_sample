import 'package:flutter/material.dart';

class TransferModel {
  final String scenario;
  final String description;

  final IconData iconData;
  const TransferModel({
    required this.scenario,
    required this.iconData,
    required this.description,
  });
}

const transferList = [
  TransferModel(
    scenario: 'Transfer to Own Account',
    iconData: Icons.account_circle,
    description: 'Transfer funds to your own account for savings.',
  ),
  TransferModel(
    scenario: 'Transfer to ATM',
    iconData: Icons.atm,
    description: 'Withdraw cash from an ATM.',
  ),
  TransferModel(
    scenario: 'Transfer to Bakong',
    iconData: Icons.monetization_on,
    description: 'Send money using Bakong digital payment system.',
  ),
  TransferModel(
    scenario: 'Transfer to Local Bank',
    iconData: Icons.location_city,
    description: 'Transfer funds to a local bank account.',
  ),
  TransferModel(
    scenario: 'Transfer to International Bank',
    iconData: Icons.public,
    description: 'Transfer money to an international bank account.',
  ),
  TransferModel(
    scenario: 'Transfer to Binance',
    iconData: Icons.shopping_cart,
    description: 'Transfer funds to your Binance cryptocurrency account.',
  ),
];
