library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity sample is
port( 
clk,inSignal : in std_logic;
outSignal : out std_logic
); 
end sample; 

architecture arch of sample is 
constant duree : integer := 50000; -- Echantillonage sur 1ms
signal timer: integer := 0;

begin
process (clk) begin

	if clk'event and clk = '1' then
	timer <= timer + 1;
			if timer >= duree then
				outSignal <= inSignal;
				timer <= 0;
			end if;
	end if;
end process;
end arch;