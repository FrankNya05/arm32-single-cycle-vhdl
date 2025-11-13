----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2025 05:41:00 PM
-- Design Name: 
-- Module Name: condition_logic - Structural
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

entity condition_logic is
  Port ( 
    PCs, RegW, MemW, clk, reset: in STD_LOGIC;
    Flagw: in STD_LOGIC_VECTOR(1 downto 0);
    cond, ALU_FLAGS: in STD_LOGIC_VECTOR(3 downto 0);
    PCsrc, Regwrite, Memwrite: out STD_LOGIC
  );
end condition_logic;

architecture Structural of condition_logic is

signal condex: STD_LOGIC;
signal Flags32, Flags10: STD_LOGIC_VECTOR(1 downto 0);

begin

    -- Instance du registre des Flags
    f_reg: entity work.flags_register
        port map(
            clk=> clk,
            reset=> reset,
            Flagw=> Flagw,
            condex=> condex,
            ALU_FLAGS=> ALU_FLAGS,
            Flags32=> Flags32,
            Flags10=> Flags10
        );
        
    -- Instance du condition check
    cond_check: entity work.condition_check
        port map(
            Flags32=> Flags32,
            Flags10=> Flags10,
            cond=> cond,
            condex=> condex
        );

    -- Logique conditionnel pour decider ou non la mise à jour du PC, l'Ecriture dans les registres ou la memoire
    PCsrc<= PCs and condex;
    Regwrite<= Regw and condex;
    Memwrite<= Memw and condex;
    
end Structural;
