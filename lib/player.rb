# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "dice.rb"
require_relative "combat_result.rb"
require_relative "bad_consequence.rb"

class Player
  @@MAXLEVEL = 10
  
  attr_reader :name, :level, :dead, :canISteal, :visibleTreasures, :hiddenTreasures, :pendingBadConsequence
  attr_accessor :enemy
  
  def self.MAXLEVEL
    @@MAXLEVEL
  end
  
  private
  
  def bringToLife
    @dead = false
  end
  
  def getCombatLevel
    bonus_total = @level
   
    @visibleTreasures.each do |x|
      bonus_total += x.bonus
    end
    
    return bonus_total
  end
  protected :getCombatLevel
  
  def incrementLevels(l)
    @level = @level + l
  end
  
  def decrementLevels(l)
    @level = @level - l
    
    if @level <= 0
      @level = 1
    end
  end
  
  def setPendingBadConsequence(b)
    @pendingBadConsequence = b
  end
  
  def applyPrize(m)
    nLevels = m.getLevelsGained
    nTreasures = m.getTreasuresGained
    incrementLevels(nLevels)
    
    if nTreasures > 0
      dealer = CardDealer.instance
      
      for i in 0..nTreasures
        treasure = dealer.nextTreasure
        @hiddenTreasures << treasure
      end
      
    end
  end
  
  def applyBadConsequence(m)
    badConsequence = m.badConsequence
    nLevels = badConsequence.levels
    
    decrementLevels(nLevels)
    pendingBad = badConsequence.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures)
    setPendingBadConsequence(pendingBad)
  end
  
  def canMakeTreasureVisible(t)
    n_onehand = howManyVisibleTreasures(TreasureKind::ONEHAND)
    n_bothhands = howManyVisibleTreasures(TreasureKind::BOTHHANDS)
    canMakeVisible = true
    
    if t.type != TreasureKind::ONEHAND
      for i in 0..(@visibleTreasures.size - 1)
        if t.type == @visibleTreasures.at(i).type
          canMakeVisible = false
          break
        end
      end
    end
    
    if t.type == TreasureKind::ONEHAND && (n_onehand > 1 || n_bothhands != 0)
      canMakeVisible = false
    end
    
    if t.type == TreasureKind::BOTHHANDS && n_onehand != 0
      canMakeVisible = false
    end
    
    return canMakeVisible
  end
  
  def howManyVisibleTreasures(tKind)
    nelementos = 0
    
    @visibleTreasures.each do |x|
      if x.type == tKind
        i += 1
      end
    end
    
    return nelementos
  end
  
  def dieIfNoTreasures
    if @visibleTreasures.empty? && @hiddenTreasures.empty?
      @dead = true
    end
  end
  
  
  def haveStolen()
    @canISteal = false
  end
  
  protected
  
  def giveMeATreasure
    tesoro = nil
    
    if @hiddenTreasures.size != 0
      aleatorio = Random.new
      indice_tesoro = aleatorio.rand(@hiddenTreasures.size)   
      tesoro = @hiddenTreasures.at(indice_tesoro)
      @hiddenTreasures.delete(tesoro)
    end
    
    return tesoro
  end
  
  def canYouGiveMeATreasure
    has_treasures = !@hiddenTreasures.empty?
    
    return has_treasures
  end
  
  public
  
  def initialize(name)
    @name = name
    @level = 1
    @dead = true
    @canISteal = true
    @enemy = nil
    @visibleTreasures = Array.new
    @hiddenTreasures = Array.new
    @pendingBadConsequence = nil
  end
  
  def self.PlayerCopia(p)
    @name = p.name
    @level = p.level
    @dead = p.dead
    @canISteal = p.canISteal
    @enemy = p.enemy
    @visibleTreasures = p.visibleTreasures
    @hiddenTreasures = p.hiddenTreasures
    @pendingBadConsequence = p.pendingBadConsequence
  end
  
  def combat(m)
    myLevel = getCombatLevel
    monsterLevel = getOponentLevel(m)
    
    if(!@canISteal)
      dice = Dice.instance
      number = dice.nextNumber
      
      if(number < 3)
        monsterLevel += @enemy.level
      end
    end
    
    if myLevel > monsterLevel
      applyPrize(m)
      
      if @level >= @@MAXLEVEL
        combatResult = CombatResult::WINGAME
      else
        combatResult = CombatResult::WIN
      end
      
    else
      applyBadConsequence(m)
      
      if shouldConvert
        combatResult = CombatResult::LOSEANDCONVERT
      else
        combatResult = CombatResult::LOSE
      end
    end
    
    return combatResult
  end
  
  def makeTreasureVisible(t)
    canI = canMakeTreasureVisible(t)
    
    if canI
      @visibleTreasures << t
      @hiddenTreasures.delete(t)
    end
  end
  
  def discardVisibleTreasure(t)
    @visibleTreasures.delete_at(@visibleTreasures.index(t) || @visibleTreasures.size)
    
    if !@pendingBadConsequence.nil? && !@pendingBadConsequence.isEmpty
      @pendingBadConsequence.substractVisibleTreasure(t)
    end
    
    dieIfNoTreasures
  end
  
  def discardHiddenTreasure(t)
    @hiddenTreasures.delete_at(@hiddenTreasures.index(t) || @hiddenTreasures.size)
    
    if !@pendingBadConsequence.nil? && !@pendingBadConsequence.isEmpty
      @pendingBadConsequence.substractHiddenTreasure(t)
    end
    
    dieIfNoTreasures
  end
  
  def validState
    valido = true
    
    if !@pendingBadConsequence.nil?
      valido = @pendingBadConsequence.isEmpty &&  @hiddenTreasures.length <= 4
    end
    
    return valido
  end
  
  def initTreasures
    dealer = CardDealer.instance
    dice = Dice.instance
    bringToLife
    
    treasure = dealer.nextTreasure
    @hiddenTreasures << treasure
    number = dice.nextNumber
    
    if number > 1
      treasure = dealer.nextTreasure
      @hiddenTreasures << treasure
    end
    
    if number == 6
      treasure = dealer.nextTreasure
      @hiddenTreasures << treasure
    end
  end
  
  def stealTreasure
    canI = @canISteal
    
    if canI
      canYou = @enemy.canYouGiveMeATreasure
      
      if(canYou)
        treasure = @enemy.giveMeATreasure
        @hiddenTreasures << treasure
        haveStolen
      end
    end
    
    return treasure
  end
  
  def setEnemy(enemy)
    @enemy = enemy
  end
  
  def canISteal()
    return @canISteal
  end
  
  def discardAllTreasures
    
    visibleCopy = Array.new(@visibleTreasures)
    hiddenCopy = Array.new(@hiddenTreasures)
    
    for i in 0..(visibleCopy.size - 1)
      treasure = visibleCopy.at(i)
      self.discardVisibleTreasure(treasure)
    end
    
    for i in 0..(hiddenCopy.size - 1)
      treasure = hiddenCopy.at(i)
      self.discardHiddenTreasure(treasure)
    end
  end
  
  def getOponentLevel(m)
    m.combatLevel
  end
  protected :getOponentLevel
  
  def shouldConvert
    dice = Dice.instance
    number = dice.nextNumber
    
    return number == 6
  end
  protected :shouldConvert
  
  def to_s
    "Nombre: #{@name}"
  end
  
end
