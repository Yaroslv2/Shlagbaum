class CarNumber {
  int role;
  String number;
  String? deadTime;

  CarNumber({
    required this.role,
    required this.number,
    this.deadTime,
  });

  factory CarNumber.fromJson(Map<String, dynamic> json) => CarNumber(
        role: json["role"],
        number: json["number"],
        deadTime: json["role"] == 0 ? null : json["deadTime"],
      );
}
