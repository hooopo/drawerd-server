--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO postgres;

--
-- Name: columns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE columns (
    id bigint NOT NULL,
    table_id bigint,
    name character varying,
    comment character varying,
    nullable boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    column_type character varying DEFAULT 'string'::character varying,
    is_pk boolean DEFAULT false
);


ALTER TABLE columns OWNER TO postgres;

--
-- Name: columns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE columns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE columns_id_seq OWNER TO postgres;

--
-- Name: columns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE columns_id_seq OWNED BY columns.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE companies (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    subdomain character varying,
    owner_id bigint
);


ALTER TABLE companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE groups (
    id bigint NOT NULL,
    project_id bigint,
    user_id bigint,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE groups OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_id_seq OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE invitations (
    id bigint NOT NULL,
    company_id bigint,
    user_id bigint,
    email character varying NOT NULL,
    invitee_id bigint,
    token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE invitations OWNER TO postgres;

--
-- Name: invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invitations_id_seq OWNER TO postgres;

--
-- Name: invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE invitations_id_seq OWNED BY invitations.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE items (
    item_code integer NOT NULL,
    item_name character(35) NOT NULL,
    purchase_unit character(10),
    sale_unit character(10),
    purchase_price numeric(10,2),
    sale_price numeric(10,2)
);


ALTER TABLE items OWNER TO postgres;

--
-- Name: items_double_primary_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE items_double_primary_keys (
    item_code integer NOT NULL,
    item_name character(35) NOT NULL,
    purchase_unit character(10),
    sale_unit character(10),
    purchase_price numeric(10,2),
    sale_price numeric(10,2)
);


ALTER TABLE items_double_primary_keys OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE orders (
    ord_no integer NOT NULL,
    ord_date date,
    item_code integer,
    item_name character(35),
    item_grade character(1),
    ord_qty numeric,
    ord_amount numeric
);


ALTER TABLE orders OWNER TO postgres;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projects (
    id bigint NOT NULL,
    user_id bigint,
    company_id bigint,
    adapter character varying DEFAULT 'postgresql'::character varying NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    import_sql_data jsonb,
    share_key character varying
);


ALTER TABLE projects OWNER TO postgres;

--
-- Name: COLUMN projects.adapter; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN projects.adapter IS 'postgresql,mysql,mssql';


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE relationships (
    id bigint NOT NULL,
    project_id bigint,
    table_id bigint,
    relation_table_id bigint,
    relation_type character varying DEFAULT 'many'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    column_id bigint,
    relation_column_id bigint
);


ALTER TABLE relationships OWNER TO postgres;

--
-- Name: COLUMN relationships.relation_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN relationships.relation_type IS 'many or one';


--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE relationships_id_seq OWNER TO postgres;

--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE relationships_id_seq OWNED BY relationships.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: sql_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sql_files (
    id bigint NOT NULL,
    project_id bigint,
    user_id bigint,
    filename character varying,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE sql_files OWNER TO postgres;

--
-- Name: sql_files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sql_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sql_files_id_seq OWNER TO postgres;

--
-- Name: sql_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sql_files_id_seq OWNED BY sql_files.id;


--
-- Name: tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tables (
    id bigint NOT NULL,
    project_id bigint,
    name character varying,
    comment character varying,
    schema character varying DEFAULT 'public'::character varying,
    table_type character varying DEFAULT 'table'::character varying,
    group_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE tables OWNER TO postgres;

--
-- Name: COLUMN tables.table_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tables.table_type IS 'table or view or mv';


--
-- Name: tables_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables_id_seq OWNER TO postgres;

--
-- Name: tables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tables_id_seq OWNED BY tables.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id bigint NOT NULL,
    company_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    password_digest character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    remember_token character varying
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: columns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY columns ALTER COLUMN id SET DEFAULT nextval('columns_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: invitations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitations ALTER COLUMN id SET DEFAULT nextval('invitations_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: relationships id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationships ALTER COLUMN id SET DEFAULT nextval('relationships_id_seq'::regclass);


--
-- Name: sql_files id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sql_files ALTER COLUMN id SET DEFAULT nextval('sql_files_id_seq'::regclass);


--
-- Name: tables id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tables ALTER COLUMN id SET DEFAULT nextval('tables_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: columns columns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: invitations invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: items_double_primary_keys items_double_primary_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY items_double_primary_keys
    ADD CONSTRAINT items_double_primary_keys_pkey PRIMARY KEY (item_code, item_name);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_code, item_name);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (ord_no);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: relationships relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sql_files sql_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sql_files
    ADD CONSTRAINT sql_files_pkey PRIMARY KEY (id);


--
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_columns_on_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_columns_on_table_id ON columns USING btree (table_id);


--
-- Name: index_groups_on_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_groups_on_project_id ON groups USING btree (project_id);


--
-- Name: index_groups_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_groups_on_user_id ON groups USING btree (user_id);


--
-- Name: index_invitations_on_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitations_on_company_id ON invitations USING btree (company_id);


--
-- Name: index_invitations_on_company_id_and_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_invitations_on_company_id_and_email ON invitations USING btree (company_id, email);


--
-- Name: index_invitations_on_invitee_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitations_on_invitee_id ON invitations USING btree (invitee_id);


--
-- Name: index_invitations_on_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_invitations_on_token ON invitations USING btree (token);


--
-- Name: index_invitations_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitations_on_user_id ON invitations USING btree (user_id);


--
-- Name: index_projects_on_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_projects_on_company_id ON projects USING btree (company_id);


--
-- Name: index_projects_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_projects_on_user_id ON projects USING btree (user_id);


--
-- Name: index_relationships_on_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_relationships_on_project_id ON relationships USING btree (project_id);


--
-- Name: index_relationships_on_relation_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_relationships_on_relation_table_id ON relationships USING btree (relation_table_id);


--
-- Name: index_relationships_on_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_relationships_on_table_id ON relationships USING btree (table_id);


--
-- Name: index_sql_files_on_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_sql_files_on_project_id ON sql_files USING btree (project_id);


--
-- Name: index_sql_files_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_sql_files_on_user_id ON sql_files USING btree (user_id);


--
-- Name: index_tables_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tables_on_group_id ON tables USING btree (group_id);


--
-- Name: index_tables_on_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tables_on_project_id ON tables USING btree (project_id);


--
-- Name: index_users_on_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_company_id ON users USING btree (company_id);


--
-- Name: index_users_on_company_id_and_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_company_id_and_email ON users USING btree (company_id, email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: invitations fk_rails_00204dc74b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT fk_rails_00204dc74b FOREIGN KEY (invitee_id) REFERENCES users(id);


--
-- Name: tables fk_rails_0d7fe586fd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tables
    ADD CONSTRAINT fk_rails_0d7fe586fd FOREIGN KEY (group_id) REFERENCES groups(id);


--
-- Name: groups fk_rails_19a2103fc3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT fk_rails_19a2103fc3 FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: relationships fk_rails_27bfe53301; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_rails_27bfe53301 FOREIGN KEY (relation_table_id) REFERENCES tables(id);


--
-- Name: projects fk_rails_44a549d7b3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT fk_rails_44a549d7b3 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: sql_files fk_rails_461ec927ba; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sql_files
    ADD CONSTRAINT fk_rails_461ec927ba FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: companies fk_rails_5ab5ec3338; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT fk_rails_5ab5ec3338 FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- Name: groups fk_rails_5e78cd340a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT fk_rails_5e78cd340a FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users fk_rails_7682a3bdfe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_rails_7682a3bdfe FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: invitations fk_rails_7eae413fe6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT fk_rails_7eae413fe6 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: relationships fk_rails_7edb3f615c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_rails_7edb3f615c FOREIGN KEY (relation_column_id) REFERENCES columns(id);


--
-- Name: columns fk_rails_8dd6d1aa4d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT fk_rails_8dd6d1aa4d FOREIGN KEY (table_id) REFERENCES tables(id);


--
-- Name: relationships fk_rails_9559da9f6a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_rails_9559da9f6a FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: projects fk_rails_b872a6760a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT fk_rails_b872a6760a FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: relationships fk_rails_d31c58270a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_rails_d31c58270a FOREIGN KEY (column_id) REFERENCES columns(id);


--
-- Name: tables fk_rails_ddc1f84e13; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tables
    ADD CONSTRAINT fk_rails_ddc1f84e13 FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: relationships fk_rails_e060d907e6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_rails_e060d907e6 FOREIGN KEY (table_id) REFERENCES tables(id);


--
-- Name: sql_files fk_rails_e31f8b763f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sql_files
    ADD CONSTRAINT fk_rails_e31f8b763f FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: invitations fk_rails_f16e5a18d7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT fk_rails_f16e5a18d7 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: orders orders_item_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_item_code_fkey FOREIGN KEY (item_code, item_name) REFERENCES items(item_code, item_name);


--
-- PostgreSQL database dump complete
--

