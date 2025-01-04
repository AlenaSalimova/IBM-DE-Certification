--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (
IN School_ID INTEGER, IN Leader_Score INTEGER)

LANGUAGE SQL
MODIFIES SQL DATA

BEGIN

		IF Leader_score > 0 AND Leader_score < 20 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'Very weak'
			WHERE SCHOOL_ID = School_ID;
		
		ELSEIF Leader_Score < 40 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'Weak'
			WHERE SCHOOL_ID = School_ID;
			
		ELSEIF Leader_Score < 60 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'Average'
			WHERE SCHOOL_ID = School_ID;
			
		ELSEIF Leader_Score < 80 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'Strong'
			WHERE SCHOOL_ID = School_ID;
			
		ELSEIF Leader_Score < 100 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'Very strong'
			WHERE SCHOOL_ID = School_ID;
		
		END IF;

END

@