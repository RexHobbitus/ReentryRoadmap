import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/date_time_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/domain/entities/operating_hour.dart';

import '../../core/utils/constants.dart';

class OperatingHoursWidget extends StatefulWidget {
  final List<OperatingHour>? operatingHours;
  final Function(List<OperatingHour>)? onChange;
  const OperatingHoursWidget({
    super.key,
    this.operatingHours,
    this.onChange
  });

  @override
  State<OperatingHoursWidget> createState() => _OperatingHoursWidgetState();
}

class _OperatingHoursWidgetState extends State<OperatingHoursWidget> {
  List<OperatingHour> operatingHours=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operatingHours=widget.operatingHours??kOperatingHours;
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        for(var operatingHour in operatingHours)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dayName(operatingHour.day),
                _timeWidget(value: operatingHour.startTime,onTap: (){
                  _selectTime(context,onPicked: (dateTime){
                    setState(() {
                      operatingHour.startTime=dateTime;
                      widget.onChange?.call(operatingHours);
                    });

                  });
                }),
                _timeWidget(value: operatingHour.endTime,onTap: (){
                  _selectTime(context,onPicked: (dateTime){
                    setState(() {
                      operatingHour.endTime=dateTime;
                      widget.onChange?.call(operatingHours);
                    });
                  });
                }),
              ]
            ),
          )
      ],
    );
  }

  Widget _dayName(String name){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      constraints: const BoxConstraints(
        minWidth: 60,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colorScheme.tertiaryContainer,
      ),
      child: Center(child: Text(name,style:context.textTheme.bodyMedium,),),
    );
  }

  Widget _timeWidget({DateTime? value,VoidCallback? onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        constraints: const BoxConstraints(
          minWidth: 90,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.surface,
          border: Border.all(color: context.colorScheme.tertiaryContainer)
        ),
        child: Center(child: Text(value.toTimeAMPM(),style:context.textTheme.bodyMedium,),),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context,{Function(DateTime)? onPicked}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime:TimeOfDay.now(),
    );
    if(pickedTime!=null){
      final now = DateTime.now();
      onPicked?.call(DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute));
    }
  }

}
