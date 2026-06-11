class Rating {
  final num rate;
  final int count;

  Rating({required this.rate, required this.count});

  Map<String, dynamic> toMap() {
    return {'rate': rate, 'count': count};
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(rate: map['rate'] ?? 0, count: map['count'] ?? 0);
  }
}
