LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of observer is

constant observernumber 			 							: integer := 1;
signal count,count_next,inc_tau								: unsigned(8 downto 0):= (others => '0');
signal cycle														: integer := 0;
signal cycle_reset ,output_next		: std_logic := '0';
begin --BEGIN ARCHITECTURE


	--parallel logic
	inc_tau <= unsigned(invariance_tau) + 1 ;
	
	
	
	async: process(count,cycle)
		variable count_reset :integer := 0;
	begin
		count_next <= 	count;
		
		
			-- part of algorithm  begin
		if(cycle = observernumber) then -- m cycles passed
			if(signal_phi = '0') then   -- if w(phi) = 0)
				count_reset := 1;
			end if;
			cycle_reset <= '0';
		end if;
	
		if((count = inc_tau) and (count_reset = 0)) then
			output_next <= '1';
		else
			output_next <= '0';
		end if;
		
		if(count_reset = 1) then
			count_reset := 0;
			count_next <= "000000000";
		elsif((count+1)< inc_tau) then
			count_next <= count + 1;
		end if;
		
		end process async;
	
	
	
	
	
	--parallel logic
	sync: process(clk,reset)
	variable switch_enable_out :integer := 0;
	begin    -- count darf kein signal sein , da Änderungen sofort passieren müssen !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	if (reset = '1') then
		if(rising_edge(clk))then
			if(enable_in = '1') then
			
				count<=count_next;
				
				if(cycle_reset = '1')then
					cycle <= 0;
				else 
					cycle <= cycle + 1;
				end if;
				
				if(switch_enable_out = 1) then
					enable_out <= '1';
				else
					switch_enable_out := 1;
				end if;
		
			end if;
			output <= output_next;
		end if;
	
		
	else
		output		<=	'0';
		cycle 		<= 0;
		count 		<= (others => '0');
		enable_out	<=  '0';
		switch_enable_out:=0;
		--status_out <= 	0;
	end if;
	
	--parallel logic
	--output <= output_next;
	
	end process sync;
	
	

end architecture ; --END ARCHITECTURE