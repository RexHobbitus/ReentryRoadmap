import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';

class ExploreFooterSection extends StatelessWidget {
  const ExploreFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      color: context.themeData.cardColor,
      child: Column(
        children: [
          _companyProfileSection(context: context),
          const SizedBox(height: 20,),
          Text(_aboutUs,style: context.textTheme.bodyLarge?.copyWith(
          ),),
          _disclaimerWidget(context: context),
          const SizedBox(height: 30,),
          _ceoInformation(context: context),
        ],
      ),
    );
  }

  _companyProfileSection({required BuildContext context}){
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: context.colorScheme.secondary,
          radius: 30,
          child: SvgPicture.asset(Assets.openGate,height: 25,),
        ),
        const SizedBox(width: 10,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Our Rating"),
                const SizedBox(width: 5,),
                Icon(Icons.star,size: 15,color: context.colorScheme.secondary,),
                const SizedBox(width: 5,),
                Text("4.2",style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onTertiary
                ),),
              ],
            ),
            Text("OpenGate Oakland",style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            Text("View OpenGate Oakland >",style: context.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
              color: context.colorScheme.primary
            ),),
          ],
        )
      ],
    );
  }
  
  Widget _disclaimerWidget({required BuildContext context}){
    return Container(
      width: context.sw,
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      decoration: BoxDecoration(
        color: context.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(_disclaimerText,style: context.textTheme.bodySmall?.copyWith(
        color: context.colorScheme.onTertiaryContainer,
        fontWeight: FontWeight.w500
      ),),
    );
  }

  Widget _ceoInformation({required BuildContext context}){
    return Row(
      children: [

        const CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider("https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"),
        ),
        const SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Danny Yoon",style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            Text("CEO of Dignifi",style: context.textTheme.bodyMedium?.copyWith(

            ),),
          ],
        )
      ],
    );
  }


  final String _aboutUs='''It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader.
  ''';

  final String _disclaimerText='''Disclaimer: This is our opinions, meant to help you make a decision and not a factual disclaimer of the company. Our team has attempted to make it as accurate as possible at the time of publishing
  ''';
}
