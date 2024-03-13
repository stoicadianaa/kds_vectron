extension DurationExtension on Duration {
  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String twoDigitHours = twoDigits(inHours);
    final String twoDigitMinutes = twoDigits(inMinutes % 60);
    final String twoDigitSeconds = twoDigits(inSeconds % 60);
    return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
  }
}
