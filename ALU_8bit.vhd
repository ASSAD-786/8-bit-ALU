----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2025 11:09:29
-- Design Name: 
-- Module Name: ALU_8bit - Behavioural
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


USE ieee.numeric_std.ALL;

ENTITY ALU_8bit IS
    PORT (
        A, B     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        ch       : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        ans   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        carry,zero : OUT STD_LOGIC
    );
END ALU_8bit;

ARCHITECTURE Behavioural OF ALU_8bit IS
    SIGNAL store : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    PROCESS (A, B, ch)
        VARIABLE Temp : UNSIGNED(8 DOWNTO 0);
    BEGIN
        CASE ch IS
            WHEN "000" =>
                Temp := ('0' & UNSIGNED(A)) + UNSIGNED(B);
                store <= STD_LOGIC_VECTOR(Temp(7 DOWNTO 0));
                carry <= Temp(8);
            WHEN "001" =>
                Temp := ('0' & UNSIGNED(A)) - UNSIGNED(B);
                store <= STD_LOGIC_VECTOR(Temp(7 DOWNTO 0));
                carry <= Temp(8);
            WHEN "010" =>
                store <= A AND B;
                carry <= '0';
            WHEN "011" =>
                store <= A OR B;
                carry <= '0';
            WHEN "100" =>
                store <= A XOR B;
                carry <= '0';
            WHEN "101" =>
                store <= NOT A;
                carry <= '0';
            WHEN OTHERS =>
                store <= (OTHERS => '0');
                carry <= '0';
        END CASE;
        
        IF store = "00000000" THEN
            zero <= '1';
        ELSE
            zero <= '0';
        END IF;
        
        ans <= store;
    END PROCESS;
END Behavioural;
