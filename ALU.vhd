LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_STD.all;

ENTITY ALU IS
port(Clock : In std_logic; --input clock signal 
		A,B : in unsigned(7 downto 0); --8 bit inputs from latches A and B
		student_id : in unsigned(3 downto 0); --4 bit student id from FSM
		OP : in unsigned(15 downto 0); --16 bit selector for Operation from Decoder
		Neg : out std_logic; --is the result negative ? Set-ve bit output
		R1 : out unsigned (3 downto 0);
		R2 : out unsigned (3 downto 0));
end ALU;
architecture calculation of ALU is --temporary signal declarations
signal Reg1,Reg2,Result : unsigned(7 downto 0) := (others => '0');
signal Reg4 : unsigned (0 to 7);
begin
Reg1 <= A; --temporarily store A in Reg1 local variable
Reg2 <= B; --temporarily store B in Reg2 local variable
process(Clock,OP)
begin
	if(rising_edge(Clock))THEN --Do the calculation @ positive edge of clock cycle
		case OP is 
			WHEN "1000000000000000" =>
				--Do Addition for Reg1 and Reg2
				Result <= Reg1 + Reg2;
				WHEN "0100000000000000" =>
					--Do Subtraction
					--"Neg" bit set if required
					Result <= A - B;
				WHEN "0010000000000000" =>
					--Do Boolean NAND
					Result <= NOT(A);
				WHEN "0001000000000000" =>
					--Do Boolean NOR
					Result <= (NOT(A) AND NOT(B));
				WHEN "0000100000000000" =>
					--Do Boolean AND
					Result <= (A AND B);
				WHEN "0000010000000000" =>
					--Do Boolean OR
					Result <= (A OR B);
				WHEN "0000001000000000" =>
					--Do Boolean XOR
					Result <= (A XOR B);
				WHEN "0000000100000000" =>
					--Do Boolean XNOR
					Result <= NOT(A XOR B);
				WHEN OTHERS =>
					--Don't care. do nothing
			end case;	
		end if;
	end process;
	R1 <= Result(3 downto 0); --Since the output seven segments can
	R2 <= Result(7 downto 4);
	end calculation;