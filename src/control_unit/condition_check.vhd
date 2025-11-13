----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2025 04:58:47 PM
-- Design Name: 
-- Module Name: condition_check - condition_check_Behavioral
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

entity condition_check is
  Port (
    Flags32, Flags10: in STD_LOGIC_VECTOR(1 downto 0);
    cond: in STD_LOGIC_VECTOR(3 downto 0);
    condex: out STD_LOGIC
   );
end condition_check;

architecture condition_check_Behavioral of condition_check is
    
signal N, Z, C, V: STD_LOGIC; -- Flags de l'ALU

begin

-- Attribution des differents flags en fonction des vecteurs Flags32 et Flags10
N<= Flags32(1);
Z<= Flags32(0);
C<= Flags10(1);
V<= Flags10(0);

-- Processus conditionnel
process (Cond, Flags32) begin
    -- Décoder les bits de condition et determiner si oui ou non la l'instruction doit etre executee
    case Cond is
        when "0000" => -- EQ: Equal
            condex <= Z;
            
        when "0001" => -- NE: Not Equal
                CondEx <= not(Z);
                
        when "0010" => -- CS / HS: Carry Set / Unsigned Higher or Same
            CondEx <= C;
            
        when "0011" => -- CC / LO: Carry Clear / Unsigned Lower
            CondEx <= not(C);

        when "0100" => -- MI: Minus / Negative
            CondEx <= N;

        when "0101" => -- PL: Plus / Positive or zero
            CondEx <= not(N);

        when "0110" => -- VS: Overflow
            CondEx <= V;

        when "0111" => -- VC: No Overflow
            CondEx <= not(V);

        when "1000" => -- HI: Unsigned Higher
            CondEx <= (not(Z)) and (C);

        when "1001" => -- LS: Unsigned Lower or Same
            CondEx <= (Z) or (not(C));

        when "1010" => -- GE: Signed Greater or Equal
            CondEx <= not(N xor V);

        when "1011" => -- LT: Signed Less Than
            CondEx <= N xor V;

        when "1100" => -- GT: Signed Greater Than
            CondEx <= (not(Z)) and (not(N xor V));

        when "1101" => -- LE: Signed Less or Equal
            CondEx <= (Z) or (N xor V);

        when "1110" => -- AL (Always), l'execution aura toujours lieu
            CondEx <= '1';

        when others => -- Aucune condition, ne fait rien
            CondEx <= '0';
    end case;

end process;

end condition_check_Behavioral;
