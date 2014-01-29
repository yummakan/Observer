

LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.NUMERIC_STD.all  ; 

ENTITY multiple_observer_testbench  IS 
END ; 


ARCHITECTURE testbench_arch  OF multiple_observer_testbench   IS
  
  constant CLOCK_PERIOD :time := 20ns;
   
  
  SIGNAL output_tb   :  STD_LOGIC  ; 
  SIGNAL clk_tb      :  STD_LOGIC  ; 
  SIGNAL reset_tb    :  STD_LOGIC  ;
  SIGNAL enable_tb  :  STD_LOGIC  ;
  SIGNAL tau_tb      :  std_logic_vector(7 downto 0);
  SIGNAL next_obs_tb :  STD_LOGIC  ;
  SIGNAL phi_tb      :  STD_LOGIC  ;
  
  SIGNAL en1,en2    :   STD_LOGIC  ;
  SIGNAL add1,add2,add3:STD_LOGIC;
  
  procedure CYCLE(
        signal clk : out std_logic) is
    begin
        wait for CLOCK_PERIOD;
        clk <= '1';
        wait for CLOCK_PERIOD;
        clk <= '0';
  end procedure;
  
  
  
  COMPONENT observer 
    generic ( 
        observernumber : unsigned(15 downto 0):=x"0001"  -- how many observer are instantiated
      ); 
    PORT ( 
        clk 				     :in	std_logic;
	      reset				    :in 	std_logic;
	      enable_in		  :in   std_logic;
	      invariance_tau:in 	std_logic_vector(7 downto 0);
	      signal_phi		 :in	std_logic;
	      output			    :out  std_logic;
	      enable_out		 :out	std_logic
    ); 
  END COMPONENT ; 
    
  FOR OBS_1 : observer 
    use entity 
        work.observer(Behavioural); 
  FOR OBS_2 : observer 
    use entity 
        work.observer(Behavioural); 
  FOR OBS_3 : observer 
    use entity 
        work.observer(Behavioural);  
    
    
  COMPONENT signalgenerator
    PORT(
      clk 		:in	std_logic;
	    reset		:in 	std_logic;
	    output		:out  std_logic
      );
  END COMPONENT;
  
