class Work {
  String? workTitle;
  String? workDescription;

  Work({this.workTitle, this.workDescription});

  Work.fromJson(Map<String, dynamic> json) {
    workTitle = json['workTitle'];
    workDescription = json['workDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['workTitle'] = workTitle;
    data['workDescription'] = workDescription;
    return data;
  }
}
