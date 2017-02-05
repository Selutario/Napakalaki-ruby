# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class NumericBadConsequence < BadConsequence
  @@MAXTREASURES = 10
  
  attr_reader :nVisibleTreasures, :nHiddenTreasures
 
  def initialize(t, l, nVisible, nHidden)
    super(t, l)
    @nVisibleTreasures = nVisible
    @nHiddenTreasures = nHidden
  end
  
  def adjustToFitTreasureLists(v, h)
    a_devolver = NumericBadConsequence.new(@text, @levels, 0, 0)
    
    if @nHiddenTreasures > 0
      if h.size < @nHiddenTreasures
        a_devolver.nHiddenTreasures = h.size
      else
        a_devolver.nHiddenTreasures = @nHiddenTreasures
      end
    end
    
    if (@nVisibleTreasures > 0)
      if v.size < @nVisibleTreasures
        a_devolver.nVisibleTreasures = v.size
      else
        a_devolver.nVisibleTreasures = @nVisibleTreasures
      end
    end
    
    return a_devolver
  end
  
  def isEmpty()
    return @nVisibleTreasures == 0 && @nHiddenTreasures == 0
  end
  
  def substractVisibleTreasure(t)
    if @nVisibleTreasures > 0 
      @nVisibleTreasures = @nVisibleTreasures - 1
    end
  end
  
  def substractHiddenTreasures(t)
    if @nHiddenTreasures > 0 
      @nHiddenTreasures = @nHiddenTreasures - 1
    end
  end
  
  def self.MAXTREASURES
    @@MAXTREASURES
  end
  
  def to_s
    super +
   "\nTesoros visibles: #{@nVisibleTreasures}" +
   "\nTesoros ocultos: #{@nHiddenTreasures}"
  end
end
