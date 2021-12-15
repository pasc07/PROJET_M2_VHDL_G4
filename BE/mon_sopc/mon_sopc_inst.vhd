	component mon_sopc is
		port (
			avalon_bouton_0_conduit_end_bp_babord       : in  std_logic                    := 'X';             -- bp_babord
			avalon_bouton_0_conduit_end_bp_tribord      : in  std_logic                    := 'X';             -- bp_tribord
			avalon_bouton_0_conduit_end_bp_stby         : in  std_logic                    := 'X';             -- bp_stby
			avalon_bouton_0_conduit_end_ledbabord       : out std_logic;                                       -- ledbabord
			avalon_bouton_0_conduit_end_ledtribord      : out std_logic;                                       -- ledtribord
			avalon_bouton_0_conduit_end_ledstby         : out std_logic;                                       -- ledstby
			avalon_bouton_0_conduit_end_out_bip         : out std_logic;                                       -- out_bip
			avalon_verin_0_conduit_end_sck_o            : out std_logic;                                       -- sck_o
			avalon_verin_0_conduit_end_pwm_o            : out std_logic;                                       -- pwm_o
			avalon_verin_0_conduit_end_sens_o           : out std_logic;                                       -- sens_o
			avalon_verin_0_conduit_end_miso_i           : in  std_logic                    := 'X';             -- miso_i
			avalon_verin_0_conduit_end_cs_n_o           : out std_logic;                                       -- cs_n_o
			boutons_external_connection_export          : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			clk_clk                                     : in  std_logic                    := 'X';             -- clk
			leds_external_connection_export             : out std_logic_vector(7 downto 0);                    -- export
			test_anemo_0_conduit_end_beginbursttransfer : in  std_logic                    := 'X';             -- beginbursttransfer
			test_pwm_0_conduit_end_writeresponsevalid_n : out std_logic                                        -- writeresponsevalid_n
		);
	end component mon_sopc;

	u0 : component mon_sopc
		port map (
			avalon_bouton_0_conduit_end_bp_babord       => CONNECTED_TO_avalon_bouton_0_conduit_end_bp_babord,       -- avalon_bouton_0_conduit_end.bp_babord
			avalon_bouton_0_conduit_end_bp_tribord      => CONNECTED_TO_avalon_bouton_0_conduit_end_bp_tribord,      --                            .bp_tribord
			avalon_bouton_0_conduit_end_bp_stby         => CONNECTED_TO_avalon_bouton_0_conduit_end_bp_stby,         --                            .bp_stby
			avalon_bouton_0_conduit_end_ledbabord       => CONNECTED_TO_avalon_bouton_0_conduit_end_ledbabord,       --                            .ledbabord
			avalon_bouton_0_conduit_end_ledtribord      => CONNECTED_TO_avalon_bouton_0_conduit_end_ledtribord,      --                            .ledtribord
			avalon_bouton_0_conduit_end_ledstby         => CONNECTED_TO_avalon_bouton_0_conduit_end_ledstby,         --                            .ledstby
			avalon_bouton_0_conduit_end_out_bip         => CONNECTED_TO_avalon_bouton_0_conduit_end_out_bip,         --                            .out_bip
			avalon_verin_0_conduit_end_sck_o            => CONNECTED_TO_avalon_verin_0_conduit_end_sck_o,            --  avalon_verin_0_conduit_end.sck_o
			avalon_verin_0_conduit_end_pwm_o            => CONNECTED_TO_avalon_verin_0_conduit_end_pwm_o,            --                            .pwm_o
			avalon_verin_0_conduit_end_sens_o           => CONNECTED_TO_avalon_verin_0_conduit_end_sens_o,           --                            .sens_o
			avalon_verin_0_conduit_end_miso_i           => CONNECTED_TO_avalon_verin_0_conduit_end_miso_i,           --                            .miso_i
			avalon_verin_0_conduit_end_cs_n_o           => CONNECTED_TO_avalon_verin_0_conduit_end_cs_n_o,           --                            .cs_n_o
			boutons_external_connection_export          => CONNECTED_TO_boutons_external_connection_export,          -- boutons_external_connection.export
			clk_clk                                     => CONNECTED_TO_clk_clk,                                     --                         clk.clk
			leds_external_connection_export             => CONNECTED_TO_leds_external_connection_export,             --    leds_external_connection.export
			test_anemo_0_conduit_end_beginbursttransfer => CONNECTED_TO_test_anemo_0_conduit_end_beginbursttransfer, --    test_anemo_0_conduit_end.beginbursttransfer
			test_pwm_0_conduit_end_writeresponsevalid_n => CONNECTED_TO_test_pwm_0_conduit_end_writeresponsevalid_n  --      test_pwm_0_conduit_end.writeresponsevalid_n
		);

