import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_option_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../widgets/custom_switch_button.dart';

class ProviderContactForm extends StatefulWidget {
  final VoidCallback?  onSendMessage;
  const ProviderContactForm({super.key,this.onSendMessage});

  @override
  State<ProviderContactForm> createState() => _ProviderContactFormState();
}

class _ProviderContactFormState extends State<ProviderContactForm> {
  List<String> programs = [
    "General Services",
    "Supernova program",
    "Management Program",
  ];
  List<String> selectedProgram =[];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(
                height: 10,
              ),
              _label("Select Select the programs you are interested in"),
              ListView.builder(
                itemCount: programs.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CustomOptionTile(
                    title: programs[index],
                    isSelected: selectedProgram.contains(programs[index]),
                    onTap: () {
                      setState(() {
                        selectedProgram.contains(programs[index])?
                        selectedProgram.remove(programs[index]):
                        selectedProgram.add(programs[index]);
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              _label(
                  "Write a message to OpenGate Hayward expressing why you are interested in their program (Optional)"),
              CustomTextField(
                isDetail: true,
              ),
              _label(
                  "Would you like to share your profile with OpenGate Hayward?"),
              const CustomSwitchButton(),
              const SizedBox(height: 100,),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: CustomButton(
              text: "Send Message",
              onTap:widget.onSendMessage,
            ))
      ],
    );
  }

  Widget _label(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style:
            context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact OpenGate Hayward",
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const ProviderDetailButton(
                    title: "Eligible!",
                    icon: Icons.check_circle_outline,
                    isPrimary: true,
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)),
          ],
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
