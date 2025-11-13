----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2025 06:09:27 AM
-- Design Name: 
-- Module Name: extend - extend_Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity extend is
  Port ( ext_in: in STD_LOGIC_VECTOR(23 downto 0);
         immsrc: in STD_LOGIC_VECTOR(1 downto 0);
         extimm: out STD_LOGIC_VECTOR(31 downto 0)
   );
end extend;

architecture extend_Behavioral of extend is

begin

    extimm <= (31 downto 8 => '0') & ext_in(7 downto 0) when immsrc = "00" else -- ImmSrc = « 00 » -> 24 '0' à gauche + les 8 LSB à droite
              (31 downto 12 => '0') & ext_in(11 downto 0) when immsrc = "01" else -- ImmSrc = « 01 » -> 20 '0' à gauche + les 12 LSB à droite
              (31 downto 24 => '0') & ext_in; -- ImmSrc = « 10 » -> 8 '0' à gauche + les 24 LSB à droite

end extend_Behavioral;
