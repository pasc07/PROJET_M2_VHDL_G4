library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity bp_long is
port( 
	clk, BP: in std_logic ;
	bplong, bpcourt: out std_logic ); -- bp_court
end;

architecture arch of bp_long is 
constant duree : integer := 25000000; --8 == 1s
signal timer: integer := 0;

constant duree2 : integer := 5000; --8 == 
signal timer2: integer := 0;
--machine a etat
type ETAT is (etat_init,etat2, etat3, etat4,etat5);
-- type state is (pas_appui,appui_court, appui_long);
signal etat_present : ETAT := etat_init;
signal etat_suivant : ETAT := etat4;

begin
-- Appui long == n coups d'horloge
-- Bloc F
PROCESS (clk,BP,etat_present,timer) 
begin
if clk'event and clk = '1' then
case etat_present is
	when etat_init => 
		if BP = '0' then --rising_edge(BP) --adapter changer en 1 0 si jamais
		etat_suivant <= etat2 ;
		else
		etat_suivant <= etat_init;
		end if;
	when etat2 => 
		if BP = '1' then
		etat_suivant <= etat4 ;
		--else
		--etat_suivant <= etat2;
		end if;
	when etat3 =>
		if timer2 > duree then
		etat_suivant <= etat_init;
		end if;
	when etat4 =>
		if (timer < duree) then
			etat_suivant <= etat5;
		end if;
		if (timer >= duree) then
			etat_suivant <= etat3 ;
		end if;
	when etat5 =>
		if timer2 > duree then
		etat_suivant <= etat_init;
		end if;
	when others => 
		
end case;
end if;
END PROCESS;

-- Bloc M
PROCESS(clk,etat_suivant) BEGIN

if clk'event and clk = '1' then
	etat_present <= etat_suivant;
end if;
END PROCESS;

-- Bloc G : affection des sortie
PROCESS(clk,etat_present) 
BEGIN
if clk'event and clk = '1' then
	--1
	if etat_present = etat_init then
	--duree := 8;
	bplong <= '0';
	bpcourt <= '0';
	timer2 <= 0;
	end if;
	--2
	if etat_present = etat2 then
		timer <= timer + 1;
	end if;
	--3
	if etat_present = etat3 then
	timer <= 0;
	bpcourt <= '0';
	bplong <= '1'	;
	timer2 <= timer2 +1;
	end if;
	--4
	
	if etat_present = etat5 then
	bplong <= '0'	;
	bpcourt <= '1';
	timer <= 0;
	timer2 <= timer2 +1;
	end if;
end if;
END PROCESS;
end arch;
