LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of observer is

--constant observernumber 			 							: integer := 1;
--constant one                       : unsigned(8 downto 0) := ( others => '0';one(0)='1');
signal count,count_next,inc_tau				: unsigned(8 downto 0):= (others => '0');
signal cycle,cycle_next														: integer := 1;
signal output_next		: std_logic := '0';
begin --BEGIN ARCHITECTURE


	--parallel logic
	inc_tau <= unsigned(invariance_tau) +  to_unsigned(1,9) ;
	
	
	
	async: process(count,cycle,enable_in)
		variable count_reset :integer := 0;
	begin
		count_next <= 	count;
		cycle_next <= cycle;
		if((enable_in='1')) then
			-- part of algorithm  begin
		  if(cycle = observernumber) then -- m cycles passed
			 if(signal_phi = '0') then   -- if w(phi) = 0)
				  count_reset := 1;
			 end if;
			 cycle_next <= 0;
		  else
		    cycle_next <= cycle + 1; --every clock cycle
		  end if;
	 
		  if(count_reset = 1) then
			 count_reset := 0;
			 count_next <= "000000001";
			 output_next <= '0';
		  elsif((count+1)<= inc_tau) then
			 count_next <= count + 1; --every clock cycle
		   if((count+1) = inc_tau) then
			   output_next <= '1';
		   end if; 
		  end if;
	 end if;
	end process async;
	
	
	
	
	
	--parallel logic
	sync: process(clk,reset)
	--variable switch_enable_out :integer := 0;
	begin    -- count darf kein signal sein , da Änderungen sofort passieren müssen !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	if (reset = '1') then
		if(clk'event)then
			if(enable_in = '1') then
			
				count<=count_next;
				cycle <= cycle_next;
			  enable_out <= '1';

			end if;
			output <= output_next;
		end if;
	
		
	else
		output		<=	'0';
		--cycle 		<= 0;
		count 		<= (others => '0');
		enable_out	<=  '0';
		--switch_enable_out:=0;
		--status_out <= 	0;
	end if;
	
	--parallel logic
	--output <= output_next;
	
	end process sync;
	
	

end architecture ; --END ARCHITECTURE