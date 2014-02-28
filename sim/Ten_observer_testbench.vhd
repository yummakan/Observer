

LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.NUMERIC_STD.all  ; 
use IEEE.std_logic_misc.all;

ENTITY ten_observer_testbench  IS 
END ; 


architecture testbench_arch  OF ten_observer_testbench   IS
  
  constant CLOCK_PERIOD :time := 20ns;
  constant TAU          :integer := 3 ;

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
      clk 		     :in	std_logic;
      reset		     :in 	std_logic;
      output		     :out  std_logic
      );
  end component;


 component observer 
    generic ( 
      observernumber : unsigned(15 downto 0):=x"0001"  -- how many observer are instantiated
      ); 
    port ( 
      clk       	     :in	std_logic;
      reset	             :in 	std_logic;
      enable_in		     :in        std_logic;
      invariance_tau         :in 	std_logic_vector(7 downto 0);
      signal_phi	     :in	std_logic;
      output	             :out       std_logic;
      enable_out	     :out	std_logic
      ); 
  end component ; 
    

-------------------------------------------------------------------------------
--  <BEGIN_0>
 FOR OBS_0 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_1 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_2 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_3 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_4 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_5 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_6 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_7 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_8 : observer 
  use entity  work.observer(Behavioural);
FOR OBS_9 : observer 
  use entity  work.observer(Behavioural);
--  <END_0>
-------------------------------------------------------------------------------

signal output_s   :  STD_LOGIC := '0'; 
signal clk_s      :  STD_LOGIC := '0'; 
signal reset_s    :  STD_LOGIC := '0';
signal enable_s   :  STD_LOGIC := '0';
signal tau_s      :  std_logic_vector(7 downto 0) := (others => '0');
signal tau_s_inc  :  integer   := 0; 
signal next_obs_s :  STD_LOGIC  := '0';
signal phi_s      :  STD_LOGIC := '0';
-------------------------------------------------------------------------------
-- <BEGIN_1> 
signal add: std_logic_vector(9 downto 0):=(others=>'0');
signal en1	    :std_logic:='0';
signal en2	    :std_logic:='0';
signal en3	    :std_logic:='0';
signal en4	    :std_logic:='0';
signal en5	    :std_logic:='0';
signal en6	    :std_logic:='0';
signal en7	    :std_logic:='0';
signal en8	    :std_logic:='0';
signal en9	    :std_logic:='0';
-- <END_1>
-------------------------------------------------------------------------------



  
-------------------------------------------------------------------------------
------------------- ARCHITECTURE BEGIN ----------------------------------------
-------------------------------------------------------------------------------
begin
  
SIG : signalgenerator port map (  clk => clk_s, reset=>reset_s, output=>phi_s );  

-------------------------------------------------------------------------------
-- <BEGIN_2> 
  OBS_0:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(0),clk=>clk_s,reset =>reset_s, enable_in =>enable_s,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en1) ;
OBS_1:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(1),clk=>clk_s,reset =>reset_s, enable_in =>en1,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en2) ;
OBS_2:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(2),clk=>clk_s,reset =>reset_s, enable_in =>en2,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en3) ;
OBS_3:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(3),clk=>clk_s,reset =>reset_s, enable_in =>en3,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en4) ;
OBS_4:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(4),clk=>clk_s,reset =>reset_s, enable_in =>en4,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en5) ;
OBS_5:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(5),clk=>clk_s,reset =>reset_s, enable_in =>en5,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en6) ;
OBS_6:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(6),clk=>clk_s,reset =>reset_s, enable_in =>en6,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en7) ;
OBS_7:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(7),clk=>clk_s,reset =>reset_s, enable_in =>en7,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en8) ;
OBS_8:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(8),clk=>clk_s,reset =>reset_s, enable_in =>en8,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>en9) ;
OBS_9:  observer GENERIC MAP(observernumber => x"000A")
    PORT MAP ( output=>add(9),clk=>clk_s,reset =>reset_s, enable_in =>en9,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=> next_obs_s) ;
-- <END_2>
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- <BEGIN_3> 
output_s <= and_reduce(add);
-- <END_3> 
-------------------------------------------------------------------------------    
    
    -- Begin of testbench
stimulus:process
  variable counter : integer := 0;
  variable limit   : integer := 2000;
  variable phi_cnt : integer := 1;
begin
  --initialize all signals


  enable_s <= '0';
  reset_s  <= '0';
  clk_s    <= '0';
  tau_s    <= std_logic_vector(to_unsigned(TAU,8));
  tau_s_inc<= TAU+1;
  
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

      while (counter < limit) loop
        CYCLE(clk_s);
        if(phi_s = '1' and phi_cnt < tau_s_inc )then
          phi_cnt := phi_cnt + 1;
          assert(output_s = '0');
        elsif(phi_s = '1' and phi_cnt = tau_s_inc)then
          assert(output_s = '1');
        else  
          phi_cnt := 1;
           assert(output_s = '0');
        end if;
       
        counter := counter  + 1;
        if(counter > 450 and counter < 500)then
          reset_s <= '1';
        else
          reset_s <= '0';
        end if; 
      end loop;
  wait;      
end process stimulus;
    --End of testbench
      
    
end architecture;
