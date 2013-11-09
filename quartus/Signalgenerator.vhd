LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

ENTITY signalgenerator IS
Generic ( n: integer   := 100;  -- counter maximum for outer loop 
          
         ); 
PORT (

   --clk 		:IN	std_logic;
	reset		:IN 	std_logic;
	output	:OUT  std_logic;

)

END signalgenerator;

/*
ARCHITECTURE Behavioural OF signalgenerator
 signal oscff   : std_logic := '0';
 signal ring    : std_logic_vector(7 downto 0);
 attribute KEEP of ring : signal is "true"; 
BEGIN
	PROCESS(clk)
	 variable counter: unsigned (7 downto 0);
	BEGIN
	counter := "00000000";
		if rising_edge(clk) then
			if counter = n then
				counter := "00000000";
			end if;
		end if;
	
	END PROCESS;


END Behavioural ;
*/

ARCHITECTURE Behavioural OF signalgenerator
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

END Behavioural ;