// class CardSearchResult {
//   String? gemRateDescription;
//   String? gemrateId;
//   String? awsUrl;
//   CardSearchResult({gemRateDescription, gemrateId, awsUrl});
//   CardSearchResult.fromJson(Map<String, dynamic> json) {
//     gemRateDescription = json['gemRateDescription'];
//     gemrateId = json['gemrateId'];
//     awsUrl = json['awsUrl'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['gemRateDescription'] = gemRateDescription;
//     data['gemrateId'] = gemrateId;
//     data['awsUrl'] = awsUrl;
//     return data;
//   }
// }

class CardSearchResult {
  String? grader;
  String? gemrateId;
  String? details;
  String? cardTotalGrades;
  String? category;
  String? year;
  String? setName;
  String? setNameRaw;
  String? name;
  String? cardNumber;
  String? parallel;
  String? subset;
  String? awsUrl;
  String? cardViews;

  CardSearchResult.fromJson(Map<String, dynamic> json) {
    grader = json['grader'];
    gemrateId = json['gemrateId'];
    details = json['details'];
    cardTotalGrades = json['cardTotalGrades'];
    category = json['category'];
    year = json['year'];
    setName = json['setName'];
    setNameRaw = json['setNameRaw'];
    name = json['name'];
    cardNumber = json['cardNumber'];
    parallel = json['parallel'];
    subset = json['subset'];
    awsUrl = json['imageUrl'];
    cardViews = json['cardViews'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grader'] = grader;
    data['gemrateId'] = gemrateId;
    data['details'] = details;
    data['cardTotalGrades'] = cardTotalGrades;
    data['category'] = category;
    data['year'] = year;
    data['setName'] = setName;
    data['setNameRaw'] = setNameRaw;
    data['name'] = name;
    data['cardNumber'] = cardNumber;
    data['parallel'] = parallel;
    data['subset'] = subset;
    data['imageUrl'] = awsUrl;
    data['cardViews'] = cardViews.toString();

    return data;
  }
}
