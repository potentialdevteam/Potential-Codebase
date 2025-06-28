// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:potential/components/interest_option.dart';
// import 'package:potential/features/create_account_cubit.dart';
// import 'package:potential/utils/colors.dart';
// import 'package:potential/utils/interests_data.dart';

// class ProfileInterests extends StatefulWidget {
//   const ProfileInterests({super.key});

//   @override
//   State<ProfileInterests> createState() => _ProfileInterestsState();
// }

// class _ProfileInterestsState extends State<ProfileInterests> {
//   late final Map<String, String> _interestsHobbiesData;
//   late final Map<String, String> _interestsActivitiesData;
//   final Set<String> _selectedInterests = {};

//   @override
//   void initState() {
//     super.initState();
//     _interestsActivitiesData = getInterestsActivitiesData();
//     _interestsHobbiesData = getInterestsHobbiesData();

//     // Get the saved interests from the cubit
//     final List<String> selectedInterests = context
//         .read<CreateAccountCubit>()
//         .state
//         .interests
//         .value;

//     _selectedInterests.addAll(selectedInterests);
//   }

//   void _onInterestTap(String value) {
//     setState(() {
//       if (_selectedInterests.contains(value)) {
//         _selectedInterests.remove(value);
//       } else {
//         if (_selectedInterests.length < 6) {
//           _selectedInterests.add(value);
//           context.read<CreateAccountCubit>().updateInterests(
//             _selectedInterests.toList(),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("You can select up to 6 interests only.")),
//           );
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.05,
//         ),
//         width: MediaQuery.of(context).size.width * 0.80,
//         child: Column(
//           spacing: MediaQuery.of(context).size.height * 0.02,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               "Your Interests",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.left,
//             ),
//             Text(
//               "Pick 5 things you love. This will help you match with people who share your interests.",
//               style: TextStyle(color: Colors.white, fontSize: 13),
//               textAlign: TextAlign.left,
//             ),

//             Text(
//               "Hobbies",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.left,
//             ),
//             // list of options
//             Wrap(
//               spacing: MediaQuery.of(context).size.width * 0.05,
//               runSpacing: MediaQuery.of(context).size.height * 0.02,
//               children: List.generate(_interestsHobbiesData.length, (index) {
//                 return InterestOption(
//                   isSelected: _selectedInterests.contains(
//                     _interestsHobbiesData.entries.elementAt(index).value,
//                   ),
//                   onTap: () => _onInterestTap(
//                     _interestsHobbiesData.entries.elementAt(index).value,
//                   ),
//                   unicode: _interestsHobbiesData.entries.elementAt(index).key,
//                   title: _interestsHobbiesData.entries.elementAt(index).value,
//                 );
//               }),
//             ),

//             Text(
//               "Activities",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.left,
//             ),
//             Wrap(
//               spacing: MediaQuery.of(context).size.width * 0.05,
//               runSpacing: MediaQuery.of(context).size.height * 0.02,
//               children: List.generate(_interestsActivitiesData.length, (index) {
//                 return InterestOption(
//                   isSelected: _selectedInterests.contains(
//                     _interestsActivitiesData.entries.elementAt(index).value,
//                   ),
//                   onTap: () => _onInterestTap(
//                     _interestsActivitiesData.entries.elementAt(index).value,
//                   ),
//                   unicode: _interestsActivitiesData.entries
//                       .elementAt(index)
//                       .key,
//                   title: _interestsActivitiesData.entries
//                       .elementAt(index)
//                       .value,
//                 );
//               }),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.80,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Checkbox(
//                     value: context
//                         .watch<CreateAccountCubit>()
//                         .state
//                         .interests
//                         .isVisibleToAll,
//                     onChanged: (value) {
//                       context.read<CreateAccountCubit>().updateInterests(
//                         _selectedInterests.toList(),
//                         isVisibleToAll: value,
//                       );
//                     },
//                     activeColor: AppColors.accentRed,
//                   ),
//                   Text(
//                     "Visible to everyone",
//                     style: TextStyle(color: AppColors.accentWhite),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
