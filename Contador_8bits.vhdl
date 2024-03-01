library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Generador is
    Port ( CLK_50MHZ : in  STD_LOGIC;
           Led0 : out STD_LOGIC;
			  Led1 : out STD_LOGIC;
			  Led2 : out STD_LOGIC;
			  Led3 : out STD_LOGIC;
			  Led4 : out STD_LOGIC;
			  Led5 : out STD_LOGIC;
			  Led6 : out STD_LOGIC;
			  Led7 : out STD_LOGIC;
			  stop : in STD_LOGic; -- reset
			  INIT_PAUSE : in STD_LOGIC --permite poner en marcha o parar el cronometro
			  );
			  
end Generador;

architecture Behavioral of Generador is
	signal counter_8bit : STD_LOGIC_VECTOR (7 downto 0);
	signal aux_count : integer range 0 to 10000000; --permite llevar cuenta auxiliar para dividir la frecuencia 
	signal output : std_logic_VECTOR (7 downto 0); -- senal intermedia del contador de 8 bits
	type possible_states is ( Inicio, Contar, Pausar); 
	signal state :  possible_states;
	signal next_state :  possible_states;
	--signal inc : std_logic_vector(7 downto 0) := "00000001";  
	begin
	
	process ( CLK_50MHZ)
	
		begin
		if (CLK_50MHZ'event and CLK_50MHZ = '1') then
			if (STOP = '1') then -- reinicia el contador
				aux_count <= 0;
				state <= Inicio;
				output <= "00000000";
			
			elsif ( aux_count = 10000000) then 
						aux_count <= 0; -- reinicia cuenta auxiliar 
						state <= next_state;
						if (output = "11111111") then
							output <= "00000000";
					
						elsif( state = Contar)	then
							output  <= output + "00000001"; -- Cuenta
					
						end if;
		
			else
				aux_count <= aux_count + 1;
			end if; 
			
			Led0 <= output(0); -- se asigna el valor de la senal al cronometro, valor acutal del cronometro
		   Led1 <= output(1);
			Led2 <= output(2);
			Led3 <= output(3);
			Led4 <= output(4);
			Led5 <= output(5);
			Led6 <= output(6);
			Led7 <= output(7);
			
		
		end if;
		
	end process;
	
	process (state,INIT_PAUSE)
   begin
      next_state <= state;  --default is to stay in current state
      case (state) is
         when Inicio =>
            if INIT_Pause = '1' then
               next_state <= Contar;
            end if;
         when Contar =>
            if INIT_Pause = '1' then
               next_state <= Pausar;
            end if;
         when Pausar =>
            if INIT_Pause = '1' then
				next_state <= Contar;
				end if;
			when others =>
            next_state <= Inicio;
      end case;      
   end process;

			
	
end Behavioral;
