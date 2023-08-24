import 'package:upi_india/upi_app.dart';

class UpiPayment {
  final String receiverUpiId;
  final String receiverName;
  final String transactionRefId;
  final String transactionNote;
  String? transactionId;
  bool isTransactionSuccessful;
  final UpiApp upiApp;
  final double amount;

  UpiPayment(
      {required this.receiverUpiId,
      required this.receiverName,
      required this.transactionRefId,
      required this.transactionNote,
      this.transactionId,
      required this.isTransactionSuccessful,
      required this.upiApp,
      required this.amount});

  factory UpiPayment.fromJson(Map<String, dynamic> data) => UpiPayment(
      receiverUpiId: data['receiverUpiId'],
      receiverName: data['receiverName'],
      transactionRefId: data['transactionRefId'],
      transactionNote: data['transactionNote'],
      isTransactionSuccessful: data['isTransactionSuccessful'],
      upiApp: data['upiApp'],
      amount: data['amount']);

  Map<String, dynamic> toJson() => {
        'receiverUpiId': receiverUpiId,
        'receiverName': receiverName,
        'transactionRefId': transactionRefId,
        'transactionNote': transactionNote,
        'isTransactionSuccessful': isTransactionSuccessful,
        'upiApp': upiApp,
      };
}
