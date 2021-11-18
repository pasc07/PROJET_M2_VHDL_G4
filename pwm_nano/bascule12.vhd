library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity bascule12 is
port( 
	clk : in std_logic;
	D : in std_logic ;
	Q: out std_logic );
end bascule12;

architecture arch_bascule12 of bascule12 is
begin
process(clk)
begin

if clk'event and clk = '1' then
		Q <= D;

end if;
end process;
end arch_bascule12;