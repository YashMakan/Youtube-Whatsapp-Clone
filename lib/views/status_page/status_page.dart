import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final controller = StoryController();
  late List<StoryItem> storyItems;

  @override
  void initState() {
    storyItems = [
      StoryItem.pageImage(
          url:
              "https://images.unsplash.com/photo-1588938172737-f774f5476d2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
          controller: controller),
      StoryItem.pageImage(
          url:
              "https://images.unsplash.com/photo-1588938172737-f774f5476d2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
          controller: controller),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
        storyItems: storyItems,
        controller: controller,
        // pass controller here too
        repeat: false,
        // should the stories be slid forever
        onStoryShow: (s) {},
        onComplete: () {
          Navigator.pop(context);
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        } // To disable vertical swipe gestures, ignore this parameter.
        // Preferrably for inline story view.
        );
  }
}
