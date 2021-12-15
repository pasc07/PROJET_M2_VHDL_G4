library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Gestoin des leds et bips
entity gestion_clignote is
port( 
	clk, stby: in std_logic ;
	out_value: out std_logic ); 
end;

architecture arch of gestion_clignote is
signal buf_out : std_logic := '0';
begin

process (clk) 
variable timer: integer := 0; 
variable duree: integer := 50000000; -- Pour la validation sur carte
begin
	if clk'event and clk = '1' then
		if( stby = '1' ) then
		timer := timer +1;
			if( timer >= duree ) then
				timer := 0;
				buf_out <= not buf_out;
			end if;
		else
			buf_out <= '0';
		end if;
	end if;
end process;
out_value <= buf_out;
end arch;

