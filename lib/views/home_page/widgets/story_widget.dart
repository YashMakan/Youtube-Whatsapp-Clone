import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/models/size_config.dart';

class StoryWidget extends StatelessWidget {
  final double size;
  final String imageUrl;
  final String text;
  final bool showGreenStrip;

  const StoryWidget({
    Key? key,
    required this.size,
    required this.imageUrl,
    required this.text,
    this.showGreenStrip = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: showGreenStrip
                  ? null
                  : DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
              border: showGreenStrip
                  ? Border.all(color: greenColor, width: 2)
                  : null,
            ),
            child: showGreenStrip
                ? Padding(
                    padding: EdgeInsets.all(showGreenStrip ? 2.2 : 0),
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: size,
            child: Center(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: grayColor(SizeConfig.cntxt).lightShade,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
