library power_grid.src.game_manager.models.power_plant;

class PowerPlant {

  int _consumption;
  List<String> _materials;
  int _production;
  int _value;

  PowerPlant(int this._value, List<String> this._materials,
             int this._consumption, int this._production);

  int get consumption => _consumption;

  List<String> get materials => _materials;

  int get production => _production;

  int get value => _value;

}
