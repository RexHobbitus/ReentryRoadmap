import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';

class WebForProviderMenu extends StatelessWidget {
  const WebForProviderMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
     // height: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: context.themeData.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customListTile(context: context,title: "Add a Business",asset: Assets.addBusiness,onTap: (){}),
          _customListTile(context: context,title: "Claim your Business",asset: Assets.claimYourBusiness,onTap: (){}),
          _customListTile(context: context,title: "Login in to Business Account",asset: Assets.login,onTap: (){}),
          const Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(thickness: 2,height: 0,),
          ),
          _customListTile(context: context,title: "Explore Landmark for Business",asset: Assets.exploreLandmark,onTap: (){}),
        ],
      ),
    );
  }
  Widget _customListTile({required BuildContext context,required String asset,required String title,VoidCallback? onTap}){
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SvgPicture.asset(asset,width: 15,),
            const SizedBox(width: 20,),
            Text(title,style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
          ],
        ),
      ),
    );
  }
}
