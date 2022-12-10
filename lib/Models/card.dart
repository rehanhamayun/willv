// class CardResult {
//   // int? id;
//   String? player;
//   String? numCard;
//   String? setName;
//   String? totals;
//   String? gemCounts;
//   String? gemRates;
//   String? totalGradedPSA;
//   String? totalGradedBGS;
//   String? totalGradedSGC;
//   String? mostCommonGradePSA;
//   String? mostCommonGradeBGS;
//   String? mostCommonGradeSGC;
//   String? gemCountPSA;
//   String? gemCountBGS;
//   String? gemCountSGC;
//   String? gemPercentPSA;
//   String? gemPercentBGS;
//   String? gemPercentSGC;
//   String? sport;

//   CardResult(
//       {
//       // this.id,
//       this.player,
//       this.numCard,
//       this.setName,
//       this.totals,
//       this.gemCounts,
//       this.gemRates,
//       this.totalGradedPSA,
//       this.totalGradedBGS,
//       this.totalGradedSGC,
//       this.mostCommonGradePSA,
//       this.mostCommonGradeBGS,
//       this.mostCommonGradeSGC,
//       this.gemCountPSA,
//       this.gemCountBGS,
//       this.gemCountSGC,
//       this.gemPercentPSA,
//       this.gemPercentBGS,
//       this.gemPercentSGC,
//       this.sport});

//   CardResult.fromJson(Map<String, dynamic> json) {
//     // id = json['id'] ?? 0;
//     player = json['player'] ?? "0";
//     numCard = json['numCard'] ?? "0";
//     setName = json['set'] ?? "0";
//     totals = json['totals'] ?? "0";
//     gemCounts = json['gemCounts'] ?? "0";
//     gemRates = json['gemRates'] ?? "0";
//     totalGradedPSA = json['totalGraded_PSA'] ?? "0";
//     totalGradedBGS = json['totalGraded_BGS'] ?? "0";
//     totalGradedSGC = json['totalGraded_SGC'] ?? "0";
//     mostCommonGradePSA = json['mostCommonGrade_PSA'] ?? "0";
//     mostCommonGradeBGS = json['mostCommonGrade_BGS'] ?? "0";
//     mostCommonGradeSGC = json['mostCommonGrade_SGC'] ?? "0";
//     gemCountPSA = json['gemCount_PSA'] ?? "0";
//     gemCountBGS = json['gemCount_BGS'] ?? "0";
//     gemCountSGC = json['gemCount_SGC'] ?? "0";
//     gemPercentPSA = json['gemPercent_PSA'] ?? "0";
//     gemPercentBGS = json['gemPercent_BGS'] ?? "0";
//     gemPercentSGC = json['gemPercent_SGC'] ?? "0";
//     sport = json['Sport'] ?? "0";
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // data['id'] = id;
//     data['player'] = player;
//     data['numCard'] = numCard;
//     data['set'] = setName;
//     data['totals'] = totals;
//     data['gemCounts'] = gemCounts;
//     data['gemRates'] = gemRates;
//     data['totalGraded_PSA'] = totalGradedPSA;
//     data['totalGraded_BGS'] = totalGradedBGS;
//     data['totalGraded_SGC'] = totalGradedSGC;
//     data['mostCommonGrade_PSA'] = mostCommonGradePSA;
//     data['mostCommonGrade_BGS'] = mostCommonGradeBGS;
//     data['mostCommonGrade_SGC'] = mostCommonGradeSGC;
//     data['gemCount_PSA'] = gemCountPSA;
//     data['gemCount_BGS'] = gemCountBGS;
//     data['gemCount_SGC'] = gemCountSGC;
//     data['gemPercent_PSA'] = gemPercentPSA;
//     data['gemPercent_BGS'] = gemPercentBGS;
//     data['gemPercent_SGC'] = gemPercentSGC;
//     data['Sport'] = sport;
//     return data;
//   }

//   @override
//   String toString() {
//     return " $player,$numCard, $setName,  $totals , $gemCounts, $gemRates, $totalGradedPSA, $totalGradedBGS, $totalGradedSGC, $mostCommonGradePSA, $mostCommonGradeBGS, $mostCommonGradeSGC ";
//   }
// }

