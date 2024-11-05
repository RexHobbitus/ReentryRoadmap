import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class SearchEligibilityFeatureFilterPopup extends StatefulWidget {
  final String title;
  final List<String> list;
  final List<String> selectedList;
  final SearchCubit cubit;
  final void Function(List<String> result) onResult;

  const SearchEligibilityFeatureFilterPopup({
    super.key,
    required this.title,
    required this.list,
    required this.selectedList, required this.cubit,required this.onResult
  });

  @override
  State<SearchEligibilityFeatureFilterPopup> createState() => _SearchEligibilityFeatureFilterPopupState();
}

class _SearchEligibilityFeatureFilterPopupState extends State<SearchEligibilityFeatureFilterPopup> {
   ValueNotifier<List<String>> localSelectedList =ValueNotifier([]);
  @override
  void initState() {

    super.initState();
    localSelectedList.value = widget.selectedList;
  }

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context, constraints, deviceSize) {
        return SizedBox(
          width: deviceSize == DeviceSize.web ? 600 : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  CloseButton(
                    style: IconButton.styleFrom(
                      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                      padding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: ValueListenableBuilder(
                   valueListenable: localSelectedList,
                  builder:(context, selectedValue, child) =>  GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.list.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 40,
                    ),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: Checkbox(
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              value: localSelectedList.value.contains(widget.list[index]),
                              onChanged: (value) {
                                if(selectedValue.contains(widget.list[index])){
                                  localSelectedList.value =[...localSelectedList.value]..removeWhere((element) => element==widget.list[index],);
                                }else{
                                  localSelectedList.value = [...localSelectedList.value,widget.list[index]];
                                }
                              },
                              checkColor: Colors.transparent,
                              activeColor: context.colorScheme.secondary,
                              side: BorderSide(color: context.colorScheme.onSurface.withOpacity(0.5)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.list[index],
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colorScheme.onSurface.withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                height: 60,
                width: double.infinity,
                text: "Select ${widget.title}",
                onTap: () {
                  widget.onResult.call(localSelectedList.value);

                  widget.cubit.navigator.navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
