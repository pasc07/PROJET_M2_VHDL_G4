library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
use IEEE.std_logic_arith.all; 

entity avalon_pwm is 
port ( 
clk, chipselect, write_n, reset_n : in std_logic; 
writedata : in std_logic_vector (31 downto 0); 
readdata : out std_logic_vector (31 downto 0); 
address: std_logic_vector (1 downto 0); 
out_pwm : out std_logic 
); 
end entity; 
 
 
ARCHITECTURE arch_avalon_pwm of avalon_pwm IS 
 signal freq : std_logic_vector (31 downto 0); 
 signal duty : std_logic_vector (31 downto 0); 
 signal counter : std_logic_vector (15 downto 0); 
 signal control : std_logic_vector (1 downto 0); 
 signal pwm_on : std_logic; 
BEGIN 
 
divide: process (clk, reset_n) 
 begin 
 if control(0) = '0' then     
 counter <= (others => '0'); 
 elsif clk'event and clk = '1' then 
  if control(1) ='1' then 
   if counter >= freq then 
   counter <= (others => '0'); 
   else 
   counter <= counter + 1; 
   end if; 
  end if; 
 end if; 
end process divide;  
 
compare: process (clk, reset_n) 
 begin 
 if control(0) = '0' then 
 pwm_on <= '1'; 
 elsif clk'event and clk = '1' then 
  if counter >= duty then 
  pwm_on <= '0'; 
  elsif counter = 0 then 
  pwm_on <= '1'; 
  end if; 
 end if; 
end process compare; 
out_pwm <= pwm_on and control(0); 

process_write: process (clk, reset_n) 
 begin 
 if reset_n = '0' then 
 freq <= (others => '0'); 
 duty <= (others => '0'); 
 control <= (others => '0'); 
 elsif clk'event and clk = '1' then 
  if chipselect ='1' and write_n = '0' then 
   if address = "00" then 
   freq  <= writedata; 
   end if; 
   if address = "01" then 
   duty  <= writedata; 
   end if; 
   if address = "10" then 
   control  <= writedata (1 downto 0);
   end if; 
  end if; 
 end if;   
end process;

-- lecture registres 

PROCESS(address, freq, duty, control)
BEGIN 
 case address is 
  when "00" => readdata <= freq ; 
  when "01" => readdata <= duty ; 
  when "10" => readdata <= X"0000000"&"00"&control ; 
  when others => readdata <= (others => '0');    
 end case; 
END PROCESS process_Read ;
END arch_avalon_pwm ;