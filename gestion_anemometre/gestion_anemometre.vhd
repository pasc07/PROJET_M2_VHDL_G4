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

signal clk_1Hz_2:std_logic;
signal temp_out_compteur_2: std_logic_vector(7 downto 0);
signal out_compteur_2: std_logic_vector(7 downto 0);
signal data: std_logic_vector(7 downto 0);
signal temp_valid_2 : std_logic;
signal in_freq_anemometre_2 : std_logic;
signal acq : std_logic;
signal init : std_logic;

--machine a etat
--Entree
type ETAT is (monocoup,mode_continu, acquisition);
signal etat_present : ETAT := monocoup;
signal etat_suivant : ETAT := monocoup;

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
--Pour mode continu
init <= not raz_n and acq;
inst1: divFreq port map(clk_50M,raz_n,clk_1Hz);
inst2: compteur port map(clk_1Hz,in_freq_anemometre,out_compteur,temp_valid);
inst3: memo port map(clk_1Hz,temp_valid,out_compteur,temp_out_compteur);

--mapping pour mode monocoup
in_freq_anemometre_2 <= in_freq_anemometre;
inst4: divFreq port map(clk_50M,init,clk_1Hz_2);
inst5: compteur port map(clk_1Hz_2,in_freq_anemometre_2,out_compteur_2,temp_valid_2);
inst6: memo port map(clk_50M,acq,out_compteur_2,temp_out_compteur_2);


--finite state machine
--BLOC F
PROCESS(etat_present,continu,start_stop) BEGIN
case etat_present is
	when monocoup => 
		if continu = '1' then
		etat_suivant <=mode_continu ;
		elsif start_stop = '0' then
		etat_suivant <= acquisition ;
		else
		etat_suivant <= monocoup;
		end if;
	when mode_continu => 
		if continu = '0' then
		etat_suivant <=monocoup ;
		else
		etat_suivant <=mode_continu ;
		end if;
	when acquisition =>
		etat_suivant <= monocoup;
		

end case;
END PROCESS;

--BLOC M : affectation etat suivant
PROCESS(clk_50M) BEGIN
IF RISING_EDGE(clk_50M) THEN
	etat_present <= etat_suivant;
END IF;
END PROCESS;

--BLOC G : calcul des sorties
PROCESS(etat_present) BEGIN
--1
if etat_present = mode_continu then

data <= temp_out_compteur;
data_valid <= temp_valid;

end if;
--2
if etat_present = monocoup then
data <= temp_out_compteur_2;
acq <= '0';
data_valid <= '0';
end if;
--3
if etat_present = acquisition then
acq <= '1';
end if;

END PROCESS;

data_anemometre <= data;

end arch_gestion_anemometre;