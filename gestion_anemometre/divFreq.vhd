library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity divFreq is

port( 
	clk_50MHz: in std_logic;
	reset : in std_logic;
	-- sortie
	clk_1Hz: out std_logic );
end divFreq;

architecture arch_divFreq of divFreq is
signal count: std_logic_vector(25 downto 0);
signal clk_1Hz_interne : std_logic;
begin
-- mise en oeuvre de l'architecture 
-- Entree: clk_50 
-- Sortie :clk_1Hz
-- DIVISION PAR (25 000 000 - 1) DE L'HORLOGE de 50 MHZ
-- Exemple soit f0 = 50 000 000Hz soit T0 = 20ns,
-- pour avoir f1 = 12 500 000 Hz soit T1 = 4x20ns = 80ns
-- On compte les fronts montant count <= count +1 = [0,1,2,3] soit 4 periodes (division par 4)
-- ie quand count = 3 on a 4x20 ns et 
-- Etant donnee que la sortie clk_1Hz est alterne, pour avoir T1 = 1x80ns faut alterner 2 fois
-- quand count = 1 (division par 2) ie a la moitie

-- Ainsi pour avoir 1Hz a partir de 50 MHz il diviser par 50 000 000 soit count
-- count = 25 000 000 - 1 = 0x17D783F
 
--falling_edge(clk)
process(clk_50MHz,reset)
begin
--Div par 50 000 000
if reset = '1' then
	clk_1Hz_interne <= '0';
	count <= (others => '0');
elsif rising_edge(clk_50MHz) then
	count <= count + 1;
	if count >= X"17BF19F"then --2FAF07F or 17D783F  17A6AFF 17BF19F
		count <= (others => '0');
		clk_1Hz_interne <= not clk_1Hz_interne;
	end if;
end if;
end process;
clk_1Hz <= clk_1Hz_interne;
end arch_divFreq;