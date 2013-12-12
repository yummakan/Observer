LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity signalgenerator is
-- Generic ( n: integer   := 100;  -- counter maximum for outer loop 
 --      ); 
port (

   --clk 		:IN	std_logic;
	reset		:in 	std_logic;
	output	:out  std_logic);

end entity;



architecture Behavioural of signalgenerator is
  signal oscff   : std_logic := '0';
  signal ring    : std_logic_vector(7 downto 0);
  attribute KEEP : string; 
  attribute KEEP of ring : signal is "true"; 
begin
  -- die Gatterkette
  ring <= ring(6 downto 0) & not ring(7) when reset='0' else (others=>'0');
  -- das Symmetrier-Flipflop
  process (ring) begin
     if rising_edge(ring(7)) then
        oscff <= not oscff;
     end if;
  end process;
  -- die Ausgangszuweisung
  output <= oscff;

end architecture ;