import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Screens/provider_details_bloc.dart';
class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;
  static const path = '/CustomTabBar';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        // Define different texts for each index
        final tabTexts = [
          'Provider Details', // Index 0
          'Program Details',   // Index 1
          'Photos',           // Index 2
          'Manage Reviews'    // Index 3
        ];

        return GestureDetector(
          onTap: () {
            // Dispatch ChangeTabEvent when a tab is tapped
            context.read<ProviderDetailsBloc>().add(ChangeTabEvent(index));
          },
          child: Text(
            tabTexts[index], // Use distinct text for each tab
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: selectedIndex == index ? Colors.blue : Colors.black, // Change color when selected
            ),
          ),
        );
      })..add(Container(
        width: 250, // Set a fixed width for the container
        height: 50, // Set a fixed height for the container
        decoration: BoxDecoration(
          color: Color(0xff807ED5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'View Live Listing',
            style: GoogleFonts.poppins(color: Colors.white), // Text color for contrast
          ),
        ),
      )),
    );
  }
}