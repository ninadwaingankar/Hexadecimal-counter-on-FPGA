--Hexadecial counter on FPGA by Ninad Waingankar

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity hexcounter is
port(clk:in std_logic;
		rst:in std_logic;
		hex:out std_logic_vector(6 downto 0));
end hexcounter;

architecture hex of hexcounter is
	signal divider:std_logic_vector(23 downto 0);	--clock divider signal
begin
	process(clk,rst) 
	begin
		if(rst='1') then
			divider<=(others=>'0');
		elsif(rising_edge(clk)) then
			divider<=divider+'1';
		end if;
	end process;
	--developed by Ninad Waingankar

	process(divider(22),rst)
		variable count:natural range 0 to 16:=0;
		
	begin
		if(rst='1') then
			count:=0;
			
		elsif(rising_edge(divider(22))) then
			count:=count+1;
			if(count=16) then
				count:=0;				
			end if;
		end if;
		
	--codes for Common anode 7 segment display	abcdefg format
	
	--for hexadecimal counter on common anode 7 seg display
		case count is 
			when 0=>hex<="0000001";-- shows 0
			when 1=>hex<="1001111";-- shows 1
			when 2=>hex<="0010010";-- shows 2
			when 3=>hex<="0000110";-- shows 3
			when 4=>hex<="1001100";-- shows 4
			when 5=>hex<="0100100";-- shows 5
			when 6=>hex<="0100000";-- shows 6
			when 7=>hex<="0001111";-- shows 7
			when 8=>hex<="0000000";-- shows 8 
			when 9=>hex<="0000100";-- shows 9
			when 10=>hex<="0001000";-- shows A
			when 11=>hex<="1100000";-- shows B
			when 12=>hex<="0110001";-- shows C
			when 13=>hex<="1000010";-- shows D
			when 14=>hex<="0110000";-- shows E 
			when 15=>hex<="0111000";-- shows F
			when others=>null;
		end case;	
	end process;	
end hex;
