LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of signalgenerator_2 is
--Declaration in the whole architecture
constant counter_max : integer := 100;
type GENERATOR_STATE_TYPE is 	( GENERATOR_STATE_INIT,
                                  GENERATOR_STATE_START_FIRST_PERIOD,
                                  GENERATOR_STATE_END_FIRST_PERIOD,
			 	  GENERATOR_STATE_START_SECOND_PERIOD,
                                  GENERATOR_STATE_END_SECOND_PERIOD,
                                  GENERATOR_STATE_RESET);
                                  

 signal generator_state, generator_state_next 	: GENERATOR_STATE_TYPE;
 signal periodsize , periodsize_next		: integer range 0 to 8;
 signal cnt	, cnt_next			: integer range 0 to 8;
 signal output_next				: std_logic;

begin --BEGIN ARCHITECTURE

--------------------------------------------------------------------
  --                    PROCESS : NEXT_STATE                        --
  --------------------------------------------------------------------

generator_next_state : process(generator_state, cnt, periodsize)
	begin
	generator_state_next <= generator_state;
	case generator_state is
	when GENERATOR_STATE_INIT =>
		if(periodsize != periodsize_next and cnt != cnt_next )--????????????????????????????????ß
			generator_state_next <= GENERATOR_STATE_START_FIRST_PERIOD;
		end if;
	when GENERATOR_STATE_START_FIRST_PERIOD =>
		if(cnt = 0)
			generator_state_next <= GENERATOR_STATE_END_FIRST_PERIOD;
		end if;
	when GENERATOR_STATE_END_FIRST_PERIOD =>
		if(cnt = periodsize)
			generator_state_next <= GENERATOR_STATE_START_SECOND_PERIOD;
		end if;
	when GENERATOR_STATE_START_SECOND_PERIOD=>
		if(cnt = 0)
			generator_state_next <= GENERATOR_STATE_INIT;
		end if;
	--when GENERATOR_STATE_END_SECOND_PERIOD =>	
	when GENERATOR_STATE_RESET =>
		generator_state_next <= GENERATOR_STATE_INIT ;
	end case;
		
end  process generator_next_state;


--------------------------------------------------------------------
  --                    PROCESS : OUTPUT                        --
  --------------------------------------------------------------------

generator_output : process(generator_state, cnt, periodsize)
	begin
	output_next <= '0';
	periodsize <= '1' ;
	cnt <= '0';	
	generator_state_next <= generator_state;
	case generator_state is
	when GENERATOR_STATE_INIT =>
		if(periodsize == counter_max)
			periodsize_next <= '1';
			cnt_next <= '1';
		else
			periodsize_next <= periodsize + 1;
			cnt_next <= periodsize + 1;
		end if;
	when GENERATOR_STATE_START_FIRST_PERIOD =>
		cnt_next <= cnt - 1;
		output_next <= '1';
	when GENERATOR_STATE_END_FIRST_PERIOD =>
		cnt_next <= periodsize;
	when GENERATOR_STATE_START_SECOND_PERIOD=>
		cnt_next <= cnt - 1;
		output_next <= '0';
	--when GENERATOR_STATE_END_SECOND_PERIOD =>
		
	when GENERATOR_STATE_RESET => 
		null;
	end case;	
end  process generator_output;

sync:process(clk,reset)
begin
	if(reset = '0') then
		generator_state <=  GENERATOR_STATE_RESET;
		periodsize <= '1';
		cnt <= '0';
		--output <= 0;
		output_next<='0';
	elsif rising_edge(clk) then
		generator_state <= generator_state_next;
		periodsize 	<= periodsize_next;
		cnt 		<= cnt_next;
		output  	<= output_next;
	end if;
end process sync;






end architecture ; --END ARCHITECTURE
