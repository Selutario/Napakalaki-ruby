# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class DeathBadConsequence < NumericBadConsequence
  attr_reader :death
  
  def initialize(t, death)
    super(t, Player.MAXLEVEL, @@MAXTREASURES, @@MAXTREASURES)
    @death = death
  end
  
  def to_s
   super + "\nMuerto: #{@death}"
  end
end
