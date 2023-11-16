library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity orvhdl is
	port
	(
		-- Input ports
		PB1, PB2 : in STD_LOGIC;
		-- Output ports
		LED         : out STD_LOGIC
	);
end orvhdl;

architecture mytest of orvhdl is
-- Declarations (optional)
begin
LED <= NOT( (NOT PB1) OR (NOT PB2) );
end mytest;