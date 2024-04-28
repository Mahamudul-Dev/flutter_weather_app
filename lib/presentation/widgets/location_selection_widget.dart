import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/location/location_bloc.dart';
import '../../data/utils/utils.dart';

class LocationSelectionWidget extends StatelessWidget {
  const LocationSelectionWidget({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Your Location',
        style: theme.textTheme.titleLarge?.copyWith(
          color: Config.BG_BLUE_DARK,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Center(
            child: CSCPicker(
              // dropdownDecoration: BoxDecoration(),
              selectedItemStyle: theme.textTheme.labelMedium?.copyWith(
                color: Colors.black,
              ),
              dropdownItemStyle: theme.textTheme.labelMedium?.copyWith(
                color: Colors.black,
              ),
              dropdownHeadingStyle: theme.textTheme.titleLarge?.copyWith(
                color: Config.BG_BLUE_DARK,
              ),
              defaultCountry: CscCountry.Bangladesh,
              onCountryChanged: (value) => context.read<LocationBloc>().changeCountry(value),
              onStateChanged: (value) => context.read<LocationBloc>().changeState(value ?? ''),
              onCityChanged: (value) => context.read<LocationBloc>().changeCity(value ?? ''),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red)),
          child: Text(
            'Close',
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<LocationBloc>().add(ChangeUserLocation());
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Config.BG_BLUE_DARK)),
          child: Text(
            'Set',
            style: theme.textTheme.labelLarge?.copyWith(
              color: Config.DEFAULT_TEXT_COLOR_LIGHT,
            ),
          ),
        ),
      ],
    );
  }
}
