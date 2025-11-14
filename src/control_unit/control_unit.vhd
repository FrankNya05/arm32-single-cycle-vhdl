----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2025 02:55:19 PM
-- Design Name: 
-- Module Name: control_unit - Structural
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

entity control_unit is
  Port ( 
    clk, reset: in STD_LOGIC;
    cond, Rd, ALU_Flags: in STD_LOGIC_VECTOR(3 downto 0);
    op: in STD_LOGIC_VECTOR(1 downto 0);
    Funct : in STD_LOGIC_VECTOR(5 downto 0);
    Flags: in STD_LOGIC_VECTOR(3 downto 0);
    memtoreg, memwrite, ALUsrc, regwrite, PCsrc: out STD_LOGIC;
    ALUcontrol, Immsrc, Regsrc: out STD_LOGIC_VECTOR(1 downto 0)
  );
end control_unit;

architecture Structural of control_unit is
    signal branchi, regwi, memwi, PCsi, ALUop, nowritei: STD_LOGIC;
    signal Flagwi: STD_LOGIC_VECTOR(1 downto 0);
    
begin    
    --instance du decodeur principal
    main_deco: entity work.main_decoder
        port map(
            opcode=> op,
            funct50(1)=> Funct(5),
            funct50(0)=> Funct(0),
            Regw=> regwi, --changer cette ligne et mettre plutot le signal regwi dans le cas où on inplemente le PC Logic
            memw=> memwi,
            memtoreg=> memtoreg,
            ALUsrc=> ALUsrc,
            Immsrc=> Immsrc,
            Regsrc=> Regsrc, 
            ALUop=> ALUop
            --branch=> branchi -- Non utilisé pour l'instant. À mettre si PC Logic est implément
        );
        
    --instance du decodeur de l'ALU
    ALU_deco: entity work.ALU_decoder
        port map(
            funct41=> Funct(4 downto 1),
            funct0=> Funct(0),
            ALUop=> ALUop,
            ALUcontrol=> ALUcontrol,
            nowrite=> nowritei,
            Flagw=> Flagwi
        );
        
    -- Ajout du bloc de la logique conditionnele
    
    --Instance du conditional logic
    cond_logic: entity work.condition_logic
        port map(
            clk=> clk,
            reset=> reset,
            cond=> cond,
            ALU_FLAGS=> ALU_Flags,
            Flagw=> Flagwi,
            nowrite=> nowritei,
            Regw=> Regwi,
            Memw=> Memwi,
            PCs=> PCsi,
            Regwrite=> regwrite,
            Memwrite=> memwrite
        );

end Structural;
