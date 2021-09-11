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
	PWM_OUT : out std_logic );
end pwm;


--Def de l'architecture
architecture arch_pwm of pwm is
--For mapping
signal out_cpt: std_logic_vector(15 downto 0);
signal out_comp : std_logic;
signal pwm : std_logic;
signal rst : std_logic;

--Components

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
--Descript et mapping

inst1: compteur_n_bits port map (clk,rst,out_cpt);

rst <= out_comp and (not reset_n);

inst2: comparateur port map ("00000000"&FREQ,out_cpt,out_comp);

inst3: comparateur port map ("00000000"&DUTY,out_cpt,pwm);

PWM_OUT <= not pwm ;

end arch_pwm;
