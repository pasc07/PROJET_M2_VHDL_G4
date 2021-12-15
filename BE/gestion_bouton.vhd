library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;




entity gestion_bouton is
port( 
BP_Babord,BP_Tribord, BP_STBY,clk_50M, raz_n: in std_logic; 
ledBabord, ledTribord,ledSTBY, out_bip: out std_logic;
codeFonction: out std_logic_vector (3 downto 0)
); 
end gestion_bouton;
 


architecture arch_gestion_bouton of gestion_bouton is

signal sBP_STBY : std_logic; 
signal BP_Babord_1fois: std_logic;
signal BP_Babord_long: std_logic; 
signal BP_Tribord_1fois: std_logic;
signal BP_Tribord_long: std_logic;

signal ledSTBY_clig :std_logic; 
signal ledSTBY_allume :std_logic; 
signal ledTribord_1fois :std_logic;
signal ledTribord_2fois :std_logic;
signal ledBabord_1fois :std_logic;
signal ledBabord_2fois :std_logic;
signal bip_unique :std_logic;
signal bip_double :std_logic;
signal fm_stby : std_logic;

-- Test
signal out_b :std_logic;
signal out_t :std_logic;
-- buffer pour appui stby
signal out_s : std_logic;
constant buf_s : std_logic := '0';
signal clign_stby : std_logic;

--machine a etat

type ETAT is (etat_init,etat1,etat2,etat3,etat4,etat5,etat6,etat7);

signal etat_present : ETAT ;
signal etat_suivant : ETAT ;

component rising is
port( 
	clk, BP: in std_logic ;
	BP_front_montant: out std_logic );
end component;

component bp_long is
port( 
	clk, BP: in std_logic ;
	bplong, bpcourt: out std_logic );
end component;

component gestion_led_bip is
port( 
	clk, une_fois, deux_fois : in std_logic ;
	out_value: out std_logic ); 
end component;

-- clign
component gestion_clignote is
port( 
	clk, stby: in std_logic ;
	out_value: out std_logic ); 
end component;

begin
-- Front montant sur stby
 frontmont: rising port map(clk_50M,BP_STBY,fm_stby); 
 long_b: bp_long port map(clk_50M, BP_Babord,BP_Babord_long,BP_Babord_1fois);
 long_t: bp_long port map(clk_50M, BP_Tribord,BP_Tribord_long, BP_Tribord_1fois);
 
 gest_bp_babord : gestion_led_bip port map (clk_50M, BP_Babord_1fois,BP_Babord_long, out_b);
 gest_bp_tribord : gestion_led_bip port map (clk_50M, ledTribord_1fois,BP_Tribord_long, out_t);
 gest_bp_stby : gestion_led_bip port map (clk_50M, fm_stby,buf_s, out_s);
 clign : gestion_clignote port map (clk_50M,ledSTBY_clig,clign_stby );
 ledBabord <= out_b;
 ledTribord <= out_t;
 ledSTBY <= ledSTBY_allume or clign_stby; 
 out_bip <= out_b or out_t or out_s;
-- BLOC F
PROCESS(clk_50M,fm_stby,etat_present,BP_Babord,BP_Babord_1fois,BP_Tribord,BP_Tribord_1fois,BP_Babord_long,BP_Tribord_long,BP_STBY,raz_n) 
BEGIN
-- Mode veille
IF RISING_EDGE(clk_50M) THEN
case etat_present is
	when etat_init => 
		if BP_Babord = '0' then  -- inverse
		etat_suivant <=etat1 ;
		end if;
		if BP_Tribord = '0' then
		etat_suivant <=etat2 ;
		end if;
		if fm_stby = '1' then
		 etat_suivant <=etat3 ;
		end if;
		
	when etat2 => 
	if BP_Tribord = '1' then
		etat_suivant <=etat_init;
	end if;
	when etat1 => 
	if BP_Babord = '1' then
		etat_suivant <=etat_init;
	end if;
		
--mode auto

	when etat3=>
	   if fm_stby = '1' then
		etat_suivant <= etat_init;
		end if;
      if BP_Babord_1fois = '1' then
		etat_suivant <= etat4;
      end if;
		if BP_Tribord_1fois = '1' then
		etat_suivant <= etat5;
		end if;
		if BP_Babord_long = '1' then
		etat_suivant <= etat6;
	   end if;
		if BP_Tribord_long = '1' then
		etat_suivant <= etat7;
	   end if;
		
	when etat4 => 
		if BP_Babord_1fois = '0' then
		etat_suivant <=etat3;
		end if;
  
   when etat5 => 
   if BP_Tribord_1fois = '0' then
		etat_suivant <=etat3;
	end if;
	
	when etat6 => 
		if BP_Babord_long = '0' then
		etat_suivant <= etat3;
	   end if;
		
	when etat7=> 
		if BP_Tribord_long = '0' then
		etat_suivant <= etat3;
	   end if;
	
	
end case;
END IF;
END PROCESS;

--bloc m

PROCESS(clk_50M,etat_suivant,raz_n) BEGIN
if raz_n = '0' then
etat_present<= etat_init;
ELSIF RISING_EDGE(clk_50M) THEN
	etat_present <= etat_suivant;
END IF;
END PROCESS;

--bloc G

PROCESS(clk_50M,etat_present) BEGIN
IF RISING_EDGE(clk_50M) THEN
	if etat_present = etat_init then
		ledSTBY_allume <= '0';
		ledSTBY_clig <= '1';
		codeFonction <= "0000";
		--out_bip <= '0';
		ledBabord_1fois <= '0';
		ledTribord_1fois <= '0';
		bip_double <= '0';
		bip_unique <= '0';
	end if;
	
	if etat_present = etat1 then
		ledBabord_1fois <= '1';
		bip_unique <= '1';
		ledSTBY_clig <= '1';
		--out_bip <= '1';
		--ledBabord <= '1';
		codeFonction <= "0001";
		
	end if;
	
	if etat_present = etat2 then
		ledTribord_1fois <= '1';
		ledSTBY_clig <= '1';
		bip_unique <=  '1';
		--out_bip <= '1';
		--ledTribord <= '1';
		codeFonction <= "0010";	
	end if;
	--mode auto
	if etat_present = etat3 then
		ledSTBY_allume <= '1';
		ledSTBY_clig <= '0';
		bip_unique <=  '1';
		codeFonction <= "0011";
		
		ledBabord_1fois <= '0';
		ledTribord_1fois <= '0';
		bip_double <= '0';
		bip_unique <= '0';
	end if;
	
	if etat_present = etat4 then
		ledSTBY_allume <= '1';
		ledBabord_1fois <=  '1';
		bip_unique <=  '1';
		codeFonction <= "0100";
	end if;
	
	if etat_present = etat5 then
		ledSTBY_clig <= '0';
		ledSTBY_allume <= '1';
		ledTribord_1fois <= '1';
		bip_unique <= '1';
		codeFonction <= "0111";
	end if;
	
	if etat_present = etat6 then
		ledSTBY_allume <= '1';
		ledBabord_2fois <= '1';
		bip_double <= '1';
		codeFonction <= "0101";
	end if;
	
	if etat_present = etat7 then
		ledSTBY_allume <= '1';
		ledTribord_2fois <= '1';
		bip_double <= '1';
		codeFonction <= "0110";
	end if;
END IF;
END PROCESS;

end arch_gestion_bouton;