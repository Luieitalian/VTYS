CREATE TABLE public.announcement
(
    announcement_id SERIAL,
    instructor_id integer NOT NULL,
    message character varying(1000),
    publish_date date NOT NULL,
    CONSTRAINT "announcementPK" PRIMARY KEY (announcement_id, instructor_id),
    CONSTRAINT "instructorFK" FOREIGN KEY (instructor_id)REFERENCES "user".instructor (user_id)
)

CREATE TABLE public.assignment
(
    assignment_id SERIAL,
    course_id integer NOT NULL,
    student_id integer NOT NULL,
    due_date date NOT NULL,
    CONSTRAINT "assignmentPK" PRIMARY KEY (assignment_id, student_id, course_id),
    CONSTRAINT "courseFK" FOREIGN KEY (course_id)REFERENCES public.course (course_id),
    CONSTRAINT "studentFK" FOREIGN KEY (student_id)REFERENCES "user".student (user_id)
)

CREATE TABLE public.certificate
(
    certificate_id SERIAL,
    course_id integer NOT NULL,
    student_id integer NOT NULL,
    receiving_date date NOT NULL,
    "URL" character varying(150) NOT NULL,
    CONSTRAINT "certificatePK" PRIMARY KEY (certificate_id, student_id, course_id),
    CONSTRAINT "courseFK" FOREIGN KEY (course_id)REFERENCES public.course (course_id),
    CONSTRAINT "studentFK" FOREIGN KEY (student_id)REFERENCES "user".student (user_id)
)

CREATE TABLE public.course
(
    instructor_id integer NOT NULL,
    course_id SERIAL,
    name character varying(40) NOT NULL,
    description character varying(1000) NOT NULL,
    difficulty_level character(1),
    publish_date date NOT NULL,
    CONSTRAINT "coursePK" PRIMARY KEY (course_id, instructor_id),
    CONSTRAINT course_id_unique UNIQUE (course_id),
    CONSTRAINT "instructor_idFK" FOREIGN KEY (instructor_id)REFERENCES "user".instructor (user_id)
)

CREATE TABLE public.discussion
(
    discussion_id SERIAL,
    course_id integer NOT NULL,
    title character varying NOT NULL,
    post_date date NOT NULL,
    CONSTRAINT "discussionPK" PRIMARY KEY (discussion_id, course_id),
    CONSTRAINT discussion_id_unique UNIQUE (discussion_id),
    CONSTRAINT "courseFK" FOREIGN KEY (course_id)REFERENCES public.course (course_id)
)

CREATE TABLE public.enrollment
(
    course_id integer NOT NULL,
    student_id integer NOT NULL,
    enrollment_date date NOT NULL,
    completion_date date,
    CONSTRAINT "enrollmentPK" PRIMARY KEY (student_id, course_id),
    CONSTRAINT "courseFK" FOREIGN KEY (course_id)REFERENCES public.course (course_id),
    CONSTRAINT "studentFK" FOREIGN KEY (student_id)REFERENCES "user".student (user_id)
)

CREATE TABLE public.message
(
    message_id SERIAL,
    discussion_id integer NOT NULL,
    student_id integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    message character varying(150) NOT NULL,
    CONSTRAINT "messagePK" PRIMARY KEY (message_id, discussion_id, student_id),
    CONSTRAINT "discussionFK" FOREIGN KEY (discussion_id)REFERENCES public.discussion (discussion_id),
    CONSTRAINT "studentFK" FOREIGN KEY (student_id)REFERENCES "user".student (user_id)
)

CREATE TABLE public.rating
(
    rating_id SERIAL,
    course_id integer NOT NULL,
    student_id integer NOT NULL,
    comment character varying(150),
    rating smallint NOT NULL,
    CONSTRAINT "ratingPK" PRIMARY KEY (rating_id, student_id, course_id),
    CONSTRAINT "courseFK" FOREIGN KEY (course_id)REFERENCES public.course (course_id),
    CONSTRAINT "studentFK" FOREIGN KEY (student_id)REFERENCES "user".student (user_id),
    CONSTRAINT rating_rating_check CHECK (rating >= 0 AND rating <= 10)
)

CREATE TABLE public.request
(
    request_id SERIAL,
    instructor_id integer NOT NULL,
    student_id integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    message character varying(300) NOT NULL,
    CONSTRAINT "requestPK" PRIMARY KEY (request_id, instructor_id, student_id),
    CONSTRAINT "instructorFK" FOREIGN KEY (instructor_id)REFERENCES "user".instructor (user_id),
    CONSTRAINT "studentFK" FOREIGN KEY (student_id)REFERENCES "user".student (user_id)
)