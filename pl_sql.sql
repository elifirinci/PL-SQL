DECLARE
    input_str   VARCHAR2(30) := 'abcdefg';  -- ✅ Replace with your test input
    xml_output  VARCHAR2(4000) := '';
    char_seen   VARCHAR2(100) := '';
    curr_char   CHAR(1);
    i           INTEGER;
BEGIN
    -- Rule 1: Length check
    IF LENGTH(input_str) > 30 THEN
        DBMS_OUTPUT.PUT_LINE('Error: String exceeds maximum length of 30.');
        RETURN;
    END IF;

    -- Rule 2 & 3: Check for invalid characters and duplicates
    FOR i IN 1 .. LENGTH(input_str) LOOP
        curr_char := SUBSTR(input_str, i, 1);

        -- Check for digit or space
        IF curr_char BETWEEN '0' AND '9' OR curr_char = ' ' THEN
            DBMS_OUTPUT.PUT_LINE('Error: Invalid character found: ' || curr_char);
            RETURN;
        END IF;

        -- Check for duplicate characters
        IF INSTR(char_seen, curr_char) > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Duplicate character found: ' || curr_char);
            RETURN;
        ELSE
            char_seen := char_seen || curr_char;
        END IF;
    END LOOP;

    -- Build XML format
    xml_output := '<Characters>' || CHR(10);
    FOR i IN 1 .. LENGTH(input_str) LOOP
        curr_char := SUBSTR(input_str, i, 1);
        xml_output := xml_output || '  <Char>' || curr_char || '</Char>' || CHR(10);
    END LOOP;
    xml_output := xml_output || '</Characters>';

    -- Print final XML output
    DBMS_OUTPUT.PUT_LINE(xml_output);
END;
/
