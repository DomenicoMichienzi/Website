--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    volume_id text NOT NULL,
    username_id text NOT NULL,
    title text,
    link text,
    description text,
    review text,
    rating real,
    comment text
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movie_id text NOT NULL,
    username_id text NOT NULL,
    title text,
    description text,
    review text,
    rating real,
    comment text
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: tvs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tvs (
    tv_id text NOT NULL,
    username_id text NOT NULL,
    title text,
    description text,
    review text,
    rating real,
    comment text
);


ALTER TABLE public.tvs OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    email text,
    username text NOT NULL,
    password text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (volume_id, username_id, title, link, description, review, rating, comment) FROM stdin;
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (movie_id, username_id, title, description, review, rating, comment) FROM stdin;
\.


--
-- Data for Name: tvs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tvs (tv_id, username_id, title, description, review, rating, comment) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (email, username, password) FROM stdin;
ciao@ciao.com	Locke	certo
certo@certo.com	Leibniz	ciao
caso@gmail.com	Asimov	fondazione
\.


--
-- Name: books books_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pk PRIMARY KEY (volume_id, username_id);


--
-- Name: movies movies_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pk PRIMARY KEY (movie_id, username_id);


--
-- Name: tvs tv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tvs
    ADD CONSTRAINT tv_pk PRIMARY KEY (tv_id, username_id);


--
-- Name: users user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (username);


--
-- Name: books books_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_users_null_fk FOREIGN KEY (username_id) REFERENCES public.users(username);


--
-- Name: movies movies_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_users_null_fk FOREIGN KEY (username_id) REFERENCES public.users(username);


--
-- Name: tvs tv_users_null_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tvs
    ADD CONSTRAINT tv_users_null_fk FOREIGN KEY (username_id) REFERENCES public.users(username);


--
-- PostgreSQL database dump complete
--

