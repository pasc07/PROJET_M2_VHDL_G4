library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity gestion_anemometre is
port( 
clk_50M,chipselect, write_n, reset_n : in std_logic; 
writedata : in std_logic_vector (31 downto 0); 
readdata : out std_logic_vector (31 downto 0); 
address: std_logic_vector (1 downto 0); 
in_freq_anemometre: in std_logic
); 
end gestion_anemometre; 
  
  


--Def de l'architecture
architecture arch_gestion_anemometre of gestion_anemometre is
-- For mapping
-- signal clk_50M:  std_logic;
 signal raz_n:  std_logic;
 signal start_stop: std_logic;
 signal continu : std_logic;
 signal data_valid : std_logic;
 signal data_anemometre : std_logic_vector (7 downto 0); 


 

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
signal registre_int :  std_logic_vector(31 downto 0);
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

--component refresh is
--port( 
--	clk_50MHz: in std_logic;
--	reset : in std_logic;
--	-- sortie
--	clk_1Hz: out std_logic );
--end component;


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

-- ecriture registre
process_write: process (clk_50M, reset_n) 
begin 
	if reset_n = '0' then 
		registre_int <= (others => '0'); 
	elsif clk_50M'event and clk_50M = '1' then 
		if chipselect ='1' and write_n = '0' then 

			registre_int <= writedata; 
			start_stop <= registre_int(2);
			continu <= registre_int(1);
			raz_n<= registre_int(0);
		end if; 
	end if;   
end process; 
 
-- lecture registres 

PROCESS(address,data_anemometre, data_valid)  
BEGIN 
 case address is 
	when "00" => readdata <= "00000000000000000000000000000"& start_stop & continu & raz_n ;
	when "01" => readdata <= "0000000000000000000000"& data_valid & "0" & data_anemometre ; 
	when others => readdata <= (others => '0');
 end case; 
END PROCESS ; 

end arch_gestion_anemometre;