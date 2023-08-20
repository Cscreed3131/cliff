class Event {
  final String eventId;
  final String eventName;
  final String eventCode;
  final String eventVenue;
  final String eventDescription;
  final DateTime eventStartDateTime;
  final DateTime eventFinishDateTime;
  final String clubMemberSic1;
  final String clubMemberSic2;
  final String club;
  final String imageUrl;
  final bool isTeamEvent;
  final int maxParticipants;
  final List<dynamic> registeredParticipants;

  Event({
    required this.eventId,
    required this.eventName,
    required this.eventCode,
    required this.eventVenue,
    required this.eventDescription,
    required this.eventStartDateTime,
    required this.eventFinishDateTime,
    required this.clubMemberSic1,
    required this.clubMemberSic2,
    required this.club,
    required this.imageUrl,
    required this.registeredParticipants,
    required this.isTeamEvent,
    required this.maxParticipants,
  });
}
