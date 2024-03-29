library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity bcd7seg is

port( 
	-- Vector
	E3E2E1E0 : std_logic_vector(3 downto 0);
	
	a,b,c,d,e,f,g: out std_logic );
	
end;

architecture arch_bcd7seg of bcd7seg is
signal segment: std_logic_vector(6 downto 0);
--segment = 'abcdefg'
begin
--Architecture de l'afficheur
 with E3E2E1E0 select
	segment <= 	"0000001" when "0000",--0
			"1001111" when "0001",    --1
			"0010010" when "0010",	--2
			"0000110" when "0011",	--3
			"1001100" when "0100",	--4
			"0100100" when "0101",	--5
			"0100000" when "0110",	--6
			"0001111" when "0111", --7
			"0000000" when "1000",--8
			"0000100" when "1001",--9
			"1111111" when others;
			
-- Gestion des sortie
(a,b,c,d,e,f,g) <= segment;


end arch_bcd7seg;
