library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compteur is

port( 
	-- Entree & sortie
	clk,in_freq,raz : in std_logic;
	q: out std_logic_vector(7 downto 0);
	valid : out std_logic
	);
end compteur;

architecture arch_compteur of compteur is
--Variables
signal compteur: std_logic_vector(7 downto 0);
signal temp: std_logic_vector(7 downto 0);
signal test : std_logic;
begin
-- mise en oeuvre de l'architecture
-- OR FALLING_EDGE(clk)
-- rising_edge(in_freq)
  PROCESS(in_freq) BEGIN
	
    IF rising_edge(in_freq)   THEN
		  IF raz = '0' THEN
			if compteur > 0 then
			temp <= compteur;--(6 downto 0) & '0' ; --S1 <= A(6 downto 0) & ‘0’;
			valid <= '1';
			end if;
			compteur<=(OTHERS=>'0');
		  ELSE
		  IF clk ='1' THEN
			valid <= '0';
			compteur <= compteur + 1;
		  END IF;
		  END IF;
    END IF;
  END PROCESS;
   q <= temp;
end arch_compteur;
	