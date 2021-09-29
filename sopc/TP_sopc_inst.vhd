  --Example instantiation for system 'TP_sopc'
  TP_sopc_inst : TP_sopc
    port map(
      out_port_from_the_led => out_port_from_the_led,
      clk_0 => clk_0,
      in_port_to_the_boutons => in_port_to_the_boutons,
      reset_n => reset_n
    );


