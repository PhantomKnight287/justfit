import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubTitle extends StatelessWidget {
  final int? breakDuration;
  final int? reps;
  const SubTitle({super.key, this.breakDuration, this.reps});

  @override
  Widget build(BuildContext context) {
    if (breakDuration == null)
      return Text(
        "$reps Reps",
        style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w500),
      );
    if (reps == null)
      return Text(
        "${breakDuration}s Break",
        style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w500),
      );
    return Text(
      "$reps Reps • ${breakDuration}s Break",
      style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}
