import 'package:flutter/material.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Colors.amber,
        ),
        Switch.adaptive(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toogleTheme(value);
          },
          inactiveThumbColor: kGreyColor,
          activeColor: Theme.of(context).iconTheme.color,
        ),
      ],
    );
  }
}