BEGIN
  
  SIG : signalgenerator PORT MAP (  clk => clk_tb, reset=>reset_tb, output=>phi_tb );  
  
  OBS_1  :  observer GENERIC MAP(observernumber => x"0003") PORT MAP ( output=>add1,clk=>clk_tb,reset =>reset_tb,enable_in => enable_tb,invariance_tau => tau_tb,signal_phi=> phi_tb,enable_out=> en1) ; 
  OBS_2  :  observer GENERIC MAP(observernumber => x"0003") PORT MAP ( output=>add2,clk=>clk_tb,reset =>reset_tb,enable_in => en1,invariance_tau => tau_tb,signal_phi=> phi_tb,enable_out=> en2) ; 
  OBS_3  :  observer GENERIC MAP(observernumber => x"0003") PORT MAP ( output=>add3,clk=>clk_tb,reset =>reset_tb,enable_in => en2,invariance_tau => tau_tb,signal_phi=> phi_tb,enable_out=> next_obs_tb) ;
    
    
   output_tb <= (add1  and add2 and add3); 
    
    
    -- Begin of testbench
    process
      begin
      --initialize all signals
      enable_tb <= '0';
      reset_tb <= '0';
      clk_tb <= '0';
      tau_tb<= std_logic_vector(to_unsigned(3,8));
      --begin process
      CYCLE(clk_tb);--1
      CYCLE(clk_tb);--2
      CYCLE(clk_tb);--3
      CYCLE(clk_tb);--4
      CYCLE(clk_tb);--5
      CYCLE(clk_tb);--6
      CYCLE(clk_tb);--7
      CYCLE(clk_tb);--8
      CYCLE(clk_tb);--9
      enable_tb <= '1';
      CYCLE(clk_tb);--10
      assert(en1 = '1');
      CYCLE(clk_tb);--12
      assert(en2 = '1');
      CYCLE(clk_tb);--13
      assert(next_obs_tb = '1');
      CYCLE(clk_tb);--14
      CYCLE(clk_tb);--15
      CYCLE(clk_tb);--16
      CYCLE(clk_tb);--17
      CYCLE(clk_tb);--18
      CYCLE(clk_tb);--19
      CYCLE(clk_tb);--20
      CYCLE(clk_tb);--21
      CYCLE(clk_tb);--22
      CYCLE(clk_tb);--23
      CYCLE(clk_tb);--24
      CYCLE(clk_tb);--25
      CYCLE(clk_tb);--26
      CYCLE(clk_tb);--27
      CYCLE(clk_tb);--28
      CYCLE(clk_tb);--29
      CYCLE(clk_tb);--30
      CYCLE(clk_tb);--31
      CYCLE(clk_tb);--32
      CYCLE(clk_tb);--33
      CYCLE(clk_tb);--34
      CYCLE(clk_tb);--35
      CYCLE(clk_tb);--36
      CYCLE(clk_tb);--37
      CYCLE(clk_tb);--38
      CYCLE(clk_tb);--39
      CYCLE(clk_tb);--40
      CYCLE(clk_tb);--41
      CYCLE(clk_tb);--42
      CYCLE(clk_tb);--43
      CYCLE(clk_tb);--44
      CYCLE(clk_tb);--45
      CYCLE(clk_tb);--46
      CYCLE(clk_tb);--47
      CYCLE(clk_tb);--48
      CYCLE(clk_tb);--49
      CYCLE(clk_tb);--50
      reset_tb <= '0';
      CYCLE(clk_tb);--51
      CYCLE(clk_tb);--52
      CYCLE(clk_tb);--53
      CYCLE(clk_tb);--54
      CYCLE(clk_tb);--55
      reset_tb <= '1';
      CYCLE(clk_tb);--56
      CYCLE(clk_tb);--57
      CYCLE(clk_tb);--58
      CYCLE(clk_tb);--59
      CYCLE(clk_tb);--60
      CYCLE(clk_tb);--61      
      CYCLE(clk_tb);--62
      CYCLE(clk_tb);--63
      CYCLE(clk_tb);--64
      CYCLE(clk_tb);--65
      CYCLE(clk_tb);--66
      CYCLE(clk_tb);--67
      CYCLE(clk_tb);--68
      CYCLE(clk_tb);--69
      CYCLE(clk_tb);--70
      CYCLE(clk_tb);--71
      CYCLE(clk_tb);--72
      CYCLE(clk_tb);--73
      CYCLE(clk_tb);--74
      CYCLE(clk_tb);--75
      CYCLE(clk_tb);--76
      CYCLE(clk_tb);--77
      CYCLE(clk_tb);--78
      CYCLE(clk_tb);--79
      CYCLE(clk_tb);--80
      CYCLE(clk_tb);--81
      CYCLE(clk_tb);--80
      CYCLE(clk_tb);--82
      CYCLE(clk_tb);--83
      CYCLE(clk_tb);--84
      CYCLE(clk_tb);--85
      CYCLE(clk_tb);--86
      CYCLE(clk_tb);--87
      CYCLE(clk_tb);--88
      CYCLE(clk_tb);--89
      CYCLE(clk_tb);--90
      CYCLE(clk_tb);--91
      CYCLE(clk_tb);--92
      CYCLE(clk_tb);--93
      CYCLE(clk_tb);--94
      CYCLE(clk_tb);--95
      CYCLE(clk_tb);--96
      CYCLE(clk_tb);--97
      CYCLE(clk_tb);--98
      CYCLE(clk_tb);--99
      CYCLE(clk_tb);--100
            
      
      
      
    end process;
    --End of testbench
      
    
END;
