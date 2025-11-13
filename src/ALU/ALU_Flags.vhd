----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2025 02:40:48 PM
-- Design Name: 
-- Module Name: ALU_Flags - structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Flags is
  Port ( 
      A, B : in STD_LOGIC_VECTOR(31 downto 0);
      ALU_CONTROL : in STD_LOGIC_VECTOR(1 downto 0);
      V, C, N, Z: out STD_LOGIC;
      result : out STD_LOGIC_VECTOR(31 downto 0);
      ALU_FLAGS : out STD_LOGIC_VECTOR(3 downto 0)
  );
end ALU_Flags;

architecture structural of ALU_Flags is

    component adder
        port(
        A, B : in STD_LOGIC_VECTOR(31 downto 0);
        control: in STD_LOGIC_VECTOR(1 downto 0);
        carry_out: out STD_LOGIC;
        sum: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component and_or
        Port ( 
            A, B : in STD_LOGIC_VECTOR(31 downto 0); -- Entr?e 1 ? entr?e 4 du multiplexeur
            and_out, or_out: out STD_LOGIC_VECTOR(31 downto 0)
            );
    end component;
    
    component multiplexer
      Port ( 
          E_sum, E_sous, E_and, E_or : in STD_LOGIC_VECTOR(31 downto 0); -- Entr?e 1 ? entr?e 4 du multiplexeur
          control: in STD_LOGIC_VECTOR(1 downto 0);
          Y: out STD_LOGIC_VECTOR(31 downto 0)
      );
    end component;
    
    signal sum, and_out, or_out, sortie: STD_LOGIC_VECTOR(31 downto 0);
    signal carry_o, V1, V2: STD_LOGIC;
    signal n_i, z_i, c_i, v_i : std_logic; -- Signaux intermediaires pour N, Z, C et V
    
begin
    
    -- Instance de l'additioneur et du soustracteur
    inst_add: adder
        port map(
            A=>A,
            B=>B,
            CONTROL=>ALU_CONTROL,
            carry_out=> carry_o,
            sum=> sum
        );
    
    -- Instance de la combinaison logique and or
    inst_and_or: and_or
        port map(
            A=>A,
            B=>B,
            and_out=> and_out,
            or_out=> or_out
        );
        
        --Instance du multiplexer
        inst_mux: multiplexer
            port map(
                E_sum=> sum,
                E_sous=> sum,
                E_and=> and_out,
                E_or=> or_out,
                control => ALU_CONTROL,
                y => sortie
            );
            
      z_i <= '1' when sortie=x"00000000" else '0';
      n_i <= sortie(31);
      c_i <= carry_o and (not(ALU_CONTROL(1)));
      
      V1 <= ALU_CONTROL(0) xor A(31) xor B(31);
      V2 <= A(31) xor sum(31);
      v_i <= not(V1) and V2 and not(ALU_CONTROL(1));
      
      result <= sortie;
      Z <= z_i;
      N <= n_i;
      C <= c_i;
      V <= v_i;
      ALU_FLAGS <= (n_i & z_i & c_i & v_i);
            
end structural;
