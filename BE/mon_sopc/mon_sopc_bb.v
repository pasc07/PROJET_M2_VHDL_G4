
module mon_sopc (
	avalon_bouton_0_conduit_end_bp_babord,
	avalon_bouton_0_conduit_end_bp_tribord,
	avalon_bouton_0_conduit_end_bp_stby,
	avalon_bouton_0_conduit_end_ledbabord,
	avalon_bouton_0_conduit_end_ledtribord,
	avalon_bouton_0_conduit_end_ledstby,
	avalon_bouton_0_conduit_end_out_bip,
	avalon_verin_0_conduit_end_sck_o,
	avalon_verin_0_conduit_end_pwm_o,
	avalon_verin_0_conduit_end_sens_o,
	avalon_verin_0_conduit_end_miso_i,
	avalon_verin_0_conduit_end_cs_n_o,
	boutons_external_connection_export,
	clk_clk,
	leds_external_connection_export,
	test_anemo_0_conduit_end_beginbursttransfer,
	test_pwm_0_conduit_end_writeresponsevalid_n);	

	input		avalon_bouton_0_conduit_end_bp_babord;
	input		avalon_bouton_0_conduit_end_bp_tribord;
	input		avalon_bouton_0_conduit_end_bp_stby;
	output		avalon_bouton_0_conduit_end_ledbabord;
	output		avalon_bouton_0_conduit_end_ledtribord;
	output		avalon_bouton_0_conduit_end_ledstby;
	output		avalon_bouton_0_conduit_end_out_bip;
	output		avalon_verin_0_conduit_end_sck_o;
	output		avalon_verin_0_conduit_end_pwm_o;
	output		avalon_verin_0_conduit_end_sens_o;
	input		avalon_verin_0_conduit_end_miso_i;
	output		avalon_verin_0_conduit_end_cs_n_o;
	input	[1:0]	boutons_external_connection_export;
	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input		test_anemo_0_conduit_end_beginbursttransfer;
	output		test_pwm_0_conduit_end_writeresponsevalid_n;
endmodule
