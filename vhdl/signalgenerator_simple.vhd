LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;



architecture simple of signalgenerator is
--Declaration in the whole architecture
--constant counter_max : integer := 100;


 
 
 signal cnt						: unsigned(7 downto 0)		:= x"00"; 
 signal cnt_p					: unsigned(7 downto 0)		:= x"01"; 
 signal div,div_next	: unsigned(7 downto 0)		:= x"01"; 
 signal switch_up	: std_logic 							:= '0';
 signal output_next:std_logic 							:= '1';--start with HIGH LEVEL
 signal output_copy :std_logic 							:= '0';
 signal modular			:   unsigned(7 downto 0)		:= x"00";
-- while (counter < limit) loop
  --      CYCLE(clk_s);
--		if(phi_s = '0')then
--			switch_up := '0';
--		elsif(switch_up = '0')then
--			x :=x+2;
--			switch_up := '1';			
--		end if;
--		if((counter mod x) = 0)then
--			phi_s <= not phi_s;
--		end if;
-- loop end;

begin --BEGIN ARCHITECTURE


comb_1: process(output_copy,cnt)
begin --if cnt = 0 mybe reset='1' or cnt exceed maximum
	if(output_copy = '0')then
		switch_up <= '0';
		div_next <= div;
	elsif(output_copy = '1' and switch_up = '0')then
		div_next <= div + 1;
		switch_up <='1';
	elsif(output_copy = '1' and switch_up = '1')then			
		div_next <= div;
		switch_up <='1';
	elsif(cnt = x"00")then
		div_next <= x"01";
		switch_up <='0';
	end if;
end process comb_1;


comb_2: process(modular,output_copy,reset)
begin
	if(modular = x"00" and reset='0')then
		output_next <= not output_copy;
	else
		output_next <= output_copy;
	end if;
end process comb_2;




sync:process(clk,reset)
begin
  if rising_edge(clk) then
		if( reset='0') then  
			output <= output_next;
			output_copy <= output_next;	
			modular <= cnt_p mod div_next;		
			div <= div_next;
			cnt <= cnt + 1;
			cnt_p <= cnt_p + 1;	
    else
			output   <= '0';
		  output_copy <= '0';
			modular  <= x"00";
			div      <= x"01";
    	cnt 		 <= x"00";
			cnt_p		<= x"01";
    end if;
 end if;
end process sync;
end architecture ; --END ARCHITECTURE
