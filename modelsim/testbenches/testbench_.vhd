LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY \testbench_.vhd\  IS 
END ; 
 
ARCHITECTURE \testbench_.vhd_arch\   OF \testbench_.vhd\   IS
  SIGNAL output   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT signalgenerator_2  
    PORT ( 
      output  : out STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : signalgenerator_2  
    PORT MAP ( 
      output   => output  ,
      clk   => clk  ,
      reset   => reset   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 40 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 20 ns ;
-- 20 ns, single loop till start period.
	for Z in 1 to 24
	loop
	    clk  <= '1'  ;
	   wait for 20 ns ;
	    clk  <= '0'  ;
	   wait for 20 ns ;
-- 980 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 20 ns ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 300 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 reset  <= '0'  ;
	wait for 200 ns ;
	 reset  <= '1'  ;
	wait for 100 ns ;
	 reset  <= '0'  ;
	wait for 700 ns ;
-- dumped values till 1 us
	wait;
 End Process;
END;
