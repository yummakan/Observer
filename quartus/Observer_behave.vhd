LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture Behavioural of observer is

constant observernumber : integer := 1;
signal count,inc_tau		: unsigned(8 downto 0):= (others => '0');
signal cycle , status	: integer := 0;
begin --BEGIN ARCHITECTURE
	--parallel logic
	inc_tau <= unsigned(invariance_tau) + 1 ;
	--parallel logic
	sync: process(clk)
	--=sequentiel logic
	begin
	if (reset = '1') then
		if(rising_edge(clk))then
			if(enable_in = '1') then
				status <= 1;
			end if;
			if(status = 1) then --muss gelöscht werden, da die ausführung unmittelbar erfolensoll
									 -- nur enable_out soll einen taktzyklus später erfolgen
				if(cycle = observernumber)then
					if(signal_phi = '0') then
						count <= "00000000";
						cycle <= 0;
					end if;
				else
					cycle <= cycle + 1 ;
				end if;
					
				
				if(count = inc_tau) then
					output <= '1'; -- should be in a aparallel statement
				else
					output <= '0';
				end if;
				
				if( (count	+ 1) <= inc_tau ) then
					count <= count + 1;
				end if;
				--after one clock cycle
				enable_out <= '1';
				
			end if;
		end if;	
	else
		output		<=	'0';
		status 		<= 0;
		cycle 		<= 0;
		count 		<= (others => '0');
		enable_out	<=  '0';
		--status_out <= 	0;
	end if;
	end process sync;
	
	

end architecture ; --END ARCHITECTURE