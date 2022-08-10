import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/helper/size_config.dart';

class LocationMessage extends StatefulWidget {
  final LatLng latLng;
  final bool fromFriend;

  const LocationMessage(
      {Key? key, required this.latLng, required this.fromFriend})
      : super(key: key);

  @override
  State<LocationMessage> createState() => _LocationMessageState();
}

class _LocationMessageState extends State<LocationMessage> {
  late bool fromFriend;
  late LatLng latLng;

  @override
  void initState() {
    fromFriend = widget.fromFriend;
    latLng = widget.latLng;
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
                                  size: const Size.fromRadius(50),
                                  child: Image.network(
                                      "https://imgur.com/9nK254v.jpg", fit: BoxFit.fill),
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
                                  "${latLng.latitude.toStringAsFixed(6)}, ${latLng.longitude.toStringAsFixed(6)}",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: fromFriend
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                FutureBuilder(
                                  future: getLocationName(latLng),
                                  builder:
                                      (context, AsyncSnapshot<String> data) {
                                    if(data.hasData){
                                      return Text(
                                        data.data!,
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: fromFriend
                                                ? Colors.white
                                                : Colors.black),
                                      );
                                    }else{
                                      return const SizedBox();
                                    }
                                  },
                                )
                              ],
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
  Future<String> getLocationName(LatLng _latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(_latLng.latitude, _latLng.longitude);
    return "${placemarks.first.locality}, ${placemarks.first.country}";
  }
}
