String timeOfTheDay() {
  DateTime now = DateTime.now();
  if (now.hour >= 4 && now.hour <= 11)
    return "Good Morning";
  else if (now.hour >= 12 && now.hour <= 4)
    return "Good Afternoon";
  else
    return "Good Evening";
}
