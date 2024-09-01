import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cstain/models/categories_and_action.dart';
import 'package:cstain/models/user_contribution.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<CategoriesAndActionModel>> fetchCategoriesAndActions() async {
    try {
      final snapshot =
          await _firestore.collection('categories_and_actions').get();
      final categories = snapshot.docs
          .map((doc) => CategoriesAndActionModel.fromMap(doc.data()))
          .toList();

      print("Fetched ${categories.length} categories from Firestore");
      categories.forEach((category) {
        print(
            "Category: ${category.category_name}, Action: ${category.action_name}");
      });

      return categories;
    } catch (e) {
      print('Error fetching categories and actions: $e');
      return [];
    }
  }

  Future<void> addUserContribution(UserContributionModel contribution) async {
    try {
      final actionDoc = await _firestore
          .collection('categories_and_actions')
          .where('action_name', isEqualTo: contribution.action)
          .limit(1)
          .get();

      if (actionDoc.docs.isNotEmpty) {
        final contributionData = contribution.toMap();
        final actionData = actionDoc.docs.first.data();

        // Check if the action is meal-related
        bool isMealAction =
            contribution.action.toLowerCase().contains('meal') ||
                contribution.action.toLowerCase().contains('food');

        double co2Saved;
        if (isMealAction) {
          // For meal actions, use the duration as the number of meals
          final co2SavingPerMeal =
              actionData['co2_saving_per_meal'] as double? ?? 0.0;
          co2Saved = contribution.duration * co2SavingPerMeal;
          // Keep the duration as is (representing number of meals)
        } else {
          // For non-meal actions, convert duration to hours and calculate CO2 saved
          final co2SavingFactor = actionData['co2_saving_factor'] as double;
          final durationInHours = contribution.duration / 60;
          print('this is the final duration in  hours ${durationInHours}');
          co2Saved = durationInHours * co2SavingFactor;
          contributionData['duration'] = durationInHours;
        }

        contributionData['co2_saved'] = co2Saved;
        contributionData['created_at'] = FieldValue.serverTimestamp();

        await _firestore.collection('user_contributions').add(contributionData);
        print('User contribution added successfully with CO2 saved: $co2Saved');
      } else {
        print('Error: Action not found in categories_and_actions');
      }
    } catch (e) {
      print('Error adding user contribution: $e');
    }
  }

  // Future<void> addUserContribution(UserContributionModel contribution) async {
  //   try {
  //     // Fetch the CO2 saving factor for this action
  //     final actionDoc = await _firestore
  //         .collection('categories_and_actions')
  //         .where('action_name', isEqualTo: contribution.action)
  //         .limit(1)
  //         .get();

  //     if (actionDoc.docs.isNotEmpty) {
  //       final durationInHours = contribution.duration / 60;
  //       final contributionData = contribution.toMap();
  //       contributionData['duration'] = durationInHours;
  //       contributionData['created_at'] = FieldValue.serverTimestamp();
  //       final actionData = actionDoc.docs.first.data();
  //       final co2SavingFactor = actionData['co2_saving_factor'] as double;

  //       // Calculate CO2 saved
  //       final co2Saved = contribution.duration * co2SavingFactor;

  //       // Update the contribution data with calculated CO2 saved

  //       contributionData['co2_saved'] = co2Saved;
  //       contributionData['created_at'] = FieldValue.serverTimestamp();

  //       await _firestore.collection('user_contributions').add(contributionData);
  //       print('User contribution added successfully with CO2 saved: $co2Saved');
  //     } else {
  //       print('Error: Action not found in categories_and_actions');
  //     }
  //   } catch (e) {
  //     print('Error adding user contribution: $e');
  //   }
  // }

  Future<List<UserContributionModel>> fetchTodayUserContributions(
      String userId) async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(Duration(days: 1));

      final querySnapshot = await _firestore
          .collection('user_contributions')
          .where('user_id', isEqualTo: userId)
          .where('created_at',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('created_at', isLessThan: Timestamp.fromDate(endOfDay))
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserContributionModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching today\'s user contributions: $e');
      return [];
    }
  }
}
// Future<void> addUserContribution(UserContributionModel contribution) async {
//     try {
//       final durationInHours = contribution.duration / 60;
//       final contributionData = contribution.toMap();
//       contributionData['duration'] = durationInHours;
//       contributionData['created_at'] = FieldValue.serverTimestamp();

//       await _firestore.collection('user_contributions').add(contributionData);
//       print('User contribution added successfully');
//     } catch (e) {
//       print('Error adding user contribution: $e');
//     }
  // }