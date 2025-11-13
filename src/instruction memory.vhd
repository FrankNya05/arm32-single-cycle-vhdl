----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2025 09:56:33 PM
-- Design Name: 
-- Module Name: instruction_memory - instruction_memory_Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory is

  Port (
        clk, reset: in STD_LOGIC; 
        pca: in STD_LOGIC_VECTOR(31 downto 0); --Valeur du PC+4
        PC: out STD_LOGIC_VECTOR(31 downto 0);
        instr: out STD_LOGIC_VECTOR(31 downto 0) -- Valeur de PC à l'entrée de la memoire d'instruction
        );
end instruction_memory;

architecture instruction_memory_Behavioral of instruction_memory is

    -- Création d'une memoire de 32 valeurs de 32 bits qui contiendra nos instructions
    type mem is array((2**5)-1 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    -- Initialisation des valeurs de la memoire d'instruction
    signal memoire : mem := (
        0  => "11100000010000000000000000000000",
        1  => "11100010100000000010000000000101",
        2  => "11100010100000000011000000001100",
        3  => "11100010010000110111000000001001",
        4  => "11100001100001110100000000000010",
        5  => "11100000000000110101000000000100",
        6  => "11100000100001010101000000000100",
        7  => "11100000010101011000000000000111",
        8  => "11100000010100111000000000000100",
        9  => "11100010100000000101000000000000",
        10 => "11100000010101111000000000000010",
        11 => "10110010100001010111000000000001",
        12 => "11100000010001110111000000000010",
        13 => "11100101100000110111000001010100",
        14 => "11100101100100000010000001100000",
        15 => "11100000100010000101000000000000",
        16 => "11100010100000000010000000001110",
        17 => "11100010100000000010000000001101",
        18 => "11100010100000000010000000001010",
        19 => "11100101100000000010000001100100",
        others => (others => '0')  -- le reste de la mémoire est à zéro
    );
    
    signal PCi: STD_LOGIC_VECTOR(31 downto 0); -- Signal intermediaire permettant de faire la liaison avec la memoire d'instruction
    
begin
    
    -- Process de gestion du PC
    process(clk) begin
    -- Lecture du PC à chaque front montant de l'horloge
    if reset= '1' then
        -- Initialisation du PC à 0
        PCi<= (others=> '0');
    elsif rising_edge(clk) then
        PCi<= pca; -- Le PC à l'entrée de la memoire d'instruction prend la valeur du PC+4
    end if;
    
    end process;
    
    --Gestion de la memoire d'instruction
    instr<= memoire(to_integer(unsigned(PCi(6 downto 2)))); -- Instruction prend la valeur pointé par le PC
    PC<= pci; -- On met à jour la sortie PC

end instruction_memory_Behavioral;
