import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../TextField/custom_textfield.dart';
class ProviderContactDetails extends StatelessWidget {
  ProviderContactDetails({
    super.key,
  });
  TextEditingController controller = TextEditingController();
  static const path = '/ProviderContactDetails';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffBFD4D9)
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    width: MediaQuery.of(context).size.width,
                    height: 101,
                    decoration: BoxDecoration(
                      color: Color(0xff11404C),
                    ),
                    child:    Row(
                      children: [
                        Text('Contact Details', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20)),
                        Spacer(),
                        Icon(Icons.edit,color: Colors.white,size: 20,),
                        Gap(4),
                        Text('Edit', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone Number', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff151517),
                            fontSize: 20)),
                        CustomTextField(hint: '510 123 4567', controller: controller,),
                        Gap(12),
                        Text('Email Address', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff151517),
                            fontSize: 20)),
                        CustomTextField(hint: 'chris@opengate.org', controller: controller,),
                        Gap(12),
                        Text('Email Address', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff151517),
                            fontSize: 20)),
                        CustomTextField(hint: '111-222-3456', controller: controller,),
                        Gap(12),
                        Text('Contact Person’s Name', style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff151517),
                            fontSize: 20)),
                        CustomTextField(hint: 'Chris Brown', controller: controller,),
                      ],
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}