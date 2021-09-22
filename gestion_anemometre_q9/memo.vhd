library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity memo is

port( 
	-- Entree & sortie
	clk_50,clk,valid,continu,start_stop : in std_logic;
	out_compteur: in std_logic_vector(24 downto 0);
	q: out std_logic_vector(24 downto 0);
	data_valid : out std_logic
	);
end memo;

architecture arch_memo of memo is
--Variables
signal temp: std_logic_vector(24 downto 0);
signal temp_data_valid : std_logic;

begin
-- mise en oeuvre de l'architecture
-- OR FALLING_EDGE(clk)
  PROCESS(clk_50) BEGIN
	if rising_edge(clk_50) then 
		if valid = '1' then
		temp_data_valid <='1';
			if continu = '1' then
				if clk = '1' then
				temp <= out_compteur;
				end if;
			else
				if start_stop = '1' then 
					temp <= out_compteur;
					temp_data_valid <='1';
				else 
					temp_data_valid <='0';
				end if;
			end if;
		end if;
	end if;
  END PROCESS;
  q <= temp;
  data_valid <= temp_data_valid;
end arch_memo;
	