# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#encoding: utf-8

require_relative "treasure_kind.rb"
require_relative "player.rb"

class BadConsequence
  
  attr_reader :text
  attr_reader :levels
  attr_accessor :nVisibleTreasures
  attr_accessor :nHiddenTreasures
  attr_accessor :death
  attr_accessor :specificHiddenTreasures
  attr_accessor :specificVisibleTreasures
  
  def initialize(t, l)
    @text = t
    @levels = l
  end
  protected :initialize
  
     def isEmpty
      raise NotImplementedError.new("Abstract methods are not implemented")
    end
  
    def substractVisibleTreasure(t)
      raise NotImplementedError.new("Abstract methods are not implemented")
    end
  
    def substractHiddenTreasure(t)
      raise NotImplementedError.new("Abstract methods are not implemented")
    end
  
    def adjustToFitTreasureLists(visibleT, hiddenT)
      raise NotImplementedError.new("Abstract methods are not implemented")
    end
  
  def to_s
   "\nTexto: #{@text}" +
   "\nNiveles: #{@levels}"
  end

end
