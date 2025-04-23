import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

/// A utility constant for generating unique IDs.
const uuid = Uuid();

/// A utility constant for formatting dates in `yMd` format.
final formatter = DateFormat.yMd();

/// A mapping of [Category] values to their corresponding [Icons].
const cartegoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.card_giftcard,
  Category.work: Icons.work,
};

/// An enumeration representing different categories of expenses.
enum Category {
  /// Represents food-related expenses.
  food,

  /// Represents travel-related expenses.
  travel,

  /// Represents leisure-related expenses.
  leisure,

  /// Represents work-related expenses.
  work,
}

/* A class representing an individual expense.
 * 
 * This class contains information about an expense, including its title,
 * amount, date, and category. It also provides a method to format the date
 * for display purposes.
 *
* Each expense has a unique ID, a title, an amount, a date, and a category.
*/
class Expense {
  /// The unique identifier for the expense.
  final String id;

  /// The title or description of the expense.
  final String title;

  /// The monetary amount of the expense.
  final double amount;

  /// The date when the expense occurred.
  final DateTime date;

  /// The category of the expense.
  final Category category;

  /* Creates an [Expense] with the given [title], [amount], [date], and [category].
   * The [id] is automatically generated using the `uuid` utility.
   */
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  /// Returns the formatted date of the expense as a string.
  String get formatedDate {
    return formatter.format(date);
  }
}

/// A class representing a collection of expenses grouped by a specific category.
class ExpenseBucket {
  /// The list of expenses in this bucket.
  final List<Expense> expenses;

  /// The category associated with this bucket.
  final Category category;

  /// Creates an [ExpenseBucket] with the given [expenses] and [category].
  const ExpenseBucket({
    required this.expenses,
    required this.category,
  });

  /// Creates an [ExpenseBucket] for a specific [category] by filtering
  /// the provided [allExpenses].
  ExpenseBucket.forCategory({
    required this.category,
    required List<Expense> allExpenses,
  }) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  /// Calculates the total monetary amount of all expenses in this bucket.
  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
