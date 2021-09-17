library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compteur_n_bits is

port( 
	-- Entree & sortie
	clk,in_freq,raz : in std_logic;
	q: out std_logic_vector(7 downto 0)
	);
end compteur_n_bits;

architecture arch_compteur of compteur_n_bits is
--Variables
signal compteur: std_logic_vector(7 downto 0);
begin
-- mise en oeuvre de l'architecture

  PROCESS(clk,in_freq) BEGIN
    IF clk'event and clk='1' THEN
      IF raz='1' THEN
		compteur<=(OTHERS=>'0');
		ELSIF rising_edge(in_freq) THEN
		compteur <= compteur + 1;
		END IF;
	   END IF;
    END IF;
 
  END PROCESS;
-- 
   q <= compteur sll 1;
end arch_compteur;
	