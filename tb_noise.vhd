LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_noise IS
END tb_noise;
 
ARCHITECTURE behavior OF tb_noise IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT noise_suppressor
    PORT(
         i_clk : IN  std_logic;
         i_rst : IN  std_logic;
         i_data : IN  std_logic;
         o_data : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_rst : std_logic := '0';
   signal i_data : std_logic := '0';

 	--Outputs
   signal o_data : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: noise_suppressor PORT MAP (
          i_clk => i_clk,
          i_rst => i_rst,
          i_data => i_data,
          o_data => o_data
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		i_rst<= '1','0' after 60ns;
      i_data <= '0';
      wait for 80 ns;
			if o_data = '0' then
				report "Elimina ruido";
			else
				report "ERROR, fallo en la eliminacion";
			end if;
			
		i_data <= '1', '0' after 5 ns, '1' after 6 ns;
			wait for 10 ns;
		if o_data = '0' then
				report "Elimina ruido";
			else
				report "ERROR, fallo en la eliminacion";
		end if;
		
		i_data <= '1';	
      wait for 180 ns;
		if o_data = '1' then
				report "Elimina ruido, cambia a 1 porque la senal es estable";
			else
				report "ERROR, deberia haber cambiado";
		end if;
		
		report "END"; 
      wait;
   
	end process;

END;
