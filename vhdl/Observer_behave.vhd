
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of observer is

signal inc_tau	     								 : unsigned(8 downto 0):= "000000000";
--signal count_next       	     			 : unsigned(8 downto 0):= "000000001";
signal count_p,count_p_next	         : unsigned(8 downto 0):= "000000010";
signal cycle,cycle_next              : unsigned(15 downto 0) := x"0000";
signal direction,direction_next      : std_logic := '1';      
signal enable_logic                  : std_logic := '0';
signal output_next									 : std_logic := '0';				
begin --BEGIN ARCHITECTURE

  --parallel logic
  inc_tau <= unsigned(invariance_tau) + to_unsigned(1,9) ;
  enable_logic <= enable_in and not reset;

-- changes cycle up from 0 to observernumber and down back to 0
comb_cycle: process(cycle,enable_logic)
begin --changes cycle_next, direction, changeDirection
  if(direction = '0' and enable_logic = '1') then
    if(cycle = 0)then
      direction_next <= '1';
      cycle_next <= cycle + 1;
    else
      direction_next <= '0';
      cycle_next <= cycle - 1;
    end if;
  elsif(direction = '1' and enable_logic = '1') then
    if(cycle = observernumber)then
      direction_next <= '0';
      cycle_next <= cycle - 1;
    else
      direction_next <= '1';
      cycle_next <= cycle + 1;
    end if;
  else
    direction_next <= direction;
    cycle_next <= cycle;
  end if;
end process comb_cycle;     


 -- main logic of the observer
comb_logic: process(count_p,cycle,enable_logic)
begin --changes  count_next,output_next
  if ( (cycle = observernumber  or cycle = 0) and enable_logic = '1') then -- m cycles passed    
    if(signal_phi = '0') then   -- if w(phi) = 0)
      count_p_next <= "000000010";
      output_next  <= '0';
    elsif(count_p <= inc_tau) then
      count_p_next <= count_p + 1 ;
		  output_next       <= '0';
    else
      count_p_next <= count_p;
      output_next       <= '1';
    end if; 
 -- elsif(cycle /= observernumber  and cycle /= 0 and enable_logic = '1')then
  elsif(count_p <= inc_tau and enable_logic = '1') then
    --this elsif branch only reached if m > 1 (multiple observer)
    count_p_next <= count_p + 1 ;
		output_next       <= '0';
  elsif(count_p > inc_tau and enable_logic = '1') then
    --this elsif branch only reached if m > 1 (multiple observer)
    count_p_next <= count_p;
    output_next  <= '1';
  else
    count_p_next <= count_p;
    output_next  <= '0';
  end if;
end process comb_logic;




  --the synchronisation logic
  sync: process(clk,enable_logic)
  begin
    if(clk'event and clk = '0')then
      if(enable_logic = '1') then
        cycle           <= cycle_next;
        direction       <= direction_next;
        count_p		      <= count_p_next;
				output    <= output_next;
        enable_out      <= '1';
      else
        cycle           <= x"0000";
				direction       <='1';
        count_p		<= "000000010";
				output    <= '0';
				enable_out      <=  '0';
      end if;--if(enable_in)and (reset=0)
    end if;--if(clk'event)  
  end process sync;
end architecture ; --END ARCHITECTURE
