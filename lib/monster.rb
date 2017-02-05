# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#encoding: utf-8

require_relative "prize.rb"
require_relative "bad_consequence.rb"

class Monster
  
  attr_reader :name
  attr_reader :combatLevel
  attr_reader :badConsequence
  attr_reader :prize
  attr_reader :levelChangeAgainstCultistPlayer
  
  def initialize(n, l, p, b, lC = 0)
    @name = n
    @combatLevel = l
    @prize = p
    @badConsequence = b
    @levelChangeAgainstCultistPlayer = lC
  end
  
  def getLevelsGained()
    return @prize.levels
  end
  
  def getTreasuresGained()
    return @prize.levels
  end
  
  def getCombatLevelAgainstCultistPlayer
    suma = @combatLevel + @levelChangeAgainstCultistPlayer
    suma
  end
  
  def to_s
    "\n ----------------------- \nNombre: #{@name}\nNivel de combate: #{@combatLevel}\nBuen rollo: #{@Prize}\nMal rollo: #{@badConsequence}"
  end
end
