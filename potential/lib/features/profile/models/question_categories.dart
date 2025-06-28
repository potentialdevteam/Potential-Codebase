/// Enum for the different question categories
///
/// [spark] is the spark question category
/// [mind] is the mind question category
/// [heart] is the heart question category
/// [soul] is the soul question category
enum QuestionCategory{
  spark,
  mind,
  heart,
  soul,
}

/// Extension for the QuestionCategory enum to get the name of the question category
extension QuestionCategoryExtension on QuestionCategory {
  /// Returns a string representation of the question category [name]
  String get name {
    switch (this) {
      case QuestionCategory.spark:
        return "Spark";
      case QuestionCategory.mind:
        return "Mind";
      case QuestionCategory.heart:
        return "Heart";
      case QuestionCategory.soul:
        return "Soul";
    }
  }
}

QuestionCategory getCategoryByName({required String title}) {
  switch (title) {
    case "Spark":
      return QuestionCategory.spark;
    case "Mind":
      return QuestionCategory.mind;
    case "Heart":
      return QuestionCategory.heart;
    case "Soul":
      return QuestionCategory.soul;
    default:
      return QuestionCategory.spark;
  }
}