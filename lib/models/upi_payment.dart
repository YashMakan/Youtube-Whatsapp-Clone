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
}
