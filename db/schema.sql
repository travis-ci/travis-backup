DROP SCHEMA public CASCADE;
DROP SCHEMA sqitch CASCADE;
CREATE SCHEMA public;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: sqitch; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sqitch;


ALTER SCHEMA sqitch OWNER TO postgres;

--
-- Name: SCHEMA sqitch; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA sqitch IS 'Sqitch database deployment metadata v1.1.';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

--
-- Name: source_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE source_type AS ENUM (
    'manual',
    'stripe',
    'github',
    'unknown'
);


ALTER TYPE public.source_type OWNER TO postgres;

--
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        IF TG_OP = 'INSERT' OR
             (TG_OP = 'UPDATE' AND NEW.* IS DISTINCT FROM OLD.*) THEN
          NEW.updated_at := statement_timestamp();
        END IF;
        RETURN NEW;
      END;
      $$;


ALTER FUNCTION public.set_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: abuses; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE abuses (
    id integer NOT NULL,
    owner_id integer,
    owner_type character varying,
    request_id integer,
    level integer NOT NULL,
    reason character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.abuses OWNER TO postgres;

--
-- Name: abuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE abuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abuses_id_seq OWNER TO postgres;

--
-- Name: abuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE abuses_id_seq OWNED BY abuses.id;


--
-- Name: annotation_providers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE annotation_providers (
    id integer NOT NULL,
    name character varying,
    api_username character varying,
    api_key character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.annotation_providers OWNER TO postgres;

--
-- Name: annotation_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE annotation_providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_providers_id_seq OWNER TO postgres;

--
-- Name: annotation_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE annotation_providers_id_seq OWNED BY annotation_providers.id;


--
-- Name: annotations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE annotations (
    id integer NOT NULL,
    job_id integer NOT NULL,
    url character varying,
    description text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    annotation_provider_id integer NOT NULL,
    status character varying
);


ALTER TABLE public.annotations OWNER TO postgres;

--
-- Name: annotations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE annotations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotations_id_seq OWNER TO postgres;

--
-- Name: annotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE annotations_id_seq OWNED BY annotations.id;


--
-- Name: beta_features; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE beta_features (
    id integer NOT NULL,
    name character varying,
    description text,
    feedback_url character varying,
    staff_only boolean,
    default_enabled boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.beta_features OWNER TO postgres;

--
-- Name: beta_features_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE beta_features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beta_features_id_seq OWNER TO postgres;

--
-- Name: beta_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE beta_features_id_seq OWNED BY beta_features.id;


--
-- Name: branches; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE branches (
    id integer NOT NULL,
    repository_id integer NOT NULL,
    last_build_id integer,
    name character varying NOT NULL,
    exists_on_github boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.branches OWNER TO postgres;

--
-- Name: branches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE branches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branches_id_seq OWNER TO postgres;

--
-- Name: branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE branches_id_seq OWNED BY branches.id;


--
-- Name: broadcasts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE broadcasts (
    id integer NOT NULL,
    recipient_id integer,
    recipient_type character varying,
    kind character varying,
    message character varying,
    expired boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category character varying
);


ALTER TABLE public.broadcasts OWNER TO postgres;

--
-- Name: broadcasts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE broadcasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.broadcasts_id_seq OWNER TO postgres;

--
-- Name: broadcasts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE broadcasts_id_seq OWNED BY broadcasts.id;


--
-- Name: shared_builds_tasks_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE shared_builds_tasks_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shared_builds_tasks_seq OWNER TO postgres;

--
-- Name: builds; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE builds (
    id bigint DEFAULT nextval('shared_builds_tasks_seq'::regclass) NOT NULL,
    repository_id integer,
    number character varying,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    config text,
    commit_id integer,
    request_id integer,
    state character varying,
    duration integer,
    owner_id integer,
    owner_type character varying,
    event_type character varying,
    previous_state character varying,
    pull_request_title text,
    pull_request_number integer,
    branch character varying,
    canceled_at timestamp without time zone,
    cached_matrix_ids integer[],
    received_at timestamp without time zone,
    private boolean,
    pull_request_id integer,
    branch_id integer,
    tag_id integer,
    sender_id integer,
    sender_type character varying
);


ALTER TABLE public.builds OWNER TO postgres;

--
-- Name: builds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE builds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.builds_id_seq OWNER TO postgres;

--
-- Name: builds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE builds_id_seq OWNED BY builds.id;


--
-- Name: commits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE commits (
    id integer NOT NULL,
    repository_id integer,
    commit character varying,
    ref character varying,
    branch character varying,
    message text,
    compare_url character varying,
    committed_at timestamp without time zone,
    committer_name character varying,
    committer_email character varying,
    author_name character varying,
    author_email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    branch_id integer,
    tag_id integer
);


ALTER TABLE public.commits OWNER TO postgres;

--
-- Name: commits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE commits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commits_id_seq OWNER TO postgres;

--
-- Name: commits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE commits_id_seq OWNED BY commits.id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coupons (
    id integer NOT NULL,
    percent_off integer,
    coupon_id character varying,
    redeem_by timestamp without time zone,
    amount_off integer,
    duration character varying,
    duration_in_months integer,
    max_redemptions integer,
    redemptions integer
);


ALTER TABLE public.coupons OWNER TO postgres;

--
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coupons_id_seq OWNER TO postgres;

--
-- Name: coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE coupons_id_seq OWNED BY coupons.id;


--
-- Name: crons; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE crons (
    id integer NOT NULL,
    branch_id integer,
    "interval" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    next_run timestamp without time zone,
    last_run timestamp without time zone,
    dont_run_if_recent_build_exists boolean DEFAULT false
);


ALTER TABLE public.crons OWNER TO postgres;

--
-- Name: crons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE crons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.crons_id_seq OWNER TO postgres;

--
-- Name: crons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE crons_id_seq OWNED BY crons.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE emails (
    id integer NOT NULL,
    user_id integer,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.emails OWNER TO postgres;

--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emails_id_seq OWNER TO postgres;

--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE emails_id_seq OWNED BY emails.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE invoices (
    id integer NOT NULL,
    object text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    subscription_id integer,
    invoice_id character varying,
    stripe_id character varying,
    cc_last_digits character varying
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoices_id_seq OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE invoices_id_seq OWNED BY invoices.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jobs (
    id bigint DEFAULT nextval('shared_builds_tasks_seq'::regclass) NOT NULL,
    repository_id integer,
    commit_id integer,
    source_id integer,
    source_type character varying,
    queue character varying,
    type character varying,
    state character varying,
    number character varying,
    config text,
    worker character varying,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tags text,
    allow_failure boolean DEFAULT false,
    owner_id integer,
    owner_type character varying,
    result integer,
    queued_at timestamp without time zone,
    canceled_at timestamp without time zone,
    received_at timestamp without time zone,
    debug_options text,
    private boolean,
    stage_number character varying,
    stage_id integer
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- Name: log_parts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_parts (
    id bigint NOT NULL,
    log_id integer NOT NULL,
    content text,
    number integer,
    final boolean,
    created_at timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL
)
WITH (autovacuum_vacuum_threshold='0', autovacuum_vacuum_scale_factor='0.001');


ALTER TABLE public.log_parts OWNER TO postgres;

--
-- Name: log_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_parts_id_seq OWNER TO postgres;

--
-- Name: log_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_parts_id_seq OWNED BY log_parts.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE logs (
    id integer NOT NULL,
    job_id integer,
    content text,
    removed_by integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    aggregated_at timestamp without time zone,
    archived_at timestamp without time zone,
    purged_at timestamp without time zone,
    removed_at timestamp without time zone,
    archiving boolean,
    archive_verified boolean
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_id_seq OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE logs_id_seq OWNED BY logs.id;


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE memberships (
    id integer NOT NULL,
    organization_id integer,
    user_id integer,
    role character varying
);


ALTER TABLE public.memberships OWNER TO postgres;

--
-- Name: memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.memberships_id_seq OWNER TO postgres;

--
-- Name: memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE memberships_id_seq OWNED BY memberships.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    subject_id integer,
    subject_type character varying,
    level character varying,
    key character varying,
    code character varying,
    args json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying,
    login character varying,
    github_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    avatar_url character varying,
    location character varying,
    email character varying,
    company character varying,
    homepage character varying,
    billing_admin_only boolean
);


ALTER TABLE public.organizations OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: owner_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE owner_groups (
    id integer NOT NULL,
    uuid character varying,
    owner_id integer,
    owner_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.owner_groups OWNER TO postgres;

--
-- Name: owner_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE owner_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.owner_groups_id_seq OWNER TO postgres;

--
-- Name: owner_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE owner_groups_id_seq OWNED BY owner_groups.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permissions (
    id integer NOT NULL,
    user_id integer,
    repository_id integer,
    admin boolean DEFAULT false,
    push boolean DEFAULT false,
    pull boolean DEFAULT false
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- Name: pull_requests; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pull_requests (
    id integer NOT NULL,
    repository_id integer,
    number integer,
    title character varying,
    state character varying,
    head_repo_github_id integer,
    head_repo_slug character varying,
    head_ref character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.pull_requests OWNER TO postgres;

--
-- Name: pull_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pull_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pull_requests_id_seq OWNER TO postgres;

--
-- Name: pull_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pull_requests_id_seq OWNED BY pull_requests.id;


--
-- Name: queueable_jobs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE queueable_jobs (
    id integer NOT NULL,
    job_id integer
);


ALTER TABLE public.queueable_jobs OWNER TO postgres;

--
-- Name: queueable_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE queueable_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queueable_jobs_id_seq OWNER TO postgres;

--
-- Name: queueable_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE queueable_jobs_id_seq OWNED BY queueable_jobs.id;


--
-- Name: repositories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE repositories (
    id integer NOT NULL,
    name character varying,
    url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    last_build_id integer,
    last_build_number character varying,
    last_build_started_at timestamp without time zone,
    last_build_finished_at timestamp without time zone,
    owner_name character varying,
    owner_email text,
    active boolean,
    description text,
    last_build_duration integer,
    owner_id integer,
    owner_type character varying,
    private boolean DEFAULT false,
    last_build_state character varying,
    github_id integer,
    default_branch character varying,
    github_language character varying,
    settings json,
    next_build_number integer,
    invalidated_at timestamp without time zone,
    current_build_id bigint
);


ALTER TABLE public.repositories OWNER TO postgres;

--
-- Name: repositories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.repositories_id_seq OWNER TO postgres;

--
-- Name: repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE repositories_id_seq OWNED BY repositories.id;


--
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE requests (
    id integer NOT NULL,
    repository_id integer,
    commit_id integer,
    state character varying,
    source character varying,
    payload text,
    token character varying,
    config text,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    event_type character varying,
    comments_url character varying,
    base_commit character varying,
    head_commit character varying,
    owner_id integer,
    owner_type character varying,
    result character varying,
    message character varying,
    private boolean,
    pull_request_id integer,
    branch_id integer,
    tag_id integer,
    sender_id integer,
    sender_type character varying
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requests_id_seq OWNER TO postgres;

--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE requests_id_seq OWNED BY requests.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: ssl_keys; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ssl_keys (
    id integer NOT NULL,
    repository_id integer,
    public_key text,
    private_key text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ssl_keys OWNER TO postgres;

--
-- Name: ssl_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ssl_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ssl_keys_id_seq OWNER TO postgres;

--
-- Name: ssl_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ssl_keys_id_seq OWNED BY ssl_keys.id;


--
-- Name: stages; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stages (
    id integer NOT NULL,
    build_id integer,
    number integer,
    name character varying,
    state character varying,
    started_at timestamp without time zone,
    finished_at timestamp without time zone
);


ALTER TABLE public.stages OWNER TO postgres;

--
-- Name: stages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stages_id_seq OWNER TO postgres;

--
-- Name: stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE stages_id_seq OWNED BY stages.id;


--
-- Name: stars; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stars (
    id integer NOT NULL,
    repository_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.stars OWNER TO postgres;

--
-- Name: stars_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stars_id_seq OWNER TO postgres;

--
-- Name: stars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE stars_id_seq OWNED BY stars.id;


--
-- Name: stripe_events; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stripe_events (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    event_object text,
    event_type character varying,
    date timestamp without time zone,
    event_id character varying
);


ALTER TABLE public.stripe_events OWNER TO postgres;

--
-- Name: stripe_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stripe_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stripe_events_id_seq OWNER TO postgres;

--
-- Name: stripe_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE stripe_events_id_seq OWNED BY stripe_events.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE subscriptions (
    id integer NOT NULL,
    cc_token character varying,
    valid_to timestamp without time zone,
    owner_id integer,
    owner_type character varying,
    first_name character varying,
    last_name character varying,
    company character varying,
    zip_code character varying,
    address character varying,
    address2 character varying,
    city character varying,
    state character varying,
    country character varying,
    vat_id character varying,
    customer_id character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    cc_owner character varying,
    cc_last_digits character varying,
    cc_expiration_date character varying,
    billing_email character varying,
    selected_plan character varying,
    coupon character varying,
    contact_id integer,
    canceled_at timestamp without time zone,
    canceled_by_id integer,
    status character varying,
    source source_type DEFAULT 'unknown'::source_type NOT NULL,
    concurrency integer
);


ALTER TABLE public.subscriptions OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_id_seq OWNER TO postgres;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE subscriptions_id_seq OWNED BY subscriptions.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    repository_id integer,
    name character varying,
    last_build_id integer,
    exists_on_github boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tokens (
    id integer NOT NULL,
    user_id integer,
    token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.tokens OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tokens_id_seq OWNED BY tokens.id;


--
-- Name: trial_allowances; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE trial_allowances (
    id integer NOT NULL,
    trial_id integer,
    creator_id integer,
    creator_type character varying,
    builds_allowed integer,
    builds_remaining integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.trial_allowances OWNER TO postgres;

--
-- Name: trial_allowances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE trial_allowances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trial_allowances_id_seq OWNER TO postgres;

--
-- Name: trial_allowances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE trial_allowances_id_seq OWNED BY trial_allowances.id;


--
-- Name: trials; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE trials (
    id integer NOT NULL,
    owner_id integer,
    owner_type character varying,
    chartmogul_customer_uuids text[] DEFAULT '{}'::text[],
    status character varying DEFAULT 'new'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.trials OWNER TO postgres;

--
-- Name: trials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE trials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trials_id_seq OWNER TO postgres;

--
-- Name: trials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE trials_id_seq OWNED BY trials.id;


--
-- Name: urls; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE urls (
    id integer NOT NULL,
    url character varying,
    code character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.urls OWNER TO postgres;

--
-- Name: urls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urls_id_seq OWNER TO postgres;

--
-- Name: urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE urls_id_seq OWNED BY urls.id;


--
-- Name: user_beta_features; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_beta_features (
    id integer NOT NULL,
    user_id integer,
    beta_feature_id integer,
    enabled boolean,
    last_deactivated_at timestamp without time zone,
    last_activated_at timestamp without time zone
);


ALTER TABLE public.user_beta_features OWNER TO postgres;

--
-- Name: user_beta_features_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_beta_features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_beta_features_id_seq OWNER TO postgres;

--
-- Name: user_beta_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_beta_features_id_seq OWNED BY user_beta_features.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying,
    login character varying,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_admin boolean DEFAULT false,
    github_id integer,
    github_oauth_token character varying,
    gravatar_id character varying,
    locale character varying,
    is_syncing boolean,
    synced_at timestamp without time zone,
    github_scopes text,
    education boolean,
    first_logged_in_at timestamp without time zone,
    avatar_url character varying,
    suspended boolean DEFAULT false,
    suspended_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


SET search_path = sqitch, pg_catalog;

--
-- Name: changes; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE changes (
    change_id text NOT NULL,
    script_hash text,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.changes OWNER TO postgres;

--
-- Name: TABLE changes; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE changes IS 'Tracks the changes currently deployed to the database.';


--
-- Name: COLUMN changes.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.change_id IS 'Change primary key.';


--
-- Name: COLUMN changes.script_hash; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.script_hash IS 'Deploy script SHA-1 hash.';


--
-- Name: COLUMN changes.change; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.change IS 'Name of a deployed change.';


--
-- Name: COLUMN changes.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN changes.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.note IS 'Description of the change.';


--
-- Name: COLUMN changes.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committed_at IS 'Date the change was deployed.';


--
-- Name: COLUMN changes.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committer_name IS 'Name of the user who deployed the change.';


--
-- Name: COLUMN changes.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committer_email IS 'Email address of the user who deployed the change.';


--
-- Name: COLUMN changes.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planned_at IS 'Date the change was added to the plan.';


--
-- Name: COLUMN changes.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN changes.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planner_email IS 'Email address of the user who planned the change.';


--
-- Name: dependencies; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE dependencies (
    change_id text NOT NULL,
    type text NOT NULL,
    dependency text NOT NULL,
    dependency_id text,
    CONSTRAINT dependencies_check CHECK ((((type = 'require'::text) AND (dependency_id IS NOT NULL)) OR ((type = 'conflict'::text) AND (dependency_id IS NULL))))
);


ALTER TABLE sqitch.dependencies OWNER TO postgres;

--
-- Name: TABLE dependencies; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE dependencies IS 'Tracks the currently satisfied dependencies.';


--
-- Name: COLUMN dependencies.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.change_id IS 'ID of the depending change.';


--
-- Name: COLUMN dependencies.type; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.type IS 'Type of dependency.';


--
-- Name: COLUMN dependencies.dependency; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.dependency IS 'Dependency name.';


--
-- Name: COLUMN dependencies.dependency_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.dependency_id IS 'Change ID the dependency resolves to.';


--
-- Name: events; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE events (
    event text NOT NULL,
    change_id text NOT NULL,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    requires text[] DEFAULT '{}'::text[] NOT NULL,
    conflicts text[] DEFAULT '{}'::text[] NOT NULL,
    tags text[] DEFAULT '{}'::text[] NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL,
    CONSTRAINT events_event_check CHECK ((event = ANY (ARRAY['deploy'::text, 'revert'::text, 'fail'::text, 'merge'::text])))
);


ALTER TABLE sqitch.events OWNER TO postgres;

--
-- Name: TABLE events; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE events IS 'Contains full history of all deployment events.';


--
-- Name: COLUMN events.event; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.event IS 'Type of event.';


--
-- Name: COLUMN events.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.change_id IS 'Change ID.';


--
-- Name: COLUMN events.change; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.change IS 'Change name.';


--
-- Name: COLUMN events.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN events.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.note IS 'Description of the change.';


--
-- Name: COLUMN events.requires; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.requires IS 'Array of the names of required changes.';


--
-- Name: COLUMN events.conflicts; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.conflicts IS 'Array of the names of conflicting changes.';


--
-- Name: COLUMN events.tags; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.tags IS 'Tags associated with the change.';


--
-- Name: COLUMN events.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committed_at IS 'Date the event was committed.';


--
-- Name: COLUMN events.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committer_name IS 'Name of the user who committed the event.';


--
-- Name: COLUMN events.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committer_email IS 'Email address of the user who committed the event.';


--
-- Name: COLUMN events.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planned_at IS 'Date the event was added to the plan.';


--
-- Name: COLUMN events.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN events.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planner_email IS 'Email address of the user who plan planned the change.';


--
-- Name: projects; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE projects (
    project text NOT NULL,
    uri text,
    created_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    creator_name text NOT NULL,
    creator_email text NOT NULL
);


ALTER TABLE sqitch.projects OWNER TO postgres;

--
-- Name: TABLE projects; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE projects IS 'Sqitch projects deployed to this database.';


--
-- Name: COLUMN projects.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.project IS 'Unique Name of a project.';


--
-- Name: COLUMN projects.uri; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.uri IS 'Optional project URI';


--
-- Name: COLUMN projects.created_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.created_at IS 'Date the project was added to the database.';


--
-- Name: COLUMN projects.creator_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.creator_name IS 'Name of the user who added the project.';


--
-- Name: COLUMN projects.creator_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.creator_email IS 'Email address of the user who added the project.';


--
-- Name: releases; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE releases (
    version real NOT NULL,
    installed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    installer_name text NOT NULL,
    installer_email text NOT NULL
);


ALTER TABLE sqitch.releases OWNER TO postgres;

--
-- Name: TABLE releases; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE releases IS 'Sqitch registry releases.';


--
-- Name: COLUMN releases.version; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.version IS 'Version of the Sqitch registry.';


--
-- Name: COLUMN releases.installed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.installed_at IS 'Date the registry release was installed.';


--
-- Name: COLUMN releases.installer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.installer_name IS 'Name of the user who installed the registry release.';


--
-- Name: COLUMN releases.installer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN releases.installer_email IS 'Email address of the user who installed the registry release.';


--
-- Name: tags; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE tags (
    tag_id text NOT NULL,
    tag text NOT NULL,
    project text NOT NULL,
    change_id text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.tags OWNER TO postgres;

--
-- Name: TABLE tags; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE tags IS 'Tracks the tags currently applied to the database.';


--
-- Name: COLUMN tags.tag_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.tag_id IS 'Tag primary key.';


--
-- Name: COLUMN tags.tag; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.tag IS 'Project-unique tag name.';


--
-- Name: COLUMN tags.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.project IS 'Name of the Sqitch project to which the tag belongs.';


--
-- Name: COLUMN tags.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.change_id IS 'ID of last change deployed before the tag was applied.';


--
-- Name: COLUMN tags.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.note IS 'Description of the tag.';


--
-- Name: COLUMN tags.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committed_at IS 'Date the tag was applied to the database.';


--
-- Name: COLUMN tags.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committer_name IS 'Name of the user who applied the tag.';


--
-- Name: COLUMN tags.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committer_email IS 'Email address of the user who applied the tag.';


--
-- Name: COLUMN tags.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planned_at IS 'Date the tag was added to the plan.';


--
-- Name: COLUMN tags.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planner_name IS 'Name of the user who planed the tag.';


--
-- Name: COLUMN tags.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planner_email IS 'Email address of the user who planned the tag.';


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abuses ALTER COLUMN id SET DEFAULT nextval('abuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY annotation_providers ALTER COLUMN id SET DEFAULT nextval('annotation_providers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY annotations ALTER COLUMN id SET DEFAULT nextval('annotations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY beta_features ALTER COLUMN id SET DEFAULT nextval('beta_features_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY branches ALTER COLUMN id SET DEFAULT nextval('branches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY broadcasts ALTER COLUMN id SET DEFAULT nextval('broadcasts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commits ALTER COLUMN id SET DEFAULT nextval('commits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coupons ALTER COLUMN id SET DEFAULT nextval('coupons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crons ALTER COLUMN id SET DEFAULT nextval('crons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emails ALTER COLUMN id SET DEFAULT nextval('emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invoices ALTER COLUMN id SET DEFAULT nextval('invoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_parts ALTER COLUMN id SET DEFAULT nextval('log_parts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs ALTER COLUMN id SET DEFAULT nextval('logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY memberships ALTER COLUMN id SET DEFAULT nextval('memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY owner_groups ALTER COLUMN id SET DEFAULT nextval('owner_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests ALTER COLUMN id SET DEFAULT nextval('pull_requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY queueable_jobs ALTER COLUMN id SET DEFAULT nextval('queueable_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories ALTER COLUMN id SET DEFAULT nextval('repositories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ssl_keys ALTER COLUMN id SET DEFAULT nextval('ssl_keys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stages ALTER COLUMN id SET DEFAULT nextval('stages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars ALTER COLUMN id SET DEFAULT nextval('stars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stripe_events ALTER COLUMN id SET DEFAULT nextval('stripe_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subscriptions ALTER COLUMN id SET DEFAULT nextval('subscriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tokens ALTER COLUMN id SET DEFAULT nextval('tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY trial_allowances ALTER COLUMN id SET DEFAULT nextval('trial_allowances_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY trials ALTER COLUMN id SET DEFAULT nextval('trials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY urls ALTER COLUMN id SET DEFAULT nextval('urls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_beta_features ALTER COLUMN id SET DEFAULT nextval('user_beta_features_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);

--
-- Name: abuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('abuses_id_seq', 1, false);

--
-- Name: annotation_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('annotation_providers_id_seq', 1, false);

--
-- Name: annotations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('annotations_id_seq', 1, false);

--
-- Name: beta_features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('beta_features_id_seq', 1, false);

--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('branches_id_seq', 72, true);

--
-- Name: broadcasts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('broadcasts_id_seq', 1, false);

--
-- Name: builds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('builds_id_seq', 1, false);

--
-- Name: commits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('commits_id_seq', 210, true);

--
-- Name: coupons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('coupons_id_seq', 1, false);

--
-- Name: crons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('crons_id_seq', 1, false);

--
-- Name: emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('emails_id_seq', 8, true);

--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('invoices_id_seq', 1, false);

--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('jobs_id_seq', 1, true);

--
-- Name: log_parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('log_parts_id_seq', 7609, true);

--
-- Name: ssl_keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ssl_keys_id_seq', 30, true);


--
-- Name: stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stages_id_seq', 19, true);

--
-- Name: stars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stars_id_seq', 1, false);

--
-- Name: stripe_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stripe_events_id_seq', 1, false);

--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('subscriptions_id_seq', 1, false);

--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 1, false);

--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tokens_id_seq', 8, true);

--
-- Name: trial_allowances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('trial_allowances_id_seq', 1, false);

--
-- Name: trials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('trials_id_seq', 1, false);

--
-- Name: urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('urls_id_seq', 1, false);

--
-- Name: user_beta_features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_beta_features_id_seq', 1, false);

--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 8, true);


SET search_path = sqitch, pg_catalog;


SET search_path = public, pg_catalog;

--
-- Name: abuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abuses
    ADD CONSTRAINT abuses_pkey PRIMARY KEY (id);


--
-- Name: annotation_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY annotation_providers
    ADD CONSTRAINT annotation_providers_pkey PRIMARY KEY (id);


--
-- Name: annotations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY annotations
    ADD CONSTRAINT annotations_pkey PRIMARY KEY (id);


--
-- Name: beta_features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY beta_features
    ADD CONSTRAINT beta_features_pkey PRIMARY KEY (id);


--
-- Name: branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: broadcasts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY broadcasts
    ADD CONSTRAINT broadcasts_pkey PRIMARY KEY (id);


--
-- Name: builds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY builds
    ADD CONSTRAINT builds_pkey PRIMARY KEY (id);


--
-- Name: commits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_pkey PRIMARY KEY (id);


--
-- Name: coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- Name: crons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crons
    ADD CONSTRAINT crons_pkey PRIMARY KEY (id);


--
-- Name: emails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: log_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY log_parts
    ADD CONSTRAINT log_parts_pkey PRIMARY KEY (id);


--
-- Name: logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: owner_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY owner_groups
    ADD CONSTRAINT owner_groups_pkey PRIMARY KEY (id);


--
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: pull_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_pkey PRIMARY KEY (id);


--
-- Name: queueable_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY queueable_jobs
    ADD CONSTRAINT queueable_jobs_pkey PRIMARY KEY (id);


--
-- Name: repositories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT repositories_pkey PRIMARY KEY (id);


--
-- Name: requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: ssl_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ssl_keys
    ADD CONSTRAINT ssl_keys_pkey PRIMARY KEY (id);


--
-- Name: stages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stages
    ADD CONSTRAINT stages_pkey PRIMARY KEY (id);


--
-- Name: stars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);


--
-- Name: stripe_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stripe_events
    ADD CONSTRAINT stripe_events_pkey PRIMARY KEY (id);


--
-- Name: subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: trial_allowances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY trial_allowances
    ADD CONSTRAINT trial_allowances_pkey PRIMARY KEY (id);


--
-- Name: trials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY trials
    ADD CONSTRAINT trials_pkey PRIMARY KEY (id);


--
-- Name: urls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (id);


--
-- Name: user_beta_features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_beta_features
    ADD CONSTRAINT user_beta_features_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET search_path = sqitch, pg_catalog;

--
-- Name: changes_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_pkey PRIMARY KEY (change_id);


--
-- Name: changes_project_script_hash_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_project_script_hash_key UNIQUE (project, script_hash);


--
-- Name: dependencies_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_pkey PRIMARY KEY (change_id, dependency);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (change_id, committed_at);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project);


--
-- Name: projects_uri_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_uri_key UNIQUE (uri);


--
-- Name: releases_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_pkey PRIMARY KEY (version);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: tags_project_tag_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_tag_key UNIQUE (project, tag);


SET search_path = public, pg_catalog;

--
-- Name: index_abuses_on_owner; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_abuses_on_owner ON abuses USING btree (owner_id);


--
-- Name: index_abuses_on_owner_id_and_owner_type_and_level; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_abuses_on_owner_id_and_owner_type_and_level ON abuses USING btree (owner_id, owner_type, level);


--
-- Name: index_annotations_on_job_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_annotations_on_job_id ON annotations USING btree (job_id);


--
-- Name: index_branches_on_repository_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_branches_on_repository_id ON branches USING btree (repository_id);


--
-- Name: index_branches_on_repository_id_and_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_branches_on_repository_id_and_name ON branches USING btree (repository_id, name);


--
-- Name: index_broadcasts_on_recipient_id_and_recipient_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_broadcasts_on_recipient_id_and_recipient_type ON broadcasts USING btree (recipient_id, recipient_type);


--
-- Name: index_builds_on_repository_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_repository_id ON builds USING btree (repository_id);


--
-- Name: index_builds_on_repository_id_and_branch_and_event_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_repository_id_and_branch_and_event_type ON builds USING btree (repository_id, branch, event_type) WHERE ((state)::text = ANY ((ARRAY['created'::character varying, 'queued'::character varying, 'received'::character varying])::text[]));


--
-- Name: index_builds_on_repository_id_and_branch_and_event_type_and_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_repository_id_and_branch_and_event_type_and_id ON builds USING btree (repository_id, branch, event_type, id);


--
-- Name: index_builds_on_repository_id_and_branch_and_id_desc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_repository_id_and_branch_and_id_desc ON builds USING btree (repository_id, branch, id DESC);


--
-- Name: index_builds_on_repository_id_and_number; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_repository_id_and_number ON builds USING btree (repository_id, ((number)::integer));


--
-- Name: index_builds_on_repository_id_and_number_and_event_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_repository_id_and_number_and_event_type ON builds USING btree (repository_id, number, event_type);


--
-- Name: index_builds_on_request_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_request_id ON builds USING btree (request_id);


--
-- Name: index_builds_on_sender_type_and_sender_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_sender_type_and_sender_id ON builds USING btree (sender_type, sender_id);


--
-- Name: index_builds_on_state; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_builds_on_state ON builds USING btree (state);


--
-- Name: index_emails_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_emails_on_email ON emails USING btree (email);


--
-- Name: index_emails_on_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_emails_on_user_id ON emails USING btree (user_id);


--
-- Name: index_invoices_on_stripe_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_invoices_on_stripe_id ON invoices USING btree (stripe_id);


--
-- Name: index_jobs_on_created_at; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_jobs_on_created_at ON jobs USING btree (created_at);


--
-- Name: index_jobs_on_owner_id_and_owner_type_and_state; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_jobs_on_owner_id_and_owner_type_and_state ON jobs USING btree (owner_id, owner_type, state);


--
-- Name: index_jobs_on_source_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_jobs_on_source_id ON jobs USING btree (source_id);


--
-- Name: index_jobs_on_stage_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_jobs_on_stage_id ON jobs USING btree (stage_id);


--
-- Name: index_jobs_on_state; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_jobs_on_state ON jobs USING btree (state);


--
-- Name: index_jobs_on_type_and_source_id_and_source_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_jobs_on_type_and_source_id_and_source_type ON jobs USING btree (type, source_id, source_type);


--
-- Name: index_jobs_on_updated_at; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_jobs_on_updated_at ON jobs USING btree (updated_at);


--
-- Name: index_log_parts_on_created_at; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_log_parts_on_created_at ON log_parts USING btree (created_at);


--
-- Name: index_log_parts_on_log_id_and_number; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_log_parts_on_log_id_and_number ON log_parts USING btree (log_id, number);


--
-- Name: index_logs_on_archive_verified; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_logs_on_archive_verified ON logs USING btree (archive_verified);


--
-- Name: index_logs_on_archived_at; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_logs_on_archived_at ON logs USING btree (archived_at);


--
-- Name: index_logs_on_job_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_logs_on_job_id ON logs USING btree (job_id);


--
-- Name: index_memberships_on_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_memberships_on_user_id ON memberships USING btree (user_id);


--
-- Name: index_messages_on_subject_type_and_subject_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_messages_on_subject_type_and_subject_id ON messages USING btree (subject_type, subject_id);


--
-- Name: index_organizations_on_github_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_organizations_on_github_id ON organizations USING btree (github_id);


--
-- Name: index_organizations_on_login; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_organizations_on_login ON organizations USING btree (login);


--
-- Name: index_organizations_on_lower_login; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_organizations_on_lower_login ON organizations USING btree (lower((login)::text));


--
-- Name: index_owner_groups_on_owner_type_and_owner_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_owner_groups_on_owner_type_and_owner_id ON owner_groups USING btree (owner_type, owner_id);


--
-- Name: index_owner_groups_on_uuid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_owner_groups_on_uuid ON owner_groups USING btree (uuid);


--
-- Name: index_permissions_on_repository_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_permissions_on_repository_id ON permissions USING btree (repository_id);


--
-- Name: index_permissions_on_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_permissions_on_user_id ON permissions USING btree (user_id);


--
-- Name: index_permissions_on_user_id_and_repository_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_permissions_on_user_id_and_repository_id ON permissions USING btree (user_id, repository_id);


--
-- Name: index_pull_requests_on_repository_id_and_number; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_pull_requests_on_repository_id_and_number ON pull_requests USING btree (repository_id, number);


--
-- Name: index_queueable_jobs_on_job_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_queueable_jobs_on_job_id ON queueable_jobs USING btree (job_id);


--
-- Name: index_repositories_on_active; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_repositories_on_active ON repositories USING btree (active);


--
-- Name: index_repositories_on_github_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_repositories_on_github_id ON repositories USING btree (github_id);


--
-- Name: index_repositories_on_lower_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_repositories_on_lower_name ON repositories USING btree (lower((name)::text));


--
-- Name: index_repositories_on_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_repositories_on_name ON repositories USING btree (name);


--
-- Name: index_repositories_on_owner_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_repositories_on_owner_id ON repositories USING btree (owner_id);


--
-- Name: index_repositories_on_owner_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_repositories_on_owner_name ON repositories USING btree (owner_name);


--
-- Name: index_repositories_on_slug; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_repositories_on_slug ON repositories USING gin (((((owner_name)::text || '/'::text) || (name)::text)) gin_trgm_ops);


--
-- Name: index_requests_on_commit_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_requests_on_commit_id ON requests USING btree (commit_id);


--
-- Name: index_requests_on_created_at; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_requests_on_created_at ON requests USING btree (created_at);


--
-- Name: index_requests_on_head_commit; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_requests_on_head_commit ON requests USING btree (head_commit);


--
-- Name: index_requests_on_repository_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_requests_on_repository_id ON requests USING btree (repository_id);


--
-- Name: index_requests_on_repository_id_and_id_desc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_requests_on_repository_id_and_id_desc ON requests USING btree (repository_id, id DESC);


--
-- Name: index_ssl_key_on_repository_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_ssl_key_on_repository_id ON ssl_keys USING btree (repository_id);


--
-- Name: index_stages_on_build_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_stages_on_build_id ON stages USING btree (build_id);


--
-- Name: index_stars_on_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_stars_on_user_id ON stars USING btree (user_id);


--
-- Name: index_stars_on_user_id_and_repository_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_stars_on_user_id_and_repository_id ON stars USING btree (user_id, repository_id);


--
-- Name: index_stripe_events_on_date; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_stripe_events_on_date ON stripe_events USING btree (date);


--
-- Name: index_stripe_events_on_event_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_stripe_events_on_event_id ON stripe_events USING btree (event_id);


--
-- Name: index_stripe_events_on_event_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_stripe_events_on_event_type ON stripe_events USING btree (event_type);


--
-- Name: index_tags_on_repository_id_and_name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_tags_on_repository_id_and_name ON tags USING btree (repository_id, name);


--
-- Name: index_tokens_on_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_tokens_on_token ON tokens USING btree (token);


--
-- Name: index_tokens_on_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_tokens_on_user_id ON tokens USING btree (user_id);


--
-- Name: index_trial_allowances_on_creator_id_and_creator_type; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_trial_allowances_on_creator_id_and_creator_type ON trial_allowances USING btree (creator_id, creator_type);


--
-- Name: index_trial_allowances_on_trial_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_trial_allowances_on_trial_id ON trial_allowances USING btree (trial_id);


--
-- Name: index_trials_on_owner; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_trials_on_owner ON trials USING btree (owner_id, owner_type);


--
-- Name: index_user_beta_features_on_user_id_and_beta_feature_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_user_beta_features_on_user_id_and_beta_feature_id ON user_beta_features USING btree (user_id, beta_feature_id);


--
-- Name: index_users_on_github_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_github_id ON users USING btree (github_id);


--
-- Name: index_users_on_github_oauth_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_github_oauth_token ON users USING btree (github_oauth_token);


--
-- Name: index_users_on_login; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_users_on_login ON users USING btree (login);


--
-- Name: index_users_on_lower_login; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_users_on_lower_login ON users USING btree (lower((login)::text));


--
-- Name: subscriptions_owner; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX subscriptions_owner ON subscriptions USING btree (owner_id, owner_type) WHERE ((status)::text = 'subscribed'::text);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: set_updated_at_on_builds; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_updated_at_on_builds BEFORE INSERT OR UPDATE ON builds FOR EACH ROW EXECUTE PROCEDURE set_updated_at();


--
-- Name: set_updated_at_on_jobs; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_updated_at_on_jobs BEFORE INSERT OR UPDATE ON jobs FOR EACH ROW EXECUTE PROCEDURE set_updated_at();


--
-- Name: fk_repositories_current_build_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT fk_repositories_current_build_id FOREIGN KEY (current_build_id) REFERENCES builds(id);


SET search_path = sqitch, pg_catalog;

--
-- Name: changes_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: dependencies_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dependencies_dependency_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_dependency_id_fkey FOREIGN KEY (dependency_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- Name: events_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: tags_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- Name: tags_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

