class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        update_brie_quality(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_quality(item)
      when 'Conjured'
        update_conjured_quality(item)
      else
        update_normal_quality(item)
      end
      item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"      
    end
  end
  
  private 

  def update_brie_quality(item)
    item.quality += 1 if item.quality < 50
    if item.quality < 50 && item.sell_in <= 0
      item.quality += 1
    end
  end

  def update_normal_quality(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'
    item.quality -= 1 unless item.quality == 0
    if item.sell_in <= 0 && item.quality != 0
      item.quality -= 1
    end
  end

  def update_backstage_quality(item)
    item.quality += 1
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1 if item.sell_in <= 5
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.sell_in <= 0
  end

  def update_conjured_quality(item)
    item.quality -= 2
    item.quality -= 2 if item.sell_in <= 0
    item.quality = 0 if item.quality < 0
  end
end
  
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
