----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2025 08:02:17 AM
-- Design Name: 
-- Module Name: Data_memory - Data_memory_Behavioral
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

entity Data_memory is
    generic(N: integer := 6; M: integer := 32);
    
    Port (CLK, WE: in STD_LOGIC;
          A, WD: in STD_LOGIC_VECTOR(M-1 downto 0);
          RD: out STD_LOGIC_VECTOR(M-1 downto 0)
          );
end Data_memory;

architecture Data_memory_Behavioral of Data_memory is

    type RAM is array((2**N)-1 downto 0) of STD_LOGIC_VECTOR(M-1 downto 0); -- Création d'une structure de tableaux de 64 élements de 32 bits qui representera notre RAM
    
    signal memoire: RAM := (others => (others => '0')); -- Déclaration de notre MEMOIRE de type RAM déclaré plus haut et initialisation de toutes les valeurs à 0

begin

    -- Ecriture de la valeur WD à l'adresse pointé par les 06 bits de points faible de A lors des fronts montant de l'horloge si WE est à 1
    process(clk) begin
    if rising_edge(clk) then
        if WE = '1' then memoire(to_integer(unsigned(A(5 downto 0)))) <= WD;
        end if;
    end if;
    end process;
    
    -- Lecture des registres pointés par les adresses A1 et A2
    RD <= memoire(to_integer(unsigned(A(5 downto 0))));

end Data_memory_Behavioral;
