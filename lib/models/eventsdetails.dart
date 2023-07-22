//might delete this as well i dont think this is needed

class EventDetails {
  String supervisor;
  String eventCode;
  DateTime eventStartDate;
  int eventEndTime;
  String eventVenue;
  String eventDescription;
  String imageURL;
  String currentUser;
  int eventStartTime;
  DateTime eventFinishDate;
  String eventName;

  EventDetails({
    required this.supervisor,
    required this.eventCode,
    required this.eventStartDate,
    required this.eventEndTime,
    required this.eventVenue,
    required this.eventDescription,
    required this.imageURL,
    required this.currentUser,
    required this.eventStartTime,
    required this.eventFinishDate,
    required this.eventName,
  });
}
