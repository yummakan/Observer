
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of observer is

signal count,count_next,inc_tau	        : unsigned(8 downto 0):= "000000001";
signal cycle,cycle_next                 : unsigned(15 downto 0) := x"0000";
signal direction,direction_next                        : std_logic := '1';      
begin --BEGIN ARCHITECTURE

  --parallel logic
  inc_tau <= unsigned(invariance_tau) + to_unsigned(1,9) ;


-- changes cycle up from 0 to observernumber and down back to 0
comb_cycle: process(cycle,reset,enable_in)
begin --changes cycle_next, direction, changeDirection
  if(reset = '0' and enable_in = '1')then
    if(direction = '0') then
      if(cycle = 0)then
         direction_next <= '1';
         cycle_next <= cycle + 1;
      else
         direction_next <= '1';
         cycle_next <= cycle - 1;
      end if;
    elsif(direction = '1') then
      if(cycle = observernumber)then
         direction_next <= '0';
         cycle_next <= cycle - 1;
      else
         direction_next <= '0';
         cycle_next <= cycle + 1;
      end if;
    end if;
  else
   direction_next <= direction;
   cycle_next <= cycle;
  end if;
end process comb_cycle;     


 -- main logic of the observer
comb_logic: process(count,cycle,reset,enable_in)
begin --changes  count_next,output_next
  if(reset = '0' and enable_in = '1')then 
    if((cycle = observernumber)  or (cycle = 0)) then -- m cycles passed    
      if(signal_phi = '0') then   -- if w(phi) = 0)
        count_next <= "000000001";
        output<= '0';
      elsif((count+1) <= inc_tau) then
        count_next <= count + 1; --every clock cycle
      else
        output<= '1';
      end if; 
    else
      if((count+1)<= inc_tau) then
        --this elsif branch only reached if m > 1 (multiple observer)
        count_next <= count + 1; --every clock cycle
      else
        --this elsif branch only reached if m > 1 (multiple observer)
        output<= '1';
      end if;
    end if;
  else 
    count_next <= count;
    output<= '0';
  end if;
end process comb_logic;




  --the synchronisation logic
  sync: process(clk,reset,enable_in)
  begin
    if(clk'event and clk = '0')then
      if((enable_in='1') and (reset = '0')) then
        cycle           <= cycle_next;
        direction       <= direction_next;
        count           <= count_next;
        enable_out      <= '1';
      else
        enable_out      <=  '0';
        cycle           <= x"0000";
        count           <= "000000001";
        direction       <='1';
      end if;--if(enable_in)and (reset=0)
    end if;--if(clk'event)  
  end process sync;
end architecture ; --END ARCHITECTURE
