class TotalRecentOpens {
  String totalHarian;
  String createdAt;

  TotalRecentOpens({this.createdAt, this.totalHarian});

  factory TotalRecentOpens.fromJson(Map<String, dynamic> json) => TotalRecentOpens(
    totalHarian: json['total_harian'],
    createdAt: json['created_at']
  );
}