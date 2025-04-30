
enum AppointmentStatus {
  booked,
  cancelled,
  rescheduled,
  completed,
  pending,
  noShow,
}

extension AppointmentStatusExtension on AppointmentStatus {
  String get name {
    switch (this) {
      case AppointmentStatus.booked:
        return 'Booked';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.rescheduled:
        return 'Rescheduled';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.noShow:
        return 'No Show';
      default:
        return '';
    }
  }
}