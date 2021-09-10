library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity add5_q9 is

port( 
	-- Vector
	a, b: in std_logic_vector(4 downto 0);
	Cin: in std_logic ;
	
	s: out std_logic_vector(4 downto 0);
	Cout: out std_logic );
end;

architecture arch_add5 of add5_q9 is
signal result: std_logic_vector(5 downto 0);
begin


-- mise en oeuvre de l'architecture de l'additionneur 5 bits
	result <=  '0'&a + b + cin;
	s <= result(4 downto 0);
	cout <= result(5);

end arch_add5;
