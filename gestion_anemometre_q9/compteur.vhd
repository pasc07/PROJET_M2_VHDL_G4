library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compteur is

port( 
	-- Entree & sortie
	clk,in_freq,raz : in std_logic;
	q: out std_logic_vector(24 downto 0);
	valid : out std_logic
	);
end compteur;

architecture arch_compteur of compteur is
--Variables
signal compteur: std_logic_vector(24 downto 0);
signal temp: std_logic_vector(24 downto 0);
begin
-- mise en oeuvre de l'architecture
-- OR FALLING_EDGE(clk)
  PROCESS(clk,in_freq) BEGIN
    IF RISING_EDGE(clk) THEN
		  IF raz='0' THEN
			valid <= '1';
			temp <= compteur;
			compteur<=(OTHERS=>'0');
		  ELSE
		  IF in_freq ='1' THEN
			valid <= '0';
			compteur <= compteur + 1;
		  END IF;
		  END IF;
    END IF;
  END PROCESS;
   q <= temp;
end arch_compteur;
	