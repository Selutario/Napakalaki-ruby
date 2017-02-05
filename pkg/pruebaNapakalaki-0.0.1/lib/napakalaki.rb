#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "prize.rb"
require_relative "bad_consequence.rb"
require_relative "monster.rb"
require_relative "treasure_kind.rb"
require_relative "card_dealer.rb"
require_relative "player.rb"
require_relative "treasure.rb"
require "singleton"

class Napakalaki
  include Singleton
  attr_reader :currentMonster, :currentPlayer, :players, :dealer
 
  private
  def initialize
    @dealer = CardDealer.instance    
  end
  
  def initPlayers(names)
    @players = Array.new
    
    for i in 0..(names.size - 1)
      @players << Player.new(names.at(i))
    end
  end
  
  def nextPlayer()
    if @currentPlayer.nil?
      turno = Random.new
      indice = turno.rand(0..(@players.size - 1))
    else
      indice = (@players.index(@currentPlayer) + 1) % @players.size
    end
    
    @currentPlayer = @players.at(indice)
    
    return @currentPlayer
  end
  
  def nextTurnAllowed()
    if @currentPlayer.nil?
      return true
    else
      return @currentPlayer.validState
    end
  end
  
  def setEnemies()
    i = 0
    enemigo = Random.new
    
    while i < @players.size
      indice_enemigo = enemigo.rand(@players.size - 1)
      
      if indice_enemigo != (@players.index i)
        @players.at(i).setEnemy(@players.at(indice_enemigo))
        i += 1
      end
    end
  end
  
  public
  
  def developCombat()
    combatResult = @currentPlayer.combat(@currentMonster)
    @dealer.giveMonsterBack(@currentMonster)
    
    return combatResult
  end
  
  def discardVisibleTreasures(treasures)
    for i in 1..treasures.size
      treasure = treasures.at(i)
      
      @currentPlayer.discardVisibleTreasure(treasure)
      @dealer.giveTreasreBack(treasure)
    end
  end
  
  def discardHiddenTreasures(treasures)
    for i in 0..(treasures.size - 1)
      @currentPlayer.discardVisibleTreasure(treasures.at(i))
    end
  end
  
  def makeTreasuresVisible(treasures)
    for i in 0..(treasures.size - 1)
      t = treasures.at(i)
      @currentPlayer.makeTreasureVisible(t)
    end
  end
  
  def initGame(players)
    initPlayers(players)
    setEnemies
        @dealer.initCards
    nextTurn
  end
  
  def nextTurn()
    stateOK = nextTurnAllowed
    
    if stateOK
      @currentMonster = @dealer.nextMonster
      @currentPlayer = nextPlayer
      dead = @currentPlayer.dead
      
      if dead
        @currentPlayer.initTreasures
        
      end
    end
    
    return stateOK
  end
  
  def endOfGame(result)
    return result == CombatResult::WINGAME
  end
  
end