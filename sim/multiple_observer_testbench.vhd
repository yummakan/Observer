

LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.NUMERIC_STD.all  ; 

ENTITY multiple_observer_testbench  IS 
END ; 


architecture testbench_arch  OF multiple_observer_testbench   IS
  
  constant CLOCK_PERIOD :time := 20ns;
   

  procedure CYCLE(
    signal clk : out std_logic) is
  begin
    clk <= '1';
    wait for CLOCK_PERIOD;
    clk <= '0';
     wait for CLOCK_PERIOD;
  end procedure;
  
  component signalgenerator
    port(
      clk 		:in	std_logic;
      reset		:in 	std_logic;
      output		:out  std_logic
      );
  end component;


 component observer 
    generic ( 
      observernumber : unsigned(15 downto 0):=x"0001"  -- how many observer are instantiated
      ); 
    port ( 
      clk 				     :in	std_logic;
      reset				    :in 	std_logic;
      enable_in		  :in   std_logic;
      invariance_tau:in 	std_logic_vector(7 downto 0);
      signal_phi		 :in	std_logic;
      output			    :out  std_logic;
      enable_out		 :out	std_logic
      ); 
  end component ; 
    

-------------------------------------------------------------------------------
--  <BEGIN_0>
  for OBS_1 : observer 
    use entity 
        work.observer(Behavioural); 
  for OBS_2 : observer 
    use entity 
        work.observer(Behavioural); 
  for OBS_3 : observer 
    use entity 
        work.observer(Behavioural);  
--  <END_0>
-------------------------------------------------------------------------------

signal output_s   :  STD_LOGIC := '0'; 
signal clk_s      :  STD_LOGIC := '0'; 
signal reset_s    :  STD_LOGIC := '0';
signal enable_s   :  STD_LOGIC := '0';
signal tau_s      :  std_logic_vector(7 downto 0) := (others => '0');
signal next_obs_s :  STD_LOGIC  := '0';
signal phi_s      :  STD_LOGIC := '0';
-------------------------------------------------------------------------------
-- <BEGIN_1> 
signal en1,en2    :   STD_LOGIC;
signal add1,add2,add3:STD_LOGIC;
-- <END_1>
-------------------------------------------------------------------------------
  
begin
  
SIG : signalgenerator port map (  clk => clk_s, reset=>reset_s, output=>phi_s );  

-------------------------------------------------------------------------------
-- <BEGIN_2> 
  OBS_1  :  observer generic map(observernumber => x"0003") port map ( output=>add1,clk=>clk_s,reset =>reset_s,enable_in => enable_s,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=> en1) ; 
  OBS_2  :  observer generic map(observernumber => x"0003") port map ( output=>add2,clk=>clk_s,reset =>reset_s,enable_in => en1,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=> en2) ; 
  OBS_3  :  observer generic map(observernumber => x"0003") port map ( output=>add3,clk=>clk_s,reset =>reset_s,enable_in => en2,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=> next_obs_s) ;
    
-- <END_2>
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- <BEGIN_3> 
output_s <= (add1  and add2 and add3); 
-- <END_3> 
-------------------------------------------------------------------------------    
    
    -- Begin of testbench
    process
      begin
      --initialize all signals
      enable_s <= '0';
      reset_s <= '0';
      clk_s <= '0';
      tau_s<= std_logic_vector(to_unsigned(3,8));
      --begin process
      CYCLE(clk_s);--1
      CYCLE(clk_s);--2
      CYCLE(clk_s);--3
      CYCLE(clk_s);--4
      CYCLE(clk_s);--5
      CYCLE(clk_s);--6
      CYCLE(clk_s);--7
      CYCLE(clk_s);--8
      CYCLE(clk_s);--9
      
      enable_s <= '1';
      assert(en1 = '0');
      
      CYCLE(clk_s);--10
      assert(en1 = '1');
      assert(en2 = '0');
      CYCLE(clk_s);--12
      assert(en2 = '1');
      assert(next_obs_s = '0');
      CYCLE(clk_s);--13
      assert(next_obs_s = '1');
      CYCLE(clk_s);--14
      CYCLE(clk_s);--15
      CYCLE(clk_s);--16
      CYCLE(clk_s);--17
      CYCLE(clk_s);--18
      CYCLE(clk_s);--19
      CYCLE(clk_s);--20
      CYCLE(clk_s);--21
      CYCLE(clk_s);--22
      CYCLE(clk_s);--23
      CYCLE(clk_s);--24
      CYCLE(clk_s);--25
      CYCLE(clk_s);--26
      CYCLE(clk_s);--27
      CYCLE(clk_s);--28
      CYCLE(clk_s);--29
      CYCLE(clk_s);--30
      CYCLE(clk_s);--31
      CYCLE(clk_s);--32
      CYCLE(clk_s);--33
      CYCLE(clk_s);--34
      CYCLE(clk_s);--35
      CYCLE(clk_s);--36
      CYCLE(clk_s);--37
      CYCLE(clk_s);--38
      CYCLE(clk_s);--39
      CYCLE(clk_s);--40
      CYCLE(clk_s);--41
      CYCLE(clk_s);--42
      CYCLE(clk_s);--43
      CYCLE(clk_s);--44
      CYCLE(clk_s);--45
      CYCLE(clk_s);--46
      CYCLE(clk_s);--47
      CYCLE(clk_s);--48
      CYCLE(clk_s);--49
      CYCLE(clk_s);--50
      reset_s <= '1';
      CYCLE(clk_s);--51
      CYCLE(clk_s);--52
      CYCLE(clk_s);--53
      CYCLE(clk_s);--54
      CYCLE(clk_s);--55
      reset_s <= '0';
      CYCLE(clk_s);--56
      CYCLE(clk_s);--57
      CYCLE(clk_s);--58
      CYCLE(clk_s);--59
      CYCLE(clk_s);--60
      CYCLE(clk_s);--61      
      CYCLE(clk_s);--62
      CYCLE(clk_s);--63
      CYCLE(clk_s);--64
      CYCLE(clk_s);--65
      CYCLE(clk_s);--66
      CYCLE(clk_s);--67
      CYCLE(clk_s);--68
      CYCLE(clk_s);--69
      CYCLE(clk_s);--70
      CYCLE(clk_s);--71
      CYCLE(clk_s);--72
      CYCLE(clk_s);--73
      CYCLE(clk_s);--74
      CYCLE(clk_s);--75
      CYCLE(clk_s);--76
      CYCLE(clk_s);--77
      CYCLE(clk_s);--78
      CYCLE(clk_s);--79
      CYCLE(clk_s);--80
      CYCLE(clk_s);--81
      CYCLE(clk_s);--80
      CYCLE(clk_s);--82
      CYCLE(clk_s);--83
      CYCLE(clk_s);--84
      CYCLE(clk_s);--85
      CYCLE(clk_s);--86
      CYCLE(clk_s);--87
      CYCLE(clk_s);--88
      CYCLE(clk_s);--89
      CYCLE(clk_s);--90
      CYCLE(clk_s);--91
      CYCLE(clk_s);--92
      CYCLE(clk_s);--93
      CYCLE(clk_s);--94
      CYCLE(clk_s);--95
      CYCLE(clk_s);--96
      CYCLE(clk_s);--97
      CYCLE(clk_s);--98
      CYCLE(clk_s);--99
      CYCLE(clk_s);--100
    end process;
    --End of testbench
      
    
end architecture;
