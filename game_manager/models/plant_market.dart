part of game_manager;


class PlantMarket {

    int _currentStep;
    set currentStep(int step) {
        _currentStep = step;
        if (_currentStep == 3) {
            _entireMarket = _entireMarket.sublist(0, 5);
        }
    }

    List<PowerPlant> _entireMarket;

    List<PowerPlant> get currentMarket {
        if (_currentStep == 3) {
            return _entireMarket;
        }
        else {
            return _entireMarket.sublist(0, 3);
        }
    }

    List<PowerPlant> get futureMarket {
        if (_currentStep == 3) {
            return [];
        }
        else {
            return _entireMarket.sublist(4);
        }
    }

    PlantMarket(List<PowerPlant> currentMarket, List<PowerPlant> futureMarket) {
        _currentStep = 1;
        _entireMarket.addAll(currentMarket);
        _entireMarket.addAll(futureMarket);
        _sortMarket();
    }

    void addPowerPlant(PowerPlant plantToAdd) {
        _entireMarket.add(plantToAdd);
        _sortMarket();
    }

    void removePowerPlant(PowerPlant plantToRemove) {
        _entireMarket.remove(plantToRemove);
        _sortMarket();
    }

    void _sortMarket() {
        _entireMarket.sort((PowerPlant a, PowerPlant b) {
            if (a.value > b.value) {
                return 1;
            } else {
                return -1;
            }
        });
    }
}
