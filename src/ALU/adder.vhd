----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2025 01:47:15 AM
-- Design Name: 
-- Module Name: adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
  Port (
    A, B : in STD_LOGIC_VECTOR(31 downto 0);
    control: in STD_LOGIC_VECTOR(1 downto 0);
    carry_out: out STD_LOGIC;
    sum: out STD_LOGIC_VECTOR(31 downto 0)
  );
end adder;

architecture Behavioral of adder is
  signal sum_result: STD_LOGIC_VECTOR(32 downto 0);

begin
    process(A,B,control)
    begin
        if control = "00" then sum_result <= std_logic_vector(UNSIGNED('0' & A)+UNSIGNED('0' & B));
         elsif control = "01" then sum_result <= std_logic_vector( unsigned('0' & A) + unsigned('0' & (not B)) + to_unsigned(1, 33));                 
        else sum_result <= std_logic_vector(UNSIGNED('0' & A)+UNSIGNED('0' & B));
        end if;
    end process;
    sum <= sum_result(31 downto 0);
    carry_out<= sum_result(32);
end Behavioral;
