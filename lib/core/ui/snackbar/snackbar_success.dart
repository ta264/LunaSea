import 'package:lunasea/core.dart';

Future<void> showLunaSuccessSnackBar({
  required String title,
  required String? message,
  bool showButton = false,
  String buttonText = 'view',
  Function? buttonOnPressed,
}) async =>
    showLunaSnackBar(
      title: title,
      message: lunaSafeString(message),
      type: LunaSnackbarType.SUCCESS,
      showButton: showButton,
      buttonText: buttonText,
      buttonOnPressed: buttonOnPressed,
    );
