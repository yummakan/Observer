

LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.NUMERIC_STD.all  ; 

ENTITY multiple_observer_testbench  IS 
END ; 


architecture testbench_arch  OF multiple_observer_testbench   IS
  
  constant CLOCK_PERIOD :time := 20ns;
  constant TAU          :integer := 10 ;

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
signal tau_s_inc  :  integer   := 0; 
signal next_obs_s :  STD_LOGIC  := '0';
signal phi_s      :  STD_LOGIC := '0';
-------------------------------------------------------------------------------
-- <BEGIN_1> 
signal en1,en2    :   STD_LOGIC :='0';
signal add1,add2,add3:STD_LOGIC :='0';
-- <END_1>
-------------------------------------------------------------------------------



  
-------------------------------------------------------------------------------
------------------- ARCHITECTURE BEGIN ----------------------------------------
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
