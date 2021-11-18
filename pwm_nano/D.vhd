library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;





entity D is
port( 
	clk : in std_logic;
	 D:	in std_logic ;
	--FREQ : in std_logic_vector (7 downto 0);
	--DUTY : in std_logic_vector (7 downto 0);
	Q : 	out std_logic );
end D;

