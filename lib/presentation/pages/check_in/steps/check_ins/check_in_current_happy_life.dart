import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/widgets/check_in_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class CheckInCurrentHappyLife extends StatefulWidget {
  const CheckInCurrentHappyLife({super.key});

  @override
  State<CheckInCurrentHappyLife> createState() =>
      _CheckInCurrentHappyLifeState();
}

class _CheckInCurrentHappyLifeState extends State<CheckInCurrentHappyLife> {
  String selected = "";
  TextEditingController txtOther = TextEditingController();

  CheckInCubit get cubit => getIt();

  @override
  void initState() {
    super.initState();
    selected = cubit.howMuchHappyCurrently;
  }

  void _onNumberTap(String rating) {
    setState(() {
      selected = rating;
      cubit.howMuchHappyCurrently = rating;
      cubit.notifyTextFieldUpdates();

      // Update the cubit's state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CheckInTitleWidget(
          title: "How happy are you with your life currently?",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  Assets.sadVector, // Path to your happy image
                  width: 30,
                  height: 30,
                ),
                Text(
                  "Very Unhappy",
                  style: TextStyle(
                    color: context.colorScheme.secondary,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  Assets.happyVector, // Path to your happy image
                  width: 30,
                  height: 30,
                ),
                Text(
                  "Very Happy",
                  style: TextStyle(
                    color: context.colorScheme.secondary,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            String number = (index + 1).toString();
            return GestureDetector(
              onTap: () {
                _onNumberTap(number);
                print(cubit.howMuchHappyCurrently);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: number == selected
                      ? context.colorScheme.secondary
                      : context.colorScheme.tertiary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    color: number == selected ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: txtOther,
            onChange: (val) {
              //            txtOther = val;
              cubit.notifyTextFieldUpdates();
            },
            label: "Please Explain (Optional)",
            isDetail: true,
            bottomPadding: 0,
          ),
        ),
      ],
    );
  }
}
