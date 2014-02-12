LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of signalgenerator is
--Declaration in the whole architecture
constant counter_max : integer := 100;
type GENERATOR_STATE_TYPE is 	(GENERATOR_STATE_SECOND_PERIOD,
                                 GENERATOR_STATE_FIRST_PERIOD,
                                 GENERATOR_STATE_RESET
                                 );
                                  

 signal generator_state, generator_state_next : GENERATOR_STATE_TYPE  := GENERATOR_STATE_FIRST_PERIOD;
 signal periodsize , periodsize_next: integer   := 1; -- range 0 to 8 ;
 signal cnt	, cnt_next	    : integer   := 1; --range 0 to 8;
 signal output_next	            : std_logic := '0';


begin --BEGIN ARCHITECTURE

--------------------------------------------------------------------
  --                    PROCESS : NEXT_STATE                        --
  --------------------------------------------------------------------

generator_next_state : process(generator_state, cnt, periodsize)
begin
 
	
  case generator_state is
    when GENERATOR_STATE_FIRST_PERIOD =>
      if(cnt = 1) then
        generator_state_next <= GENERATOR_STATE_SECOND_PERIOD;
      end if;
    when GENERATOR_STATE_SECOND_PERIOD =>
      if(cnt = 1) then
        generator_state_next <= GENERATOR_STATE_FIRST_PERIOD;
      end if;
    when GENERATOR_STATE_RESET =>
      generator_state_next <= GENERATOR_STATE_FIRST_PERIOD;  
  end case;
 
end  process generator_next_state;


--------------------------------------------------------------------
  --                    PROCESS : OUTPUT                        --
--------------------------------------------------------------------

generator_output : process(generator_state, cnt, periodsize)
begin
   --periodsize_next <= periodsize ;--
   --cnt_next<=cnt;
  case generator_state is	
    when GENERATOR_STATE_FIRST_PERIOD =>
      if cnt /= 1 then
        cnt_next <= cnt - 1;
        output_next <= '1';
        periodsize_next <= periodsize ;--
      else
        periodsize_next <= periodsize ;--
        cnt_next <= periodsize;
        output_next <= '0';  
      end if;
    when GENERATOR_STATE_SECOND_PERIOD =>	
      if (cnt /= 1) then
        periodsize_next <= periodsize ;
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
    when GENERATOR_STATE_RESET =>
      periodsize_next <= 1 ;
      cnt_next        <= 1 ;
      output_next     <='1';

  end case;       
end  process generator_output;
--------------------------------------------------------------------
  --                    PROCESS : SYNC                        --
--------------------------------------------------------------------

sync:process(clk,reset)
begin
    if rising_edge(clk) then
     if( reset='1') then     
       generator_state   <=  GENERATOR_STATE_RESET;
       output            <= '0';
       periodsize 	 <=  1;
       cnt 	         <=  1;
       output  	         <= '0';
     else
       generator_state   <= generator_state_next;
       periodsize 	 <= periodsize_next;
       cnt 		 <= cnt_next;
       output  	         <= output_next;
    end if;
 end if;
end process sync;
end architecture ; --END ARCHITECTURE
