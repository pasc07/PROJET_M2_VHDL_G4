library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pwm is
port( 
	clk : in std_logic;
	reset_n : in std_logic ;
	FREQ : in std_logic_vector (7 downto 0);
	DUTY : in std_logic_vector (7 downto 0);
	PWM : out std_logic );
end pwm;


--Def de l'architecture
architecture arch_pwm of pwm is
--For mapping
signal clk_1Hz_i : std_logic;
signal out_cpt: std_logic_vector(15 downto 0);
signal out_comp : std_logic;

--Components

component compteur_n_bits is
port( 
	-- Entree & sortie
	clk,raz : in std_logic;
	q: out std_logic_vector(15 downto 0)
	);
end component;

component comparateur is
port(   A,B  :      in  std_logic_vector(15 downto 0);
    egal :      out     std_logic);
	
end component;


begin
--Descript et mapping

inst1: compteur_n_bits port map (clk,out_comp,out_cpt);

inst2: comparateur port map (out_cpt,FREQ,out_comp);

inst3: comparateur port map (out_cpt,DUTY,PWM);


end arch_pwm;
