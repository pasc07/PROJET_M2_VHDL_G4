-- Modele d'un BCD
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;
-------------------------------------------------
entity compteur is
	port (clock, opt24, enable, init12 : in  std_logic;
		  BCDu : out std_logic_vector (3 downto 0);
		  BCDd : out std_logic_vector (3 downto 0));
end compteur;
-------------------------------------------------
architecture synthetisable of compteur is
	signal u : std_logic_vector (3 downto 0);
	signal d : std_logic_vector (3 downto 0);
begin
	
-- Sequentielle BCDu BCDd
	PROCESS(clock, init12) 
	variable cpt : integer range 0 to 24 := 12;
	variable cpt_temp : integer range 0 to 24 := 12;
	variable temp : integer range 0 to 24 ;
	--variable temp2 : integer range 0 to 24 ;
	variable init : integer range 0 to 1;

	BEGIN
		if clock'event and clock = '1' then
			if enable = '1' then
				if cpt_temp = 23 then
					cpt_temp := 0;
				else
					cpt_temp := cpt_temp + 1;
				end if;
				--
				if opt24 = '1' then
					cpt_temp := cpt;
				else
					if cpt_temp > 12 then
						cpt := cpt_temp - 12;
						if cpt < 0 then
							cpt := -cpt;
						end if;
					end if;
				end if;
			else
				cpt := cpt;
			end if;
			
			if init12 = '1' then
				cpt_temp := 12;
				cpt := cpt_temp;
			end if;
		temp := cpt MOD 10;
		u <= std_logic_vector(to_unsigned(temp, u'length));
		temp := (cpt - temp) / 10;
		d <= std_logic_vector(to_unsigned(temp, d'length));
		end if;
	END PROCESS;
	BCDu <= d;
	BCDd <= u;
	
end architecture synthetisable;
-------------------------------------------------
