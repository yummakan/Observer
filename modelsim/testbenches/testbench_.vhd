LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY \testbench_\  IS 
END ; 
 
ARCHITECTURE \testbench__arch\   OF \testbench_\   IS
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
-- Start Time = 0 ns, End Time = 1 us, Period = 10 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 5 ns ;
-- 5 ns, single loop till start period.
	for Z in 1 to 99
	loop
	    clk  <= '1'  ;
	   wait for 5 ns ;
	    clk  <= '0'  ;
	   wait for 5 ns ;
-- 995 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 5 ns ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 100 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 reset  <= '0'  ;
	wait for 100 ns ;
	 reset  <= '1'  ;
	wait for 900 ns ;
-- dumped values till 1 us
	wait;
 End Process;
END;
