----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2025 04:06:15 PM
-- Design Name: 
-- Module Name: and_or - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity and_or is
    Port ( 
    A, B : in STD_LOGIC_VECTOR(31 downto 0); 
    and_out, or_out: out STD_LOGIC_VECTOR(31 downto 0)
    );
end and_or;

architecture Behavioral of and_or is

begin

    and_out<= A AND B;
    or_out <=  A OR B;

end Behavioral;
