library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity projet_complet is
port( 
	clk_50 : in std_logic;
	reset_freq : in std_logic;
	a_out,b_out,c_out,d_out,e_out,f_out,g_out: out std_logic );
	
end projet_complet;


--Def de l'architecture
architecture arch_projet_complet of projet_complet is
--For mapping
signal clk_1Hz_i : std_logic;
signal out_cpt: std_logic_vector(3 downto 0);

--Components
component divFreq is
port( 
	clk_50MHz: in std_logic;
	reset : in std_logic;
	-- sortie
	clk_1Hz: out std_logic );
end component;

component compteur is
port( 
	-- Entree & sortie
	clk,raz : in std_logic;
	q: out std_logic_vector(3 downto 0)
	);
end component;

component bcd7seg is
port( 
	-- Vector
	E3E2E1E0 : std_logic_vector(3 downto 0);
	
	a,b,c,d,e,f,g: out std_logic );
	
end component;


begin
--Description de systeme complet avec les cablages necessaire
inst1: divFreq port map (clk_50,reset_freq,clk_1Hz_i);

inst2: compteur port map (clk_1Hz_i,reset_freq,out_cpt);

inst3: bcd7seg port map (out_cpt,a_out,b_out,c_out,d_out,e_out,f_out,g_out);

end arch_projet_complet;
