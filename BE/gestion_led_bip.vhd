library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Gestoin des leds et bips
entity gestion_led_bip is
port( 
	clk, une_fois, deux_fois : in std_logic ;
	out_value: out std_logic ); 
end;

architecture arch of gestion_led_bip is 
signal timer: integer := 0;
signal timer2: integer := 0;
constant duree: integer := 5000000; -- 8
constant duree2: integer := 12500000; -- 12
--machine a etat
type ETAT is (etat0,etat1,etat2, etat3, etat4,etat5, etat6);
-- type state is (pas_appui,appui_court, appui_long);
signal etat_present : ETAT := etat1;
signal etat_suivant : ETAT := etat4;

begin
-- Appui long == n coups d'horloge
-- Bloc F
PROCESS ( clk,une_fois, deux_fois ,etat_present,timer,timer2) 
begin
if clk'event and clk = '1' then
-- F
case etat_present is
	when etat0 =>
		if une_fois = '0' then 
			etat_suivant <= etat0;
		end if;
		if une_fois = '1' then 
			etat_suivant <= etat1;
		end if;
		if deux_fois = '1' then 
			etat_suivant <= etat3;
		end if;
	when etat1 =>
		if timer >= duree then --100ms
			etat_suivant <= etat2;
		end if;
	when etat2 =>
		if une_fois = '0' then 
			etat_suivant <= etat0;
		end if;
	when etat3 =>
		if timer >= duree then --100ms
			etat_suivant <= etat4;
		end if;
	when etat4 =>
		if timer >= duree2 then --250ms
			etat_suivant <= etat5;
		end if;
	when etat5 =>
		if timer2>= duree then --100ms
			etat_suivant <= etat6;
		end if;
	when etat6 =>
		if deux_fois ='0' then --100ms
			etat_suivant <= etat0;
		end if;
end case;

end if;
END PROCESS;

Process(clk) begin
if clk'event and clk ='1' then
etat_present <= etat_suivant;
end if;
end process;

Process(clk) begin
if clk'event and clk ='1' then
	if etat_present = etat0 then
		timer<= 0;
		timer2<= 0;
		out_value <= '0';
	end if;
	
	if etat_present = etat1 then
		out_value <= '1';
		timer <= timer + 1 ;
	end if;
	if etat_present = etat2 then
		out_value <= '0';
	end if;
	
	if etat_present = etat3 then
		out_value <= '1';
		timer <= timer +1;
	end if;
	if etat_present = etat4 then
		out_value <= '0';
		timer <= timer +1 ;
	end if;
	if etat_present = etat5 then
		out_value <= '1';
		timer2 <= timer2 +1 ;
	end if;
	if etat_present = etat6 then
		out_value <= '0';
	end if;
end if;
end process;

end arch;