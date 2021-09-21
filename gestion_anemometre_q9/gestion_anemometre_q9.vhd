library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity gestion_anemometre_q9 is
port( 

  clk_50M: in std_logic;
  in_freq_anemometre:in std_logic;
  raz_n: in std_logic;
  start_stop:in std_logic;
  continu : in std_logic;
  
  data_valid:out std_logic;
  data_anemometre:out std_logic_vector (24 downto 0) );
  
end gestion_anemometre_q9 ;


--Def de l'architecture
architecture arch_gestion_anemometre of gestion_anemometre_q9 is
--For mapping
signal clk_1Hz:std_logic;
signal out_compteur: std_logic_vector(24 downto 0);

--Components



component compteur is
port( 
	-- Entree & sortie
	clk,in_freq,raz : in std_logic;
	q: out std_logic_vector(24 downto 0);
	valid: out std_logic
	);
end component;

begin
--Description and mapping
process(data) begin

if continu = 
inst3: compteur port map (clk_50M,in_freq_anemometre,in_freq_anemometre,out_compteur,data_valid);
data_anemometre <= out_compteur;
end process;
end arch_gestion_anemometre;
