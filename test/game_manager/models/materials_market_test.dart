library power_grid.test.game_manager.models.test_materials_market;

import 'package:test/test.dart';

import 'package:power_grid/src/game_manager/models/materials_market.dart';

void main() {

  group('MaterialsMarket', () {
    test('should begin with correct number of materials', () {
      MaterialsMarket market = new MaterialsMarket(4);
      expect(market.coal, equals(24));
      expect(market.oil, equals(18));
      expect(market.garbage, equals(6));
      expect(market.uranium, equals(2));
    });

    group('#buyMaterials', () {
      MaterialsMarket market;

      setUp(() {
        market = new MaterialsMarket(6);
      });

      test('should throw InsufficientMarketSupplyError when there are not enough resources', () {
        expect(market.buyMaterials('uranium', 3), throwsA(new isInstanceOf<InsufficientMarketSupplyError>()));
      });

      test('should decrement supply numbers by the amount bought', () {
        market.buyMaterials('coal', 1);
        expect(market.coal, equals(23));

        market.buyMaterials('oil', 3);
        expect(market.oil, equals(15));

        market.buyMaterials('garbage', 4);
        expect(market.garbage, equals(2));

        market.buyMaterials('uranium', 2);
        expect(market.uranium, equals(0));
      });

      group('should return the correct cost: ', () {
        test('1 coal while coal is in 1s', () {
          expect(market.buyMaterials('coal', 1), equals(1));
        });

        test('1 oil while oil is in 3s', () {
          expect(market.buyMaterials('oil', 1), equals(3));
        });

        test('1 garbage while garbage is in 7s', () {
          expect(market.buyMaterials('garbage', 1), equals(7));

        });

        test('1 uranium while uranium is in 14', () {
          expect(market.buyMaterials('uranium', 1), equals(14));
        });

        test('4 coal', () {
          expect(market.buyMaterials('coal', 4), equals(5));
        });

        test('4 oil', () {
          expect(market.buyMaterials('oil', 4), equals(13));
        });

        test('4 garbage', () {
          expect(market.buyMaterials('garbage', 4), equals(29));
        });

        test('all coal', () {
          expect(market.buyMaterials('coal', 24), equals(108));
        });

        test('all oil', () {
          expect(market.buyMaterials('oil', 18), equals(99));
        });

        test('all garbage', () {
          expect(market.buyMaterials('garbage', 6), equals(45));
        });
      });
    });

    group('#replenishMaterials', () {
      MaterialsMarket market;

      setUp(() {
        market = new MaterialsMarket(6);
      });

      test('should correctly replenish materials in step 1', () {
        market.buyMaterials('coal', 8);
        market.buyMaterials('oil', 2);
        market.replenishMaterials(1);

        expect(market.coal, equals(23));
        expect(market.oil, equals(21));
        expect(market.garbage, equals(9));
        expect(market.uranium, equals(4));
      });
    });

  });

}