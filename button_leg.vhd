library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity button_leg is
    Port (
        clk        : in  STD_LOGIC;
        clear      : in  STD_LOGIC;
        button_in  : in  STD_LOGIC;  
        button_out : in  STD_LOGIC;  
        seg        : out STD_LOGIC_VECTOR (6 downto 0)
    );
end button_leg;

architecture Behavioral of button_leg is
    signal counter : integer range 0 to 9 := 0;
    signal show_val : integer range 0 to 9 := 0;

    signal prev_button_in  : STD_LOGIC := '1';
    signal prev_button_out : STD_LOGIC := '1';
begin

    process(clk, clear)
    begin
        if clear = '0' then
            counter <= 0;
            show_val <= 0;
        elsif rising_edge(clk) then
        
            if (prev_button_in = '1' and button_in = '0') then
                if counter < 9 then
                    counter <= counter + 1;
                else
                    counter <= 0;
                end if;
            end if;

         
            if (prev_button_out = '1' and button_out = '0') then
                show_val <= counter;
            end if;

            prev_button_in  <= button_in;
            prev_button_out <= button_out;
        end if;
    end process;

    process(show_val)
    begin
        case show_val is
            when 0 => seg <= "1111110";
            when 1 => seg <= "0110000";
            when 2 => seg <= "1101101";
            when 3 => seg <= "1111001";
            when 4 => seg <= "0110011";
            when 5 => seg <= "1011011";
            when 6 => seg <= "1011111";
            when 7 => seg <= "1110000";
            when 8 => seg <= "1111111";
            when 9 => seg <= "1111011";
            when others => seg <= "0000000"; 
        end case;
    end process;

end Behavioral;
