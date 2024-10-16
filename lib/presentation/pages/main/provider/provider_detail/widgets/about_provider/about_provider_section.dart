import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

import '../provider_detail_title.dart';
import 'about_provider_all_programs.dart';
import 'about_provider_general_services.dart';

class AboutProviderSection extends StatelessWidget {
  const AboutProviderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderDetailTitle(
          title: "About OpenGate Foundation",
        ),
        Text(
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum.",
          style: AppStyle.providerDetailBody(context),
        ),
        const SizedBox(height: 50,),
        const AboutProviderGeneralServices(),
         AboutProviderAllPrograms(),

      ],
    );
  }
}
