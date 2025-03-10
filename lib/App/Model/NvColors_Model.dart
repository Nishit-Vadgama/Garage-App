class FColors {
  String? pastle;
  String? red;
  String? green;
  String? shadow;
  String? white;
  String? black;
  String? text;
  String? primary;
  String? grey;

  FColors({
    this.pastle,
    this.red,
    this.green,
    this.shadow,
    this.white,
    this.black,
    this.text,
    this.primary,
    this.grey,
  });

  FColors.fromJson(Map<String, dynamic> json) {
    pastle = json['pastle'];
    red = json['red'];
    green = json['green'];
    shadow = json['shadow'];
    white = json['white'];
    black = json['black'];
    text = json['text'];
    primary = json['primary'];
    grey = json['grey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pastle'] = pastle;
    data['red'] = red;
    data['green'] = green;
    data['shadow'] = shadow;
    data['white'] = white;
    data['black'] = black;
    data['text'] = text;
    data['primary'] = primary;
    data['grey'] = grey;
    return data;
  }
}
