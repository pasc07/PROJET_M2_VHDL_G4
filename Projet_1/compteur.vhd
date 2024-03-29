library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compteur is

port( 
	-- Entree & sortie
	clk,raz : in std_logic;
	q: out std_logic_vector(3 downto 0)
	);
end compteur;

architecture arch_compteur of compteur is
--Variables
signal compteur: std_logic_vector(3 downto 0);
begin
-- mise en oeuvre de l'architecture
-- 
  PROCESS(clk) BEGIN
    IF clk'event and clk='1' THEN
      IF raz='1' THEN
        compteur<=(OTHERS=>'0');
      ELSE
        compteur <= compteur + 1;
      END IF;
    END IF;
 
  END PROCESS;
-- 
   q <= compteur;
end arch_compteur;
	