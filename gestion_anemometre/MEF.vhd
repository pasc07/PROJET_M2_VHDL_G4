library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MEF is

port( 
	-- Entree & sortie
	H,continu,start_stop: in std_logic;
	data_valid: out std_logic;
	data_anemometre :out std_logic_vector(7 downto 0)
	);
end MEF;

architecture arch_MEF of MEF is
--Entree
type ETAT is (monocoup,mode_continu, acquisition,maj_data_valid);
signal etat_present : ETAT :=monocoup;
signal etat_suivant : ETAT :=monocoup;

begin

--BLOC F
PROCESS(etat_present,continu,start_stop) BEGIN
case etat_present is
	when monocoup => 
		if continu = '1' then
		etat_suivant <=mode_continu ;
		elsif start_stop = '1' then
		etat_suivant <= acquisition ;
		else
		etat_suivant <= maj_data_valid;
		end if;
	when mode_continu => 
		if continu = '0' then
		etat_suivant <=monocoup ;
		else
		etat_suivant <=mode_continu ;
		end if;
	when maj_data_valid =>
		if continu = '1' then
		etat_suivant <= mode_continu;
		end if;
	when acquisition =>
		etat_suivant <= mode_continu;
		

end case;
END PROCESS;

--BLOC M : affectation etat suivant
PROCESS(H) BEGIN
IF RISING_EDGE(H) THEN
	etat_present <= etat_suivant;
END IF;
END PROCESS;

--BLOC G : calcul des sorties
PROCESS(etat_present) BEGIN
if etat_present = mode_continu then

end if;

if etat_present = monocoup then

end if;

if etat_present = acquisition then

end if;
END PROCESS;

end arch_MEF;