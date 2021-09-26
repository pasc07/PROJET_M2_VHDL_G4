library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compteur is

port( 
	-- Entree & sortie
	clk,in_freq: in std_logic;
	q: out std_logic_vector(7 downto 0);
	valid : out std_logic
	);
end compteur;

architecture arch_compteur of compteur is
--Variables
signal compteur: std_logic_vector(7 downto 0);
signal compteur1: std_logic_vector(7 downto 0);
signal compteur2: std_logic_vector(7 downto 0);

signal valid1: std_logic;
signal valid2: std_logic;
--signal temp: std_logic_vector(7 downto 0);
signal temp1: std_logic_vector(7 downto 0);
signal temp2: std_logic_vector(7 downto 0);
--signal test : std_logic;
begin
-- mise en oeuvre de l'architecture 
-- OR FALLING_EDGE(clk)
-- rising_edge(in_freq)


	
  PROCESS(in_freq) BEGIN
	--Compter front montant
		
    IF rising_edge(in_freq)  THEN
		 IF clk = '0' THEN
			if compteur1 > 0 then
			temp1<= compteur1; --(6 downto 0) & '0' ; --S1 <= A(6 downto 0) & ?0?;
			valid1 <= '1';
			end if;
			compteur1<=(OTHERS=>'0');
		 END IF;
		  IF clk ='1' THEN
			valid1 <= '0';
			compteur1 <= compteur1 + 1;
		  END IF;
    END IF;
	 
  END PROCESS;
  
  
    PROCESS(in_freq,clk) BEGIN
	--Compter front descendant

    IF falling_edge(in_freq) THEN
		 IF clk = '0' THEN
			if compteur2 > 0 then
			temp2 <= compteur2; --(6 downto 0) & '0' ; --S1 <= A(6 downto 0) & ?0?;
			valid2 <= '1';
			end if;
			compteur2<=(OTHERS=>'0');
		 END IF;
		 
		  IF clk ='1' THEN
			valid2 <= '0';
			compteur2 <= compteur2 + 1;
		  END IF;
    END IF;
  END PROCESS;
  
	--compteur <= compteur1 + compteur2;
	valid <= valid1 and valid2 ;--or valid2 or valid3;
   q <= temp1+temp2;
	
end arch_compteur;