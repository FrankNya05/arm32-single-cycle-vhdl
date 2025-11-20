----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 02:26:29 AM
-- Design Name: 
-- Module Name: ARM_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ARM_tb is
--  Port ( );
end ARM_tb;

architecture Behavioral of ARM_tb is

    signal clk_tb, reset_tb: STD_LOGIC;
    signal Result_tb, ALU_result_tb, instr_tb, Data_result_tb, ExpectedALUResult, ExpectedData: STD_LOGIC_VECTOR(31 downto 0);
    
begin

    --Instance du ARM
    arm: entity work.ARM
    port map(
        clk=> clk_tb,
        reset=> reset_tb,
        instr=> instr_tb,
        result=> result_tb,
        ALU_result=> ALU_result_tb,
        Data_result=> Data_result_tb
    );

    -- Gestion du signal d'horloge
    process
    begin
        clk_tb <= '0'; wait for 5 ns;
        clk_tb <= '1'; wait for 5 ns;
    end process;
    
    process
          file tv : text;
          variable L : line;
          variable ExpectedALUResult_v, ExpectedData_v : std_logic_vector(31 downto 0);
          variable dummy : character;

        begin
          file_open(tv, "C:/GEI1084/Devoir/Devoir_4/ARM/ARM.srcs/sim_1/new/ExpectedData.txt", read_mode);
          
          -- Reset lors des deux premieres na
            reset_tb<= '1';
            wait for 2 ns;
             reset_tb<= '0';
             
          while not endfile(tv) loop
              -- lire une ligne compl?te
              readline(tv, L);
          
              -- lecture sequentielle des champs separes par '_'
              read(L, ExpectedData_v);
              read(L, dummy);
              read(L, ExpectedALUResult_v);
              
              wait until rising_edge(clk_tb); -- Lecture des signaux à chaque front montant de l'horloge
              
              -- Appliquer les entrées des signaux
              ExpectedALUResult<= ExpectedALUResult_v;
             -- ExpectedData<= ExpectedData_v;
               
              
          end loop;
      wait;
    end process;
end Behavioral;
