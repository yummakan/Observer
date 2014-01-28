
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of observer is

signal count,count_next,inc_tau				: unsigned(8 downto 0):= (others => '0');
signal reset_cycle : std_logic := '0';
signal cycle : unsigned(15 downto 0) := (others => '0');
signal output_next : std_logic := '0';

begin --BEGIN ARCHITECTURE


  --parallel logic
  inc_tau <= unsigned(invariance_tau) +  to_unsigned(1,9) ;


 comb: process(cycle,count)
   
 begin
   count_next <= count;
    -- part of algorithm  begin
   if(cycle > observernumber) then -- m cycles passed
     if(signal_phi = '0') then   -- if w(phi) = 0)
      count_next <= "000000001";
      output_next <= '0';
     end if;
     reset_cycle <= '1';
   else
     reset_cycle <= '0';
     if((count+1)<= inc_tau) then
       count_next <= count + 1; --every clock cycle
     else
       output_next<= '1';
     end if;
   end if;
 end process comb;




  
  sync: process(clk,reset)
    --variable count_reset :std_logic := '0';
    --variable cycle :unsigned(15 downto 0):=(others => '0');
		 
  begin
    --output_next <= output;
    
    if (reset = '0') then
      if(clk'event and clk = '0')then
        if((enable_in='1')) then
          if(reset_cycle = '1')then
            cycle <= to_unsigned(1,16);
          else
            cycle <= cycle + 1;
          end if;
          count <= count_next;
          output<= output_next;
          
          enable_out <= '1';

        else
          output		<=	'0';
          count 	<= (others => '0');
          enable_out	<=  '0';
          
        end if;--if(enable_in)
      end if;--if(clk'event)	
    else
      output        <=	'0';
      count 	<= (others => '0');
      enable_out	<=  '0';
    end if;--if(reset)
  end process sync;
end architecture ; --END ARCHITECTURE
