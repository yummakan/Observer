
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of observer is

signal count,inc_tau				: unsigned(8 downto 0):= (others => '0');


begin --BEGIN ARCHITECTURE


  --parallel logic
  inc_tau <= unsigned(invariance_tau) +  to_unsigned(1,9) ;
	
  sync: process(clk)
    variable count_reset :std_logic := '0';
    variable cycle :unsigned(15 downto 0):=(others => '0');
    variable switch :std_logic :='0';
		 
  begin
    --output_next <= output;
    
    if (reset = '0') then
      if(clk'event and clk = '0')then
        --cycle_next <= cycle;
        if((enable_in='1')) then	
          -- part of algorithm  begin
          if(cycle = observernumber) then -- m cycles passed
            if(signal_phi = '0') then   -- if w(phi) = 0)
              count_reset := '1';
            end if;
            cycle := to_unsigned(1,16);
          else
            cycle := cycle + 1; --every clock cycle
          end if;
          
          if(count_reset = '1') then
            count_reset := '0';
            count <= "000000001";
            output <= '0';
          elsif((count+1)<= inc_tau) then
            count <= count + 1; --every clock cycle
          else
            output<= '1';
          end if;
          
          if(switch = '1') then
            enable_out <= '1';
          else 
            switch := '1';
          end if;
        else
          output		<=	'0';
          count 	<= (others => '0');
          enable_out	<=  '0';
          switch :='0';
        end if;--if(enable_in)
      end if;--if(clk'event)	
    else
      output        <=	'0';
      count 	<= (others => '0');
      enable_out	<=  '0';
      switch :='0';
    end if;--if(reset)
  end process sync;
end architecture ; --END ARCHITECTURE
