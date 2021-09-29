	sopc_base u0 (
		.clk_clk                              (<connected-to-clk_clk>),                              //                           clk.clk
		.cpu_custom_instruction_master_readra (<connected-to-cpu_custom_instruction_master_readra>), // cpu_custom_instruction_master.readra
		.leds_external_connection_export      (<connected-to-leds_external_connection_export>),      //      leds_external_connection.export
		.boutons_external_connection_export   (<connected-to-boutons_external_connection_export>)    //   boutons_external_connection.export
	);

