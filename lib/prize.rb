# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
#encoding: utf-8

class Prize
    
  attr_reader :treasures
  attr_reader :levels
  
  def initialize(t, l)
    @treasures = t
    @levels = l
  end
   
  def to_s
    "Tesoros ganados: #{@treasures}\nNiveles ganados: #{@levels}"
  end
  
end
