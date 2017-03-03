--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: blogs; Type: TABLE; Schema: public; Owner: atsushi.sakai
--

CREATE TABLE blogs (
    id integer NOT NULL,
    name text,
    url text,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE blogs OWNER TO "atsushi.sakai";

--
-- Name: blogs_id_seq; Type: SEQUENCE; Schema: public; Owner: atsushi.sakai
--

CREATE SEQUENCE blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blogs_id_seq OWNER TO "atsushi.sakai";

--
-- Name: blogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atsushi.sakai
--

ALTER SEQUENCE blogs_id_seq OWNED BY blogs.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: atsushi.sakai
--

CREATE TABLE images (
    id integer NOT NULL,
    blog_id integer NOT NULL,
    uuid text,
    original_url text
);


ALTER TABLE images OWNER TO "atsushi.sakai";

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: atsushi.sakai
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE images_id_seq OWNER TO "atsushi.sakai";

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: atsushi.sakai
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: blogs id; Type: DEFAULT; Schema: public; Owner: atsushi.sakai
--

ALTER TABLE ONLY blogs ALTER COLUMN id SET DEFAULT nextval('blogs_id_seq'::regclass);


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: atsushi.sakai
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Data for Name: blogs; Type: TABLE DATA; Schema: public; Owner: atsushi.sakai
--

COPY blogs (id, name, url, status) FROM stdin;
\.


--
-- Name: blogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atsushi.sakai
--

SELECT pg_catalog.setval('blogs_id_seq', 1, false);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: atsushi.sakai
--

COPY images (id, blog_id, uuid, original_url) FROM stdin;
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: atsushi.sakai
--

SELECT pg_catalog.setval('images_id_seq', 1, false);


--
-- Name: blogs blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: atsushi.sakai
--

ALTER TABLE ONLY blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: atsushi.sakai
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

