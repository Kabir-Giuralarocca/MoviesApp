import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/app_theme.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';

const width_4 = SizedBox(width: 4);

const height_4 = SizedBox(height: 4);
const height_8 = SizedBox(height: 8);
const height_16 = SizedBox(height: 16);
const height_24 = SizedBox(height: 24);
const height_36 = SizedBox(height: 36);
const height_68 = SizedBox(height: 68);

// Layout
Widget filler = Expanded(child: Container());

// Shadows
List<BoxShadow> lightShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    spreadRadius: 5,
    blurRadius: 16,
    offset: const Offset(0, 2),
  )
];

List<BoxShadow> imageShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.25),
    spreadRadius: 2,
    blurRadius: 24,
    offset: const Offset(0, 2),
  )
];

// SnackBar
SnackBar messageSnackBar({
  required String message,
  bool isError = false,
  String? label,
  void Function()? onPressed,
}) {
  return SnackBar(
    backgroundColor: isError ? Colors.red : Colors.blueGrey,
    content: Text(message),
    action: label != null && onPressed != null
        ? SnackBarAction(label: label, onPressed: onPressed)
        : null,
  );
}

// Pickers
Future<TimeOfDay?> durationPicker(
  BuildContext context,
  TimeOfDay initialTime,
) async {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.inputOnly,
    helpText: "Durata",
    confirmText: "Salva",
    cancelText: "Annulla",
    hourLabelText: "Ore",
    minuteLabelText: "Minuti",
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          alwaysUse24HourFormat: true,
        ),
        child: child ?? Container(),
      );
    },
  );
}

Future<DateTime?> realeaseDatePicker(
  BuildContext context,
  DateTime releaseDate,
) async {
  return showDatePicker(
    context: context,
    initialDate: releaseDate,
    firstDate: DateTime(1900),
    lastDate: DateTime(2050),
    helpText: "Data di uscita",
    confirmText: "Salva",
    cancelText: "Annulla",
  );
}

// Dialogs
Dialog confirmDelete(
  BuildContext context,
  String movieTitle,
  void Function() callback,
) {
  return Dialog(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sei sicuro di voler eliminare $movieTitle?",
            style: bold_14,
          ),
          height_16,
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              callback.call();
            },
            style: deleteStyle(context),
            child: const Text("Elimina"),
          ),
          height_8,
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annulla"),
          )
        ],
      ),
    ),
  );
}

Dialog exitDialog(BuildContext context) {
  return Dialog(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Se esci perderai le modifiche fatte in questa pagina!",
            style: bold_14,
          ),
          height_16,
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Esci"),
          ),
          height_8,
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Annulla"),
          )
        ],
      ),
    ),
  );
}
