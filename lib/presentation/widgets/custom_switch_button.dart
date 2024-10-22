import 'package:flutter/cupertino.dart';
class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final Function(bool)? onChange;
  const CustomSwitchButton({super.key,this.value=false,this.onChange});


  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool value=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value=widget.value;
  }
  @override
  Widget build(BuildContext context) {
    return  CupertinoSwitch(
      value:value,
      onChanged: (value) {
        setState(() {
          this.value=value;
        });
        widget.onChange?.call(value);
      },
    );
  }
}
