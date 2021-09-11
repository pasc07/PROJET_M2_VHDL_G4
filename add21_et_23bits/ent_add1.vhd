library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--Debut de declaration de l'entite
entity ent_add1 is
port( 
	--Entrée logique
	A: in std_logic ;
	B: in std_logic ;
	Cin: in std_logic ;
	--Sortie logique
	Cout: out std_logic ;
	S: out std_logic  );
end;
--Fin de declaration de l'entite

--Début de la desciption de l'archictecture
architecture arch_add1 of ent_add1 is
begin
-- mise en oeuvre de l'architecture de l'additionneur 2x1 bit
--Par des équation
S <= (A xor B )xor Cin;
Cout <= (A and Cin) or (B and Cin) or (A and B);
end arch_add1;

--Fin de la desciption de l'archictecture
