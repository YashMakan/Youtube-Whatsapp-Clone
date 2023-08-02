import 'package:flutter/widgets.dart';

class CountDownDialer extends StatefulWidget {
  final double begin;
  final double end;
  final int precision;
  final Curve curve;
  final Duration duration;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final String prefix;
  final String suffix;

  const CountDownDialer({
    Key? key,
    this.begin = 0,
    this.end = 86400,
    this.precision = 0,
    this.curve = Curves.linear,
    this.duration = const Duration(seconds: 86400),
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.prefix = '',
    this.suffix = '',
  }) : super(key: key);

  @override
  _CountDownDialerState createState() => _CountDownDialerState();
}

class _CountDownDialerState extends State<CountDownDialer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double? _latestBegin;
  double? _latestEnd;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _latestBegin = widget.begin;
    _latestEnd = widget.end;
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: widget.curve);
    _animation = Tween<double>(begin: widget.begin, end: widget.end)
        .animate(curvedAnimation);

    if (widget.begin != _latestBegin || widget.end != _latestEnd) {
      _controller.reset();
    }

    _latestBegin = widget.begin;
    _latestEnd = widget.end;
    _controller.forward();

    return _CountDownDialerAnimatedText(
      key: UniqueKey(),
      animation: _animation,
      precision: widget.precision,
      style: widget.style,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      prefix: widget.prefix,
      suffix: widget.suffix,
    );
  }
}

class _CountDownDialerAnimatedText extends AnimatedWidget {
  final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  final Animation<double> animation;
  final int precision;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final String? prefix;
  final String? suffix;

  _CountDownDialerAnimatedText({
    Key? key,
    required this.animation,
    required this.precision,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.prefix,
    this.suffix,
  }) : super(key: key, listenable: animation);

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigits(duration.inHours) == "00") {
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  @override
  Widget build(BuildContext context) => Text(
        _printDuration(Duration(seconds: animation.value.toInt())),
        style: style,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      );
}
