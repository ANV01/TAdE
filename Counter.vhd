library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;



entity counter is

generic(g_dataSize: integer := 8 );

    Port ( i_en : in  STD_LOGIC;

           i_data : in  STD_LOGIC_Vector(g_dataSize-1 downto 0);

           i_clk : in  STD_LOGIC;

           i_rst : in  STD_LOGIC;

           o_data : out  STD_LOGIC_Vector(g_dataSize-1 downto 0);

           o_end : out  STD_LOGIC

			 );

end counter;



architecture Behavioral of counter is

signal count: std_logic_vector(g_dataSize-1 downto 0);

 begin

process (i_clk, i_rst) 

begin

 o_end <= '0';

   if i_rst='0' then 

      count <= "00000000" ; 
		elsif i_clk='1' and i_clk'event then

      if i_en='1' then

			if i_data = count then

			count <= "00000000" ; 
			o_end<= '1';

			else

         count <= count + 1; 
			end if;

		end if;

   end if;

	 

end process;

	
	o_data <= count;





end Behavioral;



