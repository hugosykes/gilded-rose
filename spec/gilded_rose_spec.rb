require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do

  describe '#to_s' do
    it "Should print out the string version of the item's information" do
      items = [Item.new("Normal item", 10, 5)]
      GildedRose.new(items).update_quality()
      expect(items[0].to_s).to eq "Normal item, 9, 4"
    end
  end

  describe "#update_quality" do

    describe 'Normal items' do
      it "quality should decrease each day" do
        items = [Item.new("Normal item", 10, 5)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
      end

      it "quality should decrease twice as fast after sellin date" do
        items = [Item.new("Normal item", 0, 5)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "quality should decrease twice as fast long after sellin date" do
        items = [Item.new("Normal item", -3, 5)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "quality should never be below 0, 1" do
        items = [Item.new("Normal item", -3, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "quality should never be below 0, 2" do
        items = [Item.new("Normal item", 1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "quality should never be below 0, 3" do
        items = [Item.new("Normal item", -3, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "sell in should decrease" do
        items = [Item.new("Normal item", 1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end
    end

    describe 'Aged Brie' do
      it "quality should increase each day" do
        items = [Item.new("Aged Brie", 1, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "quality should increase double each day after sellin" do
        items = [Item.new("Aged Brie", 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "quality should reach 50" do
        items = [Item.new("Aged Brie", 1, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "quality shouldn't be greater than 50" do
        items = [Item.new("Aged Brie", 1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "sell in should decrease" do
        items = [Item.new("Aged Brie", 1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end
    end

    describe 'Sulfuras, Hand of Ragnaros' do
      it "quality shouldn't change, 1" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end

      it "quality shouldn't change, 2" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", -3, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end

      it "sell in date should not decrease" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", -3, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -3
      end
    end

    describe 'Backstage passes to a TAFKAL80ETC concert' do
      it "quality should increase over 10 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 3)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
      end

      it "quality should increase double less than or equal to 10 days, 1" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 3)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 5
      end

      it "quality should increase double less than or equal to 10 days, 2" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 3)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 5
      end

      it "quality should increase triple less than or equal to 5 days, 1" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 3)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end

      it "quality should increase triple less than or equal to 5 days, 2" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 3)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end

      it "quality should go to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 3)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "quality should never go above 50, over 10 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "quality should never go above 50, under 10 days but over 5" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "quality should never go above 50, under 5 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "sell in should decrease" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end
    end
  end
end