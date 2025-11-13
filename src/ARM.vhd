----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 01:11:19 AM
-- Design Name: 
-- Module Name: ARM - structural_arm
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

entity ARM is
  Port ( 
    clk, reset: in STD_LOGIC;
    Result, ALU_result, instr, Data_result: out STD_LOGIC_VECTOR(31 downto 0)
  );
end ARM;

architecture structural_arm of ARM is
    signal pcsrci: STD_LOGIC;
    signal pcai, PCi, PCP4, PCP8, Resulti: STD_LOGIC_VECTOR(31 downto 0); --Valeur du PC+4 apres le multiplexer et valeur du PC à l'entrée de la memoire d'instruction
    signal instri: STD_LOGIC_VECTOR(31 downto 0);
begin
    
-- Instance de la memoire d'instruction
    mem_instr: entity work.instruction_memory
    port map(
        clk=> clk,
        reset=> reset,
        pca=> pcai,
        PC=> PCi,
        instr=> instri
    );
    instr<= instri;
    
-- Instance du data_path+control_unit
    data_control: entity work.datapath_deco
    port map(
        clk=> clk,
        reset=> reset,
        instr=> instri,
        R15=> PCP8,
        PCsrc=> pcsrci,
        ALUresult_out=> ALU_result, 
        Data_result=> Data_result,
        Result=> Resulti
    );
    Result<= Resulti;
    
-- Gestion du PC
    pcai<= PCP4;  -- Étant donné que dans ce laboratoire, nous n'aurons pas à gerer la logique du PC, nous prenons directement la valeur PC+4 à chaque itération
    
--Addition PC+4
    pcplus4: entity work.simple_adder
    port map(
        a=> PCi,
        b=> x"00000004",
        y=> PCP4
    );

--Adition PC+8
    pcplus8: entity work.simple_adder
    port map(
        a=> PCP4,
        B=>x"00000004",
        y=> PCP8
    );
end structural_arm;
