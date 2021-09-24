library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity memo is

port( 
	-- Entree & sortie
	clk,dispo : in std_logic;
	out_compteur: in std_logic_vector(7 downto 0);
	q: out std_logic_vector(7 downto 0)
	);
end memo;

architecture arch_memo of memo is
--Variables
signal temp: std_logic_vector(7 downto 0);

begin
-- mise en oeuvre de l'architecture
-- OR FALLING_EDGE(clk)
  PROCESS(clk) 
  BEGIN
	if rising_edge(clk) then
		if dispo = '1' then
			temp<=out_compteur;
		end if;
    end if;
  END PROCESS;
  q <= temp;
end arch_memo;
	