----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 01:03:26 AM
-- Design Name: 
-- Module Name: simple_adder - Behavioral
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

----------------------------------------------------------------------------------
-- Copyright (C)  NYA YATAT FRANK ARMAND
-- CODE PERMANENT: NYAF81340500
-- DÉPARTEMENT DE GÉNIE INFORMATIQUE
----------------------------------------------------------------------------------

-- Simple additioneur 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_adder is
    port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
    y: out STD_LOGIC_VECTOR(31 downto 0));
end simple_adder;

architecture Behavioral of simple_adder is

begin

    y <= std_logic_vector(unsigned(a) + unsigned(b));

end Behavioral;
