library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
	port(
		clk: in std_logic;
		regWrite: in std_logic;								-- Control write
		RR1,RR2: in std_logic_vector(4 downto 0);		-- Read Register Address 1,2
		WR: in std_logic_vector(4 downto 0);			-- Write Register Address
		WD: in std_logic_vector(31 downto 0);			-- Write Data
		RD1,RD2: out std_logic_vector(31 downto 0)	-- Read Data 1,2
	);
end Registers;

architecture Behavioral of Registers is
	type regArray is array (0 to 31) of std_logic_vector(31 downto 0);
	signal regfile: regArray;
	
	begin
	process(clk)
		begin
		if clk'event and clk='1' and regWrite='1' then
			regfile(to_integer(unsigned(WR))) <= WD;	-- write data into the register
		end if;
	end process;
	RD1 <= "00000000000000000000000000000000" when RR1="00000" else regfile(to_integer(unsigned(RR1)));
	RD2 <= "00000000000000000000000000000000" when RR2="00000" else regfile(to_integer(unsigned(RR2)));
end Behavioral;