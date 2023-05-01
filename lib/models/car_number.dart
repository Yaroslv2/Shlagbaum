class GuestCarNumber {
  String active;
  String number;
  int id;
  String guestName;
  String carType;
  bool oneTime;

  GuestCarNumber({
    required this.active,
    required this.number,
    required this.id,
    required this.guestName,
    required this.carType,
    required this.oneTime,
  });

  factory GuestCarNumber.fromJson(Map<String, dynamic> json) => GuestCarNumber(
        active: json["active"],
        id: json["guest_id"],
        number: json["car_num"],
        guestName: json["guest_name"],
        carType: json["car_type"],
        oneTime: json["one_time_visit"],
      );
}
