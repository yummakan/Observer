LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity top is

port (
   CLOCK_50                            	:in	std_logic;
   KEY					:in 	std_logic_vector(3 downto 0) ;
   GPIO   				:out    std_logic_vector(11 downto 0) );

end entity;





architecture rtl of top is

constant  tau_range	:integer := 10;	

component signalgenerator is 
  port(
    clk		:in  std_logic        	:= 'X';
    reset 	:in  std_logic          := 'X'; 	-- clk
    output 	:out std_logic				-- export
);

end component signalgenerator;


COMPONENT observer 
    generic ( 
        observernumber : integer   := 1  -- how many observer are instantiated
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
END COMPONENT ; 

FOR OBS_1 : observer 
  use entity  work.observer(Behavioural); 
FOR OBS_2 : observer 
  use entity  work.observer(Behavioural); 
FOR OBS_3 : observer 
  use entity  work.observer(Behavioural);    

component AltPLa is
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ; -- 25 Mhz
		c1		: OUT STD_LOGIC ;	-- 10 Mhz
		c2		: OUT STD_LOGIC ; --	1 Mhz
		c3		: OUT STD_LOGIC ; -- 0,5 Mhz
		locked		: OUT STD_LOGIC 
	);
end component;  
  
  
signal clk_s  	 	: 	std_logic	:='0';
signal clk_g		:  std_logic	:='0';
signal reset_s  	: 	std_logic	:='0';
signal enable_s	: 	std_logic	:='0';
signal phi_s		:	std_logic	:='0';
signal en1			:	std_logic	:='0';
signal en2			:	std_logic	:='0';
signal next_obs_s:	std_logic	:='0';
signal add1			:	std_logic	:='0';
signal add2			:	std_logic	:='0';
signal add3			:	std_logic	:='0';
signal output_s	:	std_logic	:='0';
signal tau_s		:	std_logic_vector(7 downto 0) := (others => '0');

begin
	signalgenerator_top : component signalgenerator
	port map (
		output => phi_s,
		reset => reset_s,
		clk => clk_g  
	);
	
	OBS_1  :  observer GENERIC MAP(observernumber => 3) 
		PORT MAP ( output=>add1,	clk=>clk_s,reset =>reset_s,	enable_in => enable_s,	invariance_tau => tau_s,	signal_phi=> phi_s,	enable_out=> en1) ; 
	OBS_2  :  observer GENERIC MAP(observernumber => 3) 
		PORT MAP ( output=>add2,	clk=>clk_s,reset =>reset_s,	enable_in => en1,			invariance_tau => tau_s,	signal_phi=> phi_s,	enable_out=> en2) ; 
	OBS_3  :  observer GENERIC MAP(observernumber => 3) 	
		PORT MAP ( output=>add3,	clk=>clk_s,reset =>reset_s,	enable_in => en2,			invariance_tau => tau_s,	signal_phi=> phi_s,	enable_out=> next_obs_s) ;
		
	PLL: 		AltPLa
		PORT MAP (areset => reset_s,    inclk0 => CLOCK_50		  ,	c2 => clk_s		,	c3		=>		clk_g 	   ) ;
		
	
	
	--clk_s <= CLOCK_50;
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
	output_s <= (add1  and add2 and add3) or '0';

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
