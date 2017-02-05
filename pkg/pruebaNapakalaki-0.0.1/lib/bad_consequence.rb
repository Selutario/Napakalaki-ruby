# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#encoding: utf-8

class BadConsequence
  private_class_method :new
  @@MAXTREASURES = 10
  
  attr_reader :text
  attr_reader :levels
  attr_accessor :nVisibleTreasures
  attr_accessor :nHiddenTreasures
  attr_accessor :death
  attr_accessor :specificHiddenTreasures
  attr_accessor :specificVisibleTreasures
  
  def initialize(t, l, nVisible, nHidden, someSpecificVisibleTreasures, someSpecificHiddenTreasures, death)
    @text = t
    @levels = l
    @nVisibleTreasures = nVisible
    @nHiddenTreasures = nHidden
    @specificHiddenTreasures = someSpecificHiddenTreasures
    @specificVisibleTreasures = someSpecificVisibleTreasures
    @death = death
  end
 
  def self.newLevelNumberOfTreasures (t, l, someVisibleTreasures, someHiddenTreasures)
    new(t, l, someVisibleTreasures, someHiddenTreasures, Array.new, Array.new, false)
  end
  
  def self.newLevelSpecificTreasures (t, l, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
    new(t, l,0,0,someSpecificVisibleTreasures,someSpecificHiddenTreasures, false)
  end
  
  def self.newDeath (t, death)
    new(t,Player.MAXLEVEL,@@MAXTREASURES,@@MAXTREASURES,Array.new,Array.new,death)
  end
  
  def self.MAXTREASURES
    @@MAXTREASURES
  end
  
  def adjustToFitTreasureLists(v, h)
    copiaHidden = @specificHiddenTreasures
    copiaVisible = @specificVisibleTreasures
    a_devolver = BadConsequence.newLevelNumberOfTreasures(@text, @levels, 0, 0)
    a_devolver.death = @death
    
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
    return @nVisibleTreasures == 0 && @nHiddenTreasures == 0 && @specificHiddenTreasures.empty? && @specificVisibleTreasures.empty?
  end
  
  def substractVisibleTreasure(t)
    if @nVisibleTreasures > 0 
      @nVisibleTreasures = @nVisibleTreasures - 1
    else
      if @specificVisibleTreasures.size > 0
        @specificVisibleTreasures.delete_at( @specificVisibleTreasures.index(t.type) || @specificVisibleTreasures.size )
      end
    end
  end
  
  def substractHiddenTreasures(t)
    if @nHiddenTreasures > 0 
      @nHiddenTreasures = @nHiddenTreasures - 1
    else
      if @specificHiddenTreasures.size > 0
        @specificHiddenTreasures.delete_at( @specificHiddenTreasures.index(t.type) || @specificHiddenTreasures.size )
      end
    end
  end
  
  def to_s
   "\nTexto: #{@text}" +
   "\nNiveles: #{@levels}" +
   "\nTesoros visibles: #{@nVisibleTreasures}" +
   "\nTesoros ocultos: #{@nHiddenTreasures}" +
   "\nMuerto: #{@death}"+
   "\nTesoros ocultos especificos: #{@specificHiddenTreasures}" +
   "\nTesoros visibles especificos: #{@specificVisibleTreasures}"
  end

  
end
