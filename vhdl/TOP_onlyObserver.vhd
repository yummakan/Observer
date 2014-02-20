






LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_misc.all;

entity top_onlyObserver is

port (
   CLOCK_50                            	:in	std_logic;
   KEY					:in 	std_logic_vector(3 downto 0) ;
   GPIO   				:out    std_logic_vector(34 downto 0) );

end entity;

--------------------------------------------------------------------------
------------------      ARCHITECTURE    ---------------------------------
--------------------------------------------------------------------------
architecture rtl of top_onlyObserver is

constant  tau_range	:integer := 10;	

--component Altpla is
--  PORT
--    (
--      areset		: IN STD_LOGIC  := '0';
--      inclk0		: IN STD_LOGIC  := '0';
--      c0		    : OUT STD_LOGIC ; -- 50Mhz
--      c1		    : OUT STD_LOGIC ; -- 100Mhz
--      c2		    : OUT STD_LOGIC ; -- 120 Mhz
--     c3		    : OUT STD_LOGIC ; -- 150 Mhz
--      c4		    : OUT STD_LOGIC  --  200 Mhz
--    );
--end component;  

  
component Altplb is
  PORT
    (
      areset		: IN STD_LOGIC  := '0';
      inclk0		: IN STD_LOGIC  := '0';
      c0		    : OUT STD_LOGIC ; -- 100Mhz
      c1		    : OUT STD_LOGIC ; -- 200Mhz
      c2		    : OUT STD_LOGIC ; -- 400 Mhz
      c3		    : OUT STD_LOGIC ; -- 600 Mhz
      c4		    : OUT STD_LOGIC ; --  1200 Mhz
      locked		: OUT STD_LOGIC 
      );
end component; 
  



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

-------------------------------------------------------------------------------
--  <BEGIN_0> 
FOR OBS_0 : observer 
  use entity  work.observer(Behavioural);

--  <END_0>
-------------------------------------------------------------------------------
  
signal clk 	 	:  std_logic	:='0';
signal reset_s  	:  std_logic	:='0';
signal enable_s	        :  std_logic	:='0';
signal phi_s		:  std_logic	:='0';
signal next_obs_s       :  std_logic	:='0';
-------------------------------------------------------------------------------
-- <BEGIN_1> 
signal add0	    :std_logic:='0';

-- <END_1>
-------------------------------------------------------------------------------
signal output_s	: std_logic	:='0';
signal tau_s	: std_logic_vector(7 downto 0) := (others => '0');


-------------------------------------------------------------------------------------
----- BEGIN OF ARCHITECTURE   ------------------------------------------------------
-------------------------------------------------------------------------------------
begin
  
  
  PLL: component Altplb --??: maybe reduce to only needed clocks
    PORT MAP (areset => reset_s,inclk0 => CLOCK_50 ,c3 => clk) ;
  
-------------------------------------------------------------------------------
-- <BEGIN_2> 
  OBS_0:  observer GENERIC MAP(observernumber => x"0001")
    PORT MAP ( output=>add0,clk=>clk,reset =>reset_s, enable_in =>enable_s,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=> next_obs_s) ;

-- <END_2>
-------------------------------------------------------------------------------		
 

  -------------------------------------------------------------------------------
-- <BEGIN_3> 
 output_s <=add0;
-- <END_3> 
-------------------------------------------------------------------------------

  
  
	
 
  reset_s <= not KEY(0);
 	
  GPIO(0) <= reset_s;
  GPIO(1) <= enable_s;	
  --GPIO(2) <= en1;		
  ---GPIO(3) <= en2;	
  --GPIO(4) <= en3;		
  --GPIO(5) <= en4;	
  GPIO(6) <= next_obs_s;  
  GPIO(7) <= clk;
  GPIO(8) <= phi_s;	
  --GPIO(9)<= clk_s;
  GPIO(10) <= add0;	
  --GPIO(10) <= add(0);		
  --GPIO(11) <= add(1);		
  --GPIO(12) <= add(2);		
  --GPIO(13) <= add(3);		
  --GPIO(14) <= add(4);	
  GPIO(15)<= output_s;	

  tau_s	<= std_logic_vector(to_unsigned(tau_range,8));
 
  
  

  

  
  sync:process(clk)
  begin
    if(clk'event and clk='1') then
      if reset_s ='0' then
        enable_s<= '1';
        phi_s	<= not phi_s; 
      else
        enable_s <= '0';
        phi_s	<= '0';
      end if;
    end if;	
  end process;
	
end architecture;
