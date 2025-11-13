----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2025 04:39:39 AM
-- Design Name: 
-- Module Name: main_decoder - main_decoder_Behavioral
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

entity main_decoder is
  Port ( 
  opcode, funct50: in STD_LOGIC_VECTOR(1 downto 0);
  branch, memtoreg, memw, ALUsrc, Regw, ALUop: out STD_LOGIC;
  Immsrc, Regsrc: out STD_LOGIC_VECTOR(1 downto 0)
  );
end main_decoder;

architecture main_decoder_Behavioral of main_decoder is

begin

    branch<= '0'; -- Pour l'instant on ne considere pas la logique du PC donc on fixe juste branch a 0
    
    process(opcode, funct50) begin
    case opcode is
        when "00"=>
            if funct50(1)= '0' then
                memtoreg<= '0';
                memw<= '0';
                ALUSrc<= '0';
                ImmSrc<= "00";
                RegW<= '1';
                RegSrc<= "00";
                ALUOp<= '1';
            else
                memtoreg<= '0';
                memw<= '0';
                ALUSrc<= '1';
                ImmSrc<= "00";
                RegW<= '1';
                RegSrc<= "00";
                ALUOp<= '1';
            end if;
         
         when "01" =>
            if funct50(0)= '0' then
                memtoreg<= '0';
                memw<= '1';
                ALUSrc<= '1';
                ImmSrc<= "01";
                RegW<= '0';
                RegSrc<= "10";
                ALUOp<= '0';
            else 
                memtoreg<= '1';
                memw<= '0';
                ALUSrc<= '1';
                ImmSrc<= "01";
                RegW<= '1';
                RegSrc<= "00";
                ALUOp<= '0';
            end if; 
        when others =>
            memtoreg<= '0';
            memw<= '0';
            ALUSrc<= '0';
            ImmSrc<= "00";
            RegW<= '0';
            RegSrc<= "00";
            ALUOp<= '0';
    end case;
    end process;
end main_decoder_Behavioral;
