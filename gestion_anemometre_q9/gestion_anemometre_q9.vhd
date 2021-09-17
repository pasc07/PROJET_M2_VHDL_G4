library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity gestion_anemometre_q9 is
port( 

  clk_50M:in std_logic;
  in_freq_anemometre:in std_logic;
  raz_n:in std_logic;
  start_stop:in std_logic;
  continu :in std_logic;
  
  data_valid:out std_logic;
  data_anemometre:out std_logic_vector (7 downto 0);
  
end gestion_anemometre_q9


--Def de l'architecture
architecture arch_gestion_anemometre of gestion_anemometre_q9 is
--For mapping
clk_1Hz:std_logic;
out_compteur: std_logic;

--Components

--diviseur
component divFreq is
port( 
	clk_50MHz: in std_logic;
	reset : in std_logic;
	-- sortie
	clk_1Hz: out std_logic );
end component;

--Counter on n= 16 bits with clk and reset
component compteur_n_bits is
port( 
	-- Entree & sortie
	clk,raz : in std_logic;
	q: out std_logic_vector(15 downto 0)
	);
end component;

--Comparison of 16 bits words
component comparateur is
port(   A,B  :      in  std_logic_vector(15 downto 0);
    egal :      out     std_logic);
	
end component;


begin
--Description and mapping
inst1: divFreq port map (clk_50M, start_stop,clk_1Hz);
inst2: compteur_n_bits port map (clk_1Hz, in_freq_anemometre,raz_n,out_compteur);


end arch_gestion_anemometre;
