import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:formz/formz.dart';

class MagicBallPainter extends CustomPainter {
  const MagicBallPainter({required this.status});

  final FormzSubmissionStatus status;

  @override
  void paint(Canvas canvas, Size size) {
    final bool tight = size.height > size.width;

    final Color color;

    switch (status) {
      case FormzSubmissionStatus.initial:
        color = const Color(0xff0d0a23);
        break;
      case FormzSubmissionStatus.failure:
        color = const Color(0xffe71515);
        break;
      default:
        color = Colors.black;
    }

    canvas.drawCircle(
      Offset(size.width / 2, (tight ? size.width : size.height) / 2),
      (tight ? size.width : size.height) / 2,
      Paint()..color = const Color(0xff17b0b7),
    );

    RadialGradient gradient = RadialGradient(
      center: const Alignment(0.01, 0),
      radius: 0.5,
      colors: [
        color,
        const Color(0xff16439b),
      ],
      stops: const [0.85, 1],
    );

    canvas.drawCircle(
      Offset(size.width / 2 + 3, (tight ? size.width : size.height) / 2),
      (tight ? size.width : size.height) / 2 - 5,
      Paint()
        ..shader = gradient.createShader(Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width, size.height),
        )),
    );

    for (int i = 0; i < 100; i++) {
      final double rr = (i < 60 ? 0.6 : 0.9) * math.sqrt(sid[i % sid.length]);
      final double theta = sid[(i + 5) % sid.length] * 2 * math.pi;
      final double positionX = size.width / 2 +
          (tight ? size.width : size.height) / 2 * rr * math.cos(theta);
      final double positionY = (tight ? size.width : size.height) / 2 +
          (tight ? size.width : size.height) / 2 * rr * math.sin(theta);
      final double width = 1 + sid[(i + 3) % sid.length] * 2;
      final double height = 1 + sid[(i + 2) % sid.length] * 2;
      final double radians = sid[(i + 1) % sid.length];
      final Color color =
          Color((sid[i % sid.length] * 0xFFFFFF).toInt()).withOpacity(1.0);

      canvas.save();
      canvas.translate(positionX, positionY);
      canvas.rotate(radians);

      final BorderRadius borderRadius = BorderRadius.circular(1.5);
      final Rect rect = Rect.fromCenter(
        center: Offset.zero,
        width: width,
        height: height,
      );
      final RRect outer = borderRadius.toRRect(rect);
      canvas.drawRRect(
        outer,
        Paint()..color = color,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant MagicBallPainter oldDelegate) =>
      oldDelegate.status != status;
}

const List<double> sid = [
  0.00223696557909109,
  0.504600342598092,
  0.109415297913093,
  0.728218722496284,
  0.461720396979582,
  0.383367913953666,
  0.923148883470869,
  0.117638140040281,
  0.361207928211059,
  0.50871312129717,
  0.968951309550997,
  0.317764743379208,
  0.901505124709339,
  0.635206814685467,
  0.211271901247684,
  0.112058588355807,
  0.430312695647736,
  0.997906114439436,
  0.639523269906418,
  0.248548659611749,
  0.0485455841052093,
  0.532327817535181,
  0.232161029350088,
  0.493472166123554,
  0.153811990355054,
  0.373152465733305,
  0.317605898863452,
  0.388722202921623,
  0.139610812598658,
  0.621670544902641,
  0.967329978461997,
  0.898301644669055,
  0.000813486520579777,
  0.622046277216657,
  0.437152946105764,
  0.0182535327124659,
  0.899859009263971,
  0.206760439186711,
  0.393806048852301,
  0.21541082077446,
  0.397644546068108,
  0.62380239722496,
  0.598022941778425,
  0.420766580114498,
  0.0810986436349799,
  0.278083359952124,
  0.642972064969582,
  0.394970429313821,
  0.0193629106596871,
  0.65121104831398,
  0.860605276124834,
  0.578094632634006,
  0.183528763327528,
  0.935732376266146,
  0.816590890668608,
  0.469909148043911,
  0.272439313248004,
  0.615943131789539,
  0.57440673214123,
  0.0885679312462769,
  0.0657620150902132,
  0.534426680549247,
  0.978027327441623,
  0.739537383308419,
  0.541383142835173,
  0.0706496648819417,
  0.316951256858628,
  0.279458847492681,
  0.198053868579703,
  0.193018368535218,
  0.212199579091836,
  0.223552256461024,
  0.604100065587135,
  0.424112449131958,
  0.850904113543641,
  0.424743186880249,
  0.934304875756756,
  0.811394449235589,
  0.412373522488574,
  0.87572863040293,
  0.730180400763722,
  0.922635469549631,
  0.369359292261935,
  0.488399764284678,
  0.761065268777807,
  0.389235345827991,
  0.714772881341527,
  0.0650811102544335,
  0.805455386548049,
  0.967243798061853,
  0.745814219464461,
  0.283915877474433,
  0.632353707045481,
  0.305238117606024,
  0.149648805684246,
  0.863217865518861,
  0.645775069783337,
  0.858485558470006,
  0.879383437279325,
  0.0104489787530382,
];
