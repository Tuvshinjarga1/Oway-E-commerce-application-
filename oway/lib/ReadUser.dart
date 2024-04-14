// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ListUsers extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('register').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No users found.'),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//               return ListTile(
//                 title: Text(userData['name'] ?? 'Name not provided'),
//                 subtitle: Text(
//                   'Age: ${userData['age'] ?? 'Age not provided'}, '
//                   'Birthday: ${(userData['birthday'] as Timestamp?)?.toDate() ?? 'Birthday not provided'}',
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
