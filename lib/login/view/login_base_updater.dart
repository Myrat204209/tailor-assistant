// import 'package:flutter/material.dart';

// Future<void> showTextFieldDialog({
//   required BuildContext context,
//   void Function(String value)? onSuccess,
//   String? initialValue,
//   String? labelText,
//   String? Function(String?)? validator,
// }) async {
//   final formKey = GlobalKey<FormState>();
//   var value = initialValue ?? '';

//   final errorText = ValueNotifier<String?>(null);

//   void checkConfirmAvailability(String? v, [isFirstTime = false]) {
//     if (validator != null) {
//       errorText.value = validator(v);
//       // confirmEnabled.value = formKey.currentState?.validate() ?? fa;
//       // confirmEnabled.value = validator(v) == null;
//     }
//   }

//   // first time run initialization
//   checkConfirmAvailability(initialValue);

//   await showAdaptiveDialog<String>(
//     context: context,
//     builder: (context) => AlertDialog(
//       contentPadding: const EdgeInsets.all(10),
//       content: Row(
//         children: [
//           Expanded(
//             child: Form(
//               key: formKey,
//               child: ValueListenableBuilder(
//                 valueListenable: errorText,
//                 builder: (context, error, _) {
//                   return TextFormField(
//                     autofocus: true,
//                     onChanged: (v) {
//                       value = v;
//                       checkConfirmAvailability(v);
//                     },
//                     initialValue: initialValue,
//                     validator: validator,
//                     decoration: InputDecoration(
//                       labelText: labelText,
//                       prefixText: 'http://',
//                       errorText: error,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
//         ),
//         ValueListenableBuilder(
//           valueListenable: errorText,
//           builder: (context, error, child) {
//             return TextButton(
//               onPressed: error != null
//                   ? null
//                   : () {
//                       if (formKey.currentState!.validate()) {
//                         onSuccess?.call(value);
//                       }
//                       Navigator.pop(context);
//                     },
//               child: Text(MaterialLocalizations.of(context).okButtonLabel),
//             );
//           },
//         ),
//       ],
//     ),
//   );
// }
