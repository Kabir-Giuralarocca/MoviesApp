import 'package:form_validator/form_validator.dart';

final requiredValidator = ValidationBuilder(
  requiredMessage: "Campo obbligatorio!",
).build();

final emailValidator = ValidationBuilder(
  requiredMessage: "Campo obbligatorio!",
).email("Email non valida!").build();

final passwordValidator = ValidationBuilder(
  requiredMessage: "Campo obbligatorio!",
)
    .minLength(8, "La password deve avere almeno 8 caratteri!")
    .regExp(
      RegExp(r"[a-z0-9]+"),
      "La password deve comprendere sia numeri che lettere!",
    )
    .regExp(
      RegExp(r"[A-Z]+"),
      "La password deve avere almeno una lettera maiuscola!",
    )
    .regExp(
      RegExp(r"[@!$%&*-+]+"),
      "La password deve avere almeno un carattere speciale!",
    )
    .build();
