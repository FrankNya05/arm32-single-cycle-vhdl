----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2025 03:40:40 PM
-- Design Name: 
-- Module Name: registers - module_reg_Behavioral
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

entity registers is
    generic(N: integer := 4; M: integer := 32);
    
    Port (CLK, WE3: in STD_LOGIC;
          A1, A2, A3: in STD_LOGIC_VECTOR(N-1 downto 0);
          WD3, R15: in STD_LOGIC_VECTOR(M-1 downto 0);
          RD1, RD2: out STD_LOGIC_VECTOR(M-1 downto 0)
          );
          
end registers;

architecture module_reg_Behavioral of registers is

    type reg_array is array((2**N)-1 downto 0) of STD_LOGIC_VECTOR(M-1 downto 0); -- Création d'une structure de tableaux de 16 élements de 32 bits qui representera notre register file
    
    signal register_file: reg_array := (others => (others => '0')); -- Déclaration de notre register_file de type reg_array déclaré plus haut et initialisation de toutes les valeurs à 0
    
begin

    -- Ecriture de la valeur WD3 à l'adresse pointé par A3 lors des fronts montant de l'horloge si WE3 est à 1
    process(clk) begin
    if rising_edge(clk) then
        if WE3 = '1' then register_file(to_integer(unsigned(A3))) <= WD3;
        end if;
    end if;
    end process;
    
    -- Lecture des registres pointés par les adresses A1 et A2
    RD1 <= register_file(to_integer(unsigned(A1)));
    RD2 <= register_file(to_integer(unsigned(A2)));


end module_reg_Behavioral;