class CardResult {
  String? gemrateId;
  String? description;
  String? date;
  List<dynamic>? gradersIncluded;
  int? totalGemsOrGreater;
  int? totalPopulation;
  String? lastPopulationChange;
  List<PopulationData>? populationData;

  CardResult(
      {this.gemrateId,
      this.description,
      this.date,
      this.gradersIncluded,
      this.totalGemsOrGreater,
      this.totalPopulation,
      this.lastPopulationChange,
      this.populationData});

  CardResult.fromJson(Map<String, dynamic> json) {
    gemrateId = json['gemrate_id'] ?? "";
    description = json['description'] ?? "";
    date = json['date'] ?? "";
    gradersIncluded = json['graders_included'] ?? [];
    totalGemsOrGreater = json['total_gems_or_greater'] ?? "";
    totalPopulation = json['total_population'] ?? "";
    lastPopulationChange = json['last_population_change'] ?? "";
    if (json['population_data'] != null) {
      populationData = <PopulationData>[];
      json['population_data'].forEach((v) {
        populationData!.add(PopulationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gemrate_id'] = gemrateId;
    data['description'] = description;
    data['date'] = date;
    data['graders_included'] = gradersIncluded;
    data['total_gems_or_greater'] = totalGemsOrGreater;
    data['total_population'] = totalPopulation;
    data['last_population_change'] = lastPopulationChange;
    if (populationData != null) {
      data['population_data'] = populationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopulationData {
  String? gemrateId;
  String? grader;
  bool? popResults;
  String? lastPopulationChange;
  String? category;
  String? year;
  String? setName;
  String? name;
  String? parallel;
  String? cardNumber;
  String? setUrl;
  GradesJson? gradesJson;
  HalvesJson? halvesJson;
  QualifiersJson? qualifiersJson;
  int? cardTotalGrades;
  int? cardGems;
  String? cardGemRate;

  PopulationData(
      {this.gemrateId,
      this.grader,
      this.popResults,
      this.lastPopulationChange,
      this.category,
      this.year,
      this.setName,
      this.name,
      this.parallel,
      this.cardNumber,
      this.setUrl,
      this.gradesJson,
      this.halvesJson,
      this.qualifiersJson,
      this.cardTotalGrades,
      this.cardGems,
      this.cardGemRate});

  PopulationData.fromJson(Map<String, dynamic> json) {
    gemrateId = json['gemrate_id'] ?? "";
    grader = json['grader'] ?? "";
    popResults = json['pop_results'] ?? "";
    lastPopulationChange = json['last_population_change'] ?? "";
    category = json['category'] ?? "";
    year = json['year'] ?? "";
    setName = json['set_name'] ?? "";
    name = json['name'] ?? "";
    parallel = json['parallel'] ?? "";
    cardNumber = json['card_number'] ?? "";
    setUrl = json['set_url'] ?? "";
    gradesJson = json['grades_json'] != null
        ? GradesJson.fromJson(json['grades_json'])
        : null;
    halvesJson = json['halves_json'] != null
        ? HalvesJson.fromJson(json['halves_json'])
        : null;
    qualifiersJson = json['qualifiers_json'] != null
        ? QualifiersJson.fromJson(json['qualifiers_json'])
        : null;
    cardTotalGrades = json['card_total_grades'] ?? "";
    cardGems = json['card_gems'] ?? "";
    cardGemRate = json['card_gem_rate'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gemrate_id'] = gemrateId;
    data['grader'] = grader;
    data['pop_results'] = popResults;
    data['last_population_change'] = lastPopulationChange;
    data['category'] = category;
    data['year'] = year;
    data['set_name'] = setName;
    data['name'] = name;
    data['parallel'] = parallel;
    data['card_number'] = cardNumber;
    data['set_url'] = setUrl;
    if (gradesJson != null) {
      data['grades_json'] = gradesJson!.toJson();
    }
    if (halvesJson != null) {
      data['halves_json'] = halvesJson!.toJson();
    }
    if (qualifiersJson != null) {
      data['qualifiers_json'] = qualifiersJson!.toJson();
    }
    data['card_total_grades'] = cardTotalGrades;
    data['card_gems'] = cardGems;
    data['card_gem_rate'] = cardGemRate;
    return data;
  }
}

class GradesJson {
  int? auth;
  int? g1;
  int? g10;
  int? g2;
  int? g3;
  int? g4;
  int? g5;
  int? g6;
  int? g7;
  int? g8;
  int? g9;
  int? g10b;
  int? g10p;
  int? g15;
  int? g25;
  int? g35;
  int? g45;
  int? g55;
  int? g65;
  int? g75;
  int? g85;
  int? g95;
  int? gA;
  int? g10Perfect;

  GradesJson(
      {this.auth,
      this.g1,
      this.g10,
      this.g2,
      this.g3,
      this.g4,
      this.g5,
      this.g6,
      this.g7,
      this.g8,
      this.g9,
      this.g10b,
      this.g10p,
      this.g15,
      this.g25,
      this.g35,
      this.g45,
      this.g55,
      this.g65,
      this.g75,
      this.g85,
      this.g95,
      this.gA,
      this.g10Perfect});

  GradesJson.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    g1 = json['g1'];
    g10 = json['g10'];
    g2 = json['g2'];
    g3 = json['g3'];
    g4 = json['g4'];
    g5 = json['g5'];
    g6 = json['g6'];
    g7 = json['g7'];
    g8 = json['g8'];
    g9 = json['g9'];
    g10b = json['g10b'];
    g10p = json['g10p'];
    g15 = json['g1_5'];
    g25 = json['g2_5'];
    g35 = json['g3_5'];
    g45 = json['g4_5'];
    g55 = json['g5_5'];
    g65 = json['g6_5'];
    g75 = json['g7_5'];
    g85 = json['g8_5'];
    g95 = json['g9_5'];
    gA = json['gA'];
    g10 = json['G10'];
    g10Perfect = json['G10Perfect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth'] = auth;
    data['g1'] = g1;
    data['g10'] = g10;
    data['g2'] = g2;
    data['g3'] = g3;
    data['g4'] = g4;
    data['g5'] = g5;
    data['g6'] = g6;
    data['g7'] = g7;
    data['g8'] = g8;
    data['g9'] = g9;
    data['g10b'] = g10b;
    data['g10p'] = g10p;
    data['g1_5'] = g15;
    data['g2_5'] = g25;
    data['g3_5'] = g35;
    data['g4_5'] = g45;
    data['g5_5'] = g55;
    data['g6_5'] = g65;
    data['g7_5'] = g75;
    data['g8_5'] = g85;
    data['g9_5'] = g95;
    data['gA'] = gA;
    data['G10'] = g10;
    data['G10Perfect'] = g10Perfect;
    return data;
  }
}

class HalvesJson {
  int? g15;
  int? g25;
  int? g35;
  int? g45;
  int? g55;
  int? g65;
  int? g75;
  int? g85;

  HalvesJson(
      {this.g15,
      this.g25,
      this.g35,
      this.g45,
      this.g55,
      this.g65,
      this.g75,
      this.g85});

  HalvesJson.fromJson(Map<String, dynamic> json) {
    g15 = json['g1_5'];
    g25 = json['g2_5'];
    g35 = json['g3_5'];
    g45 = json['g4_5'];
    g55 = json['g5_5'];
    g65 = json['g6_5'];
    g75 = json['g7_5'];
    g85 = json['g8_5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['g1_5'] = g15;
    data['g2_5'] = g25;
    data['g3_5'] = g35;
    data['g4_5'] = g45;
    data['g5_5'] = g55;
    data['g6_5'] = g65;
    data['g7_5'] = g75;
    data['g8_5'] = g85;
    return data;
  }
}

class QualifiersJson {
  int? g3;
  int? g5;
  int? g7;
  int? q1;
  int? q2;
  int? q4;
  int? q6;
  int? q8;

  QualifiersJson(
      {this.g3, this.g5, this.g7, this.q1, this.q2, this.q4, this.q6, this.q8});

  QualifiersJson.fromJson(Map<String, dynamic> json) {
    g3 = json['g3'];
    g5 = json['g5'];
    g7 = json['g7'];
    q1 = json['q1'];
    q2 = json['q2'];
    q4 = json['q4'];
    q6 = json['q6'];
    q8 = json['q8'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['g3'] = g3;
    data['g5'] = g5;
    data['g7'] = g7;
    data['q1'] = q1;
    data['q2'] = q2;
    data['q4'] = q4;
    data['q6'] = q6;
    data['q8'] = q8;
    return data;
  }
}
