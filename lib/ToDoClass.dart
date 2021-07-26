class ToDo {
  int _id;
  String _title;
  bool _isChecked;
  //This is Optioanl Position Paremeter if {} This is Optional Named Parameter
  ToDo(this._title, this._isChecked);
  //This is during editing(Called with Id)
  ToDo.withId(this._id, this._title, this._isChecked);

//All the Getters(Controls the Data Asked By another method from this Class)
  int get id {
    return _id;
  }

  String get title => _title;
  bool get isChecked => _isChecked;

//These are all the Setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set isChecked(bool newChecked) {
    this._isChecked = newChecked;
  }

//Used to Save and Retrive from the Database
//Converting the ToDo Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database
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
