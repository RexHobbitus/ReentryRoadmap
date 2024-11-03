import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomProfile extends StatelessWidget {
  const CustomProfile({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
        ),
        Gap(8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Opengate Oakland',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 30)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.verified_user,
                  color: Color(0xff396773),
                ),
                Text('Claimed',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff396773),
                        fontSize: 20)),
              ],
            )
          ],
        )
      ],
    );
  }
}