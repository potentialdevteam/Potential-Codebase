// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:potential/features/create_account_cubit.dart';
// import 'package:potential/utils/colors.dart';
// import 'package:potential/utils/love_languages_data.dart';

// class ProfileLoveLanguage extends StatefulWidget {
//   const ProfileLoveLanguage({super.key});

//   @override
//   State<ProfileLoveLanguage> createState() => _ProfileLoveLanguageState();
// }

// class _ProfileLoveLanguageState extends State<ProfileLoveLanguage> {
//   late List<bool> selectedCheckboxes;
//   late final List<String> _loveLanguages;

//   @override
//   void initState() {
//     super.initState();
//     _loveLanguages = getLoveLanguagesOptions();
//     selectedCheckboxes = List.filled(_loveLanguages.length, false);

//     final List<String> selectedLoveLanguages = context
//         .read<CreateAccountCubit>()
//         .state
//         .loveLanguages
//         .value;

//     for (var ll in selectedLoveLanguages) {
//       int idx = _loveLanguages.indexOf(ll);
//       if (idx == -1) {
//         selectedCheckboxes[idx] = false;
//       } else {
//         selectedCheckboxes[idx] = true;
//       }
//     }
//   }

//   void selectLoveLanguages({bool? value}) {
//     List<String> selectedLanguages = [];
//     for (int i = 0; i < selectedCheckboxes.length; i++) {
//       if (selectedCheckboxes[i]) {
//         selectedLanguages.add(_loveLanguages[i]);
//       }
//     }

//     if (selectedLanguages.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please select at least one love language")),
//       );
//     } else {
//       context.read<CreateAccountCubit>().updateLoveLanguages(
//         selectedLanguages,
//         isVisibleToAll: value,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
//       width: MediaQuery.of(context).size.width * 0.80,
//       child: Column(
//         spacing: MediaQuery.of(context).size.height * 0.02,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "Favourite Love Languages?",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.left,
//           ),

//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.80,
//             child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: _loveLanguages.length,
//               itemBuilder: (context, index) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       _loveLanguages[index],
//                       style: TextStyle(color: AppColors.accentWhite),
//                     ),
//                     Checkbox(
//                       value: selectedCheckboxes[index],
//                       onChanged: (bool? value) {
//                         setState(() {
//                           selectedCheckboxes[index] = value ?? false;
//                         });
//                         selectLoveLanguages();
//                       },
//                       activeColor: AppColors.accentRed,
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),

//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.80,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Checkbox(
//                   value: context
//                       .watch<CreateAccountCubit>()
//                       .state
//                       .loveLanguages
//                       .isVisibleToAll,
//                   onChanged: (value) {
//                     selectLoveLanguages(value: value);
//                   },
//                   activeColor: AppColors.accentRed,
//                 ),
//                 Text(
//                   "Visible to everyone",
//                   style: TextStyle(color: AppColors.accentWhite),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
