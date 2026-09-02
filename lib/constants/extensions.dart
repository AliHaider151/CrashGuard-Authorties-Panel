extension TimeAgo on DateTime {
  String timePassed() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds} sec${diff.inSeconds != 1 ? 's' : ''} ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min${diff.inMinutes != 1 ? 's' : ''} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours != 1 ? 's' : ''} ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} day${diff.inDays != 1 ? 's' : ''} ago";
    } else if (diff.inDays < 30) {
      int weeks = (diff.inDays / 7).floor();
      return "$weeks week${weeks != 1 ? 's' : ''} ago";
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return "$months month${months != 1 ? 's' : ''} ago";
    } else {
      int years = (diff.inDays / 365).floor();
      return "$years year${years != 1 ? 's' : ''} ago";
    }
  }
}
