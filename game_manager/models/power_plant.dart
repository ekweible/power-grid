part of game_manager;


class PowerPlant {

    int _consumption;
    int get consumption => _consumption;

    List<String> _materials;
    List<String> get materials => _materials;

    int _production;
    int get production => _production;

    int _value;
    int get value => _value;

    PowerPlant(this._value, this._materials, this._consumption, this._production);
}
