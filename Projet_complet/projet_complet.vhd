library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity projet_complet is

end projet_complet;


--Def de l'architecture
architecture arch_projet_complet of projet_complet is
--For mapping
signal clk_50MHz : std_logic;
signal reset : std_logic;
signal a,b,c,d,e,f,g: std_logic );

--Components
component divFreq
port( 
	clk_50MHz: in std_logic;
	reset : in std_logic;
	-- sortie
	clk_1Hz: out std_logic );
end component

component compteur
port( 
	-- Entree & sortie
	clk,raz : in std_logic;
	q: out std_logic_vector(3 downto 0)
	);
end component ;

component bcd7seg
port( 
	-- Vector
	E3E2E1E0 : std_logic_vector(3 downto 0);
	
	a,b,c,d,e,f,g: out std_logic );
	
end component;


begin
--Descript

end arch_projet_complet;
