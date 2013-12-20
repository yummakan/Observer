LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of signalgenerator is
--Declaration in the whole architecture
constant counter_max : integer := 100;
type GENERATOR_STATE_TYPE is 	( 	GENERATOR_STATE_CHECK,
                                 GENERATOR_STATE_START_FIRST_PERIOD,
                                 GENERATOR_STATE_END_FIRST_PERIOD,
											GENERATOR_STATE_START_SECOND_PERIOD,
											GENERATOR_STATE_NEXT_PERIOD,
                                 --GENERATOR_STATE_END_SECOND_PERIOD,
                                 GENERATOR_STATE_RESET);
                                  

 signal generator_state, generator_state_next 	: GENERATOR_STATE_TYPE  := GENERATOR_STATE_CHECK;
 signal periodsize , periodsize_next,periodsize_old	: integer := 1; -- range 0 to 8 ;
 signal cnt	, cnt_next,cnt_old			: integer   := 1; --range 0 to 8;
 signal output_next		,output_current		: std_logic;


begin --BEGIN ARCHITECTURE

--------------------------------------------------------------------
  --                    PROCESS : NEXT_STATE                        --
  --------------------------------------------------------------------

generator_next_state : process(generator_state, cnt,cnt_old, periodsize,periodsize_old)
	begin
	generator_state_next <= generator_state;
	
	case generator_state is
	
	when GENERATOR_STATE_CHECK =>
			if((periodsize >= 1 and periodsize <=counter_max)) then
				generator_state_next <= GENERATOR_STATE_START_FIRST_PERIOD;
			end if;

	
	
	when GENERATOR_STATE_START_FIRST_PERIOD =>
		if(cnt <= 1) then
			generator_state_next <= GENERATOR_STATE_END_FIRST_PERIOD;
		end if;
		
	when GENERATOR_STATE_END_FIRST_PERIOD =>
		if(cnt = periodsize) then
			generator_state_next <= GENERATOR_STATE_START_SECOND_PERIOD;
		end if;
		
	when GENERATOR_STATE_START_SECOND_PERIOD=>
		if(cnt <= 1) then
			generator_state_next <= GENERATOR_STATE_NEXT_PERIOD;
		end if;
		
	when GENERATOR_STATE_NEXT_PERIOD =>
		if(periodsize = periodsize_old + 1) then
			generator_state_next <= GENERATOR_STATE_CHECK;
		end if;
	--when GENERATOR_STATE_END_SECOND_PERIOD =>	
	when GENERATOR_STATE_RESET =>
		generator_state_next <= GENERATOR_STATE_CHECK ;
	end case;
		
end  process generator_next_state;


--------------------------------------------------------------------
  --                    PROCESS : OUTPUT                        --
  --------------------------------------------------------------------

generator_output : process(generator_state, cnt, periodsize)
	begin
	---periodsize_next <= periodsize ;
	--cnt_next <= cnt;	
	
	
	case generator_state is
	
	when GENERATOR_STATE_CHECK =>
		if(periodsize < 1 or periodsize > counter_max) then
			periodsize_old <= 1;
			cnt_old <= 1;
			periodsize_next <= 1;
			cnt_next <= 1;
		elsif(periodsize >=1 and periodsize <= counter_max) then
		  periodsize_old <= periodsize;
		  cnt_old <= cnt;
		  periodsize_next <= periodsize + 1;
		  cnt_next <= periodsize + 1;
		end if;
		
	when GENERATOR_STATE_START_FIRST_PERIOD =>
		cnt_next <= cnt - 1;
		output_next <= '1';
		
	when GENERATOR_STATE_END_FIRST_PERIOD =>
		cnt_next <= periodsize;-- ??? driver problem maybe
		--output_next <= '0'; -- maybe should set up here !!!!!!!!!!!!!!!
	when GENERATOR_STATE_START_SECOND_PERIOD=>
		cnt_next <= cnt - 1;
		output_next <= '0';
	--when GENERATOR_STATE_END_SECOND_PERIOD =>
	when GENERATOR_STATE_NEXT_PERIOD =>	
			periodsize_old <= periodsize;
			periodsize_next <= periodsize + 1;
			cnt_old <= cnt;
			cnt_next <= periodsize + 1;
			
	when GENERATOR_STATE_RESET => 
		null;
	end case;	
end  process generator_output;

sync:process(clk)
begin
--	if(reset='0') then
	--	generator_state <=  GENERATOR_STATE_RESET;
		--periodsize_old<=periodsize;
		--cnt_old<=cnt;
--		periodsize <= 1;
	--	cnt <= 1;
	--	output <= '1';
		--output_next<='0';
	if rising_edge(clk) then
		generator_state <= generator_state_next;
		periodsize 	<= periodsize_next;
		--periodsize_old<=periodsize;
		--cnt_old<=cnt;
		cnt 		<= cnt_next;
		output  	<= output_next;
		output_current <= output_next;
	end if;
end process sync;






end architecture ; --END ARCHITECTURE
