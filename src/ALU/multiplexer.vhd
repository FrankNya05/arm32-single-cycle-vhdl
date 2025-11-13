----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2025 03:49:35 PM
-- Design Name: 
-- Module Name: multiplexer - Behavioral
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

entity multiplexer is
  Port ( 
  E_sum, E_sous, E_and, E_or : in STD_LOGIC_VECTOR(31 downto 0); -- Entrée 1 à entrée 4 du multiplexeur
  control: in STD_LOGIC_VECTOR(1 downto 0);
  Y: out STD_LOGIC_VECTOR(31 downto 0)
  );
end multiplexer;

architecture Behavioral of multiplexer is

begin
    Y<=E_sum when control= "00" else
       E_sous when control= "01" else
       E_and when control= "10" else
       E_or;         
end Behavioral;
