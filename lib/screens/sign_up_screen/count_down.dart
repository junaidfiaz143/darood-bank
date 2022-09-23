import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../models/otp_callback_model.dart';
import '../../utils/colors.dart';

class CountDownTimer extends StatefulWidget {
  final Function(String) onCountDownComplete;
  final bool goHomeScreen;
  final bool online;

  const CountDownTimer({
    required this.onCountDownComplete,
    required this.goHomeScreen,
    required this.online,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CountDownTimerState();
  }
}

class CountDownTimerState extends State<CountDownTimer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  final int _minutes = 1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(minutes: _minutes));
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Center(
        child: Countdown(
          goHomeScreen: widget.goHomeScreen,
          online: widget.online,
          onCountDownComplete: widget.onCountDownComplete,
          animation: StepTween(
            begin: _minutes * 60,
            end: 0,
          ).animate(_controller!),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class Countdown extends AnimatedWidget {
  Countdown(
      {Key? key,
      this.animation,
      required this.onCountDownComplete,
      required this.goHomeScreen,
      required this.online})
      : super(key: key, listenable: animation!);

  final Function(String) onCountDownComplete;
  final Animation<int>? animation;
  final bool goHomeScreen;
  final bool online;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    if (clockTimer.inMinutes == 0 && clockTimer.inSeconds == 0) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<OTPCallback>(context, listen: false).setOTPDone(true);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (_) => LoginScreen()));

        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
        // Navigator.of(screenContext).pop();
        // Navigator. .../
      });
      // onCountDownComplete("timer done");
      // SchedulerBinding.instance!.addPostFrameCallback((_) {
      //   if (goHomeScreen == true) {
      //     if (online == true)
      //       Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(builder: (_) => HomeScreen()),
      //           (route) => false);
      //     else
      //       Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(builder: (_) => OnlineOfflineScreen()),
      //           (route) => false);
      //   } else
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (_) => LoginScreen()),
      //         (route) => false);
      // });
    }

    return Text(
      timerText,
      style: const TextStyle(
          color: Color(MyColors.primaryColor), fontWeight: FontWeight.bold),
    );
  }
}
