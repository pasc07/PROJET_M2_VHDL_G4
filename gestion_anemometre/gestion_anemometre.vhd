library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity gestion_anemometre is
port( 

  clk_50M: in std_logic;
  in_freq_anemometre:in std_logic;
  raz_n: in std_logic;
  start_stop:in std_logic;
  continu : in std_logic;
  
  data_valid:out std_logic;
  data_anemometre:out std_logic_vector (7 downto 0) );
  
end gestion_anemometre ;


--Def de l'architecture
architecture arch_gestion_anemometre of gestion_anemometre is
--For mapping
signal clk_05Hz:std_logic;
signal clk_1Hz:std_logic;
signal temp_out_compteur: std_logic_vector(7 downto 0);
signal out_compteur: std_logic_vector(7 downto 0);
signal temp_valid : std_logic;

--Components



component compteur is
port( 
	-- Entree & sortie
	clk,in_freq : in std_logic;
	q: out std_logic_vector(7 downto 0);
	valid: out std_logic
	);
end component;


component divFreq is
port( 
	clk_50MHz: in std_logic;
	reset : in std_logic;
	-- sortie
	clk_1Hz: out std_logic );
end component;

component memo is

port( 
	-- Entree & sortie
	clk,dispo : in std_logic;
	out_compteur: in std_logic_vector(7 downto 0);
	q: out std_logic_vector(7 downto 0)
	);
end component;

component refresh is
port( 
	clk_50MHz: in std_logic;
	reset : in std_logic;
	-- sortie
	clk_1Hz: out std_logic );
end component;


begin
--Description and mapping

inst1: divFreq port map(clk_50M,raz_n,clk_1Hz);
inst2: compteur port map(clk_1Hz,in_freq_anemometre,out_compteur,temp_valid);
inst3: memo port map(clk_1Hz,temp_valid,out_compteur,temp_out_compteur);


data_anemometre <= temp_out_compteur;
data_valid <= temp_valid;

end arch_gestion_anemometre;