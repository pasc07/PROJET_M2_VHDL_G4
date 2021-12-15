
library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;  

entity sopc_pwm is 
port ( 
clk, reset_n : in std_logic; 
freq, duty : in std_logic_vector (15 downto 0); 
out_pwm_nano : out std_logic 
); 
end entity; 
 
ARCHITECTURE arch_sopc_pwm of sopc_pwm IS 
-- signaux relatifs au circuit gestion pwm_nano 
 signal counter : std_logic_vector (15 downto 0); 
 signal pwm_nano_on : std_logic; 
 
BEGIN

divide: process (clk, reset_n) 
	begin 
	if reset_n = '0' then 
	counter <= (others => '0'); 
	elsif clk'event and clk = '1' then 
	if counter >= freq then 
	counter <= (others => '0'); 
	else 
	counter <= counter + 1; 
	end if; 
	end if; 
 end process divide; 
 
compare: process (clk, reset_n) 
 begin 
 if reset_n = '0' then 
 pwm_nano_on <= '0';   
 elsif clk'event and clk = '1' then 
  if counter >= duty then 
  pwm_nano_on <= '0'; 
  else 
  pwm_nano_on <= '1'; 
  end if; 
 end if; 
end process compare;
END arch_sopc_pwm ; 
