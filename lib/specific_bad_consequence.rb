# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class SpecificBadConsequence < BadConsequence
  attr_accessor :specificHiddenTreasures, :specificVisibleTreasures
  
  def initialize(t, l, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
    super(t, l)
    @specificHiddenTreasures = someSpecificHiddenTreasures
    @specificVisibleTreasures = someSpecificVisibleTreasures
  end
  
  def adjustToFitTreasureLists(v, h)
    copiaHidden = @specificHiddenTreasures
    copiaVisible = @specificVisibleTreasures
    a_devolver = SpecificBadConsequence.new(@text, @levels, Array.new, Array.new)
    #a_devolver.death = @death
    
    if @specificHiddenTreasures.size > 0
      for i in 0..(h.size - 1)
        if copiaHidden.include?(h.at(i).type)
          a_devolver.specificHiddenTreasures << h.at(i).type
          copiaHidden.delete_at(copiaHidden.index(h.at(i).type)) 
        end
      end
    end
    
    if @specificVisibleTreasures.size > 0
      for i in 0..(v.size - 1)
        if copiaVisible.include?(v.at(i).type)
          a_devolver.specificVisibleTreasures << v.at(i).type
          copiaVisible.delete_at(copiaVisible.index(v.at(i).type)) 
        end
      end
    end
    
    return a_devolver
  end
  
  def isEmpty()
    return @specificHiddenTreasures.empty? && @specificVisibleTreasures.empty?
  end
  
  def substractVisibleTreasure(t)
    if @specificVisibleTreasures.size > 0
      @specificVisibleTreasures.delete_at( @specificVisibleTreasures.index(t.type) || @specificVisibleTreasures.size )
    end
  end
  
  def substractHiddenTreasures(t)
    if @specificHiddenTreasures.size > 0
      @specificHiddenTreasures.delete_at( @specificHiddenTreasures.index(t.type) || @specificHiddenTreasures.size )
    end
  end
  
  def to_s
   super +
   "\nTesoros ocultos especificos: #{@specificHiddenTreasures}" +
   "\nTesoros visibles especificos: #{@specificVisibleTreasures}"
  end
  
end
