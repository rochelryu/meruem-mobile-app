import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = MultiValidator([
  RequiredValidator(errorText: 'Nom & prénom requis'),
  MinLengthValidator(6, errorText: 'Nom complet doit dépasser 6 lettres'),
]);

final numberValidator = MultiValidator([
  RequiredValidator(errorText: 'Numero est requis'),
  MinLengthValidator(10, errorText: 'Numero est invalide')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email est requis'),
  EmailValidator(errorText: 'Email incorrect')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Mot de passe est requis'),
  MinLengthValidator(8, errorText: 'Mot de passe doit contenir au moins 8'),
]);
