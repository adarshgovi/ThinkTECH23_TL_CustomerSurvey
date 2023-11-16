library ieee;
use ieee.std_logic_1164.all;

entity BCDto7Seg is
port
(
-- Input ports
BCD1 : in STD_LOGIC_VECTOR (3 downto 0);
BCD2 : in STD_LOGIC_VECTOR (3 downto 0);
key1 : in STD_LOGIC;
key0: in STD_LOGIC;
switch9: in STD_LOGIC;
		
-- Output ports
DISPLAY0 : out STD_LOGIC_VECTOR (0 to 6);
DISPLAY1 : out STD_LOGIC_VECTOR (0 to 6)
);
end BCDto7Seg;
architecture a of BCDto7Seg is
-- Declarations (optional)
signal bcd_one: STD_LOGIC_VECTOR (3 downto 0);
signal bcd_two: STD_LOGIC_VECTOR (3 downto 0);
signal digit_a_2: STD_LOGIC_VECTOR (3 downto 0);
signal digit_a_1: STD_LOGIC_VECTOR (3 downto 0);
signal digit_b_2: STD_LOGIC_VECTOR (3 downto 0);
signal digit_b_1: STD_LOGIC_VECTOR (3 downto 0);
signal display_out : STD_LOGIC_VECTOR (0 to 6);
signal display_two_out : STD_LOGIC_VECTOR (0 to 6);

begin
bcd_one <= BCD1;
bcd_two <= BCD2;
DISPLAY0 <= display_out;
DISPLAY1 <= display_two_out;
	process(bcd_one, bcd_two, display_out, display_two_out) is
	
-- Declaration(s)
	begin
-- Sequential Statement(s)
	if key1 ='0' then
		digit_a_1<=bcd_one;
		digit_a_2<=bcd_two;
		case bcd_one is
			when "0000" =>
				display_out<="0000001";
			when "0001" =>
				display_out<="1001111";
			when "0010" =>
				display_out<="0010010";
			when "0011" =>
				display_out<="0000110";
			when "0100" =>
				display_out<="1001100";
			when "0101" =>
				display_out<="0100100";
			when "0110" =>
				display_out<="0100000";
			when "0111" =>
				display_out<="0001111";
			when "1000" =>
				display_out<="0000000";
			when "1001" =>
				display_out<="0000100";
			when others =>
				display_out<="1111111";
			end case;
		case bcd_two is
			when "0000" =>
				display_two_out<="0000001";
			when "0001" =>
				display_two_out<="1001111";
			when "0010" =>
				display_two_out<="0010010";
			when "0011" =>
				display_two_out<="0000110";
			when "0100" =>
				display_two_out<="1001100";
			when "0101" =>
				display_two_out<="0100100";
			when "0110" =>
				display_two_out<="0100000";
			when "0111" =>
				display_two_out<="0001111";
			when "1000" =>
				display_two_out<="0000000";
			when "1001" =>
				display_two_out<="0000100";
			when others =>
				display_two_out<="1111111";
			end case;
			end if;
			
		if  key0='0' then
			digit_b_1<=bcd_one;
			digit_b_2<=bcd_two;
			case bcd_one is
				when "0000" =>
					display_out<="0000001";
				when "0001" =>
					display_out<="1001111";
				when "0010" =>
					display_out<="0010010";
				when "0011" =>
					display_out<="0000110";
				when "0100" =>
					display_out<="1001100";
				when "0101" =>
					display_out<="0100100";
				when "0110" =>
					display_out<="0100000";
				when "0111" =>
					display_out<="0001111";
				when "1000" =>
					display_out<="0000000";
				when "1001" =>
					display_out<="0000100";
				when others =>
					display_out<="1111111";
				end case;
			case bcd_two is
				when "0000" =>
					display_out<="0000001";
				when "0001" =>
					display_two_out<="1001111";
				when "0010" =>
					display_two_out<="0010010";
				when "0011" =>
					display_two_out<="0000110";
				when "0100" =>
					display_two_out<="1001100";
				when "0101" =>
					display_two_out<="0100100";
				when "0110" =>
					display_two_out<="0100000";
				when "0111" =>
					display_two_out<="0001111";
				when "1000" =>
					display_two_out<="0000000";
				when "1001" =>
					display_two_out<="0000100";
				when others =>
					display_two_out<="1111111";
				end case;
				
			end if;
		
		end process;
end a;
