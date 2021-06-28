library IEEE;
use IEEE.std_logic_1164.all;
use iEEE.std_logic_signed.all;
use IEEE.numeric_std.all;
use IEEE.fixed_pkg.all;

entity multiplier is
    generic (
        last_layer_values_count : integer := 3;  -- full input size
        n : integer := 16
    );
    port (
        weights: in std_logic_vector(last_layer_values_count*n - 1 downto 0);
        values: in std_logic_vector(last_layer_values_count*n - 1 downto 0);
        index: in std_logic_vector(7 downto 0);
        result: out std_logic_vector(n-1 downto 0)
    );
end multiplier;

architecture multiplier_booth of multiplier is
    signal m, r: std_logic_vector(n-1 downto 0);
    signal msf, rsf, ressf: sfixed(4 downto -11);
    signal ii: integer := 0;
    signal res_sig: std_logic_vector(n-1 downto 0) := (others => '0');
    begin
        ii <= to_integer(unsigned(index)) * 16;

        -- Get values[index], weights[index]
        m <= weights(n-1+ii downto ii) WHEN (ii < n*last_layer_values_count) ELSE (others => '0');
        r <= values(n-1+ii downto ii) WHEN (ii < n*last_layer_values_count) ELSE (others => '0');

        msf <= to_sfixed(m, 4, -11);
        rsf <= to_sfixed(r, 4, -11);
        ressf <= to_sfixed(res_sig, 4, -11);
        result <= res_sig;

        multiplication_loop : process( m, r )
            variable A : std_logic_vector (2*n downto 0) := (others => '0');
            variable P : std_logic_vector (2*n downto 0) := (others => '0');
            variable S : std_logic_vector (2*n downto 0) := (others => '0');
        begin
            A(2*n DOWNTO n+1) := m;
            S(2*n DOWNTO n+1) := std_logic_vector(unsigned(not(m)) + 1);
            P := (others => '0');
            P(n DOWNTO 1) := r;
            -- report to_bstring(P);
            for i in 0 to n-1 loop
                -- report to_bstring((P(1 downto 0)));
                -- Case 2
                if P(1 downto 0) = "01" then
                    report "Case 2";
                    P := P + A;
                -- Case 3
                elsif P(1 downto 0) = "10" then
                    report "Case 3";
                    P := P + S;
                end if;

                P(2*n DOWNTO 0) := P(2*n) & P(2*n DOWNTO 1);
                -- report to_bstring(P);
            end loop ;
            res_sig <= std_logic_vector(signed(P(2*n-5 downto 2*n-20)));
        end process ; -- multiplication_loop
    
end multiplier_booth ; -- multiplier_booth