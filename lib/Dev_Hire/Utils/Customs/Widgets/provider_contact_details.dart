import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/bloc/provider_info_bloc/provider_info_bloc.dart';
import 'package:reentry_roadmap/bloc/provider_info_bloc/provider_info_event.dart';
import 'package:reentry_roadmap/bloc/provider_info_bloc/provider_info_state.dart';

import '../../../../core/utils/pref_utils.dart';
import '../TextField/custom_textfield.dart';

class ProviderContactDetails extends StatefulWidget {
  const ProviderContactDetails({super.key});
  static const path = '/ProviderContactDetails';

  @override
  _ProviderContactDetailsState createState() => _ProviderContactDetailsState();
}

class _ProviderContactDetailsState extends State<ProviderContactDetails> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alternatePhoneController =
      TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  bool isEditMode = false;

  void saveContactDetails() async {
    final email = emailController.text;

    // Check if email already exists
    final emailQuery = await FirebaseFirestore.instance
        .collection('ProviderContactDetails')
        .where('email', isEqualTo: email)
        .get();

    if (emailQuery.docs.isNotEmpty) {
      Fluttertoast.showToast(
        msg: "This email is already in use. Please use a different email.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      phoneController.clear();
      emailController.clear();
      alternatePhoneController.clear();
      log("Attempt to use an existing email: $email");
      return; // Stop further execution if email exists
    }

    // Proceed to save contact details if email does not exist
    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection('ProviderContactDetails')
        .doc(uniqueId)
        .set({
      'id': uniqueId,
      'phone': phoneController.text,
      'email': email,
      'alternatePhone': alternatePhoneController.text,
      'contactName': contactNameController.text,
    });
    PrefUtil.setString(PrefUtil.userId, uniqueId);

    Fluttertoast.showToast(
      msg: "Contact details saved successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    log("Contact details saved with ID: $uniqueId");
  }

  @override
  Widget build(BuildContext context) {
    String? userId = PrefUtil.getString(PrefUtil.userId);
    log("User Id is $userId");

    return Center(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ProviderContactDetails')
            .doc(userId.isNotEmpty ? userId : "Not")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return BlocBuilder<ProviderInfoBloc, ProviderInfoState>(
            builder: (context, state) {
              bool isDocumentAvailable =
                  snapshot.hasData && snapshot.data!.exists;
              log("Is document available $isDocumentAvailable and isContact edit mode ${state.isContactEditMode}");

              if (isDocumentAvailable && !state.isContactEditMode) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                log("Data is $data");
                phoneController.text = data['phone'] ?? '';
                emailController.text = data['email'] ?? '';
                alternatePhoneController.text = data['alternatePhone'] ?? '';
                contactNameController.text = data['contactName'] ?? '';
              }
              return Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffBFD4D9),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          width: MediaQuery.of(context).size.width,
                          height: 101,
                          decoration: const BoxDecoration(
                            color: Color(0xff11404C),
                          ),
                          child: Row(
                            children: [
                              Text('Contact Details',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20,
                                  )),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (state.isContactEditMode) {
                                    saveContactDetails();
                                  }
                                  context
                                      .read<ProviderInfoBloc>()
                                      .add(ToggleContactEditMode());
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit,
                                        color: Colors.white, size: 20),
                                    const Gap(4),
                                    Text(
                                      state.isContactEditMode ? 'Save' : 'Edit',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildContactForm(isDocumentAvailable, state),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContactForm(bool isDocumentAvailable, ProviderInfoState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phone Number',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color(0xff151517),
                fontSize: 20,
              )),
          CustomTextField(
            hint: '510 123 4567',
            controller: phoneController,
            enabled: state.isContactEditMode || !isDocumentAvailable,
          ),
          const Gap(12),
          Text('Email Address',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color(0xff151517),
                fontSize: 20,
              )),
          CustomTextField(
            readOnly: emailController.text != "" ? true : false,
            hint: 'chris@opengate.org',
            controller: emailController,
            enabled: state.isContactEditMode || !isDocumentAvailable,
          ),
          const Gap(12),
          Text('Alternate Phone Number',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color(0xff151517),
                fontSize: 20,
              )),
          CustomTextField(
            hint: '111-222-3456',
            controller: alternatePhoneController,
            enabled: state.isContactEditMode || !isDocumentAvailable,
          ),
          const Gap(12),
          Text('Contact Person’s Name',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color(0xff151517),
                fontSize: 20,
              )),
          CustomTextField(
            hint: 'Chris Brown',
            controller: contactNameController,
            enabled: state.isContactEditMode || !isDocumentAvailable,
          ),
        ],
      ),
    );
  }
}
