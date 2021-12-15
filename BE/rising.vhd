library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity rising is

port( 
	clk, BP: in std_logic ;
	BP_front_montant: out std_logic );
end;

architecture a of rising is 
--machine a etat
type ETAT is (etat1, etat2, etat3, etat4);
-- type state is (pas_appui,appui_court, appui_long);
signal etat_present : ETAT := etat1;
signal etat_suivant : ETAT := etat1;
begin

process(clk) 

begin
if clk'event and clk = '1' then

	case etat_present is 
		when etat1 =>
			if BP = '1' then -- rechanger 0 1 pour front montant
				etat_suivant <= etat2;
			end if;
		when etat2 =>
			if BP = '0' then
				etat_suivant <= etat3;
			else
				etat_suivant <= etat2;
			end if;
		when etat3 =>
				etat_suivant <= etat4;
		when etat4 =>
				etat_suivant <= etat1;
	end case;
	
	-- Affectation
	etat_present <= etat_suivant;
	
	-- Sortie
	if etat_present =  etat2 then
		BP_front_montant <= '0' ;
	end if;
	if etat_present =  etat3 then
		BP_front_montant <= '1' ;
	end if;
	
	if etat_present =  etat4 then
		BP_front_montant <= '0' ;
	end if;
end if;
end process;
end a;