import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/check_in/check_in_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/header_auth_buttons.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';
import 'widgets/check_in_footer.dart';

class CheckInPage extends StatefulWidget {
  final CheckInCubit cubit;
  final CheckInInitialParams initialParams;

  static const path = '/CheckInPage';

  const CheckInPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  CheckInCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (val,data){
        cubit.backAction();
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: double.maxFinite,
          leading: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderLogo(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kScreenHorizontalPadding),
                  child: HeaderAuthButtons(
                    loginAction: () {},
                    isMobileView: constraints.maxWidth <= kMenuBreakPoint,
                  ),
                ),
              ],
            );
          }),
        ),
        body: BlocBuilder<CheckInCubit, CheckInState>(
          bloc: cubit,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenHorizontalPadding),
                child: cubit.onBoardingSteps[state.checkInSectionIndex],
              ),
            );
          },
        ),
        bottomNavigationBar: CheckInFooter(
          cubit: cubit,
        ),
      ),
    );
  }
}
