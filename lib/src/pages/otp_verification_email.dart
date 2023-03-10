import 'package:flutter/material.dart';
import 'package:edeli/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:math' as math;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

// ignore: must_be_immutable
class OtpVerificationEmail extends StatefulWidget {
  String email;
  String otp;
  UserController con;
  OtpVerificationEmail({
    Key key,
    this.email,
    this.otp,
    this.con,
  }) : super(key: key);

  @override
  _OtpVerificationEmailState createState() => _OtpVerificationEmailState();
}

class _OtpVerificationEmailState extends StateMVC<OtpVerificationEmail>
    with TickerProviderStateMixin {
  AnimationController controller1;
  String otpEntered;

  bool isPlaying = true;

  String get timerString {
    Duration duration = controller1.duration * controller1.value;
    String timer =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    if (timer == '0:00') {
      isPlaying = false;
    }
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 300),
    );

    controller1.reverse(
        from: controller1.value == 0.0 ? 1.0 : controller1.value);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: controller1,
                            builder: (BuildContext context, Widget child) {
                              return CustomPaint(
                                  painter: TimerPainter(
                                animation: controller1,
                                backgroundColor: Colors.white,
                                color: themeData.indicatorColor,
                              ));
                            },
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AnimatedBuilder(
                                  animation: controller1,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Text(
                                      timerString,
                                      style: themeData.textTheme.headline4,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text("OTP Verification",
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 10.0),
              Text("Enter the otp send to ${widget.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400])),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: OTPTextField(
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 40,
                            style: TextStyle(fontSize: 20),
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {
                              otpEntered = pin;
                              if (otpEntered == widget.otp) {}
                            },
                          ),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: isPlaying
                    ? Text('$isPlaying')
                    : GestureDetector(
                        onTap: () {
                          setState(() => isPlaying = true);
                          if (controller1.isAnimating) {
                            controller1.stop(canceled: true);
                          } else {
                            controller1.reverse(
                                from: controller1.value == 0.0
                                    ? 1.0
                                    : controller1.value);
                          }
                        },
                        child: Text("Don't Receive OTP? RESEND OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),

                // Icon(isPlaying
                // ? Icons.pause
                // : Icons.play_arrow);
              ),
              SizedBox(height: 43.0),
              // ignore: deprecated_member_use
              ElevatedButton(
                onPressed: () {
                  if (widget.otp == otpEntered) {
                    Navigator.of(context).pushReplacementNamed('/newPassword',
                        arguments: widget.email);
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFc8019), Color(0xFFFc8019)],
                        begin: Alignment(-2.0, -2.0),
                        end: Alignment(1.0, 1.0),
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("VERIFY",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor))),
                  ),
                ),
              ),
              SizedBox(height: 80.0),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
