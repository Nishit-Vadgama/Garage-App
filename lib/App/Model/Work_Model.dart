class Work {
  String? workTitle;
  String? workDescription;
  int? itemCost;
  int? serviceCost;

  Work({this.workTitle, this.workDescription, this.itemCost, this.serviceCost});

  Work.fromJson(Map<String, dynamic> json) {
    workTitle = json['workTitle'];
    workDescription = json['workDescription'];
    itemCost = json['workCost'];
    serviceCost = json['serviceCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['workTitle'] = workTitle;
    data['workDescription'] = workDescription;
    data['workCost'] = itemCost;
    data['serviceCost'] = serviceCost;
    return data;
  }
}
