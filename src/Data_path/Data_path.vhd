----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2025 03:16:54 PM
-- Design Name: 
-- Module Name: Data_path - Data_path_Structural
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

entity Data_path is
  Port ( 
        memto_reg, mem_write, ALU_src, reg_write, clk: in STD_LOGIC;
        imm_src,reg_src, ALU_control: in STD_LOGIC_VECTOR(1 downto 0);
        instr, R15: in STD_LOGIC_VECTOR(31 downto 0);
        ALU_FLAGSo: out STD_LOGIC_VECTOR(3 downto 0);
        srcaout, srcbout: out STD_LOGIC_VECTOR(31 DOWNTO 0); -- AjouT POUR RESOUDRE UN BUG SUR LE DEVOIR 3
        Result_final, ALUresout, WDOUT: out STD_LOGIC_VECTOR(31 downto 0) --ALUresout et WDOUT sont ajoutés pour voir ces sorties dans le cadre du devoir 3
        );
end Data_path;

architecture Data_path_Structural of Data_path is

    signal RA1, RA2, A3: STD_LOGIC_VECTOR(3 downto 0);
    signal entre_extend: STD_LOGIC_VECTOR(23 downto 0);
    signal WD3, extimm, SrcA, srcB, RD2, ALU_Result, WD, Read_Data, sortie: STD_LOGIC_VECTOR(31 downto 0);
    signal RD2is, RD2os: STD_LOGIC_VECTOR(31 downto 0); -- Signaux d'entree et de sortie du barrel shifter
    signal V, C, N, Z: STD_LOGIC;

begin

   -- Gestion des signaux RA1, RA2, A3 qui seront utilisés dans le register file
   RA1 <= instr(19 downto 16) when reg_src(0)= '0' else "1111";
   RA2 <= instr(3 downto 0) when reg_src(1)= '0' else instr(15 downto 12);
   A3 <= instr(15 downto 12);
   
   -- Instance du register file
   Reg_file: entity work.registers
    port map(
       clk=> clk,
       WE3=> reg_write,
       A1=> RA1,
       A2=> RA2,
       A3=> A3,
       WD3=> sortie,
       R15=> R15,
       RD1=> SrcA,
       RD2=> RD2
    );
    
    --RD2is <= RD2;
    
    entre_extend <= instr(23 downto 0); -- Entree du bloc extend
    -- Instance du module Extend
    ext_mod: entity work.extend
        port map(
            ext_in=> entre_extend,
            immsrc=> imm_src,
            extimm=> extimm
        );
        
    -- Instance du barrel shifter
        B_Shift: entity work.barrel_shifter
            port map(
                RD2 => RD2,
                shift_info => instr(11 downto 5),
                RD2s => RD2os 
            );
            
    SrcB<= RD2os when ALU_src= '0' else extimm; -- Choix de la donnée à envoyer au signal srcB
    
    -- Instance de l'ALU
    ALU: entity work.ALU_FLAGS
        port map(
            A=> SrcA,
            B=> SrcB,
            ALU_CONTROL=> ALU_control,
            V=> V,
            C=> C,
            N=> N,
            Z=> Z,
            result=> ALU_Result,
            ALU_FLAGS=> ALU_FLAGSo
        );
        
        
    -- Instance de la memoire de donnée
    Mem_data: entity work.Data_memory
        port map(
            clk=> clk,
            WE=> mem_write,
            A=> ALU_Result,
            WD=> RD2,
            RD=> Read_Data
        );
    
    sortie<= Read_Data when memto_reg= '1' else ALU_Result;
    Result_final<= sortie;
    ALUresout<= ALU_Result; -- Ligne ajouté pour permettre de voir la sortie ALU_RESULT DANS LE CADRE DU DEVOIR 3
    WDOUT<= RD2; -- Ligne ajouté pour permettre de voir la sortie ALU_RESULT DANS LE CADRE DU DEVOIR 3
    SRCAout<= srcA;
    srcbout<= srcb;
end Data_path_Structural;
