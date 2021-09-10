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
end divFreq

architecture arch_divFreq of divFreq is
signal count: std_logic_vector(25 downto 0);
signal clk_1Hz_interne : std_logic;
begin
-- mise en oeuvre de l'architecture 
-- DIVISION PAR 50 000 000 DE L'HORLOGE 50 MHZ
process(clk_50MHz,reset)
begin
--Div par 50 000 000
if reset = '1' then
	clk_1Hz_interne <= '0';
	count <= (others => '0');
elsif rising_edge(clk_50MHz) then
	if count >= X"2FAF080" then --2FAF080
		count <= (others => '0');
		clk_1Hz_interne <= not clk_1Hz_interne;
	else
		count <= count + 1;
	end if;
end if;
end process;
clk_1Hz <= clk_1Hz_interne;
end arch_divFreq;
