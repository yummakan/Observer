LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity signalgenerator_testbench is
end entity;

architecture testbench_architecture of signalgenerator_testbench is
--signals
signal inputclk :   std_logic := '0';
signal inputreset:  std_logic := '0';
signal outputsignal:std_logic := '0' ;
--components
component signalgenerator is 
	port(
		clk		  :in  std_logic:= 'X';
		reset 	:in 	std_logic       := 'X'; 	-- clk
		output :out	std_logic 		        -- export
	);
end component signalgenerator;

 --FOR signalgenerator_top : signalgenerator 
 --   use entity 
 --       work.signalgenerator(Behavioural);
 FOR signalgenerator_top : signalgenerator 
    use entity 
        work.signalgenerator(simple);

begin --begin ARCHITECTURE
  
  
signalgenerator_top : component signalgenerator
	port map (
		clk     => inputclk,
		reset   => inputreset,
		output  => outputsignal
	);
	

stimulus: process is
  variable counter : integer :=0;
-- put all signals here to give them default values
begin
  counter := 1000;
  inputclk <= '1';
  inputreset <= '0';
  --outputsignal <= '0';
  while (counter > 0) loop
    inputclk <= not inputclk;
    counter := counter  - 1;
    if(counter > 450 and counter < 500)then
      inputreset <= '1';
    else
       inputreset <= '0';
    end if;
    wait for 50ns;
  end loop;
  wait;
end process stimulus;  
end architecture;
