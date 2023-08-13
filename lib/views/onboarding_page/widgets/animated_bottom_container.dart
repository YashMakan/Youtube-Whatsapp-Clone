import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/models/onboarding_page.dart';
import 'package:whatsapp_redesign/models/size_config.dart';
import 'package:whatsapp_redesign/widgets/gradient_icon_button.dart';

class AnimatedBottomContainer extends StatefulWidget {
  final bool showForm;
  final bool onOTPage;
  final OnBoardingPageModel page;
  final int selectedPageIndex;
  final Function() onLeftArrowClicked;
  final Function() onRightArrowClicked;
  final Function() onLeftArrowReset;
  final Function(String) onSendOtpClicked;
  final Function(String, String) onOtpSubmit;

  const AnimatedBottomContainer(
      {super.key,
      required this.showForm,
      required this.onOTPage,
      required this.page,
      required this.selectedPageIndex,
      required this.onLeftArrowClicked,
      required this.onRightArrowClicked,
      required this.onLeftArrowReset,
      required this.onSendOtpClicked,
      required this.onOtpSubmit});

  @override
  State<AnimatedBottomContainer> createState() =>
      _AnimatedBottomContainerState();
}

class _AnimatedBottomContainerState extends State<AnimatedBottomContainer> {
  final phoneNumberController = TextEditingController();
  late List<TextEditingController> otpControllers;

  @override
  void initState() {
    otpControllers = List.generate(6, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.8),
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 800),
        width: SizeConfig.screenWidth * 0.9,
        height: widget.showForm
            ? SizeConfig.screenHeight * 0.42
            : SizeConfig.screenHeight * 0.33,
        child: Card(
          elevation: 3,
          shadowColor: blackColor(context).lightShade.withOpacity(0.3),
          color: backgroundColor(context),
          child: !widget.showForm
              ? Column(
                  children: [
                    const SizedBox(
                      height: 26,
                    ),
                    Text(
                      widget.page.heading,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blackColor(context).darkShade,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 14),
                      child: Text(
                        widget.page.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: blackColor(context).lightShade),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.onLeftArrowClicked();
                            },
                            child: GradientIconButton(
                                size: 40,
                                iconData: LineIcons.arrowLeft,
                                isEnabled: widget.selectedPageIndex != 0),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.onRightArrowClicked();
                            },
                            child: const GradientIconButton(
                                size: 40, iconData: LineIcons.arrowRight),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : !widget.onOTPage
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        widget.onLeftArrowReset();
                                      },
                                      icon: Icon(
                                        LineIcons.arrowLeft,
                                        color: blackColor(context).darkShade,
                                      )),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Login Account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: blackColor(context).darkShade,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "Hello, let's setup everything.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: blackColor(context).lightShade,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 16.0,
                                      backgroundImage: NetworkImage(
                                          "https://media.istockphoto.com/vectors/flag-of-india-vector-id472317739?k=20&m=472317739&s=612x612&w=0&h=EyWmhj952ZyJEgDStLz3fd0WZjqYIpSvnK3OpPfJ4eA="),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: blackColor(context).darkShade,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                border: Border.all(
                                    color: blackColor(context).lightShade,
                                    width: 1.5)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const CircleAvatar(
                                          radius: 14.0,
                                          backgroundImage: NetworkImage(
                                              "https://media.istockphoto.com/vectors/flag-of-india-vector-id472317739?k=20&m=472317739&s=612x612&w=0&h=EyWmhj952ZyJEgDStLz3fd0WZjqYIpSvnK3OpPfJ4eA="),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: blackColor(context).lightShade,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 8),
                                  child: Container(
                                    width: 1.5,
                                    height: 46,
                                    color: blackColor(context).lightShade,
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    controller: phoneNumberController,
                                    style: TextStyle(
                                        color: blackColor(context).darkShade),
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        hintStyle: TextStyle(
                                            color:
                                                blackColor(context).lightShade),
                                        hintText: "phone number"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                gradient: LinearGradient(colors: [
                                  greenGradient.darkShade,
                                  greenGradient.lightShade,
                                ])),
                            child: ElevatedButton(
                              onPressed: () {
                                if (phoneNumberController.text.trim().length ==
                                    10) {
                                  widget.onSendOtpClicked(
                                      phoneNumberController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: Container(
                                height: 45.0,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: const Text(
                                  "REQUEST OTP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        widget.onLeftArrowReset();
                                      },
                                      icon: Icon(
                                        LineIcons.arrowLeft,
                                        color: blackColor(context).darkShade,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Verification Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackColor(context).darkShade,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "We have sent the code verification to\nYour Mobile Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackColor(context).lightShade,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "+91 ${phoneNumberController.text}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: blackColor(context).lightShade,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const GradientIconButton(
                                        size: 30,
                                        iconData: Icons.edit_outlined,
                                        iconSize: 15)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        otpControllers.length,
                                        (index) => Container(
                                              width: 35,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: !context.isDarkMode()
                                                      ? const Color(0xFFF8F7FB)
                                                      : Colors.white12),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(1)
                                                ],
                                                onChanged: (value){
                                                  if(value.isNotEmpty) {
                                                    FocusScope.of(context).nextFocus();
                                                  } else {
                                                    FocusScope.of(context).previousFocus();
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: blackColor(context)
                                                        .darkShade),
                                                autofocus: true,
                                                controller:
                                                    otpControllers[index],
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                              ),
                                            )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                gradient: LinearGradient(colors: [
                                  greenGradient.darkShade,
                                  greenGradient.lightShade,
                                ])),
                            child: ElevatedButton(
                              onPressed: () {
                                String otp = otpControllers
                                    .map((e) => e.text)
                                    .toList()
                                    .join();
                                widget.onOtpSubmit(phoneNumberController.text, otp);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: Container(
                                height: 45.0,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
