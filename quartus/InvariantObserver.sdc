create_clock -period 20.000 -name CLOCK_50
create_clock -period 20.000 -name CLOCK2_50
create_clock -period 20.000 -name CLOCK3_50
derive_pll_clocks
derive_clock_uncertainty