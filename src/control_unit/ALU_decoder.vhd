----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2025 02:18:33 PM
-- Design Name: 
-- Module Name: ALU_decoder - ALU_decoder_Behavioral
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

entity ALU_decoder is
  Port (
        funct41: in STD_LOGIC_VECTOR(3 downto 0);
        funct0, ALUop: in STD_LOGIC;  
        ALUcontrol, Flagw: out STD_LOGIC_VECTOR(1 downto 0)
   );
end ALU_decoder;

architecture ALU_decoder_Behavioral of ALU_decoder is

begin

    process(funct0, ALUop, funct41) begin
        -- Pas de traitement de données
        if ALUop = '0' then
            ALUcontrol<= "00";
            Flagw<= "00";
        else
            -- Traitement de donnée 
            case funct41 is
                
                when "0100" =>
                -- ADD
                ALUcontrol<= "00";
                if funct0 = '0' then
                    Flagw<= "00";
                else
                    Flagw<= "11";
                end if;
                
                --SUB
                when "0010" =>            
                ALUcontrol<= "01";
                if funct0 = '0' then
                    Flagw<= "00";
                else
                    Flagw<= "11";
                end if;
                
                --AND
                when "0000" =>
                ALUcontrol<= "10";
                if funct0 = '0' then
                    Flagw<= "00";
                else
                    Flagw<= "10";
                end if; 
                
                --OR
                when "1100" =>
                ALUcontrol<= "11";
                if funct0 = '0' then
                    Flagw<= "00";
                else
                    Flagw<= "10";
                end if; 
                
                when others =>
                ALUcontrol<= "00";
                Flagw<= "00";          
            end case;
        end if;
    end process;

end ALU_decoder_Behavioral;
