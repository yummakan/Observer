LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity signalgenerator_testbench is
end entity;

architecture testbench_architecture of signalgenerator_testbench is
--signals
signal inputclk :   std_logic ;
signal inputreset:  std_logic ;
signal outputsignal:std_logic ;
--components
component signalgenerator is 
	port(
		clk		  :in  std_logic							:= 'X';
		reset 	:in 	std_logic       := 'X'; 	-- clk
		output :out	std_logic 				           -- export
	);
end component signalgenerator;

 FOR signalgenerator_top : signalgenerator 
    use entity 
        work.signalgenerator(Behavioural);

begin --begin ARCHITECTURE
  
  
signalgenerator_top : component signalgenerator
	port map (
		clk     => inputclk,
		reset   => inputreset,
		output  => outputsignal
	);
	

stimulus: process is
-- put all signals here to give them default values
  procedure initialize is 
    begin
      inputclk <= '1';
      inputreset <= '0';
      outputsignal <= '0';
  end procedure initialize;
begin
  initialize;
  loop
    inputclk <= not inputclk after 50 ns;
  end loop;
  wait;
end process stimulus;  
end architecture;