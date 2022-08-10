import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/helper/size_config.dart';
import 'package:whatsapp_application/models/upi_payment.dart';

class PaymentMessage extends StatefulWidget {
  final UpiPayment payment;
  final bool fromFriend;

  const PaymentMessage(
      {Key? key, required this.payment, required this.fromFriend})
      : super(key: key);

  @override
  State<PaymentMessage> createState() => _PaymentMessageState();
}

class _PaymentMessageState extends State<PaymentMessage> {
  late bool fromFriend;
  late UpiPayment payment;

  @override
  void initState() {
    fromFriend = widget.fromFriend;
    payment = widget.payment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            fromFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.8,
            height: 90,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        width: (SizeConfig.screenWidth * 0.8) - 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40))),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 36,
                              height: 36,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(50),
                                  child: Image.memory(payment.upiApp.icon),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  payment.receiverUpiId,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: fromFriend
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  payment.transactionNote,
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: fromFriend
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "₹" + payment.amount.toStringAsFixed(2),
                              style: TextStyle(
                                  color: fromFriend
                                      ? Colors.white70
                                      : Colors.black87),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: fromFriend ? 0 : 10,
                      ),
                      const SizedBox(width: 16,),
                      if (payment.transactionId == null)
                        const Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.info_outlined,
                            color: Colors.redAccent,
                            size: 16,
                          ),
                        ),
                      Text(
                        payment.transactionId ?? "Failed Transaction",
                        style: TextStyle(
                            fontSize: 12,
                            color: payment.transactionId != null
                                ? fromFriend
                                    ? Colors.white70
                                    : Colors.black87
                                : Colors.redAccent),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(
                        "7:31 PM",
                        style: TextStyle(
                            fontSize: 12,
                            color:
                                fromFriend ? Colors.white70 : Colors.black87),
                      ),
                      SizedBox(
                        width: fromFriend ? 30 : 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(fromFriend ? 0 : 40),
                  topLeft: const Radius.circular(40),
                  topRight: const Radius.circular(40),
                  bottomRight: Radius.circular(fromFriend ? 40 : 0)),
              color: fromFriend ? const Color(0xFF313131) : null,
              gradient: fromFriend
                  ? null
                  : LinearGradient(colors: [
                      greenGradient.lightShade,
                      greenGradient.darkShade,
                    ]),
            ),
          ),
        ],
      ),
    );
  }
}
