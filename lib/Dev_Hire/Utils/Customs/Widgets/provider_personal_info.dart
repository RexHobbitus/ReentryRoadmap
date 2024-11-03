import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../TextField/custom_textfield.dart';

class ProviderPersonalInfo extends StatelessWidget {
  ProviderPersonalInfo({
    super.key,
  });

  static const path = '/ProviderPersonalInfo';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffBFD4D9)),
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
                    child: Row(
                      children: [
                        Text('Personal Details',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20)),
                        Spacer(),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        Gap(4),
                        Text('Edit',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Personal Details',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff151517),
                                fontSize: 20)),
                        CustomTextField(
                          hint: 'John Doe',
                          controller: controller,
                        ),
                        Gap(12),
                        Text('Description of Provider Location',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff151517),
                                fontSize: 20)),
                        CustomTextField(
                          maxlines: 8,
                          hint:
                              'Hispanic or Latino In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Hispanic or Latino In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                          controller: controller,
                        ),
                        Gap(12),
                        Text('Relation to Reentry',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff151517),
                                fontSize: 20)),
                        CustomTextField(
                          hint: 'Reentry Adjacent',
                          controller: controller,
                        ),
                        Gap(12),
                        Text('Location',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff151517),
                                fontSize: 20)),
                        CustomTextField(
                          hasLable: true,
                          lableText: "Location",
                          hint: '1234, La jolla Village',
                          controller: controller,
                        ),
                        Gap(12),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hasLable: true,
                                lableText: "City",
                                hint: 'Hayward',
                                controller: controller,
                              ),
                            ),
                            Gap(12),
                            Expanded(
                              child: CustomTextField(
                                hasLable: true,
                                lableText: "Country",
                                hint: 'Alameda',
                                controller: controller,
                              ),
                            ),
                          ],
                        ),
                        Gap(12),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hasLable: true,
                                lableText: "State",
                                hint: 'California',
                                controller: controller,
                              ),
                            ),
                            Gap(12),
                            Expanded(
                              child: CustomTextField(
                                hasLable: true,
                                lableText: "ZipCode",
                                hint: '1234',
                                controller: controller,
                              ),
                            ),
                          ],
                        ),
                        Gap(12),
                        Text('Operating Hours',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff151517),
                                fontSize: 20)),
                        Gap(12),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child:
                                    CustamDayTimeRow(controller: controller)),
                            Gap(18),
                            Expanded(
                                flex: 1,
                                child:
                                    CustamDayTimeRow(controller: controller)),
                          ],
                        ),
                        Gap(12),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child:
                                    CustamDayTimeRow(controller: controller)),
                            Gap(18),
                            Expanded(
                                flex: 1,
                                child:
                                    CustamDayTimeRow(controller: controller)),
                          ],
                        ),
                        Gap(12),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child:
                                    CustamDayTimeRow(controller: controller)),
                            Gap(18),
                            Expanded(
                                flex: 1,
                                child:
                                    CustamDayTimeRow(controller: controller)),
                          ],
                        ),
                        Gap(12),
                        Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.468,
                                child:
                                    CustamDayTimeRow(controller: controller)),
                          ],
                        ),
                        Gap(22),
                        Text('Organization website',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff151517),
                                fontSize: 20)),
                        CustomTextField(
                          hint: 'www.Opengatehayward.org',
                          controller: controller,
                        ),
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

class CustamDayTimeRow extends StatefulWidget {
  const CustamDayTimeRow({
    super.key,
    required this.controller,
    this.day = 'Monday',
  });

  final String day;

  final TextEditingController controller;

  @override
  State<CustamDayTimeRow> createState() => _CustamDayTimeRowState();
}

class _CustamDayTimeRowState extends State<CustamDayTimeRow> {
  String? selectedValue;

  void onChanged(String? newValue) {
    setState(() {
      selectedValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 21),
          // Set a fixed width for the container
          height: 60,
          // Set a fixed height for the container
          decoration: BoxDecoration(
            color: Color(0xff97aaaa),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              widget.day,
              style: GoogleFonts.poppins(
                  color: Colors.black), // Text color for contrast
            ),
          ),
        ),
        Gap(12),
        Expanded(
          child: DropdownButton<String>(
            value: selectedValue,
            hint: Text('Select a value'),
            items: ["12", "13"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
            // Make the dropdown expand to full width
            underline: SizedBox(),
            // Remove the underline
            icon: Icon(Icons.arrow_drop_down),
          ),
        ),
        Gap(8),
        Text(
          'to',
          style: GoogleFonts.poppins(
              color: Colors.black), // Text color for contrast
        ),
        Gap(8),
        Expanded(
          child: CustomTextField(
            hint: '8 pm',
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}
