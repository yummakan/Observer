LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of signalgenerator is
--Declaration in the whole architecture
constant counter_max : integer := 100;
type GENERATOR_STATE_TYPE is 	( 	GENERATOR_STATE_SECOND_PERIOD,
                                 GENERATOR_STATE_FIRST_PERIOD
                                
										);
                                  

 signal generator_state, generator_state_next 			: GENERATOR_STATE_TYPE  := GENERATOR_STATE_FIRST_PERIOD;
 signal periodsize , periodsize_next: integer := 1; -- range 0 to 8 ;
 signal cnt	, cnt_next								: integer   := 1; --range 0 to 8;
 signal output_next												: std_logic := '0';


begin --BEGIN ARCHITECTURE

--------------------------------------------------------------------
  --                    PROCESS : NEXT_STATE                        --
  --------------------------------------------------------------------

generator_next_state : process(generator_state, cnt, periodsize)
	begin
	generator_state_next <= generator_state;
	
 
	case generator_state is
	
	
	when GENERATOR_STATE_FIRST_PERIOD =>
		if(cnt = 1) then
			generator_state_next <= GENERATOR_STATE_SECOND_PERIOD;
		end if;
		
	
	
	when GENERATOR_STATE_SECOND_PERIOD =>
		if(cnt = 1) then
			generator_state_next <= GENERATOR_STATE_FIRST_PERIOD;
		end if;
		
	--when GENERATOR_STATE_END_SECOND_PERIOD =>	
	--when GENERATOR_STATE_RESET =>
	--	if(periodsize=1)and(cnt=1)then
	--		generator_state_next <= GENERATOR_STATE_CHECK ;
	--	end if;
	end case;
 
end  process generator_next_state;


--------------------------------------------------------------------
  --                    PROCESS : OUTPUT                        --
  --------------------------------------------------------------------

generator_output : process(generator_state, cnt, periodsize)

	begin
	periodsize_next <= periodsize ;
	cnt_next <= cnt;
 
	
	case generator_state is
	
	
	when GENERATOR_STATE_FIRST_PERIOD =>
	  if cnt /= 1 then
		  cnt_next <= cnt - 1;
		  output_next <= '1';
		else 
		  cnt_next <= periodsize;
		  output_next <= '0';  
		end if;

	
	when GENERATOR_STATE_SECOND_PERIOD =>	
			if (cnt /= 1) then
			   cnt_next <= cnt - 1 ;
			   output_next <= '0';
			elsif ( (periodsize + 1) <= counter_max) then
			 periodsize_next <= periodsize + 1;
			 cnt_next <= periodsize + 1;
			 output_next <= '1';
			else
			  periodsize_next <= 1;
			  cnt_next <= 1;
			  output_next <= '1';
			  
		  end if;
	--when GENERATOR_STATE_RESET => 
	--	periodsize_next <= 1;
	--	cnt_next<=1;
	--	output_next<='0';
		
	end case;
 
end  process generator_output;

sync:process(clk)
variable reset_event: boolean :=FALSE;
begin
	
 if rising_edge(clk) then
	if( reset='0' and not reset_event) then
		generator_state <=  GENERATOR_STATE_FIRST_PERIOD ;
		reset_event := TRUE;
		--not allowed to set this signals, already set in another process
		--generator_state_next <= GENERATOR_STATE_RESET;
		--periodsize_old<=1;
		--cnt_old<=1;
		--periodsize <= 1;
		--cnt <= 1;
		output <= '0';
		periodsize 	<= 1;
		cnt 		<= 1;
		output  	<= '0';
		--output_next<='0';
	else
	
		if(reset='1') then
			reset_event := FALSE;
		end if;
		generator_state <= generator_state_next;
		periodsize 	<= periodsize_next;
		cnt 		<= cnt_next;
		output  	<= output_next;
   end if;
 end if;
end process sync;






end architecture ; --END ARCHITECTURE
