----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2025 03:46:06 PM
-- Design Name: 
-- Module Name: datapath_deco - Structural
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

entity datapath_deco is
  Port (
        instr, R15: in STD_LOGIC_VECTOR(31 downto 0);
        clk, reset: in STD_LOGIC;
        PCsrc: out STD_LOGIC;
        Data_result, ALUresult_out, Result:  out STD_LOGIC_VECTOR(31 downto 0)
   );
end datapath_deco;

architecture Structural of datapath_deco is

signal memto_regi, mem_writei, ALU_srci, reg_writei, PCi: STD_LOGIC;
signal imm_srci,reg_srci, ALU_controli: STD_LOGIC_VECTOR(1 downto 0);
signal ALU_FLAGSi: STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Instance du Control unit
    control: entity work.control_unit
        port map(
            clk=> clk,
            reset=> reset,
            cond=> instr(31 downto 28),
            Rd=> instr(15 downto 12),
            ALU_FLAGS=> ALU_FLAGSi,
            op=> instr(27 downto 26),
            Funct=> instr(25 downto 20),
            Flags=> ALU_FLAGSi,
            memtoreg=> memto_regi,
            memwrite=> mem_writei,
            ALUsrc=> ALU_srci,
            regwrite=> reg_writei,
            ALUcontrol=> ALU_controli,
            Immsrc=> imm_srci,
            PCsrc=> PCsrc,
            Regsrc=> reg_srci
        );
        
    -- Instance du datapath
    datapath: entity work.Data_path
        port map(
            R15=> R15,
            memto_reg=> memto_regi,
            mem_write=> mem_writei,
            ALU_src=> ALU_srci,
            reg_write=> reg_writei,
            clk=> clk,
            imm_src=> imm_srci,
            reg_src=> reg_srci,
            ALU_control=> ALU_controli,
            instr=> instr,
            ALU_FLAGSo=> ALU_FLAGSi,
            ALUresout=> ALUresult_out, -- Resultat de l'ALU
            WDOUT=> Data_result, -- Résultat write Data
            Result_final=> Result -- On recupere le resultat final a la sortie du multiplexer 
        );        
end Structural;
