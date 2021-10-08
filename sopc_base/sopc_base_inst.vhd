	component sopc_base is
		port (
			boutons_external_connection_export   : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			clk_clk                              : in  std_logic                    := 'X';             -- clk
			cpu_custom_instruction_master_readra : out std_logic;                                       -- readra
			leds_external_connection_export      : out std_logic_vector(7 downto 0)                     -- export
		);
	end component sopc_base;

	u0 : component sopc_base
		port map (
			boutons_external_connection_export   => CONNECTED_TO_boutons_external_connection_export,   --   boutons_external_connection.export
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                           clk.clk
			cpu_custom_instruction_master_readra => CONNECTED_TO_cpu_custom_instruction_master_readra, -- cpu_custom_instruction_master.readra
			leds_external_connection_export      => CONNECTED_TO_leds_external_connection_export       --      leds_external_connection.export
		);

