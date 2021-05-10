library IEEE;
use IEEE.std_logic_1164.all;
use iEEE.std_logic_signed.all;
use IEEE.numeric_std.all;
use IEEE.fixed_pkg.all;

entity multiplier is
    generic (
        n : integer := 16;  -- full input size
        fp: integer := 4     -- input precision
    );
    port (
        m: in sfixed (n-fp-1 downto -fp);
        r: in sfixed (n-fp-1 downto -fp);
        res: out sfixed (2*(n-fp)-1 downto -2*fp) := (others => '0')
    );
end multiplier;

architecture multiplier_booth of multiplier is
    
    begin
        multiplication_loop : process( m, r )
            variable A : std_logic_vector (2*n downto 0) := (others => '0');
            variable P : std_logic_vector (2*n downto 0) := (others => '0');
            variable S : std_logic_vector (2*n downto 0) := (others => '0');
        begin
            A(2*n DOWNTO n+1) := to_slv(m);
            S(2*n DOWNTO n+1) := to_slv(resize(-m, m'high, m'low));
            P := (others => '0');
            P(n DOWNTO 1) := to_slv(r);
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
            res <= to_sfixed(signed(P(2*n downto 1)));
        end process ; -- multiplication_loop
    
end multiplier_booth ; -- multiplier_booth