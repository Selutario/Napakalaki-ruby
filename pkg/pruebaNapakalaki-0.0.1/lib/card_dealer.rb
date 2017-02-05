#encoding: utf-8
#
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative "prize.rb"
require_relative "bad_consequence.rb"
require_relative "monster.rb"
require_relative "treasure_kind.rb"
require_relative "treasure.rb"
require "singleton"

class CardDealer
  include Singleton
  
  attr_accessor :used_monsters
  attr_accessor :unused_monsters
  attr_accessor :used_treasures
  attr_accessor :unused_treasures
  
  
  def initTreasureCardDeck()
    @unusedTreasures = Array.new
    @usedTreasures = Array.new
    
    @unusedTreasures << Treasure.new("Sí mi amo!", 4, [TreasureKind::HELMET])
    @unusedTreasures << Treasure.new("Botas de investigación", 3,[TreasureKind::SHOES])
    @unusedTreasures << Treasure.new("Capucha de Cthulhu", 3, [TreasureKind::HELMET])
    @unusedTreasures << Treasure.new("A prueba de babas", 2, [TreasureKind::ARMOR]) 
    @unusedTreasures << Treasure.new("Botas de lluvia ácida",1, [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Casco minero", 2, [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Ametralladora ACME", 4, [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Camiseta de la ETSIIT", 1, [TreasureKind::ARMOR]) 
    @unusedTreasures << Treasure.new("Clavo de rail ferroviario", 3,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Cuchillo de sushi arcano", 2,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Fez alópodo", 3, [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Hacha prehistórica", 2,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("El aparato del Pr. Tesla", 4,  [TreasureKind::ARMOR]) 
    @unusedTreasures << Treasure.new("Gaita", 4,  [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Insecticida", 2,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Escopeta de 3 cañones", 4,  [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Garabato Mistico", 2,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("La rebeca metálica",2,  [TreasureKind::ARMOR]) 
    @unusedTreasures << Treasure.new("Lanzallamas", 4,  [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Necro-comicón", 1, [TreasureKind::ONEHAND]) 
    @unusedTreasures << Treasure.new("Necronomicón", 5,  [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Linterna a 2 manos", 3,  [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Necro-gnomicón", 2,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Necrotelecom", 2, [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Mazo de los antiguos", 3,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Necro-playboycon", 3,   [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Porra preternatural", 2,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Shogulador", 1,  [TreasureKind::BOTHHANDS]) 
    @unusedTreasures << Treasure.new("Varita de atizamiento", 3,  [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Tentáculo de pega", 2, [TreasureKind::HELMET]) 
    @unusedTreasures << Treasure.new("Zapato deja-amigos", 1, [TreasureKind::SHOES]) 

  end
  
  def initMonsterCardDeck()
    @unusedMonsters = Array.new
    @usedMonsters = Array.new
    
    # 1º Monstruo
    prize = Prize.new(2,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Pierdes tu armadura visible y otra oculta",0,[TreasureKind::ARMOR],[TreasureKind::ARMOR])
    @unusedMonsters << Monster.new("3 Byakhees de bonanza",8,prize,badcon)

    # 2º Monstruo
    prize = Prize.new(1,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Embobados con el lindo primigenio te descartas de tu casco visible",0,[TreasureKind::HELMET],[])
    @unusedMonsters << Monster.new("Tecnochtitlan",2, prize, badcon)

    # 3º Monstruo 
    prize = Prize.new(1,1)
    badcon = BadConsequence.newLevelSpecificTreasures("El primordial bostezo contagioso. Pierdes el calzado visible",0,[TreasureKind::SHOES],[])
    @unusedMonsters << Monster.new("El sopor de Dunwich",2,prize,badcon)

    # 4º Monstruo - Demonios de Magaluf
    prize = Prize.new(4,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Te atrapan para llevarte de fiesta y te dejan
     caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta",0,[TreasureKind::ONEHAND],[TreasureKind::ONEHAND])
    @unusedMonsters << Monster.new("Demonios de Magaluf",2,prize,badcon)

    # 5º Monstruo - El gorrón en el umbral
    prize = Prize.new(3,1)
    badcon = BadConsequence.newLevelNumberOfTreasures("Pierdes todos tus tesoros visibles",0,BadConsequence.MAXTREASURES,0) 
    @unusedMonsters << Monster.new("El gorron del umbral",13,prize,badcon)

    # 6º Monstruo - H.P.Munchcraft
    prize = Prize.new(2,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Pierdes la armadura visible",0,[TreasureKind::ARMOR],[])
    @unusedMonsters << Monster.new("H.P.Munchcraft",6,prize, badcon)

    # 7º Monstruo - Necrófago
    prize = Prize.new(1,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Sientes bichos bajo la
    ropa. Descarta la armadura visible",0,[TreasureKind::ARMOR],[])
    @unusedMonsters << Monster.new("Necrofago",13,prize, badcon)

    # 8º Monstruo - El rey de rosa
    prize = Prize.new(4,2)
    badcon = BadConsequence.newLevelNumberOfTreasures("Pierdes 5 niveles y 3
    tesoros visibles",5 , 3, 0)
    @unusedMonsters << Monster.new("El rey de rosa",13,prize,badcon)

    # 9º Monstruo - Flecher
    prize = Prize.new(1,1)
    badcon = BadConsequence.newLevelNumberOfTreasures("Toses los pulmones y
    pierdes 2 niveles.",2 , 0, 0)
    @unusedMonsters << Monster.new("Flecher",2,prize,badcon)

    # 10º Monstruo - Los hondos
    prize = Prize.new(2,1)
    badcon = BadConsequence.newDeath("Estos monstruos resultan
    bastante superficiales y te aburren mortalmente. Estas muerto",true)
    @unusedMonsters << Monster.new("Los hondos",8,prize,badcon)

    # 11º Monstruo - Semillas Cthulhu
    prize = Prize.new(2,1)
    badcon = BadConsequence.newLevelNumberOfTreasures("Pierdes 2 niveles y 2 tesoros ocultos", 2,0,2)
    @unusedMonsters << Monster.new("Semillas Cthulhu", 4, prize, badcon)

    # 12º Monstruo - Dameargo
    prize=Prize.new(2,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Te intentas escaquear. Pierdes una mano visible",0, [TreasureKind::ONEHAND], [])
    @unusedMonsters << Monster.new("Dameargo",1,prize,badcon)

    # 13º Monstruo - Pollipoliop volante
    prize =Prize.new(2,1)
    badcon = BadConsequence.newLevelNumberOfTreasures("Da mucho asquito. ",3,0,0)
    @unusedMonsters << Monster.new("Pollipolipo volante",3,prize,badcon)

    # 14º Monstruo - Yskhtihyssg-Goth
    prize = Prize.new(3,1)
    badcon = BadConsequence.newDeath("No le hace gracia que pronuncien mal su nombre. Estas muerto",true)
    @unusedMonsters << Monster.new("Yskhtihyssg-Goth",14,prize, badcon)

    # 15º Monstruo - Familia Feliz
    prize = Prize.new(3,1)
    badcon = BadConsequence.newDeath("La familia te atrapa. Estas muerto",true)
    @unusedMonsters << Monster.new("Familia feliz",1,prize, badcon)

    # 16º Monstruo - Roboggoth
    prize = Prize.new(2,1)
    badcon = BadConsequence.newLevelSpecificTreasures("La quinta directiva te obliga a perder 2 niveles y un tesoro 2 manos visible",2, [TreasureKind::BOTHHANDS], [])
    @unusedMonsters << Monster.new("Robbogoth", 8, prize, badcon)

    # 17º Monstruo - El espia sordo
    prize= Prize.new(1,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Te asusta en la noche. Pierdes un casco visible",0,[TreasureKind::HELMET], [])
    @unusedMonsters << Monster.new("El espia sordo",5,prize,badcon)

    # 18º Monstruo - Tongue
    prize = Prize.new(2,1)
    badcon = BadConsequence.newLevelNumberOfTreasures("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles",2,5,0)
    @unusedMonsters << Monster.new("Tongue",19,prize,badcon)

    # 19º Monstruo - Bicefalo
    prize = Prize.new(2,1)
    badcon = BadConsequence.newLevelSpecificTreasures("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.",3, [TreasureKind::ONEHAND, TreasureKind::ONEHAND, TreasureKind::BOTHHANDS], 0)
    @unusedMonsters << Monster.new("Bicefalo",21,prize,badcon)
  end
  
  def shuffleTreasures()
    @unusedTreasures = @unusedTreasures.shuffle
  end
  
  def shuffleMonsters()
    @unusedMonsters = @unusedMonsters.shuffle
  end
  
  public
 
  def nextTreasure()
    
    if @unusedTreasures.empty?
      for i in 0..@usedTreasures.size 
        @unusedTreasures << @usedTreasures.at(i)
        @usedTreasures.delete(i)
      end
      shuffleTreasures
    end
    
    siguiente_t = @unusedTreasures.at(0)
    @unusedTreasures.delete_at(@unusedTreasures.index(siguiente_t) || @unusedTreasures.length) 
    
    return siguiente_t
  end
  
  def nextMonster()
    
    if @unusedMonsters.empty?
      @unusedMonsters = @usedMonsters
      @usedMonsters = Array.new
      shuffleMonsters
    end
    
    siguiente_m = @unusedMonsters.at(0)
    @unusedMonsters.delete_at(@unusedMonsters.index(siguiente_m) || @unusedMonsters.length) 
    
    return siguiente_m
  end
  
  def giveTreasreBack(t)
    @usedTreasures << t
  end
  
  def giveMonsterBack(m)
    @usedMonsters << m
  end
  
  def initCards()
    self.initTreasureCardDeck
    self.initMonsterCardDeck
    shuffleMonsters
    shuffleTreasures
  end
  
end
