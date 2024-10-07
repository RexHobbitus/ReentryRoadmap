import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';

class ServiceProvidersDropdown extends StatelessWidget {
  final ServiceProvider? initialValue;

  ServiceProvidersDropdown({super.key, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ServiceProvider>(
         value: _serviceProviders.first,
        items: _serviceProviders
            .map((data) => DropdownMenuItem<ServiceProvider>(
                value:data,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(backgroundColor: Colors.primaries[3]),
                    const Text("Hello")
                  ],
                )))
            .toList(),
        onChanged: (serviceProvider) {
          debugPrint(serviceProvider?.title.toString());
        });
  }

  final List<ServiceProvider> _serviceProviders = [
    ServiceProvider(
        title: "OpenGate Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.openGate),
    ServiceProvider(
        title: "OpenGate Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.openGate),
    ServiceProvider(
        title: "OpenGate Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.openGate),
    ServiceProvider(
        title: "OpenGate Foundation",
        subTitle: "2786 Marine Blvd, Hayward, California",
        icon: Assets.openGate),
  ];
}

class ServiceProvider {
  String? title;
  String? subTitle;
  String? icon;

  ServiceProvider({
    required this.title,
    required this.subTitle,
    required this.icon,
  });
}
