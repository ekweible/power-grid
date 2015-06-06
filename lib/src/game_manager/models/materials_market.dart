library power_grid.src.game_manager.models.materials_market;

class MaterialsMarket {

  int _numPlayers;

  Map<String, int> _materialNameMap;

  MaterialsMarket(int this._numPlayers) {
    // TODO should these starting values be determined here?
    _materialNameMap = {
      'coal': 24,
      'oil': 18,
      'garbage': 6,
      'uranium': 2
    };
  }

  int get coal => _materialNameMap['coal'];

  int get oil => _materialNameMap['oil'];

  int get garbage => _materialNameMap['garbage'];

  int get uranium => _materialNameMap['uranium'];

  /**
   * Returns cost of purchase
   */
  int buyMaterials(String materialName, int amount) {
    int remaining = _materialNameMap[materialName];
    if (remaining < amount) {
      throw new InsufficientMarketSupplyError(materialName, amount, remaining);
    }

    int totalCost = _recursivelyPriceMaterials(remaining, amount);
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
    _materialNameMap['coal'] += _coalReplenishingMatrix[_numPlayers][currentStep];
    _materialNameMap['oil'] += _oilReplenishingMatrix[_numPlayers][currentStep];
    _materialNameMap['garbage'] += _garbageReplenishingMatrix[_numPlayers][currentStep];
    _materialNameMap['uranium'] += _uraniumReplenishingMatrix[_numPlayers][currentStep];
  }

}

// Replenishing matrices
// numPlayers: currentStep: replenishAmount
Map<int, Map<int, int>> _coalReplenishingMatrix = {
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

Map<int, Map<int, int>> _oilReplenishingMatrix = {
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

Map<int, Map<int, int>> _garbageReplenishingMatrix = {
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

Map<int, Map<int, int>> _uraniumReplenishingMatrix = {
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

class InsufficientMarketSupplyError extends StateError {
  InsufficientMarketSupplyError(String type, int desired, int remaining) : super('Attempted to buy $desired $type but there is only $remaining remaining.');
}
