# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "player.rb"

class CultistPlayer < Player
  @@totalCultistPlayers = 0
  
  def initialize(p, c)
    super(p)
    @@totalCultistPlayers = @@totalCultistPlayers + 1
    @myCultistCard = c
  end
  
  def self.totalCultistPlayer
    @@totalCultistPlayers
  end
 
  def getOponentLevel(m)
    m.getCombatLevelAgainstCultistPlayer
  end
  protected :getOponentLevel
  
  def shouldConvert
    false
  end
  protected :shouldConvert
  
  def getCombatLevel
    combatlevel = super() + 0.7 * super()
        
    return combatlevel.round + @myCultistCard.gainedLevels * @@totalCultistPlayers;
  end
  protected :getCombatLevel
  
  def giveMeATreasure
    indice_tesoro = Random.rand(@hiddenTreasures.size - 1)
    tesoro = @visibleTreasures.at(indice_tesoro)
    @visibleTreasures.delete(tesoro)
    
    tesoro
  end
  private :giveMeATreasure
  
  def canYouGiveMeATreasure
    !@enemy.visibleTreasures.isEmpty
  end
  private :canYouGiveMeATreasure
  
end
