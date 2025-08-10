// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../provider/user_progres_provider.dart';
// // import 'lesson_screen.dart';
// //
// // class LanguageListScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Beginner Italian')),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             SizedBox(height: 20),
// //             _buildCategorySection('Greetings', 'greetings'),
// //             _buildCategorySection('Food & Dining', 'food'),
// //             _buildCategorySection('Travel', 'travel'),
// //             _buildCategorySection('Shopping', 'shopping'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Widget _buildCategorySection(String title, String category) {
// //   //   return Column(
// //   //     crossAxisAlignment: CrossAxisAlignment.start,
// //   //     children: [
// //   //       Padding(
// //   //         padding: EdgeInsets.symmetric(vertical: 8),
// //   //         child: Text(
// //   //           title,
// //   //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //   //         ),
// //   //       ),
// //   //       FutureBuilder<QuerySnapshot>(
// //   //         future: FirebaseFirestore.instance
// //   //             .collection('courses/italian_beginner/lessons')
// //   //             .where('category', isEqualTo: category)
// //   //             .orderBy('order')
// //   //             .get(),
// //   //         builder: (context, snapshot) {
// //   //           if (snapshot.connectionState == ConnectionState.waiting) {
// //   //             return const Center(child: CircularProgressIndicator());
// //   //           }
// //   //
// //   //           if (snapshot.hasError) {
// //   //             return Center(child: Text('Error: ${snapshot.error}'));
// //   //           }
// //   //
// //   //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //   //             return const Center(child: Text('No lessons found.'));
// //   //           }
// //   //
// //   //           final lessons = snapshot.data!.docs;
// //   //
// //   //           return ListView.builder(
// //   //             shrinkWrap: true,
// //   //             physics: const NeverScrollableScrollPhysics(),
// //   //             itemCount: lessons.length,
// //   //             itemBuilder: (context, index) {
// //   //               final lesson = lessons[index];
// //   //               return ListTile(
// //   //                 leading: CircleAvatar(
// //   //                   backgroundColor:
// //   //                       Provider.of<UserProgress>(
// //   //                         context,
// //   //                       ).isLessonCompleted(lesson.id)
// //   //                       ? Colors.green
// //   //                       : Colors.grey,
// //   //                   child: Text('${lesson['order']}'),
// //   //                 ),
// //   //                 title: Text(lesson['content']),
// //   //                 subtitle: Text(lesson['translation']),
// //   //                 onTap: () {
// //   //                   Navigator.push(
// //   //                     context,
// //   //                     MaterialPageRoute(
// //   //                       builder: (context) => LessonScreen(lessonId: lesson.id, courseId: '',),
// //   //                     ),
// //   //                   );
// //   //                 },
// //   //               );
// //   //             },
// //   //           );
// //   //         },
// //   //       ),
// //   //
// //   //       // FutureBuilder<QuerySnapshot>(
// //   //       //   future: FirebaseFirestore.instance
// //   //       //       .collection('courses/italian_beginner/lessons')
// //   //       //       .where('category', isEqualTo: category)
// //   //       //       .orderBy('order')
// //   //       //       .get(),
// //   //       //   builder: (context, snapshot) {
// //   //       //     if (snapshot.connectionState == ConnectionState.waiting) {
// //   //       //       return Center(child: CircularProgressIndicator());
// //   //       //     }
// //   //       //
// //   //       //     return ListView.builder(
// //   //       //       shrinkWrap: true,
// //   //       //       physics: NeverScrollableScrollPhysics(),
// //   //       //       itemCount: snapshot.data!.docs.length,
// //   //       //       itemBuilder: (context, index) {
// //   //       //         final lesson = snapshot.data!.docs[index];
// //   //       //         return ListTile(
// //   //       //           leading: CircleAvatar(
// //   //       //             child: Text('${lesson['order']}'),
// //   //       //             backgroundColor: Provider.of<UserProgress>(context)
// //   //       //                 .isLessonCompleted(lesson.id)
// //   //       //                 ? Colors.green
// //   //       //                 : Colors.grey,
// //   //       //           ),
// //   //       //           title: Text(lesson['content']),
// //   //       //           subtitle: Text(lesson['translation']),
// //   //       //           onTap: () {
// //   //       //             Navigator.push(
// //   //       //               context,
// //   //       //               MaterialPageRoute(
// //   //       //                 builder: (context) => LessonScreen(lessonId: lesson.id),
// //   //       //               ),
// //   //       //             );
// //   //       //           },
// //   //       //         );
// //   //       //       },
// //   //       //     );
// //   //       //   },
// //   //       // ),
// //   //     ],
// //   //   );
// //   // }
// //
// //   Widget _buildCategorySection(String title, String category, BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: EdgeInsets.symmetric(vertical: 8),
// //           child: Text(
// //             title,
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         FutureBuilder<QuerySnapshot>(
// //           future: FirebaseFirestore.instance
// //               .collection('courses/italian_beginner/lessons')
// //               .where('category', isEqualTo: category)
// //               .orderBy('order')
// //               .orderBy(FieldPath.documentId)
// //               .get(),
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return Center(child: CircularProgressIndicator());
// //             }
// //
// //             if (snapshot.hasError) {
// //               debugPrint("Firestore Error: ${snapshot.error}");
// //               return Column(
// //                 children: [
// //                   Text('Temporary loading issue'),
// //                   SizedBox(height: 10),
// //                   ElevatedButton(
// //                     onPressed: () => _retryLoading(context),
// //                     child: Text('Try Again'),
// //                   ),
// //                 ],
// //               );
// //             }
// //
// //             final lessons = snapshot.data?.docs ?? [];
// //             if (lessons.isEmpty) {
// //               return Center(child: Text('No lessons available'));
// //             }
// //
// //             return ListView.builder(
// //               shrinkWrap: true,
// //               physics: NeverScrollableScrollPhysics(),
// //               itemCount: lessons.length,
// //               itemBuilder: (context, index) {
// //                 final lesson = lessons[index];
// //                 return _buildLessonTile(lesson, context);
// //               },
// //             );
// //           },
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildLessonTile(QueryDocumentSnapshot lesson, BuildContext context) {
// //     return ListTile(
// //       leading: CircleAvatar(
// //         backgroundColor: Provider.of<UserProgress>(context)
// //             .isLessonCompleted(lesson.id)
// //             ? Colors.green
// //             : Colors.grey,
// //         child: Text('${lesson['order']}'),
// //       ),
// //       title: Text(lesson['content'] ?? 'No content'),
// //       subtitle: Text(lesson['translation'] ?? 'No translation'),
// //       onTap: () => Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => LessonScreen(
// //             lessonId: lesson.id,
// //             courseId: 'italian_beginner',
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _retryLoading(BuildContext context) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Refreshing data...')),
// //     );
// //     // This will automatically trigger a rebuild
// //   }
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_project/core/constants.dart';
// import 'package:provider/provider.dart';
// import '../../../provider/user_progres_provider.dart';
// import 'lesson_screen.dart';
// class ProficiencySelectionScreen extends StatelessWidget {
//   final VoidCallback? onBackPressed;
//   final String language;
//
//   const ProficiencySelectionScreen({required this.language, this.onBackPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryRed,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back,color: white,),
//             onPressed: () {
//               if (onBackPressed != null) {
//                 onBackPressed!(); // Custom back navigation
//               } else {
//                 Navigator.pop(context); // Default back behavior
//               }
//             },
//           ),
//           title: Text('Select Level for ${language.capitalize()}',style: TextStyle(color: white),)),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('courses/$language/levels')
//             .snapshots(),
//         builder: (context, snapshot) {
//           // if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No proficiency levels found'));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final proficiency = snapshot.data!.docs[index];
//               return ListTile(
//                 title: Text(proficiency['name']),
//                 subtitle: Text('${proficiency['totalLessons']} lessons'),
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChapterListScreen(
//                       language: language,
//                       proficiency: proficiency.id,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ChapterListScreen extends StatelessWidget {
//   final String language;
//   final String proficiency;
//   final VoidCallback? onBackPressed;
//
//   const ChapterListScreen({
//     required this.language,
//     required this.proficiency, this.onBackPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryRed,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back,color: white,),
//           onPressed: () {
//             if (onBackPressed != null) {
//               onBackPressed!(); // Custom back navigation
//             } else {
//               Navigator.pop(context); // Default back behavior
//             }
//           },
//         ),
//         title: Text('${proficiency.capitalize()} ${language.capitalize()} - Chapters',style: TextStyle(color: white),),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('courses/$language/levels/$proficiency/chapters')
//             .orderBy('order')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return CircularProgressIndicator();
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final chapter = snapshot.data!.docs[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   child: Text('${index + 1}'),
//                   backgroundColor: Provider.of<UserProgress>(context)
//                       .isLessonCompleted(chapter.id)
//                       ? Colors.green
//                       : Colors.grey,
//                 ),
//                 title: Text(chapter['name']),
//                 subtitle: Text("total lessons ${chapter['totalLessons']}"),
//                   onTap: () async {
//                     final chapterId = chapter.id;
//
//                     // 🔍 Fetch the first lesson by order
//                     final lessonsSnapshot = await FirebaseFirestore.instance
//                         .collection('courses')
//                         .doc(language)
//                         .collection('levels')
//                         .doc(proficiency)
//                         .collection('chapters')
//                         .doc(chapterId)
//                         .collection('lessons')
//                         .orderBy('order') // order ascending
//                         .limit(1)
//                         .get();
//
//                     if (lessonsSnapshot.docs.isNotEmpty) {
//                       final lessonId = lessonsSnapshot.docs.first.id;
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LessonScreen(
//                             language: language,
//                             proficiency: proficiency,
//                             chapterId: chapterId,
//                             lessonId: lessonId,
//                           ),
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('No lessons found in this chapter.')),
//                       );
//                     }
//                   }
//
//                 // onTap: () => Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => LessonScreen(language: language, proficiency: proficiency, chapterId: chapterId, lessonId: lessonId)
//                 //     // LessonListScreen(
//                 //     //   language: language,
//                 //     //   proficiency: proficiency,
//                 //     //   chapterId: chapter.id,
//                 //     // ),
//                 //   ),
//                 // ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//
// class LessonListScreen extends StatelessWidget {
//   final String language;
//   final String proficiency;
//   final String chapterId;
//   final VoidCallback? onBackPressed;
//
//   const LessonListScreen({
//     required this.language,
//     required this.proficiency,
//     required this.chapterId, this.onBackPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: primaryRed,leading: IconButton(
//         icon: Icon(Icons.arrow_back,color: white,),
//         onPressed: () {
//           if (onBackPressed != null) {
//             onBackPressed!(); // Custom back navigation
//           } else {
//             Navigator.pop(context); // Default back behavior
//           }
//         },
//       ),title: Text('Lessons',style: TextStyle(color: white),),),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('courses/$language/levels/$proficiency/chapters/$chapterId/lessons')
//             .orderBy('order')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return CircularProgressIndicator();
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final lesson = snapshot.data!.docs[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   child: Text('${index + 1}'),
//                   backgroundColor: Provider.of<UserProgress>(context)
//                       .isLessonCompleted(lesson.id)
//                       ? Colors.green
//                       : Colors.grey,
//                 ),
//                 title: Text(lesson['content']),
//                 subtitle: Text(lesson['translation']),
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => LessonScreen(
//                       language: language,
//                       proficiency: proficiency,
//                       chapterId: chapterId,
//                       lessonId: lesson.id,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }