part of game_manager;


class MaterialsMarket {

    int _numPlayers;

    int _coal;
    int get coal => _coal;

    int _oil;
    int get oil => _oil;

    int _garbage;
    int get trash => _garbage;

    int _uranium;
    int get uranium => _uranium;

    Map<String, int> _materialNameMap;

    MaterialsMarket(this._numPlayers) {
        // TODO should these starting values be determined here?
        _coal = 24;
        _oil = 18;
        _garbage = 6;
        _uranium = 2;

        _materialNameMap = {
            'coal': _coal,
            '_oil': _oil,
            '_garbage': _garbage,
            '_uranium': _uranium
        };
    }

    /**
     * Returns cost of purchase
     */
    int buyMaterials(String materialName, int amount) {
        int totalCost = _recursivelyPriceMaterials(_materialNameMap[materialName], amount);
        _materialNameMap[materialName] -= amount;
        return totalCost;
    }

    int _recursivelyPriceMaterials(int materialSupply, int amount) {
        int baseCost = 9 - (materialSupply ~/ 3);
        int remain = materialSupply % 3;

        var cost = 0;
        if (amount == 0) {
            return 0;
        }
        if (remain != 0) {
            cost = remain * (baseCost - 1);
            return _recursivelyPriceMaterials(materialSupply - remain, amount - remain) + cost;
        } else {
            var subAmount = 3;
            if (amount < 3) {
                subAmount = amount;
            }
            cost = subAmount * baseCost;
            return _recursivelyPriceMaterials(materialSupply - subAmount, amount - subAmount) + cost;
        }

    }

    void replenishMaterials(int currentStep) {
        _coal += coalReplenishingMatrix[_numPlayers][currentStep];
        _oil += oilReplenishingMatrix[_numPlayers][currentStep];
        _garbage += garbageReplenishingMatrix[_numPlayers][currentStep];
        _uranium += uraniumReplenishingMatrix[_numPlayers][currentStep];
    }

}

// Replenishing matrices
// numPlayers: currentStep: replenishAmount
Map<int, Map<int, int>> coalReplenishingMatrix = {
    2: {
        1: 3,
        2: 4,
        3: 3,
    },
    3: {
        1: 4,
        2: 5,
        3: 3
    },
    4: {
        1: 5,
        2: 6,
        3: 4
    },
    5: {
        1: 5,
        2: 7,
        3: 5
    },
    6: {
        1: 7,
        2: 9,
        3: 6
    }
};

Map<int, Map<int, int>> oilReplenishingMatrix = {
    2: {
        1: 2,
        2: 2,
        3: 4,
    },
    3: {
        1: 2,
        2: 3,
        3: 4
    },
    4: {
        1: 3,
        2: 4,
        3: 5
    },
    5: {
        1: 4,
        2: 5,
        3: 6
    },
    6: {
        1: 5,
        2: 6,
        3: 7
    }
};

Map<int, Map<int, int>> garbageReplenishingMatrix = {
    2: {
        1: 1,
        2: 2,
        3: 3,
    },
    3: {
        1: 1,
        2: 2,
        3: 3
    },
    4: {
        1: 2,
        2: 3,
        3: 4
    },
    5: {
        1: 3,
        2: 3,
        3: 5
    },
    6: {
        1: 3,
        2: 5,
        3: 6
    }
};

Map<int, Map<int, int>> uraniumReplenishingMatrix = {
    2: {
        1: 1,
        2: 1,
        3: 1,
    },
    3: {
        1: 1,
        2: 1,
        3: 1
    },
    4: {
        1: 1,
        2: 2,
        3: 2
    },
    5: {
        1: 2,
        2: 3,
        3: 2
    },
    6: {
        1: 2,
        2: 3,
        3: 3
    }
};
