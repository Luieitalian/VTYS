CREATE OR REPLACE FUNCTION "user".check_instructor()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.instructor_id IS NULL OR NOT EXISTS (
        SELECT 1 FROM "user"."instructor" WHERE user_id = NEW.instructor_id
    ) THEN
        RAISE EXCEPTION 'Invalid user_id. Please provide a valid instructor.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "public".check_course_id()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.course_id IS NULL OR NOT EXISTS (
        SELECT 1 FROM "public"."course" WHERE course_id = NEW.course_id
    ) THEN
        RAISE EXCEPTION 'Invalid course_id. Please provide a valid course_id.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "public".check_student()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.student_id IS NULL OR NOT EXISTS (
        SELECT 1 FROM "user"."student" WHERE user_id = NEW.student_id
    ) THEN
        RAISE EXCEPTION 'Invalid student_id. Please provide a valid student_id.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "public".check_discussion()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.discussion_id IS NULL OR NOT EXISTS (
        SELECT 1 FROM "public"."discussion" WHERE discussion_id = NEW.discussion_id
    ) THEN
        RAISE EXCEPTION 'Invalid discussion_id. Please provide a valid discussion_id.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_check_course_id
    BEFORE INSERT ON "public"."assignment"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_course_id();

CREATE TRIGGER before_insert_check_course_id
    BEFORE INSERT ON "public"."certificate"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_course_id();

CREATE TRIGGER before_insert_check_course_id
    BEFORE INSERT ON "public"."discussion"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_course_id();

CREATE TRIGGER before_insert_check_course_id
    BEFORE INSERT ON "public"."enrollment"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_course_id();

CREATE TRIGGER before_insert_check_course_id
    BEFORE INSERT ON "public"."rating"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_course_id();

CREATE TRIGGER before_insert_check_instructor
    BEFORE INSERT ON "public"."course"
    FOR EACH ROW
    EXECUTE FUNCTION "user".check_instructor();

CREATE TRIGGER before_insert_check_instructor
    BEFORE INSERT ON "public"."announcement"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_instructor();

CREATE TRIGGER before_insert_check_student_id
    BEFORE INSERT ON "public"."request"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_student();

CREATE TRIGGER before_insert_check_student_id
    BEFORE INSERT ON "public"."message"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_student();

CREATE TRIGGER before_insert_check_student_id
    BEFORE INSERT ON "public"."rating"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_student();

CREATE TRIGGER before_insert_check_student_id
    BEFORE INSERT ON "public"."certificate"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_student();

CREATE TRIGGER before_insert_check_student_id
    BEFORE INSERT ON "public"."enrollment"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_student();

CREATE TRIGGER before_insert_check_student_id
    BEFORE INSERT ON "public"."assignment"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_student();

CREATE TRIGGER before_insert_check_discussion_id
    BEFORE INSERT ON "public"."message"
    FOR EACH ROW
    EXECUTE FUNCTION "public".check_discussion();