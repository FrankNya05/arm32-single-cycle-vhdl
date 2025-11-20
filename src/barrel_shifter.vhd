----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2025 10:19:11 AM
-- Design Name: 
-- Module Name: barrel_shifter - barrel_shifter_Behavioral
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

entity barrel_shifter is
  Port ( 
    RD2: in STD_LOGIC_VECTOR(31 downto 0); -- Valeur de RD2 a l'entree
    shift_info: in STD_LOGIC_VECTOR(6 downto 0); -- Information relatif au shift a savoir le type et la quantité du shift
    RD2s: out STD_LOGIC_VECTOR(31 downto 0) -- Valeur de RD2 a la sortie du barrel shifter
  );
end barrel_shifter;

architecture barrel_shifter_Behavioral of barrel_shifter is

signal shamt5: STD_LOGIC_VECTOR(4 downto 0); -- Quantité du shift
signal sh: STD_LOGIC_VECTOR(1 downto 0); -- Type de shift a appliquer sur l'operande

begin
    shamt5 <= shift_info(6 downto 2);
    sh <= shift_info(1 downto 0);
    
    process(RD2, shift_info, shamt5, sh) 
        variable S: natural;
        variable RD2_temp: STD_LOGIC_VECTOR(31 downto 0);
    begin
         s := to_integer(unsigned(shamt5));  -- convertir le décalage en entier
        case sh is
            -- Cas du LSL
            when "00" =>
                RD2_temp := std_logic_vector( shift_left(unsigned(RD2), s) );
            -- Cas du LSR
            when "01" =>
                RD2_temp := std_logic_vector( shift_right(unsigned(RD2), s) );
            -- Cas du ASR
            when "10" =>
                RD2_temp := std_logic_vector( shift_right(signed(RD2), s) );
            -- Cas du ROR
            when others =>
                if s = 0 then
                    RD2_temp := RD2;  -- aucune rotation
                else
                    RD2_temp := RD2(s-1 downto 0) & RD2(31 downto s);
                end if;
               -- RD2_temp := RD2((s-1) downto 0) & RD2(31 downto s);

        end case;
        
        if (shamt5 = "00000") and (sh = "00") then
            RD2s <= RD2;
        else
            RD2s <= RD2_temp;
        end if;
    end process;

end barrel_shifter_Behavioral;
