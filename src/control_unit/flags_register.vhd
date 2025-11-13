----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2025 04:15:49 PM
-- Design Name: 
-- Module Name: flags_register - flags_register_Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flags_register is
  Port (
    Flagw: in STD_LOGIC_VECTOR(1 downto 0);
    condex, clk, reset: in STD_LOGIC;
    ALU_Flags: in STD_LOGIC_VECTOR(3 downto 0); 
    Flags32, Flags10: out STD_LOGIC_VECTOR(1 downto 0)
  );
end flags_register;

architecture flags_register_Behavioral of flags_register is

signal Flagwrite: STD_LOGIC_VECTOR(1 downto 0);

begin
    
    -- Logique du Flag_write
    Flagwrite<= Flagw and (condex & condex);
    
    process(clk, reset) begin
    -- Reset des registres au demarrage
        if reset = '1' then
            Flags32<= "00";
            Flags10<= "00";
        elsif rising_edge(clk) then
            -- Decision de la sauvegarde ou non des Flags N et Z en fonction de Flagwrite(1)
            if Flagwrite(1) = '1' then
                Flags32<= ALU_Flags(3 downto 2);
            end if;
            -- Decision de la sauvegarde ou non des Flags C et V en fonction de Flagwrite(0)
            if Flagwrite(0) = '1' then
                Flags10<= ALU_Flags(1 downto 0);
            end if;
        end if;
    end process;
end flags_register_Behavioral;
