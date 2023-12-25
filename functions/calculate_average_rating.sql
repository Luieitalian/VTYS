CREATE OR REPLACE FUNCTION calculate_average_rating(course_id INT)
    RETURNS NUMERIC AS $$
DECLARE
    total_rating INT;
    number_of_ratings INT;
    average_rating NUMERIC;
BEGIN
    SELECT COALESCE(SUM(rating), 0), COALESCE(COUNT(rating), 0)
    INTO total_rating, number_of_ratings
    FROM "public"."rating"
    WHERE "public"."rating"."course_id" = calculate_average_rating."course_id";

    IF number_of_ratings = 0 THEN
        RETURN NULL; 
    END IF;
    
    average_rating := total_rating::NUMERIC / number_of_ratings;

    RETURN average_rating;
END;
$$ LANGUAGE plpgsql;
