
LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.NUMERIC_STD.all  ; 

ENTITY Observer_testbench  IS 
END ; 


ARCHITECTURE testbench_arch  OF Observer_testbench   IS
  
  constant CLOCK_PERIOD :time    := 20ns;
  constant TAU          :integer := 10 ;
  
  SIGNAL output_s   :  STD_LOGIC := '0'; 
  SIGNAL clk_s      :  STD_LOGIC := '0'; 
  SIGNAL reset_s    :  STD_LOGIC := '0';
  SIGNAL enable_s   :  STD_LOGIC := '0';
  SIGNAL tau_s      :  std_logic_vector(7 downto 0):= (others => '0');
  SIGNAL next_obs_s :  STD_LOGIC := '0';
  SIGNAL phi_s      :  STD_LOGIC := '0';
  
  procedure CYCLE(
    signal clk : out std_logic) is
  begin
      clk <= '1';
      wait for CLOCK_PERIOD;
      clk <= '0';
      wait for CLOCK_PERIOD;
  end procedure;
  
  
  
  COMPONENT observer
    generic ( 
      observernumber : unsigned(15 downto 0):=x"0001"  -- how many observer are instantiated
      );
    PORT ( 
      clk	     :in  std_logic;
      reset	     :in  std_logic;
      enable_in	     :in  std_logic;
      invariance_tau :in  std_logic_vector(7 downto 0);
      signal_phi     :in  std_logic;
      output	     :out std_logic;
      enable_out     :out std_logic
    ); 
  END COMPONENT ; 
    
  FOR OBS : observer 
    use entity 
        work.observer(Behavioural);
    
    
  COMPONENT signalgenerator
    PORT(
      clk 		:in	std_logic;
      reset		:in 	std_logic;
      output		:out  std_logic
      );
  END COMPONENT;

	FOR SIG : signalgenerator 
    use entity 
        work.signalgenerator(simple);
  
BEGIN
  OBS  : observer 
    PORT MAP ( 
      clk       => clk_s  ,
      reset     => reset_s,
      enable_in => enable_s,
      invariance_tau => tau_s,
      signal_phi=> phi_s,
      output    =>  output_s  ,
      enable_out=> next_obs_s
      ) ; 
    
    
  SIG : signalgenerator
    PORT MAP (
      clk => clk_s,
      reset=>reset_s,
      output=>phi_s
    );      


    -- Begin of testbench
  stimulus: process
    variable counter : integer := 0;
    variable limit   : integer := 2000; 
    variable x	     :integer := 1;
	variable switch_up:std_logic:='0';
      begin
      --initialize all signals
      enable_s <= '0';
      reset_s <= '0';
      clk_s <= '0';
      tau_s<= std_logic_vector(to_unsigned(TAU,8));
      --phi_s <= '1';

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
      CYCLE(clk_s);--10
      assert(next_obs_s = '1');
      
      while (counter < limit) loop
        CYCLE(clk_s);
		--if(phi_s = '0')then
		--	switch_up := '0';
		--elsif(switch_up = '0')then
		--	x :=x+2;
		--	switch_up := '1';			
		--end if;
		---if((counter mod x) = 0)then
		--	phi_s <= not phi_s;
		--end if;

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
      
    
END;
