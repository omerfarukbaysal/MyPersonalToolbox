class ToDo {
  int _id;
  String _title;
  bool _isChecked;
  ToDo(this._title, this._isChecked);
  ToDo.withId(this._id, this._title, this._isChecked);

  int get id {
    return _id;
  }

  String get title => _title;
  bool get isChecked => _isChecked;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set isChecked(bool newChecked) {
    this._isChecked = newChecked;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['isChecked'] = _isChecked == true ? 1 : 0;
    return map;
  }

  ToDo.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._isChecked = map['isChecked'] == 1 ? true : false;
  }
}
