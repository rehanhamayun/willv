class FavoritCard {
  int? id;
  String? cardName;
  String? gemId;
  String? cardUrl;

  FavoritCard({
    this.id,
    this.cardName,
    this.gemId,
    this.cardUrl,
  });

  FavoritCard.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] ?? 0;
    cardName = json['cardName'] ?? "0";
    gemId = json['gemId'] ?? "0";
    cardUrl = json['cardUrl'] ?? "";
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['id'] = id;
    data['cardName'] = cardName;
    data['gemId'] = gemId;
    data['cardUrl'] = cardUrl;
    return data;
  }

  @override
  String toString() {
    return "$id, $cardName, $gemId, $cardUrl";
  }
}
