library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ent_add1 is

port( 
	--CLK: in std_logic;
	A: in std_logic ;
	B: in std_logic ;
	Cin: in std_logic ;
	
	Cout: out std_logic ;
	S: out std_logic  );
end;

architecture arch_add1 of ent_add1 is
begin
-- mise en oeuvre de l'architecture de l'addit
S <= (A xor B )xor Cin;
Cout <= (A and Cin) or (B and Cin) or (A and B);

end arch_add1;

