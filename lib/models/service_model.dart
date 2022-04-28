class ServiceModel {
  ServiceModel({
    required this.id,
    required this.date,
    required this.mileage,
    required this.name,
    required this.finished,
  });

  final String id;
  final DateTime date;
  final int mileage;
  final String name;
  final bool finished;

  String daysLeft() {
    return date.difference(DateTime.now()).inDays.toString();
  }

  String mileageLeft() {
    return '5000';
  }
}

class CurrentMileage {
  CurrentMileage({
    required this.currentMileage,
  });

  final String currentMileage;
  
}
