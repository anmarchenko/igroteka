--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.11
-- Dumped by pg_dump version 12.2

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

SET default_tablespace = '';

--
-- Name: backlog_available_platforms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlog_available_platforms (
    id bigint NOT NULL,
    platform_id integer,
    platform_name character varying(255),
    entry_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.backlog_available_platforms OWNER TO postgres;

--
-- Name: backlog_available_platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backlog_available_platforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backlog_available_platforms_id_seq OWNER TO postgres;

--
-- Name: backlog_available_platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backlog_available_platforms_id_seq OWNED BY public.backlog_available_platforms.id;


--
-- Name: backlog_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlog_entries (
    id bigint NOT NULL,
    game_id integer,
    game_name character varying(255),
    game_release_date date,
    owned_platform_id integer,
    owned_platform_name character varying(255),
    finished_at date,
    score integer,
    status character varying(255),
    user_id bigint,
    note character varying(255),
    poster_thumb_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    expectation_rating integer
);


ALTER TABLE public.backlog_entries OWNER TO postgres;

--
-- Name: backlog_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backlog_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backlog_entries_id_seq OWNER TO postgres;

--
-- Name: backlog_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backlog_entries_id_seq OWNED BY public.backlog_entries.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name character varying(255),
    external_id character varying(255),
    external_url character varying(255),
    website character varying(255),
    description text,
    twitter character varying(255),
    country character varying(255),
    start_date date,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: external_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_links (
    id bigint NOT NULL,
    url character varying(255),
    category character varying(255),
    game_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    external_id character varying(255),
    external_category_id character varying(255)
);


ALTER TABLE public.external_links OWNER TO postgres;

--
-- Name: external_links_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.external_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.external_links_id_seq OWNER TO postgres;

--
-- Name: external_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.external_links_id_seq OWNED BY public.external_links.id;


--
-- Name: franchises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.franchises (
    id bigint NOT NULL,
    name character varying(255),
    external_id character varying(255),
    external_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.franchises OWNER TO postgres;

--
-- Name: franchises_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.franchises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.franchises_id_seq OWNER TO postgres;

--
-- Name: franchises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.franchises_id_seq OWNED BY public.franchises.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id bigint NOT NULL,
    name character varying(255),
    external_id character varying(255),
    external_url character varying(255),
    short_description text,
    description text,
    release_date date,
    cover_id bigint,
    rating double precision,
    category integer,
    status integer,
    ttb_hastly integer,
    ttb_normally integer,
    ttb_completely integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    ratings_count integer
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_developers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_developers (
    id bigint NOT NULL,
    game_id bigint,
    company_id bigint
);


ALTER TABLE public.games_developers OWNER TO postgres;

--
-- Name: games_developers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_developers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_developers_id_seq OWNER TO postgres;

--
-- Name: games_developers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_developers_id_seq OWNED BY public.games_developers.id;


--
-- Name: games_franchises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_franchises (
    id bigint NOT NULL,
    game_id bigint,
    franchise_id bigint
);


ALTER TABLE public.games_franchises OWNER TO postgres;

--
-- Name: games_franchises_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_franchises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_franchises_id_seq OWNER TO postgres;

--
-- Name: games_franchises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_franchises_id_seq OWNED BY public.games_franchises.id;


--
-- Name: games_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_genres (
    id bigint NOT NULL,
    game_id bigint,
    genre_id bigint
);


ALTER TABLE public.games_genres OWNER TO postgres;

--
-- Name: games_genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_genres_id_seq OWNER TO postgres;

--
-- Name: games_genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_genres_id_seq OWNED BY public.games_genres.id;


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: games_platforms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_platforms (
    id bigint NOT NULL,
    game_id bigint,
    platform_id bigint
);


ALTER TABLE public.games_platforms OWNER TO postgres;

--
-- Name: games_platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_platforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_platforms_id_seq OWNER TO postgres;

--
-- Name: games_platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_platforms_id_seq OWNED BY public.games_platforms.id;


--
-- Name: games_publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_publishers (
    id bigint NOT NULL,
    game_id bigint,
    company_id bigint
);


ALTER TABLE public.games_publishers OWNER TO postgres;

--
-- Name: games_publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_publishers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_publishers_id_seq OWNER TO postgres;

--
-- Name: games_publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_publishers_id_seq OWNED BY public.games_publishers.id;


--
-- Name: games_themes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_themes (
    id bigint NOT NULL,
    game_id bigint,
    theme_id bigint
);


ALTER TABLE public.games_themes OWNER TO postgres;

--
-- Name: games_themes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_themes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_themes_id_seq OWNER TO postgres;

--
-- Name: games_themes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_themes_id_seq OWNED BY public.games_themes.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    id bigint NOT NULL,
    name character varying(255),
    external_id character varying(255),
    external_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genres_id_seq OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id bigint NOT NULL,
    big_url character varying(255),
    thumb_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- Name: platforms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.platforms (
    id bigint NOT NULL,
    name character varying(255),
    alternative_name character varying(255),
    generation integer,
    summary text,
    website character varying(255),
    external_id character varying(255),
    external_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.platforms OWNER TO postgres;

--
-- Name: platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.platforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.platforms_id_seq OWNER TO postgres;

--
-- Name: platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.platforms_id_seq OWNED BY public.platforms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: themes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.themes (
    id bigint NOT NULL,
    name character varying(255),
    external_id character varying(255),
    external_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.themes OWNER TO postgres;

--
-- Name: themes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.themes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.themes_id_seq OWNER TO postgres;

--
-- Name: themes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.themes_id_seq OWNED BY public.themes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    encrypted_password character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    name character varying(255) NOT NULL,
    avatar character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: backlog_available_platforms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_available_platforms ALTER COLUMN id SET DEFAULT nextval('public.backlog_available_platforms_id_seq'::regclass);


--
-- Name: backlog_entries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_entries ALTER COLUMN id SET DEFAULT nextval('public.backlog_entries_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: external_links id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_links ALTER COLUMN id SET DEFAULT nextval('public.external_links_id_seq'::regclass);


--
-- Name: franchises id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.franchises ALTER COLUMN id SET DEFAULT nextval('public.franchises_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: games_developers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_developers ALTER COLUMN id SET DEFAULT nextval('public.games_developers_id_seq'::regclass);


--
-- Name: games_franchises id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_franchises ALTER COLUMN id SET DEFAULT nextval('public.games_franchises_id_seq'::regclass);


--
-- Name: games_genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_genres ALTER COLUMN id SET DEFAULT nextval('public.games_genres_id_seq'::regclass);


--
-- Name: games_platforms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_platforms ALTER COLUMN id SET DEFAULT nextval('public.games_platforms_id_seq'::regclass);


--
-- Name: games_publishers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_publishers ALTER COLUMN id SET DEFAULT nextval('public.games_publishers_id_seq'::regclass);


--
-- Name: games_themes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_themes ALTER COLUMN id SET DEFAULT nextval('public.games_themes_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- Name: platforms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platforms ALTER COLUMN id SET DEFAULT nextval('public.platforms_id_seq'::regclass);


--
-- Name: themes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes ALTER COLUMN id SET DEFAULT nextval('public.themes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: backlog_available_platforms backlog_available_platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_available_platforms
    ADD CONSTRAINT backlog_available_platforms_pkey PRIMARY KEY (id);


--
-- Name: backlog_entries backlog_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_entries
    ADD CONSTRAINT backlog_entries_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: external_links external_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_links
    ADD CONSTRAINT external_links_pkey PRIMARY KEY (id);


--
-- Name: franchises franchises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.franchises
    ADD CONSTRAINT franchises_pkey PRIMARY KEY (id);


--
-- Name: games_developers games_developers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_developers
    ADD CONSTRAINT games_developers_pkey PRIMARY KEY (id);


--
-- Name: games_franchises games_franchises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_franchises
    ADD CONSTRAINT games_franchises_pkey PRIMARY KEY (id);


--
-- Name: games_genres games_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_genres
    ADD CONSTRAINT games_genres_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: games_platforms games_platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_platforms
    ADD CONSTRAINT games_platforms_pkey PRIMARY KEY (id);


--
-- Name: games_publishers games_publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_publishers
    ADD CONSTRAINT games_publishers_pkey PRIMARY KEY (id);


--
-- Name: games_themes games_themes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_themes
    ADD CONSTRAINT games_themes_pkey PRIMARY KEY (id);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: platforms platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platforms
    ADD CONSTRAINT platforms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: themes themes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: backlog_available_platforms_entry_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backlog_available_platforms_entry_id_index ON public.backlog_available_platforms USING btree (entry_id);


--
-- Name: backlog_entries_unique_user_id_game_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX backlog_entries_unique_user_id_game_id_index ON public.backlog_entries USING btree (game_id, user_id);


--
-- Name: backlog_entries_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backlog_entries_user_id_index ON public.backlog_entries USING btree (user_id);


--
-- Name: companies_external_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX companies_external_id_index ON public.companies USING btree (external_id);


--
-- Name: franchises_external_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX franchises_external_id_index ON public.franchises USING btree (external_id);


--
-- Name: games_developers_game_id_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX games_developers_game_id_company_id_index ON public.games_developers USING btree (game_id, company_id);


--
-- Name: games_external_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX games_external_id_index ON public.games USING btree (external_id);


--
-- Name: games_franchises_game_id_franchise_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX games_franchises_game_id_franchise_id_index ON public.games_franchises USING btree (game_id, franchise_id);


--
-- Name: games_genres_game_id_genre_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX games_genres_game_id_genre_id_index ON public.games_genres USING btree (game_id, genre_id);


--
-- Name: games_platforms_game_id_platform_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX games_platforms_game_id_platform_id_index ON public.games_platforms USING btree (game_id, platform_id);


--
-- Name: games_publishers_game_id_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX games_publishers_game_id_company_id_index ON public.games_publishers USING btree (game_id, company_id);


--
-- Name: games_themes_game_id_theme_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX games_themes_game_id_theme_id_index ON public.games_themes USING btree (game_id, theme_id);


--
-- Name: genres_external_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX genres_external_id_index ON public.genres USING btree (external_id);


--
-- Name: platforms_external_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX platforms_external_id_index ON public.platforms USING btree (external_id);


--
-- Name: themes_external_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX themes_external_id_index ON public.themes USING btree (external_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: backlog_available_platforms backlog_available_platforms_entry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_available_platforms
    ADD CONSTRAINT backlog_available_platforms_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES public.backlog_entries(id) ON DELETE CASCADE;


--
-- Name: backlog_entries backlog_entries_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_entries
    ADD CONSTRAINT backlog_entries_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: external_links external_links_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_links
    ADD CONSTRAINT external_links_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games games_cover_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_cover_id_fkey FOREIGN KEY (cover_id) REFERENCES public.images(id);


--
-- Name: games_developers games_developers_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_developers
    ADD CONSTRAINT games_developers_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: games_developers games_developers_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_developers
    ADD CONSTRAINT games_developers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_franchises games_franchises_franchise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_franchises
    ADD CONSTRAINT games_franchises_franchise_id_fkey FOREIGN KEY (franchise_id) REFERENCES public.franchises(id);


--
-- Name: games_franchises games_franchises_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_franchises
    ADD CONSTRAINT games_franchises_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_genres games_genres_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_genres
    ADD CONSTRAINT games_genres_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_genres games_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_genres
    ADD CONSTRAINT games_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id);


--
-- Name: games_platforms games_platforms_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_platforms
    ADD CONSTRAINT games_platforms_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_platforms games_platforms_platform_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_platforms
    ADD CONSTRAINT games_platforms_platform_id_fkey FOREIGN KEY (platform_id) REFERENCES public.platforms(id);


--
-- Name: games_publishers games_publishers_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_publishers
    ADD CONSTRAINT games_publishers_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: games_publishers games_publishers_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_publishers
    ADD CONSTRAINT games_publishers_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_themes games_themes_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_themes
    ADD CONSTRAINT games_themes_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_themes games_themes_theme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_themes
    ADD CONSTRAINT games_themes_theme_id_fkey FOREIGN KEY (theme_id) REFERENCES public.themes(id);


--
-- PostgreSQL database dump complete
--

