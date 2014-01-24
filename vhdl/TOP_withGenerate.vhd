

LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_misc.all;



entity top_withGenerate is
generic (
  number_observer:unsigned(15 downto 0):=x"0001"
  );
port (
   CLOCK_50                            	:in	std_logic;
   KEY					:in 	std_logic_vector(3 downto 0) ;
   GPIO   				:out    std_logic_vector(11 downto 0) );

end entity;


architecture rtl of top_withGenerate is

constant  tau_range	:integer := 10;	

component AltPLa is
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		    : OUT STD_LOGIC ; -- 100 Mhz
		c1		    : OUT STD_LOGIC ; -- 200Mhz
		c2		    : OUT STD_LOGIC ; -- 400 Mhz
		c3		    : OUT STD_LOGIC ; -- 600 Mhz
                c4		    : OUT STD_LOGIC ; -- 1200 Mhz
		locked		: OUT STD_LOGIC 
	);
end component;  
  
component signalgenerator is 
  port(
   clk		:in  std_logic        	:= 'X';
   reset 	:in  std_logic          := 'X'; 	-- clk
   output 	:out std_logic				-- export
);
end component signalgenerator;


component observer 
    generic ( 
        observernumber :unsigned(15 downto 0):=x"0001"  -- how many observer are instantiated
      ); 
    PORT ( 
      clk 				:in	std_logic			:= 'X';
      reset				:in 	std_logic			:= 'X';
      enable_in		:in   std_logic;
      invariance_tau	:in 	std_logic_vector(7 downto 0);
      signal_phi		:in	std_logic;
      output			:out  std_logic;
      enable_out		:out	std_logic
      ); 
end component;


signal clk_s  	 	:  std_logic	:='0';
signal clk_g		:  std_logic	:='0';
signal reset_s  	:  std_logic	:='0';
signal enable_s	        :  std_logic	:='0';
signal phi_s		:  std_logic	:='0';
signal next_obs_s       :  std_logic	:='0';

-------------------------------------------------------------------------------
-- <BEGIN_1>
--SIGNAL_CASE: if number_observer > 2  generate
--  signal signal_add   : std_logic_vector(number_observer-1 downto 0):= (others => '0');
--  signal signal_enable: std_logic_vector(number_observer-2 downto 0):= (others => '0');
--elsif number_observer = 2  generate
--  signal signal_add   : std_logic_vector(number_observer-1 downto 0):= (others => '0');
--  signal signal_enable: std_logic;
--else  generate      
--  signal signal_add : std_logic :='0';       
--end generate SIGNAL_CASE;
 signal signal_add   : std_logic_vector(number_observer):= (others => '0');

-- <END_1>
-------------------------------------------------------------------------------
signal output_s	: std_logic	:='0';
signal tau_s	: std_logic_vector(7 downto 0) := (others => '0');

begin
  signalgenerator_top : component signalgenerator
    port map (
      output => phi_s, 
      reset => reset_s,
      clk => clk_g  
      );

   PLL:  AltPLa
    PORT MAP (areset => reset_s,inclk0 => CLOCK_50  ,c1 => clk_s,c0 => clk_g   ) ;
	-- PORT MAP (areset => reset_s,inclk0 => CLOCK_50    ) ;
-------------------------------------------------------------------------------
-- <BEGIN_2>
-
  OBS_CASE: if  number_observer > 2 generate   ---------------------------------- more than 2 OBSERVER

    
    OBS_FIRST:  observer GENERIC MAP(observernumber => to_integer(number_observer,16))
      PORT MAP ( output=>add(0),clk=>clk_s,reset =>reset_s, enable_in =>enable_s,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>signal_enable(0)) ;
    
    GEN_OBS: for I in 1 to (number_observer-2) generate
       OBS_X:  observer GENERIC MAP(observernumber => to_integer(number_observer,16))
         PORT MAP ( output=>add(I),clk=>clk_s,reset =>reset_s, enable_in =>signal_enable(I-1),invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>signal_enable(I)) ;
    end generate GEN_OBS;
    
    OBS_LAST  observer GENERIC MAP(observernumber => to_integer(number_observer,16))
      PORT MAP ( output=>add(number_observer-1),clk=>clk_s,reset =>reset_s, enable_in =>signal_enable(number_observer-2),invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>next_obs_s) ;

    
  elsif number_observer = 2 generate ------------------------------------------- 2 OBSERVER
    
    OBS_0:  observer GENERIC MAP(observernumber => to_integer(number_observer,16))
      PORT MAP ( output=>add(0),clk=>clk_s,reset =>reset_s, enable_in =>enable_s,invariance_tau => tau_s,signal_phi=> phi_s) ;
    OBS_1:  observer GENERIC MAP(observernumber => to_integer(number_observer,16))--
      --???????????
      PORT MAP ( output=>add(1),clk=>clk_s,reset =>reset_s, enable_in =>enable_out(0),invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>next_obs_s) ;
    
  else  generate  -- ----------------------------------------------------------  1 OBSERVER
          
    OBS_0:  observer GENERIC MAP(observernumber => to_integer(number_observer,16))
      PORT MAP ( output=>add(0),clk=>clk_s,reset =>reset_s, enable_in =>enable_s,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>next_obs_s) ;
    
  end generate OBS_CASE;       

-- <END_2>
-------------------------------------------------------------------------------		
 
		
	
	
	--clk_s <= CLOCK_50;
	--clk_g <= CLOCK_50;
        reset_s <= not KEY(0);
	GPIO(0) <= clk_s; 	--clk
	GPIO(1) <= reset_s;	--reset_key(0)
	GPIO(2) <= enable_s;	--enable_start	
	GPIO(3) <= en1;		--obs1_enable
	GPIO(4) <= en2;		--obs2_enable
	GPIO(5) <= next_obs_s;--obs3_enable
	GPIO(6) <= phi_s;		--phi_signal
	GPIO(7) <= add1;		--add1
	GPIO(8) <= add2;		--add2
	GPIO(9) <= add3;		--add3
	GPIO(10)<= output_s;	--output
	--GPIO(0) <= clk_s ;
	--GPIO(0) <= clk_s;
	
	tau_s		<= std_logic_vector(to_unsigned(tau_range,8));
-------------------------------------------------------------------------------
-- <BEGIN_3>
 OUTPUT_CASE: if number_observer > 2  generate
   output_s <= and_reduce(add);
 elsif number_observer = 2  generate
   output_s <= add(0) and add(1);
else  generate      
      	output_s <= add;
end generate OUTPUT_CASE;
	

-- <END_3> 
-------------------------------------------------------------------------------	
	sync:process(clk_s)
	begin
          if(clk_s'event and clk_s='1') then
            if reset_s ='0' then
              enable_s <= '1';
            else
              enable_s <= '0';
            end if;
          end if;	
        end process;
	
end architecture;
