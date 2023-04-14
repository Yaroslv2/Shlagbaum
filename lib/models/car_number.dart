class GuestCarNumber {
  String number;
  int id;
  String guestName;
  bool oneTime;

  GuestCarNumber({
    required this.number,
    required this.id,
    required this.guestName,
    required this.oneTime,
  });

  factory GuestCarNumber.fromJson(Map<String, dynamic> json) => GuestCarNumber(
        id: json["guest_id"],
        number: json["car_num"],
        guestName: json["guest_name"],
        oneTime: json["one_time_visit"],
      );
}
