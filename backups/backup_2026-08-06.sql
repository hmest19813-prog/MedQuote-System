--
-- PostgreSQL database dump
--

\restrict PggnPUKaZIqTEhgtdValLLhpTnMFhV3OvPba4cDERZtSrUyJ2MLpG0PnaYe25U7

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.10 (Ubuntu 17.10-1.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_realtime_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in',
    'like',
    'ilike',
    'is',
    'match',
    'imatch',
    'isdistinct'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_realtime_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text,
	negate boolean
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_realtime_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_realtime_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_realtime_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
begin
    if not exists (
        select 1
        from pg_event_trigger_ddl_commands() ev
        join pg_catalog.pg_extension e on ev.objid = e.oid
        where e.extname = 'pg_graphql'
    ) then
        return;
    end if;

    drop function if exists graphql_public.graphql;
    create or replace function graphql_public.graphql(
        "operationName" text default null,
        query text default null,
        variables jsonb default null,
        extensions jsonb default null
    )
        returns jsonb
        language sql
    as $$
        select graphql.resolve(
            query := query,
            variables := coalesce(variables, '{}'),
            "operationName" := "operationName",
            extensions := extensions
        );
    $$;

    -- Attach the wrapper to the extension so DROP EXTENSION cascades to it,
    -- which in turn triggers set_graphql_placeholder to reinstall the "not enabled" stub.
    alter extension pg_graphql add function graphql_public.graphql(text, text, jsonb, jsonb);

    grant usage on schema graphql to postgres, anon, authenticated, service_role;
    grant execute on function graphql.resolve to postgres, anon, authenticated, service_role;
    grant usage on schema graphql to postgres with grant option;
    grant usage on schema graphql_public to postgres with grant option;
end;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: supabase_admin
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;


ALTER FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) OWNER TO supabase_admin;

--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: confirm_draft_quotation(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.confirm_draft_quotation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF OLD.status = 'draft' AND NEW.status != 'draft' THEN
    NEW.number := public.generate_quotation_number();
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.confirm_draft_quotation() OWNER TO postgres;

--
-- Name: create_user_with_profile(text, text, text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text DEFAULT 'user'::text, p_is_active boolean DEFAULT true) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  new_user_id UUID;
BEGIN
  INSERT INTO auth.users (
    instance_id, id, aud, role, email, encrypted_password,
    email_confirmed_at, created_at, updated_at,
    raw_app_meta_data, raw_user_meta_data, confirmation_token
  ) VALUES (
    '00000000-0000-0000-0000-000000000000',
    gen_random_uuid(), 'authenticated', 'authenticated',
    p_email,
    crypt(p_password, gen_salt('bf')),
    NOW(), NOW(), NOW(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    jsonb_build_object('full_name', p_full_name),
    ''
  ) RETURNING id INTO new_user_id;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (new_user_id, new_user_id, jsonb_build_object('sub', new_user_id::text, 'email', p_email), 'email', new_user_id::text, NOW(), NOW(), NOW());

  INSERT INTO public.profiles (id, email, full_name, role, is_active)
  VALUES (new_user_id, p_email, p_full_name, p_role, p_is_active)
  ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name, role = EXCLUDED.role, is_active = EXCLUDED.is_active;

  RETURN new_user_id;
END;
$$;


ALTER FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean) OWNER TO postgres;

--
-- Name: create_user_with_profile(text, text, text, text, boolean, text, jsonb); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text DEFAULT 'employee'::text, p_is_active boolean DEFAULT true, p_username text DEFAULT NULL::text, p_permissions jsonb DEFAULT '{}'::jsonb) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public', 'auth'
    AS $$
DECLARE
  v_user_id UUID;
  v_username TEXT;
BEGIN
  SELECT id INTO v_user_id
  FROM auth.users
  WHERE email = LOWER(TRIM(p_email))
  LIMIT 1;

  IF v_user_id IS NULL THEN
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password,
      email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
      created_at, updated_at, confirmation_token, recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000',
      gen_random_uuid(),
      'authenticated', 'authenticated',
      LOWER(TRIM(p_email)),
      crypt(p_password, gen_salt('bf')),
      NOW(),
      '{"provider":"email","providers":["email"]}'::jsonb,
      jsonb_build_object('full_name', p_full_name),
      NOW(), NOW(), '', ''
    )
    RETURNING id INTO v_user_id;
  END IF;

  v_username := NULLIF(TRIM(COALESCE(p_username, '')), '');
  IF v_username IS NULL THEN
    v_username := split_part(LOWER(TRIM(p_email)), '@', 1);
  END IF;

  INSERT INTO public.profiles (
    id, email, full_name, username, role, is_active, permissions
  ) VALUES (
    v_user_id, LOWER(TRIM(p_email)), TRIM(p_full_name),
    v_username, p_role, p_is_active, COALESCE(p_permissions, '{}'::jsonb)
  )
  ON CONFLICT (id) DO UPDATE SET
    full_name   = EXCLUDED.full_name,
    username    = EXCLUDED.username,
    role        = EXCLUDED.role,
    is_active   = EXCLUDED.is_active,
    permissions = EXCLUDED.permissions,
    updated_at  = NOW();

  RETURN v_user_id;
END;
$$;


ALTER FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean, p_username text, p_permissions jsonb) OWNER TO postgres;

--
-- Name: delete_user_completely(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_user_completely(p_user_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  UPDATE public.quotations SET created_by = NULL WHERE created_by = p_user_id;
  UPDATE public.customers SET created_by = NULL WHERE created_by = p_user_id;
  UPDATE public.customers SET assigned_to = NULL WHERE assigned_to = p_user_id;
  UPDATE public.official_letters SET created_by = NULL WHERE created_by = p_user_id;
  DELETE FROM public.notifications WHERE user_id = p_user_id;
  DELETE FROM public.activity_logs WHERE user_id = p_user_id;
  DELETE FROM public.profiles WHERE id = p_user_id;
  DELETE FROM auth.users WHERE id = p_user_id;
END;
$$;


ALTER FUNCTION public.delete_user_completely(p_user_id uuid) OWNER TO postgres;

--
-- Name: generate_customer_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_customer_number() RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  next_val INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'customer'
    RETURNING current_value INTO next_val;

  RETURN 'C-' || LPAD(next_val::TEXT, 4, '0');
END;
$$;


ALTER FUNCTION public.generate_customer_number() OWNER TO postgres;

--
-- Name: generate_draft_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_draft_number() RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  next_val INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'draft'
    RETURNING current_value INTO next_val;

  RETURN '2026D-' || LPAD(next_val::TEXT, 3, '0');
END;
$$;


ALTER FUNCTION public.generate_draft_number() OWNER TO postgres;

--
-- Name: generate_order_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_order_number() RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val     INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = 0, year = current_year
    WHERE id = 'order' AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'order'
    RETURNING current_value INTO next_val;

  RETURN 'ORD-' || current_year || '-' || LPAD(next_val::TEXT, 3, '0');
END;
$$;


ALTER FUNCTION public.generate_order_number() OWNER TO postgres;

--
-- Name: generate_quotation_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_quotation_number() RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val     INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = 0, year = current_year
    WHERE id = 'quotation' AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'quotation'
    RETURNING current_value INTO next_val;

  RETURN 'QT-' || current_year || '-' || LPAD(next_val::TEXT, 4, '0');
END;
$$;


ALTER FUNCTION public.generate_quotation_number() OWNER TO postgres;

--
-- Name: get_email_by_username(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_email_by_username(p_username text) RETURNS text
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT email
  FROM public.profiles
  WHERE LOWER(TRIM(username)) = LOWER(TRIM(p_username))
  LIMIT 1;
$$;


ALTER FUNCTION public.get_email_by_username(p_username text) OWNER TO postgres;

--
-- Name: get_my_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_my_role() RETURNS text
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$;


ALTER FUNCTION public.get_my_role() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, username)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'مستخدم جديد'),
    COALESCE(
      NEW.raw_user_meta_data->>'username',
      split_part(NEW.email, '@', 1)
    )
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: reset_user_password(uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reset_user_password(p_user_id uuid, p_new_password text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin') THEN
    RAISE EXCEPTION 'حرصم ريغ';
  END IF;
  UPDATE auth.users
  SET encrypted_password = crypt(p_new_password, gen_salt('bf'))
  WHERE id = p_user_id;
END;
$$;


ALTER FUNCTION public.reset_user_password(p_user_id uuid, p_new_password text) OWNER TO postgres;

--
-- Name: set_order_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_order_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    NEW.number := generate_order_number();
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_order_number() OWNER TO postgres;

--
-- Name: set_quotation_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_quotation_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    IF NEW.status = 'draft' THEN
      NEW.number := public.generate_draft_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_quotation_number() OWNER TO postgres;

--
-- Name: setup_new_user_profile(uuid, text, text, text, text, boolean, jsonb); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.setup_new_user_profile(p_user_id uuid, p_email text, p_full_name text, p_username text, p_role text DEFAULT 'employee'::text, p_is_active boolean DEFAULT true, p_permissions jsonb DEFAULT '{}'::jsonb) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  v_username TEXT;
BEGIN
  v_username := NULLIF(TRIM(COALESCE(p_username, '')), '');
  IF v_username IS NULL THEN
    v_username := split_part(LOWER(TRIM(p_email)), '@', 1);
  END IF;

  INSERT INTO public.profiles (id, email, full_name, username, role, is_active, permissions)
  VALUES (p_user_id, LOWER(TRIM(p_email)), TRIM(p_full_name), v_username, p_role, p_is_active, COALESCE(p_permissions, '{}'::jsonb))
  ON CONFLICT (id) DO UPDATE SET
    full_name   = EXCLUDED.full_name,
    username    = EXCLUDED.username,
    role        = EXCLUDED.role,
    is_active   = EXCLUDED.is_active,
    permissions = EXCLUDED.permissions,
    updated_at  = NOW();
END;
$$;


ALTER FUNCTION public.setup_new_user_profile(p_user_id uuid, p_email text, p_full_name text, p_username text, p_role text, p_is_active boolean, p_permissions jsonb) OWNER TO postgres;

--
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
    -- Regclass of the table e.g. public.notes
    entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

    -- I, U, D, T: insert, update ...
    action realtime.action = (
        case wal ->> 'action'
            when 'I' then 'INSERT'
            when 'U' then 'UPDATE'
            when 'D' then 'DELETE'
            else 'ERROR'
        end
    );

    -- Is row level security enabled for the table
    is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

    subscriptions realtime.subscription[] = array_agg(subs)
        from
            realtime.subscription subs
        where
            subs.entity = entity_
            -- Filter by action early - only get subscriptions interested in this action
            -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
            and (subs.action_filter = '*' or subs.action_filter = action::text);

    -- Subscription vars
    working_role regrole;
    working_selected_columns text[];
    claimed_role regrole;
    claims jsonb;

    subscription_id uuid;
    subscription_has_access bool;
    visible_to_subscription_ids uuid[] = '{}';

    -- structured info for wal's columns
    columns realtime.wal_column[];
    -- previous identity values for update/delete
    old_columns realtime.wal_column[];

    error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

    -- Primary jsonb output for record
    output jsonb;

    -- Loop record for iterating unique roles (outer loop)
    role_record record;
    -- Loop record for iterating unique selected_columns within a role (inner loop)
    cols_record record;
    -- Subscription ids visible at the role level (before fanning out by selected_columns)
    visible_role_sub_ids uuid[] = '{}';

begin
    perform set_config('role', null, true);

    columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'columns') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    old_columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'identity') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    for role_record in
        select claims_role
        from (select distinct claims_role from unnest(subscriptions)) t
        order by claims_role::text
    loop
        working_role := role_record.claims_role;

        -- Update `is_selectable` for columns and old_columns (once per role)
        columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(columns) c;

        old_columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(old_columns) c;

        if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
            -- Fan out 400 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;
            end loop;

        -- The claims role does not have SELECT permission to the primary key of entity
        elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
            -- Fan out 401 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;
            end loop;

        else
            -- Create the prepared statement (once per role)
            if is_rls_enabled and action <> 'DELETE' then
                if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                    deallocate walrus_rls_stmt;
                end if;
                execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
            end if;

            -- Collect all visible subscription IDs for this role (filter check + RLS check)
            visible_role_sub_ids = '{}';

            for subscription_id, claims in (
                    select
                        subs.subscription_id,
                        subs.claims
                    from
                        unnest(subscriptions) subs
                    where
                        subs.entity = entity_
                        and subs.claims_role = working_role
                        and (
                            realtime.is_visible_through_filters(columns, subs.filters)
                            or (
                              action = 'DELETE'
                              and realtime.is_visible_through_filters(old_columns, subs.filters)
                            )
                        )
            ) loop

                if not is_rls_enabled or action = 'DELETE' then
                    visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                else
                    -- Check if RLS allows the role to see the record
                    perform
                        -- Trim leading and trailing quotes from working_role because set_config
                        -- doesn't recognize the role as valid if they are included
                        set_config('role', trim(both '"' from working_role::text), true),
                        set_config('request.jwt.claims', claims::text, true);

                    execute 'execute walrus_rls_stmt' into subscription_has_access;

                    -- Reset the role on every FOR..LOOP batch execution.
                    -- The first batch of 10 rows is pre-fetched using the current connection role (PG internal behaviour)
                    -- then we have to reset it again otherwise it would use the role defined in the `set_config` above
                    -- to fetch the remaining rows when rows>10, which could be a user-defined role that lacks execution grants.
                    -- The flow is:
                    --   1. run batch with conn role
                    --   2. set_config working_role
                    --   3. execute walrus
                    --   4. reset role (revert)
                    --   5. repeat
                    perform set_config('role', null, true);

                    if subscription_has_access then
                        visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                    end if;
                end if;
            end loop;

            perform set_config('role', null, true);

            -- Inner loop: per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;

                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                            left join (
                                select unnest(conkey) as pkey_attnum
                                from pg_constraint
                                where conrelid = entity_ and contype = 'p'
                            ) pk on pk.pkey_attnum = pa.attnum
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                            and (working_selected_columns is null or pa.attname = any(working_selected_columns) or pk.pkey_attnum is not null)
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and (working_selected_columns is null or coalesce((c).name, (oc).name) = any(working_selected_columns) or coalesce((c).is_pkey, (oc).is_pkey))
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Filter visible_role_sub_ids to those matching the current selected_columns group
                visible_to_subscription_ids = coalesce(
                    (
                        select array_agg(s.subscription_id)
                        from unnest(subscriptions) s
                        where s.claims_role = working_role
                          and (s.selected_columns is not distinct from working_selected_columns)
                          and s.subscription_id = any(visible_role_sub_ids)
                    ),
                    '{}'::uuid[]
                );

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;
            end loop;

        end if;
    end loop;

    perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_realtime_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_realtime_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_realtime_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_realtime_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
/*
Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
*/
declare
    op_symbol text = (
        case
            when op = 'eq' then '='
            when op = 'neq' then '!='
            when op = 'lt' then '<'
            when op = 'lte' then '<='
            when op = 'gt' then '>'
            when op = 'gte' then '>='
            when op = 'in' then '= any'
            else 'UNKNOWN OP'
        end
    );
    res boolean;
begin
    execute format(
        'select %L::'|| type_::text || ' ' || op_symbol
        || ' ( %L::'
        || (
            case
                when op = 'in' then type_::text || '[]'
                else type_::text end
        )
        || ')', val_1, val_2) into res;
    return res;
end;
$$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_realtime_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $$
declare
    op_symbol text;
    res boolean;
begin
    -- IS DISTINCT FROM / IS NOT DISTINCT FROM: infix, both sides typed literals
    if op = 'isdistinct' then
        execute format(
            'select %L::%s %s %L::%s',
            val_1,
            type_::text,
            case when negate then 'IS NOT DISTINCT FROM' else 'IS DISTINCT FROM' end,
            val_2,
            type_::text
        ) into res;
        return res;
    end if;

    -- IS requires a keyword RHS (NULL, TRUE, FALSE, UNKNOWN), not a typed literal
    if op = 'is' then
        if val_2 not in ('null', 'true', 'false', 'unknown') then
            raise exception 'invalid value for is filter: must be null, true, false, or unknown';
        end if;
        execute format(
            'select %L::%s %s %s',
            val_1,
            type_::text,
            case when negate then 'IS NOT' else 'IS' end,
            upper(val_2)
        ) into res;
        return res;
    end if;

    op_symbol = case
        when op = 'eq'    then '='
        when op = 'neq'   then '!='
        when op = 'lt'    then '<'
        when op = 'lte'   then '<='
        when op = 'gt'    then '>'
        when op = 'gte'   then '>='
        when op = 'in'    then '= any'
        when op = 'like'   then 'LIKE'
        when op = 'ilike'  then 'ILIKE'
        when op = 'match'  then '~'
        when op = 'imatch' then '~*'
        else null
    end;

    if op_symbol is null then
        raise exception 'unsupported equality operator: %', op::text;
    end if;

    execute format(
        'select %L::%s %s (%L::%s)',
        val_1,
        type_::text,
        op_symbol,
        val_2,
        case when op = 'in' then type_::text || '[]' else type_::text end
    ) into res;

    return case when negate then not res else res end;
end;
$$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) OWNER TO supabase_realtime_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
    select
        filters is null
        or array_length(filters, 1) is null
        or coalesce(
            count(col.name) = count(1)
            and sum(
                realtime.check_equality_op(
                    op:=f.op,
                    type_:=coalesce(col.type_oid::regtype, col.type_name::regtype),
                    val_1:=col.value #>> '{}',
                    val_2:=f.value,
                    negate:=coalesce(f.negate, false)
                )::int
            ) filter (where col.name is not null) = count(col.name),
            false
        )
    from
        unnest(filters) f
        left join unnest(columns) col
            on f.column_name = col.name;
$$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_realtime_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_realtime_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    realtime.wal2json_escape_identifier(nsp.nspname::text)
    || '.'
    || realtime.wal2json_escape_identifier(pc.relname::text)
  FROM pg_class pc
  JOIN pg_namespace nsp ON pc.relnamespace = nsp.oid
  WHERE pc.oid = entity
$$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_realtime_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_realtime_admin;

--
-- Name: send_binary(bytea, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, binary_payload, event, topic, private, extension)
    VALUES (generated_id, payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) OWNER TO supabase_realtime_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    col_names text[] = coalesce(
            array_agg(a.attname order by a.attnum),
            '{}'::text[]
        )
        from
            pg_catalog.pg_attribute a
        where
            a.attrelid = new.entity
            and a.attnum > 0
            and not a.attisdropped
            and pg_catalog.has_column_privilege(
                (new.claims ->> 'role'),
                a.attrelid,
                a.attnum,
                'SELECT'
            );
    filter realtime.user_defined_filter;
    col_type regtype;
    in_val jsonb;
    selected_col text;
begin
    for filter in select * from unnest(new.filters) loop
        if not filter.column_name = any(col_names) then
            raise exception 'invalid column for filter %', filter.column_name;
        end if;

        col_type = (
            select atttypid::regtype
            from pg_catalog.pg_attribute
            where attrelid = new.entity
                  and attname = filter.column_name
        );
        if col_type is null then
            raise exception 'failed to lookup type for column %', filter.column_name;
        end if;

        if filter.op = 'in'::realtime.equality_op then
            in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
            if coalesce(jsonb_array_length(in_val), 0) > 100 then
                raise exception 'too many values for `in` filter. Maximum 100';
            end if;
        elsif filter.op = 'is'::realtime.equality_op then
            -- `is` requires a keyword RHS rather than a typed literal
            if filter.value not in ('null', 'true', 'false', 'unknown') then
                raise exception 'invalid value for is filter: must be null, true, false, or unknown';
            end if;
            -- IS NULL works for any type, but IS TRUE/FALSE/UNKNOWN require a boolean
            -- operand. Reject the non-null keywords on non-boolean columns here so they
            -- don't abort apply_rls at WAL time.
            if filter.value <> 'null' and col_type <> 'boolean'::regtype then
                raise exception 'is % filter requires a boolean column, got %', filter.value, col_type::text;
            end if;
        elsif filter.op in ('like'::realtime.equality_op, 'ilike'::realtime.equality_op) then
            -- like/ilike apply the text pattern operator (~~); reject column types that
            -- have no such operator instead of failing at WAL time
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = '~~' and oprleft = col_type
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
        elsif filter.op in ('match'::realtime.equality_op, 'imatch'::realtime.equality_op) then
            -- match/imatch apply the regex operators ~ / ~*; reject column types that have
            -- no such operator (e.g. integer) instead of failing at WAL time, mirroring the
            -- like/ilike guard above.
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = case when filter.op = 'imatch'::realtime.equality_op then '~*' else '~' end
                  and oprleft = col_type
                  and oprright = col_type
                  and oprresult = 'boolean'::regtype
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
            -- validate the regex eagerly so a bad pattern is rejected here, not inside
            -- apply_rls where it would abort the WAL stream for the entity
            begin
                perform '' ~ filter.value;
            exception when others then
                raise exception 'invalid regular expression for % filter: %', filter.op::text, sqlerrm;
            end;
        else
            -- eq/neq/lt/lte/gt/gte: value must be coercable to the type
            perform realtime.cast(filter.value, col_type);
        end if;
    end loop;

    if new.selected_columns is not null then
        for selected_col in select * from unnest(new.selected_columns) loop
            if not selected_col = any(col_names) then
                raise exception 'invalid column for select %', selected_col;
            end if;
        end loop;
    end if;

    -- Apply consistent order to filters so the unique constraint can't be tricked by a
    -- different filter order. negate is part of the sort key.
    new.filters = coalesce(
        array_agg(f order by f.column_name, f.op, f.value, f.negate),
        '{}'
    ) from unnest(new.filters) f;

    new.selected_columns = (
        select array_agg(c order by c)
        from unnest(new.selected_columns) c
    );

    return new;
end;
$$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_realtime_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_realtime_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: wal2json_escape_identifier(text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.wal2json_escape_identifier(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  -- Prefix `\`, `,`, `.`, and any whitespace with `\`
  SELECT regexp_replace(name, '([\\,.[:space:]])', '\\\1', 'g')
$$;


ALTER FUNCTION realtime.wal2json_escape_identifier(name text) OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Get the last path segment (the actual filename)
    SELECT _parts[array_length(_parts, 1)] INTO _filename;
    -- Extract extension: reverse, split on '.', then reverse again
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint)::bigint as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    custom_claims_allowlist text[] DEFAULT '{}'::text[] NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_logs (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    user_name text,
    action text NOT NULL,
    target_type text,
    target_id uuid,
    target_number text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.activity_logs OWNER TO postgres;

--
-- Name: archive_reasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.archive_reasons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reason text NOT NULL,
    last_used_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.archive_reasons OWNER TO postgres;

--
-- Name: catalog_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalog_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    created_by uuid
);


ALTER TABLE public.catalog_categories OWNER TO postgres;

--
-- Name: catalog_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalog_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    unit text DEFAULT 'EACH'::text,
    unit_price numeric DEFAULT 0,
    origin text DEFAULT 'CHINA'::text,
    delivery text DEFAULT 'PROMPT'::text,
    category text,
    notes text,
    is_active boolean DEFAULT true,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.catalog_items OWNER TO postgres;

--
-- Name: custom_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_origins (
    id bigint NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.custom_origins OWNER TO postgres;

--
-- Name: custom_origins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.custom_origins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_origins_id_seq OWNER TO postgres;

--
-- Name: custom_origins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.custom_origins_id_seq OWNED BY public.custom_origins.id;


--
-- Name: custom_units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_units (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.custom_units OWNER TO postgres;

--
-- Name: custom_units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.custom_units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_units_id_seq OWNER TO postgres;

--
-- Name: custom_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.custom_units_id_seq OWNED BY public.custom_units.id;


--
-- Name: customer_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.customer_categories OWNER TO postgres;

--
-- Name: customer_districts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_districts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    governorate text NOT NULL,
    name text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.customer_districts OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    phone text,
    alt_phone text,
    address text,
    website text,
    notes text,
    assigned_to uuid,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    customer_code text,
    fax text,
    mobile text,
    email text,
    city text,
    category text,
    tags text,
    contact1_name text,
    contact1_title text,
    contact1_phone text,
    contact1_mobile text,
    contact1_email text,
    contact1_ext text,
    contact1_notes text,
    contact2_name text,
    contact2_title text,
    contact2_phone text,
    contact2_mobile text,
    contact2_email text,
    contact2_ext text,
    contact2_notes text,
    rep_name text,
    contact1_last_name text,
    contact1_mobile2 text,
    contact2_last_name text,
    contact2_mobile2 text
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: hr_attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hr_attendance (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    employee_id uuid NOT NULL,
    date date NOT NULL,
    status text DEFAULT 'present'::text NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hr_attendance_status_check CHECK ((status = ANY (ARRAY['present'::text, 'absent'::text, 'late'::text, 'leave_annual'::text, 'leave_sick'::text, 'leave_unpaid'::text, 'leave_personal'::text, 'holiday'::text])))
);


ALTER TABLE public.hr_attendance OWNER TO postgres;

--
-- Name: hr_employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hr_employees (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    full_name text NOT NULL,
    job_title text,
    department text,
    hire_date date,
    base_salary numeric(12,2) DEFAULT 0,
    phone text,
    national_id text,
    status text DEFAULT 'active'::text,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hr_employees_status_check CHECK ((status = ANY (ARRAY['active'::text, 'inactive'::text, 'terminated'::text])))
);


ALTER TABLE public.hr_employees OWNER TO postgres;

--
-- Name: hr_letters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hr_letters (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    employee_id uuid,
    letter_type text NOT NULL,
    title text NOT NULL,
    content text,
    issued_date date DEFAULT CURRENT_DATE,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.hr_letters OWNER TO postgres;

--
-- Name: hr_salaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hr_salaries (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    employee_id uuid NOT NULL,
    month integer NOT NULL,
    year integer NOT NULL,
    base_salary numeric(12,2) DEFAULT 0,
    bonus numeric(12,2) DEFAULT 0,
    deductions numeric(12,2) DEFAULT 0,
    status text DEFAULT 'pending'::text,
    paid_at timestamp with time zone,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hr_salaries_month_check CHECK (((month >= 1) AND (month <= 12))),
    CONSTRAINT hr_salaries_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'paid'::text])))
);


ALTER TABLE public.hr_salaries OWNER TO postgres;

--
-- Name: letter_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.letter_contacts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    contact_type text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.letter_contacts OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    body text,
    type text DEFAULT 'info'::text,
    link_type text,
    link_id uuid,
    is_read boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: number_sequences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.number_sequences (
    id text NOT NULL,
    prefix text NOT NULL,
    current_value integer DEFAULT 0 NOT NULL,
    year integer DEFAULT (EXTRACT(year FROM now()))::integer NOT NULL
);


ALTER TABLE public.number_sequences OWNER TO postgres;

--
-- Name: official_letters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.official_letters (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    number integer NOT NULL,
    recipient text NOT NULL,
    attention text,
    date text NOT NULL,
    subject text NOT NULL,
    category text DEFAULT 'correspondence'::text,
    body text NOT NULL,
    signer_name text,
    signer_title text,
    use_letterhead boolean DEFAULT true,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.official_letters OWNER TO postgres;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    order_id uuid NOT NULL,
    sort_order integer DEFAULT 0,
    item_name text NOT NULL,
    description text,
    unit text,
    quantity numeric(10,3) DEFAULT 1 NOT NULL,
    unit_price numeric(12,3) DEFAULT 0 NOT NULL,
    total_price numeric(12,3),
    origin text,
    delivery text,
    notes text,
    tax_pct numeric(5,2)
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    number text NOT NULL,
    quotation_id uuid,
    quotation_number text,
    customer_name text NOT NULL,
    currency text DEFAULT 'JOD'::text,
    total_amount numeric(12,3) DEFAULT 0,
    status text DEFAULT 'pending'::text NOT NULL,
    notes text,
    expected_delivery date,
    actual_delivery date,
    created_by uuid,
    archived boolean DEFAULT false,
    archived_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    archive_note text,
    prepared_by text,
    delivered_by text,
    CONSTRAINT orders_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'confirmed'::text, 'processing'::text, 'delivered'::text, 'cancelled'::text])))
);

ALTER TABLE ONLY public.orders REPLICA IDENTITY FULL;


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    username text,
    full_name text DEFAULT 'مستخدم جديد'::text NOT NULL,
    email text,
    phone text,
    role text DEFAULT 'employee'::text NOT NULL,
    is_active boolean DEFAULT true,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    permissions jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT profiles_role_check CHECK ((role = ANY (ARRAY['admin'::text, 'manager'::text, 'user'::text, 'employee'::text])))
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: order_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.order_summary AS
 SELECT o.id,
    o.number,
    o.quotation_number,
    o.customer_name,
    o.total_amount,
    o.currency,
    o.status,
    p.full_name AS created_by_name,
    o.created_at,
    o.archived
   FROM (public.orders o
     LEFT JOIN public.profiles p ON ((p.id = o.created_by)));


ALTER VIEW public.order_summary OWNER TO postgres;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    quotation_id uuid NOT NULL,
    amount numeric NOT NULL,
    payment_date date DEFAULT CURRENT_DATE NOT NULL,
    method text DEFAULT 'تحويل بنكي'::text,
    reference_no text,
    notes text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT payments_amount_check CHECK ((amount > (0)::numeric))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: quotation_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotation_items (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    quotation_id uuid NOT NULL,
    sort_order integer DEFAULT 0,
    item_name text NOT NULL,
    description text,
    unit text DEFAULT 'EACH'::text,
    quantity numeric(10,3) DEFAULT 1 NOT NULL,
    unit_price numeric(12,3) DEFAULT 0 NOT NULL,
    total_price numeric(12,3) GENERATED ALWAYS AS ((quantity * unit_price)) STORED,
    origin text DEFAULT 'CHINA'::text,
    delivery text DEFAULT 'PROMPT'::text,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    tax_pct numeric(5,2) DEFAULT 16,
    option_group text
);


ALTER TABLE public.quotation_items OWNER TO postgres;

--
-- Name: quotation_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.quotation_summary AS
SELECT
    NULL::uuid AS id,
    NULL::text AS number,
    NULL::text AS customer_name,
    NULL::date AS date,
    NULL::text AS status,
    NULL::numeric(12,3) AS nett_price,
    NULL::text AS currency,
    NULL::text AS created_by_name,
    NULL::bigint AS item_count,
    NULL::timestamp with time zone AS created_at,
    NULL::boolean AS archived;


ALTER VIEW public.quotation_summary OWNER TO postgres;

--
-- Name: quotations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    number text NOT NULL,
    customer_name text NOT NULL,
    attention text,
    phone text,
    address text,
    date date DEFAULT CURRENT_DATE NOT NULL,
    reference text,
    currency text DEFAULT 'JOD'::text NOT NULL,
    delivery text DEFAULT 'PROMPT'::text,
    subtotal numeric(12,3) DEFAULT 0,
    discount_pct numeric(5,2) DEFAULT 5,
    discount_amt numeric(12,3) DEFAULT 0,
    grand_total numeric(12,3) DEFAULT 0,
    tax_pct numeric(5,2) DEFAULT 16,
    tax_amt numeric(12,3) DEFAULT 0,
    nett_price numeric(12,3) DEFAULT 0,
    notes text,
    terms text,
    prepared_by text,
    status text DEFAULT 'draft'::text NOT NULL,
    created_by uuid,
    archived boolean DEFAULT false,
    archived_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    customer_id uuid,
    valid_until date,
    discount_type text DEFAULT 'pct'::text,
    discount_fixed numeric DEFAULT 0,
    deleted_at timestamp with time zone,
    deleted_by uuid,
    delete_reason text,
    quote_type text DEFAULT 'quote'::text,
    detailed_layout boolean DEFAULT true,
    archive_note text,
    CONSTRAINT quotations_status_check CHECK ((status = ANY (ARRAY['draft'::text, 'sent'::text, 'approved'::text, 'partial_referral'::text, 'rejected'::text, 'converted'::text, 'invoiced'::text, 'cancelled'::text, 'expired'::text])))
);

ALTER TABLE ONLY public.quotations REPLICA IDENTITY FULL;


ALTER TABLE public.quotations OWNER TO postgres;

--
-- Name: quote_followups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quote_followups (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    quotation_id uuid NOT NULL,
    note text NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.quote_followups OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_02; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL)))
);


ALTER TABLE realtime.messages_2026_08_02 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_03; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL)))
);


ALTER TABLE realtime.messages_2026_08_03 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_04; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_04 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL)))
);


ALTER TABLE realtime.messages_2026_08_04 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_05; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_05 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL)))
);


ALTER TABLE realtime.messages_2026_08_05 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_06; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_06 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL)))
);


ALTER TABLE realtime.messages_2026_08_06 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_07; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_07 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL)))
);


ALTER TABLE realtime.messages_2026_08_07 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_08; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_08 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL)))
);


ALTER TABLE realtime.messages_2026_08_08 OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    selected_columns text[],
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_realtime_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: messages_2026_08_02; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_02 FOR VALUES FROM ('2026-08-02 00:00:00') TO ('2026-08-03 00:00:00');


--
-- Name: messages_2026_08_03; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_03 FOR VALUES FROM ('2026-08-03 00:00:00') TO ('2026-08-04 00:00:00');


--
-- Name: messages_2026_08_04; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_04 FOR VALUES FROM ('2026-08-04 00:00:00') TO ('2026-08-05 00:00:00');


--
-- Name: messages_2026_08_05; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_05 FOR VALUES FROM ('2026-08-05 00:00:00') TO ('2026-08-06 00:00:00');


--
-- Name: messages_2026_08_06; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_06 FOR VALUES FROM ('2026-08-06 00:00:00') TO ('2026-08-07 00:00:00');


--
-- Name: messages_2026_08_07; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_07 FOR VALUES FROM ('2026-08-07 00:00:00') TO ('2026-08-08 00:00:00');


--
-- Name: messages_2026_08_08; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_08 FOR VALUES FROM ('2026-08-08 00:00:00') TO ('2026-08-09 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: custom_origins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_origins ALTER COLUMN id SET DEFAULT nextval('public.custom_origins_id_seq'::regclass);


--
-- Name: custom_units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_units ALTER COLUMN id SET DEFAULT nextval('public.custom_units_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at, custom_claims_allowlist) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
ee095348-a2de-4906-a078-0e8a3f3560a9	ee095348-a2de-4906-a078-0e8a3f3560a9	{"sub": "ee095348-a2de-4906-a078-0e8a3f3560a9", "email": "o.alawy.oa@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-05-14 08:04:06.711179+00	2026-05-14 08:04:06.711261+00	2026-05-14 08:04:06.711261+00	6b44a234-dfe0-4838-b6c4-915460183944
445bc65d-256f-48d3-9367-464a408e657b	445bc65d-256f-48d3-9367-464a408e657b	{"sub": "445bc65d-256f-48d3-9367-464a408e657b", "email": "hmest19811@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-05-14 08:52:11.005184+00	2026-05-14 08:52:11.00524+00	2026-05-14 08:52:11.00524+00	302791c6-724a-42e5-9a63-cb6a2781683a
65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	{"sub": "65ce1c8f-6151-402a-8bcd-4270b3cf6d0a", "email": "hmest1969@gmail.com", "full_name": "Dr.Ahmad tannerah", "email_verified": false, "phone_verified": false}	email	2026-07-23 13:35:58.470815+00	2026-07-23 13:35:58.470869+00	2026-07-23 13:35:58.470869+00	c4d5d474-f3d9-4744-97e0-55579ee446fc
6f484e98-e110-4ceb-8070-e61810c5f108	6f484e98-e110-4ceb-8070-e61810c5f108	{"sub": "6f484e98-e110-4ceb-8070-e61810c5f108", "email": "hmest121981@gmail.com", "full_name": "Eng. Ahlam Alyamani", "email_verified": false, "phone_verified": false}	email	2026-07-23 13:50:50.491563+00	2026-07-23 13:50:50.491611+00	2026-07-23 13:50:50.491611+00	f3a89c40-e65d-4726-bd07-0f449e4e44ef
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
bf26c995-6f22-4087-b1bc-543137eaac5c	2026-07-23 13:46:48.969188+00	2026-07-23 13:46:48.969188+00	password	27c8e240-6ac9-4c8d-9544-72c24a09a6cc
ba8bb428-473f-4332-81d0-823bf4f2eb2e	2026-07-23 14:45:06.174135+00	2026-07-23 14:45:06.174135+00	password	2018b522-dbdd-4ddd-bb6d-edeaac863e34
dd3bf543-408e-452e-94ff-ccf18a1fcc01	2026-07-26 07:28:27.177594+00	2026-07-26 07:28:27.177594+00	password	a7a186b5-d9f0-481e-a84b-97d331d1062f
554d0cce-c668-4fc1-96e0-aeea4964cad8	2026-07-26 07:29:26.737534+00	2026-07-26 07:29:26.737534+00	password	19962f22-0b46-4d39-818c-2d0c9e70b9b3
1215717f-92b0-4f5e-ab78-ba455494a244	2026-07-26 07:47:02.40765+00	2026-07-26 07:47:02.40765+00	password	48dee9da-ea68-416e-9c10-94365d196118
5b601af7-d03f-4de6-85e3-597dac4efdc7	2026-07-26 08:09:21.664525+00	2026-07-26 08:09:21.664525+00	password	067e96ea-bb25-4c16-a5f7-dc3bff41e996
bb4d963b-0fbf-4987-ac7b-25046f553eb0	2026-07-26 09:35:23.10056+00	2026-07-26 09:35:23.10056+00	password	89d81b8b-3d01-4a7f-92a9-98b8f37e0ce9
d9a803fd-4083-44f7-bef8-9fc3bce694b4	2026-07-29 09:04:55.9974+00	2026-07-29 09:04:55.9974+00	password	1b70f69b-1ed1-4e26-a463-c006295b588f
59194506-4734-4a94-94f9-cc23d7c277ea	2026-08-02 08:56:54.250114+00	2026-08-02 08:56:54.250114+00	password	c89ed3c2-a6d1-4974-8eb6-37485a89d6c8
ef9f4808-0648-4c2e-8445-fe944da726e3	2026-08-02 10:45:06.526657+00	2026-08-02 10:45:06.526657+00	password	83b76703-b84e-40b9-b6be-491a56b86be9
33e641d9-0ffc-42cc-ad73-381d336ac129	2026-08-02 12:52:59.865616+00	2026-08-02 12:52:59.865616+00	password	aeeb5803-4a24-4daa-a34f-cb009353f18c
9b2f1dbe-03b4-453f-a04e-cb7568a0aa75	2026-08-02 13:03:38.043629+00	2026-08-02 13:03:38.043629+00	password	fc91b755-e1d2-4fb3-a854-ad4f8d523c48
0f043215-a780-435e-ad80-95dd3108b415	2026-08-04 07:28:09.916454+00	2026-08-04 07:28:09.916454+00	password	5e035906-71a3-4edd-9e5f-486c473ac959
39b45c3f-092d-435f-bce3-efbcb7291b77	2026-08-05 23:06:08.472333+00	2026-08-05 23:06:08.472333+00	password	2415e0e4-5a11-4237-99b6-b3190445e7fe
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	385	de4gzgvgwlj3	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-28 12:35:14.530176+00	2026-07-28 14:11:03.884104+00	64s2vm23udkv	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	381	4kqoq2bp34ut	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-28 09:17:44.300995+00	2026-07-29 10:53:51.273182+00	vdvspcfvxy7u	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	380	elub7cen3nqk	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-28 08:36:09.673697+00	2026-08-01 11:31:35.007407+00	3ppa7imlwzyz	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	337	kxrjgjeyxlon	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-26 07:15:36.360903+00	2026-08-04 08:45:39.445586+00	5dgxffyqutnl	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	327	2zxlmvrdxuz2	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-23 14:45:06.138903+00	2026-07-23 15:43:14.721454+00	\N	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	322	q3ps2dmal34d	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-23 13:46:48.961932+00	2026-07-23 16:05:42.607187+00	\N	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	329	4tku74bohdua	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-23 16:05:42.621521+00	2026-07-23 17:03:59.867308+00	q3ps2dmal34d	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	328	4k67shzw5mbr	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-23 15:43:14.74326+00	2026-07-23 17:14:46.339603+00	2zxlmvrdxuz2	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	331	ssyechi7keea	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-23 17:14:46.347832+00	2026-07-25 09:51:05.807122+00	4k67shzw5mbr	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	332	goprxtdmrf4z	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-25 09:51:05.828533+00	2026-07-25 11:21:32.387897+00	ssyechi7keea	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	330	w4uqshlzd657	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-23 17:03:59.890427+00	2026-07-25 18:04:13.245105+00	4tku74bohdua	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	333	focl6ofmusmo	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-25 11:21:32.393445+00	2026-07-25 18:04:18.96709+00	goprxtdmrf4z	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	335	5dgxffyqutnl	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-25 18:04:18.969193+00	2026-07-26 07:15:36.3424+00	focl6ofmusmo	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	334	6mokowkfw4he	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-25 18:04:13.257256+00	2026-07-26 07:15:38.856299+00	w4uqshlzd657	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	342	o3gyhtavader	445bc65d-256f-48d3-9367-464a408e657b	f	2026-07-26 07:29:26.735258+00	2026-07-26 07:29:26.735258+00	\N	554d0cce-c668-4fc1-96e0-aeea4964cad8
00000000-0000-0000-0000-000000000000	343	lpmrv4doxwcy	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-07-26 07:47:02.391994+00	2026-07-26 07:47:02.391994+00	\N	1215717f-92b0-4f5e-ab78-ba455494a244
00000000-0000-0000-0000-000000000000	344	cqtur3ic7qlb	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 08:09:21.634358+00	2026-07-26 09:13:08.163008+00	\N	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	345	fwmdl5x2dskk	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 09:13:08.177853+00	2026-07-26 10:21:48.142861+00	cqtur3ic7qlb	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	346	ku4yo3rn5vts	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-26 09:35:23.090851+00	2026-07-26 11:09:09.078081+00	\N	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	347	6ifvodupaebg	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 10:21:48.160459+00	2026-07-26 14:04:56.082186+00	fwmdl5x2dskk	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	349	j6yt56p3rllr	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 14:04:56.093057+00	2026-07-26 15:03:06.424195+00	6ifvodupaebg	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	350	scmvbvwv666c	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 15:03:06.448349+00	2026-07-26 16:01:36.298397+00	j6yt56p3rllr	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	351	c7lavpcfnyhd	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 16:01:36.309225+00	2026-07-26 17:00:06.379474+00	scmvbvwv666c	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	352	5di2m3ptwa2c	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 17:00:06.40049+00	2026-07-26 17:58:36.379316+00	c7lavpcfnyhd	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	353	lylzkzg6xyto	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 17:58:36.395619+00	2026-07-26 18:57:06.457283+00	5di2m3ptwa2c	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	354	7qoxpasc5spc	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 18:57:06.469479+00	2026-07-26 19:55:36.461572+00	lylzkzg6xyto	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	355	5hfhc43umvnl	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 19:55:36.47497+00	2026-07-26 20:54:06.225186+00	7qoxpasc5spc	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	356	5qazranrly4i	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 20:54:06.236501+00	2026-07-26 21:52:36.582106+00	5hfhc43umvnl	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	357	5lnsovvgyla5	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 21:52:36.596518+00	2026-07-26 22:51:06.586888+00	5qazranrly4i	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	358	56roc5tnhdhm	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 22:51:06.604425+00	2026-07-26 23:49:36.605481+00	5lnsovvgyla5	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	359	jxzl7dffogjo	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 23:49:36.620348+00	2026-07-27 00:48:06.68863+00	56roc5tnhdhm	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	360	mx6r23yiq6oj	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 00:48:06.700907+00	2026-07-27 01:46:36.751562+00	jxzl7dffogjo	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	361	4lff6w7sztci	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 01:46:36.764477+00	2026-07-27 02:45:06.691425+00	mx6r23yiq6oj	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	362	iirbsbdfh3jq	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 02:45:06.700558+00	2026-07-27 03:43:36.865611+00	4lff6w7sztci	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	363	exoviohipba6	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 03:43:36.87934+00	2026-07-27 04:42:06.783222+00	iirbsbdfh3jq	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	348	gsrouiz2mevm	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-26 11:09:09.084999+00	2026-07-27 06:04:14.164877+00	ku4yo3rn5vts	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	364	inglvrz5kepj	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 04:42:06.791845+00	2026-07-27 06:54:55.116992+00	exoviohipba6	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	366	xkfoi7aw4jtw	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 06:54:55.13225+00	2026-07-27 07:53:14.510051+00	inglvrz5kepj	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	338	g5zcanmebhnf	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-26 07:15:38.856999+00	2026-07-27 08:53:24.181705+00	6mokowkfw4he	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	341	rybgpa6oqqpv	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-26 07:28:27.176036+00	2026-07-27 09:04:09.667015+00	\N	dd3bf543-408e-452e-94ff-ccf18a1fcc01
00000000-0000-0000-0000-000000000000	369	zvxn77nxtxmm	445bc65d-256f-48d3-9367-464a408e657b	f	2026-07-27 09:04:09.68024+00	2026-07-27 09:04:09.68024+00	rybgpa6oqqpv	dd3bf543-408e-452e-94ff-ccf18a1fcc01
00000000-0000-0000-0000-000000000000	368	zslaidqfgtpo	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-27 08:53:24.193119+00	2026-07-27 09:51:55.561975+00	g5zcanmebhnf	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	370	pnscnmc4xbpg	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-27 09:51:55.576326+00	2026-07-27 10:50:02.30796+00	zslaidqfgtpo	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	371	zkay7c4t2vx4	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-27 10:50:02.32215+00	2026-07-27 11:49:29.577142+00	pnscnmc4xbpg	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	373	76k2bljyht6y	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-27 11:49:29.601034+00	2026-07-27 12:58:10.842246+00	zkay7c4t2vx4	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	367	myw4oiyqjg3w	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 07:53:14.525827+00	2026-07-27 13:06:20.778945+00	xkfoi7aw4jtw	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	375	tdacmphpnfjd	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 13:06:20.786954+00	2026-07-27 14:04:57.648392+00	myw4oiyqjg3w	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	377	3ppa7imlwzyz	445bc65d-256f-48d3-9367-464a408e657b	t	2026-07-27 14:04:57.664385+00	2026-07-28 08:36:09.668976+00	tdacmphpnfjd	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	365	vdvspcfvxy7u	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-27 06:04:14.179866+00	2026-07-28 09:17:44.296718+00	gsrouiz2mevm	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	374	m622jpmz73de	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-27 12:58:10.863201+00	2026-07-28 11:35:06.013105+00	76k2bljyht6y	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	383	64s2vm23udkv	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-28 11:35:06.029926+00	2026-07-28 12:35:14.514733+00	m622jpmz73de	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	387	bywypvu7qalj	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-28 14:11:03.895895+00	2026-07-29 08:54:19.282144+00	de4gzgvgwlj3	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	389	fneusqfjbn3i	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-07-29 09:04:55.967865+00	2026-07-29 09:04:55.967865+00	\N	d9a803fd-4083-44f7-bef8-9fc3bce694b4
00000000-0000-0000-0000-000000000000	388	m4swb2yxjg5h	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-29 08:54:19.297532+00	2026-07-29 10:07:27.149484+00	bywypvu7qalj	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	391	l3rwgwfakhdy	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-29 10:07:27.162621+00	2026-07-29 11:24:47.393812+00	m4swb2yxjg5h	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	394	6bmjemdh7uqc	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-29 11:24:47.408972+00	2026-07-29 12:31:40.609404+00	l3rwgwfakhdy	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	396	gsfx7nwxcjiv	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-29 12:31:40.625302+00	2026-07-29 14:11:12.884529+00	6bmjemdh7uqc	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	397	fmve5rdvavvp	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-29 14:11:12.90074+00	2026-07-30 10:58:41.07003+00	gsfx7nwxcjiv	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	398	mjx5mipks2ms	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-30 10:58:41.091264+00	2026-07-30 12:31:03.514268+00	fmve5rdvavvp	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	399	kxuzlglv73ff	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-30 12:31:03.528211+00	2026-07-30 13:56:15.139065+00	mjx5mipks2ms	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	400	wyz4uydjqdeo	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-07-30 13:56:15.152442+00	2026-08-01 07:13:10.408423+00	kxuzlglv73ff	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	401	ouyu5rvd4toa	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-01 07:13:10.426568+00	2026-08-01 08:11:20.265981+00	wyz4uydjqdeo	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	402	xqpvp3ofpjoi	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-01 08:11:20.286186+00	2026-08-01 12:24:00.293335+00	ouyu5rvd4toa	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	403	smet3w435zr4	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-01 11:31:35.020229+00	2026-08-01 12:51:15.803364+00	elub7cen3nqk	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	404	xdgvtol5cert	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-01 12:24:00.311427+00	2026-08-01 15:01:31.514704+00	xqpvp3ofpjoi	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	405	ady6fvk47pe6	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-01 12:51:15.823731+00	2026-08-01 16:24:23.086774+00	smet3w435zr4	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	407	ibetpfcd2gdl	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-01 16:24:23.099912+00	2026-08-01 17:33:07.14988+00	ady6fvk47pe6	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	408	k4wo6r5zbe67	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-01 17:33:07.163113+00	2026-08-02 06:25:33.721847+00	ibetpfcd2gdl	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	409	nxy3pa5d5ntp	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 06:25:33.744252+00	2026-08-02 07:23:45.935557+00	k4wo6r5zbe67	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	406	d6dnjwufwxwy	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-01 15:01:31.531535+00	2026-08-02 07:53:08.825959+00	xdgvtol5cert	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	410	zldjpxkhadlh	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 07:23:45.95312+00	2026-08-02 08:24:14.094171+00	nxy3pa5d5ntp	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	411	hrdpd6e5fmm7	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 07:53:08.839456+00	2026-08-02 08:51:06.868954+00	d6dnjwufwxwy	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	414	dqkorppjlfg4	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 08:56:54.23984+00	2026-08-02 09:54:57.568433+00	\N	59194506-4734-4a94-94f9-cc23d7c277ea
00000000-0000-0000-0000-000000000000	415	62wsvxgkzzgc	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-02 09:54:57.585325+00	2026-08-02 09:54:57.585325+00	dqkorppjlfg4	59194506-4734-4a94-94f9-cc23d7c277ea
00000000-0000-0000-0000-000000000000	413	nzv4ve7jul7b	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 08:51:06.881818+00	2026-08-02 10:14:48.43394+00	hrdpd6e5fmm7	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	416	bqirothbiz2o	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 10:14:48.445854+00	2026-08-02 11:14:32.985217+00	nzv4ve7jul7b	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	418	u4m7rjlkgvht	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 11:14:32.99418+00	2026-08-02 12:51:14.84887+00	bqirothbiz2o	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	412	otmi3cdoet77	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 08:24:14.106389+00	2026-08-02 13:03:05.362703+00	zldjpxkhadlh	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	420	wc3a5rgjhv6r	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 12:52:59.854365+00	2026-08-02 15:28:52.305325+00	\N	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	393	l6qrkyq2quna	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-29 10:53:51.288553+00	2026-08-03 06:07:06.367455+00	4kqoq2bp34ut	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	422	vubvs4waj5vv	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 13:03:38.04167+00	2026-08-03 06:21:56.527245+00	\N	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	421	wwbpxnbkv3bo	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 13:03:05.373196+00	2026-08-03 06:21:59.700653+00	otmi3cdoet77	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	423	2bdnkz2wogw5	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 15:28:52.317829+00	2026-08-03 07:35:39.393644+00	wc3a5rgjhv6r	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	419	eucb7nqrcyf5	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 12:51:14.866184+00	2026-08-03 07:38:29.970795+00	u4m7rjlkgvht	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	429	2bbgcq4gmrcb	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-03 07:38:29.97969+00	2026-08-03 07:38:29.97969+00	eucb7nqrcyf5	bf26c995-6f22-4087-b1bc-543137eaac5c
00000000-0000-0000-0000-000000000000	417	vehacnrfy2rv	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-02 10:45:06.497364+00	2026-08-03 08:17:07.308668+00	\N	ef9f4808-0648-4c2e-8445-fe944da726e3
00000000-0000-0000-0000-000000000000	430	vxkf5zzmsoho	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-03 08:17:07.322488+00	2026-08-03 08:17:07.322488+00	vehacnrfy2rv	ef9f4808-0648-4c2e-8445-fe944da726e3
00000000-0000-0000-0000-000000000000	428	hzl32fc7i6ni	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 07:35:39.403286+00	2026-08-03 09:03:54.670877+00	2bdnkz2wogw5	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	431	grj2ivlgvnfu	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 09:03:54.687682+00	2026-08-03 10:20:43.745036+00	hzl32fc7i6ni	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	426	kxpnq7hqpl3x	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:21:59.706672+00	2026-08-03 11:22:50.885156+00	wwbpxnbkv3bo	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	425	nrqpiv2qtpng	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:21:56.544139+00	2026-08-03 11:23:54.300227+00	vubvs4waj5vv	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	424	fkrhygs65sos	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-03 06:07:06.388497+00	2026-08-03 11:32:30.010468+00	l6qrkyq2quna	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	436	ihncblxigqtx	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-03 11:32:30.021009+00	2026-08-03 12:30:30.72588+00	fkrhygs65sos	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	433	c22mdxnrbqmx	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 10:20:43.769165+00	2026-08-03 12:33:24.8074+00	grj2ivlgvnfu	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	435	psopt7bjfnfi	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 11:23:54.301303+00	2026-08-03 13:34:27.593752+00	nrqpiv2qtpng	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	434	tcqvcmawc3no	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 11:22:50.889836+00	2026-08-03 13:36:57.10838+00	kxpnq7hqpl3x	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	440	b74qlb7p2seh	445bc65d-256f-48d3-9367-464a408e657b	f	2026-08-03 13:36:57.113699+00	2026-08-03 13:36:57.113699+00	tcqvcmawc3no	5b601af7-d03f-4de6-85e3-597dac4efdc7
00000000-0000-0000-0000-000000000000	438	xbfwmhowlakj	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 12:33:24.817401+00	2026-08-03 14:19:45.443883+00	c22mdxnrbqmx	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	439	ma43wrvl3esy	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 13:34:27.608757+00	2026-08-04 06:44:37.276179+00	psopt7bjfnfi	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	437	bdebts5vhi2c	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-03 12:30:30.748297+00	2026-08-04 11:28:50.265995+00	ihncblxigqtx	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	453	fnyt7ijoxnkt	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 10:48:43.708288+00	2026-08-04 11:47:43.798494+00	wic456nrcfdk	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	454	5jgtfh76dqej	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 10:51:40.408688+00	2026-08-04 11:50:18.757086+00	w4isz4do4umn	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	455	t7qbvrgyxtn5	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-04 11:28:50.281474+00	2026-08-04 12:27:06.873011+00	bdebts5vhi2c	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	442	vobt3fxoy4j4	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 14:19:45.456943+00	2026-08-04 06:57:51.700512+00	xbfwmhowlakj	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	456	xhtuvvm3xqnl	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 11:40:43.508842+00	2026-08-04 12:39:43.735206+00	cm3ukyqzx2ue	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	445	omhz73tkp7cn	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 07:28:09.902805+00	2026-08-04 08:26:37.989369+00	\N	0f043215-a780-435e-ad80-95dd3108b415
00000000-0000-0000-0000-000000000000	446	sg7yu4i2oaa7	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-04 08:26:38.005154+00	2026-08-04 08:26:38.005154+00	omhz73tkp7cn	0f043215-a780-435e-ad80-95dd3108b415
00000000-0000-0000-0000-000000000000	444	zxdyqlwoarjj	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 06:57:51.707892+00	2026-08-04 08:49:30.472299+00	vobt3fxoy4j4	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	457	64z4jrohyuai	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 11:47:43.811949+00	2026-08-04 12:46:43.779587+00	fnyt7ijoxnkt	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	447	f72wrzl2fxfo	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 08:45:39.458211+00	2026-08-04 09:44:02.811021+00	kxrjgjeyxlon	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	448	sdpzy2xwaq4w	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 08:49:30.481005+00	2026-08-04 09:49:42.622377+00	zxdyqlwoarjj	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	458	cjh2ah2fxdxq	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 11:50:18.765005+00	2026-08-04 12:49:26.938615+00	5jgtfh76dqej	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	449	v4chvcgnlq57	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 09:44:02.829692+00	2026-08-04 10:42:43.853005+00	f72wrzl2fxfo	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	460	rox4r4olj5h4	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 12:39:43.742362+00	2026-08-04 13:37:54.627299+00	xhtuvvm3xqnl	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	450	wic456nrcfdk	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 09:49:42.629358+00	2026-08-04 10:48:43.703535+00	sdpzy2xwaq4w	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	443	w4isz4do4umn	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 06:44:37.297445+00	2026-08-04 10:51:40.397312+00	ma43wrvl3esy	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	451	cm3ukyqzx2ue	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 10:42:43.867234+00	2026-08-04 11:40:43.489087+00	v4chvcgnlq57	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	461	6fg6bencn6tf	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 12:46:43.7972+00	2026-08-04 13:45:43.712755+00	64z4jrohyuai	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	462	lsgq2y27elgf	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 12:49:26.94687+00	2026-08-04 13:48:26.922966+00	cjh2ah2fxdxq	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	463	o3pea347qhwn	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 13:37:54.646751+00	2026-08-04 14:36:09.279658+00	rox4r4olj5h4	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	464	g7p6sempri2z	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 13:45:43.724454+00	2026-08-04 14:44:21.878154+00	6fg6bencn6tf	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	466	sncvzrtnrgjy	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 13:48:26.929144+00	2026-08-04 14:47:26.944964+00	lsgq2y27elgf	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	467	abfqqf74hkwv	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 14:36:09.29539+00	2026-08-04 15:34:17.685747+00	o3pea347qhwn	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	468	3u4sw3vfsh5b	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 14:44:21.889026+00	2026-08-04 15:43:43.703524+00	g7p6sempri2z	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	469	rx3q7j5fe6i5	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 14:47:26.950846+00	2026-08-04 15:46:27.020595+00	sncvzrtnrgjy	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	470	kcffohfdlnbd	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 15:34:17.706433+00	2026-08-04 16:33:43.739219+00	abfqqf74hkwv	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	471	w5nuf73xs43t	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 15:43:43.715589+00	2026-08-04 16:42:43.625416+00	3u4sw3vfsh5b	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	472	x5mqoksfmilp	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 15:46:27.030734+00	2026-08-04 16:45:27.067927+00	rx3q7j5fe6i5	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	473	ts3xe6oxchow	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 16:33:43.755691+00	2026-08-04 17:32:43.847599+00	kcffohfdlnbd	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	475	ib33aikcf2t5	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 16:45:27.075482+00	2026-08-04 17:44:27.162895+00	x5mqoksfmilp	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	477	pdx7dj47gxrk	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 17:44:27.171706+00	2026-08-04 18:43:27.259632+00	ib33aikcf2t5	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	478	cgbirtc6cotb	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 18:43:27.277509+00	2026-08-04 19:42:27.302376+00	pdx7dj47gxrk	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	479	pmk7pbmpcsls	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 19:42:27.321969+00	2026-08-04 20:41:27.405319+00	cgbirtc6cotb	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	480	nt7obngsopwm	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 20:41:27.423235+00	2026-08-04 21:40:27.570502+00	pmk7pbmpcsls	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	481	xd364amk4ypx	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 21:40:27.586485+00	2026-08-04 22:39:27.559138+00	nt7obngsopwm	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	482	x7lwsmo65ppu	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 22:39:27.574082+00	2026-08-04 23:38:27.441706+00	xd364amk4ypx	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	483	xgalehmyn6a6	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-04 23:38:27.461239+00	2026-08-05 00:37:27.592282+00	x7lwsmo65ppu	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	484	asjuyci5dk26	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 00:37:27.610862+00	2026-08-05 01:36:27.677835+00	xgalehmyn6a6	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	485	ipro22yewxva	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 01:36:27.688109+00	2026-08-05 02:35:27.831139+00	asjuyci5dk26	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	486	evytmxtdxxzl	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 02:35:27.848127+00	2026-08-05 03:34:27.718128+00	ipro22yewxva	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	487	k4ikzwbsx7ca	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 03:34:27.730274+00	2026-08-05 04:33:28.14295+00	evytmxtdxxzl	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	488	ux6fmk4qj2bz	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 04:33:28.157434+00	2026-08-05 05:32:27.834068+00	k4ikzwbsx7ca	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	489	74cewbzctv2g	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 05:32:27.848044+00	2026-08-05 06:31:27.932401+00	ux6fmk4qj2bz	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	474	mwoxnooup6as	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 16:42:43.634795+00	2026-08-05 07:03:43.110971+00	w5nuf73xs43t	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	476	ri4acwlv7bfh	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-04 17:32:43.868899+00	2026-08-05 07:03:43.111028+00	ts3xe6oxchow	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	490	b7zq7dwj643x	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 06:31:27.949728+00	2026-08-05 07:30:27.796154+00	74cewbzctv2g	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	493	jtabjwvgyk6j	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 07:30:27.810738+00	2026-08-05 08:29:27.94903+00	b7zq7dwj643x	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	459	h4r4pxrkscmf	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-04 12:27:06.893316+00	2026-08-05 09:36:14.784991+00	t7qbvrgyxtn5	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	491	hqasdx6pl5ll	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 07:03:43.132028+00	2026-08-05 11:08:22.148593+00	ri4acwlv7bfh	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	492	b7nm4bylekec	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 07:03:43.128432+00	2026-08-05 11:08:25.367637+00	mwoxnooup6as	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	494	mzuzpu5e7zg3	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 08:29:27.97273+00	2026-08-05 09:28:28.018135+00	jtabjwvgyk6j	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	495	deqhkpikxvzj	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 09:28:28.027055+00	2026-08-05 10:27:28.059351+00	mzuzpu5e7zg3	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	496	k5gcyvd4btup	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-05 09:36:14.796308+00	2026-08-05 10:34:42.565941+00	h4r4pxrkscmf	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	497	jphi4xqdvd37	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 10:27:28.074867+00	2026-08-05 11:26:28.197874+00	deqhkpikxvzj	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	498	x2w6tzsw2ror	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-05 10:34:42.576766+00	2026-08-05 11:32:42.733364+00	k5gcyvd4btup	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	502	ejhk5gz2unxo	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 11:26:28.216914+00	2026-08-05 12:25:28.110966+00	jphi4xqdvd37	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	503	bwm72jbtp7yd	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-05 11:32:42.743702+00	2026-08-05 12:30:43.318207+00	x2w6tzsw2ror	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	505	yjemgpuvxdal	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	2026-08-05 12:30:43.324687+00	2026-08-05 12:30:43.324687+00	bwm72jbtp7yd	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	504	ztwbs67mdtra	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 12:25:28.122983+00	2026-08-05 13:24:24.864738+00	ejhk5gz2unxo	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	506	yhvfxeqjhm7e	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 13:24:24.880175+00	2026-08-05 14:23:28.231687+00	ztwbs67mdtra	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	507	vyc3qve32fky	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 14:23:28.249491+00	2026-08-05 15:22:28.339614+00	yhvfxeqjhm7e	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	508	6fdtaiovrgya	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 15:22:28.35687+00	2026-08-05 16:21:28.783453+00	vyc3qve32fky	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	509	ecttv54xbhhi	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 16:21:28.803267+00	2026-08-05 17:20:28.534195+00	6fdtaiovrgya	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	500	aejzq3mrrgts	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 11:08:22.169927+00	2026-08-05 17:39:14.730045+00	hqasdx6pl5ll	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	501	mwefxt67ocvp	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 11:08:25.368082+00	2026-08-05 17:39:14.730166+00	b7nm4bylekec	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	510	ypsjemvxqos5	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 17:20:28.553425+00	2026-08-05 18:19:28.374912+00	ecttv54xbhhi	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	511	d6qlzlne7kof	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 17:39:14.745454+00	2026-08-05 18:54:58.595767+00	mwefxt67ocvp	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	512	gzj7zkv67xtx	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 17:39:14.745527+00	2026-08-05 18:54:58.595416+00	aejzq3mrrgts	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	513	32gf6yj6k7ra	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 18:19:28.390619+00	2026-08-05 19:18:28.446557+00	ypsjemvxqos5	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	515	gjh46cf5ffgj	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 18:54:58.617965+00	2026-08-05 19:54:03.341035+00	d6qlzlne7kof	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	514	daor4lejnts7	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 18:54:58.616795+00	2026-08-05 19:54:03.340826+00	gzj7zkv67xtx	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	516	kqepqmtum32q	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 19:18:28.464753+00	2026-08-05 20:17:28.631699+00	32gf6yj6k7ra	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	518	6ousy6xigeoq	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 19:54:03.363689+00	2026-08-05 20:53:03.37926+00	daor4lejnts7	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	517	xfdcmvnzngsj	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 19:54:03.363676+00	2026-08-05 20:53:03.37868+00	gjh46cf5ffgj	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	519	lesnotung4ld	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 20:17:28.636169+00	2026-08-05 21:16:28.567967+00	kqepqmtum32q	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	521	cpblngmsq6xd	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 20:53:03.400813+00	2026-08-05 21:52:03.253625+00	6ousy6xigeoq	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	520	2q34odxczb7k	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 20:53:03.400831+00	2026-08-05 21:52:03.253071+00	xfdcmvnzngsj	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	522	zxo3hmfs5ank	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 21:16:28.590337+00	2026-08-05 22:15:28.620803+00	lesnotung4ld	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	523	zpackqghdm3a	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 21:52:03.272082+00	2026-08-05 22:51:03.88856+00	2q34odxczb7k	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	524	ej6cjxefws6u	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 21:52:03.269693+00	2026-08-05 22:51:03.88798+00	cpblngmsq6xd	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	528	ohzrdux5csjz	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-05 23:06:08.446672+00	2026-08-05 23:06:08.446672+00	\N	39b45c3f-092d-435f-bce3-efbcb7291b77
00000000-0000-0000-0000-000000000000	525	5erpn577wdl6	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 22:15:28.639988+00	2026-08-05 23:14:28.6414+00	zxo3hmfs5ank	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	527	rv5hjet257v6	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 22:51:03.908479+00	2026-08-05 23:50:03.29216+00	zpackqghdm3a	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	526	dvbgdgmdsxdl	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-05 22:51:03.908488+00	2026-08-05 23:50:03.291629+00	ej6cjxefws6u	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	530	xdf237khmqow	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-05 23:50:03.321723+00	2026-08-05 23:50:03.321723+00	rv5hjet257v6	33e641d9-0ffc-42cc-ad73-381d336ac129
00000000-0000-0000-0000-000000000000	531	tmxby5mzwe4q	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-05 23:50:03.321703+00	2026-08-05 23:50:03.321703+00	dvbgdgmdsxdl	ba8bb428-473f-4332-81d0-823bf4f2eb2e
00000000-0000-0000-0000-000000000000	529	46f7tbpeuuaw	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-05 23:14:28.651247+00	2026-08-06 00:13:29.026956+00	5erpn577wdl6	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	532	whk66o3x3i7f	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-06 00:13:29.044646+00	2026-08-06 01:12:28.841187+00	46f7tbpeuuaw	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	533	cviocchaoikn	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-06 01:12:28.857544+00	2026-08-06 02:11:28.806404+00	whk66o3x3i7f	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	534	3dri4r6kekwf	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-06 02:11:28.822159+00	2026-08-06 03:10:28.85254+00	cviocchaoikn	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	535	4hwdlkb262de	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-06 03:10:28.8658+00	2026-08-06 04:09:28.885671+00	3dri4r6kekwf	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
00000000-0000-0000-0000-000000000000	536	aghox3t6divq	445bc65d-256f-48d3-9367-464a408e657b	f	2026-08-06 04:09:28.897727+00	2026-08-06 04:09:28.897727+00	4hwdlkb262de	9b2f1dbe-03b4-453f-a04e-cb7568a0aa75
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
20260625000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
9b2f1dbe-03b4-453f-a04e-cb7568a0aa75	445bc65d-256f-48d3-9367-464a408e657b	2026-08-02 13:03:38.033002+00	2026-08-06 04:09:28.915573+00	\N	aal1	\N	2026-08-06 04:09:28.915474	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	86.108.21.228	\N	\N	\N	\N	\N
d9a803fd-4083-44f7-bef8-9fc3bce694b4	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-07-29 09:04:55.935194+00	2026-07-29 09:04:55.935194+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.21.188	\N	\N	\N	\N	\N
59194506-4734-4a94-94f9-cc23d7c277ea	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-02 08:56:54.215735+00	2026-08-02 09:54:57.609176+00	\N	aal1	\N	2026-08-02 09:54:57.609064	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Claude/1.24012.9 Chrome/148.0.7778.280 Electron/42.7.0 Safari/537.36 MSIX	86.108.21.228	\N	\N	\N	\N	\N
dd3bf543-408e-452e-94ff-ccf18a1fcc01	445bc65d-256f-48d3-9367-464a408e657b	2026-07-26 07:28:27.17314+00	2026-07-27 09:04:09.706662+00	\N	aal1	\N	2026-07-27 09:04:09.706559	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	176.29.155.25	\N	\N	\N	\N	\N
554d0cce-c668-4fc1-96e0-aeea4964cad8	445bc65d-256f-48d3-9367-464a408e657b	2026-07-26 07:29:26.726499+00	2026-07-26 07:29:26.726499+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.21.188	\N	\N	\N	\N	\N
5b601af7-d03f-4de6-85e3-597dac4efdc7	445bc65d-256f-48d3-9367-464a408e657b	2026-07-26 08:09:21.594816+00	2026-08-03 13:36:57.131138+00	\N	aal1	\N	2026-08-03 13:36:57.131031	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	86.108.21.228	\N	\N	\N	\N	\N
1215717f-92b0-4f5e-ab78-ba455494a244	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-07-26 07:47:02.375051+00	2026-07-26 07:47:02.375051+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.21.188	\N	\N	\N	\N	\N
0f043215-a780-435e-ad80-95dd3108b415	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-04 07:28:09.887717+00	2026-08-04 08:26:38.027427+00	\N	aal1	\N	2026-08-04 08:26:38.027315	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.21.228	\N	\N	\N	\N	\N
bf26c995-6f22-4087-b1bc-543137eaac5c	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-07-23 13:46:48.944842+00	2026-08-03 07:38:29.995561+00	\N	aal1	\N	2026-08-03 07:38:29.99546	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.21.228	\N	\N	\N	\N	\N
ef9f4808-0648-4c2e-8445-fe944da726e3	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-02 10:45:06.463354+00	2026-08-03 08:17:07.343801+00	\N	aal1	\N	2026-08-03 08:17:07.343684	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.21.228	\N	\N	\N	\N	\N
bb4d963b-0fbf-4987-ac7b-25046f553eb0	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	2026-07-26 09:35:23.061376+00	2026-08-05 12:30:43.340972+00	\N	aal1	\N	2026-08-05 12:30:43.340822	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.23.104	\N	\N	\N	\N	\N
39b45c3f-092d-435f-bce3-efbcb7291b77	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-05 23:06:08.41332+00	2026-08-05 23:06:08.41332+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 26_5_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/151.0.7922.57 Mobile/15E148 Safari/604.1	91.186.248.131	\N	\N	\N	\N	\N
ba8bb428-473f-4332-81d0-823bf4f2eb2e	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-07-23 14:45:06.101836+00	2026-08-05 23:50:03.354981+00	\N	aal1	\N	2026-08-05 23:50:03.354874	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.16.40	\N	\N	\N	\N	\N
33e641d9-0ffc-42cc-ad73-381d336ac129	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-02 12:52:59.839333+00	2026-08-05 23:50:03.376804+00	\N	aal1	\N	2026-08-05 23:50:03.376689	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.16.40	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	6f484e98-e110-4ceb-8070-e61810c5f108	authenticated	authenticated	hmest121981@gmail.com	$2a$10$cswVSqKwOlj9ZePnOwu0mOrCQw.aKIVszm5jz8JFeTYNTCkQCzv6i	2026-07-23 13:50:50.499033+00	\N		\N		\N			\N	2026-08-05 10:40:45.03815+00	{"provider": "email", "providers": ["email"]}	{"sub": "6f484e98-e110-4ceb-8070-e61810c5f108", "email": "hmest121981@gmail.com", "full_name": "Eng. Ahlam Alyamani", "email_verified": true, "phone_verified": false}	\N	2026-07-23 13:50:50.460703+00	2026-08-05 10:40:45.061351+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	445bc65d-256f-48d3-9367-464a408e657b	authenticated	authenticated	hmest19811@gmail.com	$2a$06$c5UtrCnK6voqm8quZtzUV.oJI50h6.e8va7ovkmSt8y7D.EOHAGjC	2026-05-14 08:52:11.008535+00	\N		\N		2026-07-26 07:16:36.112426+00			\N	2026-08-02 13:03:38.032876+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-05-14 08:52:10.987135+00	2026-08-06 04:09:28.905517+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	authenticated	authenticated	hmest1969@gmail.com	$2a$10$xOcTVCdJlssGGoyPoF.2ueG.WSKTYZOV.e6fg4qox/fqfLbqcCNrq	2026-07-23 13:35:58.478749+00	\N		\N		\N			\N	2026-07-26 09:35:23.058149+00	{"provider": "email", "providers": ["email"]}	{"sub": "65ce1c8f-6151-402a-8bcd-4270b3cf6d0a", "email": "hmest1969@gmail.com", "full_name": "Dr.Ahmad tannerah", "email_verified": true, "phone_verified": false}	\N	2026-07-23 13:35:58.417249+00	2026-08-05 12:30:43.328227+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ee095348-a2de-4906-a078-0e8a3f3560a9	authenticated	authenticated	o.alawy.oa@gmail.com	$2a$06$7NtFUAULFUU6tQEmJJGtAeHNSV13DaBM1jWuXE2OVXVJWOMPGC6Jm	2026-05-14 08:04:06.72541+00	\N		\N		2026-07-13 18:58:51.966934+00			\N	2026-08-05 23:06:08.411414+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-05-14 08:04:06.685428+00	2026-08-05 23:50:03.337712+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_logs (id, user_id, user_name, action, target_type, target_id, target_number, metadata, created_at) FROM stdin;
513925b9-7d27-4d14-9d4a-5fd506a79541	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	\N	\N	2026-07-28 09:32:37.782666+00
6b1c5718-ea7b-4ccf-966e-c36cbd71d38a	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0024	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	QT-2026-0024	\N	2026-07-28 09:33:35.019683+00
03b55bd5-b2a9-4499-a7f6-471948850c48	6f484e98-e110-4ceb-8070-e61810c5f108	Eng. Ahlam Alyamani	أنشأ عرض سعر جديد 	quote	219269a5-5fdf-4a4a-ad24-5551d478bc55	\N	\N	2026-07-28 14:07:07.314661+00
cc36557e-be45-4c78-a47e-8ed9a6c109bf	6f484e98-e110-4ceb-8070-e61810c5f108	Eng. Ahlam Alyamani	أنشأ عرض سعر جديد 	quote	95edd244-8e7a-47ce-9210-d8d3595a72fb	\N	\N	2026-07-29 10:01:04.528671+00
f9ebc682-ebc7-469a-a04d-327c231ad05b	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	\N	\N	2026-07-29 11:01:49.658016+00
ec89b598-1a30-416c-8168-cd30b86a5612	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0027	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	\N	2026-07-29 11:02:46.475589+00
6dd2494e-2e8c-4946-a69d-d72775139b98	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0027	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	\N	2026-07-29 11:03:44.023845+00
c5d7339c-8d08-477e-836b-0bed55cc7d83	6f484e98-e110-4ceb-8070-e61810c5f108	Eng. Ahlam Alyamani	عدّل عرض السعر QT-2026-0022	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-07-29 11:37:58.321408+00
85694cc7-13fc-45f3-ab5d-c02082b6827b	ee095348-a2de-4906-a078-0e8a3f3560a9	Osama Alawy	عدّل عرض السعر QT-2026-0011	quote	f61ede0a-f287-4823-9f93-08362eae21f2	QT-2026-0011	\N	2026-07-30 11:28:40.577021+00
64de92b8-4261-44dd-afb9-c0596d93cdf7	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0026	quote	95edd244-8e7a-47ce-9210-d8d3595a72fb	QT-2026-0026	\N	2026-08-01 11:56:42.318433+00
46ef395a-a32c-45fb-8448-4c82c800cb2b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0026	quote	95edd244-8e7a-47ce-9210-d8d3595a72fb	QT-2026-0026	\N	2026-08-01 11:56:52.871469+00
4c5ac6ba-f747-4fff-8eb4-6e8420c69085	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0022 إلى "محوّل لطلب"	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-01 11:58:05.909965+00
09f47042-4bc0-45b1-87be-8aeb4bf60dd8	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0022	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-01 11:58:42.883186+00
1beea225-659e-438f-8a7d-257cdf6a52b3	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0022 إلى "محوّل لطلب"	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-01 11:58:51.098458+00
fca9f0b4-5a6a-4b1d-9997-0a962ad99e2b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0022 إلى "قيد الدراسة"	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-01 11:59:25.104042+00
d00ba129-d68b-4682-afb9-2e15f92725de	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0023 إلى "محوّل لطلب"	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	QT-2026-0023	\N	2026-08-01 12:00:24.027148+00
d242c8b7-2b81-4d9a-a1a7-fb6560b36224	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0023 إلى "قيد الدراسة"	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	QT-2026-0023	\N	2026-08-01 12:00:35.13917+00
3041e742-70c9-4e94-9f71-a098e51b9350	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0022 إلى "قيد الدراسة"	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-01 12:00:57.168725+00
a1bc80e9-a58c-40b8-8ce5-661c40dbe5e9	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف الطلبية ORD-2026-006	order	b0d92d73-2ef5-4346-8770-02413e9fd80c	ORD-2026-006	\N	2026-08-01 12:01:13.199966+00
052950a7-cda9-4b1a-ac21-13a872f06636	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0022 إلى "محوّل لطلب"	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-01 12:01:20.54567+00
d1a1b50c-e37b-4154-acd9-d96beb76932c	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0022 إلى "قيد الدراسة"	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-01 12:01:27.935305+00
bdfaa055-3181-4b5f-97bb-c1740db14ff5	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	\N	\N	2026-08-01 15:50:38.641324+00
5ab0eb39-798a-4863-8340-93d9512a7f63	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0028	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-01 15:53:44.444649+00
c987e999-4a09-4148-8fbd-a90a8ae167d5	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أضاف عميلاً جديداً: شركة المناصير لتكنولوجيا المعلومات (#C-0009)	customer	98c85065-5320-477e-b78c-83ad9270728a	شركة المناصير لتكنولوجيا المعلومات	\N	2026-08-01 16:27:39.269222+00
420460a2-5b58-409d-b2aa-e84f501393f4	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0028	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-01 16:27:44.979206+00
7b8f02cf-d0d7-46a7-bd64-cc42288ef9f0	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0028	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-01 16:28:07.113007+00
b6ee26e2-12c8-4efb-bf67-4c19db691390	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0028	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-01 16:29:03.456514+00
844ce686-ad43-422e-bdea-99d0c73284c8	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أنشأ عرض سعر جديد 	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	\N	\N	2026-08-02 06:27:25.568105+00
f19677a5-059e-4498-a1d2-3f674969749b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أنشأ عرض سعر جديد 	quote	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	\N	\N	2026-08-02 06:33:16.795245+00
78322304-bfa5-4355-90c7-bb57ddbe6678	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أنشأ عرض سعر جديد 	quote	0877fc34-9ecb-4956-9fbe-8818861c219c	\N	\N	2026-08-02 06:38:14.534186+00
7ca67c9a-980e-464e-8982-c87a3f69ade1	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0031 إلى "مرفوض"	quote	0877fc34-9ecb-4956-9fbe-8818861c219c	QT-2026-0031	\N	2026-08-02 06:45:08.121571+00
60eaabaf-ea92-456c-85b8-a5653105d1a5	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0030 إلى "مرفوض"	quote	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	QT-2026-0030	\N	2026-08-02 06:45:13.193344+00
e0307063-6a51-4e29-8d13-cbe3ff42c743	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أضاف عميلاً جديداً: مدارس عمان الاهلية (#C-0010)	customer	cf5c4b24-cf21-4602-b569-5f069d914ee5	مدارس عمان الاهلية	\N	2026-08-02 06:46:37.772971+00
cf192e7c-abe3-48a7-9627-5c3705e4d64a	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0024	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	QT-2026-0024	\N	2026-08-02 06:47:03.452663+00
47dfb0ce-8deb-4350-a782-920fc64ba176	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0027	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	\N	2026-08-02 06:47:13.595835+00
a7cdd245-0c3c-4cbe-bbdf-01e208d92bfb	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0021	quote	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	QT-2026-0021	\N	2026-08-02 06:47:23.255651+00
1dd5da7f-26eb-41e4-a68b-c262ff7b7859	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0007	quote	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	QT-2026-0007	\N	2026-08-02 06:48:14.678364+00
0e2a3449-bc63-4fc1-9e04-1ce66e7783a1	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0004	quote	c22be163-9877-485c-8053-e3dfbf094862	QT-2026-0004	\N	2026-08-02 06:48:18.134868+00
d048806a-710a-4a1c-8ced-bd51a7b63b1d	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0003	quote	deb11bf4-fad8-4379-a302-25be8454c7b3	QT-2026-0003	\N	2026-08-02 06:48:22.801579+00
14e3f8d7-8e7d-4a6b-abda-a9e80278b423	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0001	quote	c2ece74c-a5df-4ea3-9907-e54b2e5567ad	QT-2026-0001	\N	2026-08-02 06:48:28.043561+00
b1f9d628-4dd7-48d4-89de-d2150d487373	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0021 إلى "قيد الدراسة"	quote	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	QT-2026-0021	\N	2026-08-02 06:48:40.059857+00
76b4c735-9251-4289-b665-a747ccc600c4	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0024 إلى "قيد الدراسة"	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	QT-2026-0024	\N	2026-08-02 06:48:46.37942+00
777b53e9-5688-4f7c-8521-001abd56eaeb	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0031	quote	0877fc34-9ecb-4956-9fbe-8818861c219c	QT-2026-0031	\N	2026-08-02 06:49:18.07141+00
841d9923-bba5-43dc-a94f-c3ceace8bf90	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0030	quote	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	QT-2026-0030	\N	2026-08-02 06:49:21.96927+00
0d4f47ee-85fa-4e21-b95f-71218cf15f85	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0027 إلى "قيد الدراسة"	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	\N	2026-08-02 06:49:26.183252+00
ea9a0598-2470-4833-ac08-b2700b32ae7b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0001	quote	c2ece74c-a5df-4ea3-9907-e54b2e5567ad	QT-2026-0001	\N	2026-08-02 08:05:12.18481+00
076cd54b-66a8-4e2f-8966-6d97c7fd8a54	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0028	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-02 08:09:22.106323+00
3f8aced6-ec39-42e9-b692-0bef65ea20e5	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0011	quote	f61ede0a-f287-4823-9f93-08362eae21f2	QT-2026-0011	\N	2026-08-02 08:19:52.624441+00
72239424-17e8-4270-9751-d7752d82a3be	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0029 إلى "محوّل لطلب"	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 10:15:17.990366+00
ee104fb5-bfd9-4e16-a110-94867d9e9c49	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0029 إلى "قيد الدراسة"	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 10:15:39.396687+00
68989077-df5e-404b-8525-fb143ff9e242	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	حوّل العرض QT-2026-0029 إلى الطلبية ORD-2026-008	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 10:18:23.739816+00
043cad3c-e3df-4737-b6a5-0872bd90b235	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0029 إلى "قيد الدراسة"	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 10:45:22.222938+00
dc90654c-bf2c-4875-9c9a-ddbed086dfab	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	حذف الطلبية ORD-2026-008	order	7289f44e-bb8d-46a7-baa2-2116206444e7	ORD-2026-008	\N	2026-08-02 10:58:23.042719+00
22433240-16dc-47f0-8f59-ece79b786f18	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	حوّل العرض QT-2026-0029 إلى الطلبية ORD-2026-009	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 10:58:30.469536+00
ed75c186-4ebb-4cc1-8715-d1dd97b526a4	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0029 إلى "قيد الدراسة"	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 10:58:41.137515+00
208a9bfb-b6e4-4cdb-b3d5-0c720ccfb2fa	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حوّل العرض QT-2026-0029 إلى الطلبية ORD-2026-010	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 13:06:23.820174+00
84e7ffea-3d93-4d6f-bc2f-70ff78c0e7e4	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف الطلبية ORD-2026-010	order	2d927f9b-f0be-481d-87f1-2134f4da1bee	ORD-2026-010	\N	2026-08-02 13:07:19.334559+00
1f9c2931-ab47-4e98-989f-ffd9eee499dd	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0029 إلى "قيد الدراسة"	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-02 13:07:30.77691+00
7cc2176e-5ebc-45b2-b1bf-a31196b35d8d	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0031 — التاخر في ارسال عرض السعر للعميل وتم الشراء من مصدر اخر	quote	0877fc34-9ecb-4956-9fbe-8818861c219c	QT-2026-0031	\N	2026-08-02 13:08:23.832923+00
366aca24-f6a7-44ef-97d8-a94ef221ab30	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0030 — التاخر في ارسال عرض السعر للعميل وتم الطلب من مصدر اخر	quote	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	QT-2026-0030	\N	2026-08-02 13:08:55.442299+00
c1f03621-bcdd-498f-ba4a-de1657c58ab1	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	حوّل العرض QT-2026-0028 إلى الطلبية ORD-2026-011	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-02 15:31:28.511975+00
d56c2d3a-2800-40c2-bdc5-cdc633c01bf8	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0028 إلى "قيد الدراسة"	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-02 15:31:50.3843+00
3bc1deb9-e5b1-4265-99a2-a1a9dfbee603	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	50143d1a-360b-484f-8d5a-23172401aa7d	\N	\N	2026-08-03 06:12:58.350148+00
a9c81bb4-330b-4d78-86b4-0419df9f522e	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0032	quote	50143d1a-360b-484f-8d5a-23172401aa7d	QT-2026-0032	\N	2026-08-03 06:15:07.278257+00
ff0d2b6e-976f-429e-ab17-8b0301e32465	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0001 — تم الشراء من جهة اخرى بسبب السعر	quote	c2ece74c-a5df-4ea3-9907-e54b2e5567ad	QT-2026-0001	\N	2026-08-03 06:53:46.807247+00
ff25c308-1071-46c2-9028-36f7cdb8a09f	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0003 — تمت احالة جزئية للعرض والغاء باقي البنود	quote	deb11bf4-fad8-4379-a302-25be8454c7b3	QT-2026-0003	\N	2026-08-03 06:54:14.064832+00
197ced17-f344-4ffb-9ae5-9288ed155a1d	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0004 — تم تقديم العرض لجهة وسيطة ولم يتم احالة العرض	quote	c22be163-9877-485c-8053-e3dfbf094862	QT-2026-0004	\N	2026-08-03 06:54:47.201053+00
bebcb257-f1e0-4c0c-ac62-54dd9df02916	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0007 — تمت احالة كامل الطلبية على المؤسسة ولله الحمد	quote	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	QT-2026-0007	\N	2026-08-03 06:55:05.401854+00
28df7ea5-9eb0-4db2-8b74-9600fd6afbe0	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أضاف عميلاً جديداً: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات (#C-0011)	customer	cd40c449-f543-4142-8804-dcc8838ac95e	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	\N	2026-08-03 07:41:41.506861+00
268c7fa6-8ab1-4147-955b-cc6805fed527	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	\N	\N	2026-08-03 07:46:51.960425+00
949296f9-c9e6-4c29-b262-3312f875dab4	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أضاف صنفاً للكتالوج: Vertical Electric Heating Air Blast Drying Oven 20Lit Model WGL-20BE	catalog	\N	Vertical Electric Heating Air Blast Drying Oven 20Lit Model WGL-20BE	\N	2026-08-03 08:18:27.010568+00
e9a92dce-652c-46f8-8793-32f81fdd8f0a	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أضاف صنفاً للكتالوج: Biological Microscope BIO-001	catalog	\N	Biological Microscope BIO-001	\N	2026-08-03 08:18:38.753358+00
eaa2e19d-49bd-43c8-a916-4d0f24255055	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0033	quote	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	QT-2026-0033	\N	2026-08-03 08:18:54.321304+00
914ce18a-ce9b-4ef9-bbac-ed1b62a14e42	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	\N	\N	2026-08-03 12:42:11.941651+00
6f3c2126-0806-49df-b5c5-502e9e60fbca	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أضاف عميلاً جديداً: شركة سحاب لمواد التجميل  (#C-0012)	customer	739a0229-8e24-4988-9731-58c9c8cd56b6	شركة سحاب لمواد التجميل 	\N	2026-08-03 12:58:24.112205+00
27a5c2c8-44e9-467b-aca1-fb6718fd1a11	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أضاف صنفاً للكتالوج: Disposable Arm Sleeve	catalog	\N	Disposable Arm Sleeve	\N	2026-08-03 13:08:53.868434+00
3158b720-ea84-4ef8-a2ec-3c9867096f98	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أضاف صنفاً للكتالوج: Disposable Head Cover	catalog	\N	Disposable Head Cover	\N	2026-08-03 13:12:05.905805+00
ef986eaf-fcce-4b19-9cf0-c0bbacef24e8	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	\N	\N	2026-08-03 13:12:29.040162+00
6097f7d6-4194-4ada-9108-f175c6afda7b	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0035	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-03 13:13:04.352841+00
a43b5dc3-25dd-4cdd-af73-505673424856	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0035	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-03 13:13:42.980259+00
2a889623-e632-42a6-972d-6b447fb54aa8	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0016 — الادعاء من المصنع بان المطلوب ليس نفس العينة المرسلة علما انه تم ارسال العينة الى مالك الخوالدة لكن تم رفضه من المختبرات	quote	7f415e1f-baf2-412b-b49d-7437453aeb95	QT-2026-0016	\N	2026-08-03 13:41:00.737402+00
4866a96d-d2f1-406a-8650-75a8942b6889	6f484e98-e110-4ceb-8070-e61810c5f108	Eng. Ahlam Alyamani	أنشأ عرض سعر جديد 	quote	505e698c-09ce-4610-8d79-772e36f62ec1	\N	\N	2026-08-03 13:41:04.961029+00
ea653205-c9a9-44a3-844c-7a3bb614b67b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0029 — الادعاء من العميل بان العينات المرسلة غير مطابقة حيث تم طلب ان تكون مدرجة ومفتوحة من الطرفين	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	\N	2026-08-03 13:41:58.227599+00
1980b0b8-b639-4ef6-b82b-c7600a7982e6	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0002 إلى "ملغي"	quote	19276c37-9a91-48b0-af67-f9f8a99e8795	QT-2026-0002	\N	2026-08-03 13:44:59.31522+00
6f7bf8a6-2a3e-43bb-83b9-76a21bc3fa7f	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0002 — تم تحويله الى طلب اخر من المؤسسة بموجب عرض سعر رقم 22/2026	quote	19276c37-9a91-48b0-af67-f9f8a99e8795	QT-2026-0002	\N	2026-08-03 13:45:30.548948+00
f5e9cc3f-be0a-45f0-bc53-85e468930e25	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0036	quote	505e698c-09ce-4610-8d79-772e36f62ec1	QT-2026-0036	\N	2026-08-03 14:14:22.305197+00
6b034002-e73a-44b3-859b-db4cf02c642f	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0022 — تم احالة الطلبية بشكل كلي على المؤسسة ولله الحمد	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	\N	2026-08-03 14:16:53.892843+00
c0753cf9-0179-4290-b140-699549b44730	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	9ac83342-e490-4896-93fb-04fc3f70b0cb	\N	\N	2026-08-04 09:25:46.354346+00
68c291b8-fa5c-468f-83b8-1260e627c17b	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:10:39.436805+00
e8712e79-f36e-472c-bfc1-b8673795008e	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:11:23.655176+00
fb299913-d988-45be-8155-115c19f1c2c3	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:13:00.558065+00
d5912342-3383-479d-8798-9164283db033	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:17:12.462888+00
3bd9a6ea-5517-4547-a9d3-cfc7008a3356	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:20:48.341236+00
15b5b969-ab93-487d-a581-0f97a67b4c4d	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:23:28.572111+00
2c68d5f3-97d3-4b6a-a4a6-937df7f18ee6	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:23:36.269069+00
82b71bef-3b1a-418d-b044-4160ebb6debd	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:23:42.607799+00
3442ecb2-2030-46c4-bf7c-5d9db6771b3f	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:24:03.549798+00
6816ae0f-9c2f-4178-be46-4101c894326e	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:24:21.577598+00
12f7175b-f74c-4a77-a4ac-0cb75250aab1	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 10:26:19.124016+00
b3d4320c-b059-4807-b813-a43557828458	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 11:02:13.961519+00
fb8f0234-a587-42cb-ab26-3cbb60c728af	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 11:05:03.293891+00
33bbce03-b78e-4357-bea4-c561ea95e607	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 11:05:08.915068+00
667e468a-b16e-417b-94aa-71083b3ff003	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0035	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-04 11:08:38.68622+00
b1f8d8fc-bd6d-4a4c-9361-f62ae4813b2d	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0033	quote	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	QT-2026-0033	\N	2026-08-04 11:09:52.954567+00
1fea04a4-e942-4d04-bb01-abf9783bc722	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0028	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	\N	2026-08-04 11:10:24.070528+00
dd9f7fe1-ee82-423c-a3dc-131e9b3f2427	6f484e98-e110-4ceb-8070-e61810c5f108	Eng. Ahlam Alyamani	أنشأ عرض سعر جديد 	quote	e7dec721-47fa-4b65-9d98-6519600bc45d	\N	\N	2026-08-04 11:16:03.556792+00
9d4347c6-c911-43de-8e8d-413231ad1d38	6f484e98-e110-4ceb-8070-e61810c5f108	Eng. Ahlam Alyamani	عدّل عرض السعر QT-2026-0037	quote	e7dec721-47fa-4b65-9d98-6519600bc45d	QT-2026-0037	\N	2026-08-04 11:18:34.727126+00
9f3d011a-bfae-4ab1-92c6-07d41895cb04	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0036 إلى "مُعتمد"	quote	505e698c-09ce-4610-8d79-772e36f62ec1	QT-2026-0036	\N	2026-08-04 11:19:00.411372+00
b5461f44-a800-45e4-814f-0fa3f932eaa0	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0036 إلى "قيد الدراسة"	quote	505e698c-09ce-4610-8d79-772e36f62ec1	QT-2026-0036	\N	2026-08-04 11:19:03.71917+00
76a4fbe5-efa4-4a40-8475-6525d1c32969	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة الطلبية ORD-2026-007 إلى "مُسلَّم"	order	823b33c4-edc2-4922-96e3-ea790aaadc1d	ORD-2026-007	\N	2026-08-04 12:03:03.292641+00
df0dd78d-6a97-43cf-a794-3b3ef69bab91	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف الطلبية ORD-2026-007 — تم تسليم الطلبية للعميل بموجب فاتورة مفوترة رقم 471	order	823b33c4-edc2-4922-96e3-ea790aaadc1d	ORD-2026-007	\N	2026-08-04 12:03:43.642525+00
43a4613c-2844-4060-8c3e-6d8311c60a3f	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	\N	\N	2026-08-04 12:32:46.63073+00
9c52db61-4e60-4365-9ae7-21e825d976a6	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0006 إلى "مُعتمد"	quote	a3215728-2478-4155-b0a2-d4342a61e744	QT-2026-0006	\N	2026-08-04 12:50:16.962202+00
3cf495c4-45a9-4dec-8468-cbe18b506743	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0006 — تم اعتماد الطلب	quote	a3215728-2478-4155-b0a2-d4342a61e744	QT-2026-0006	\N	2026-08-04 12:50:54.140763+00
56c95420-2116-41ea-87dd-64a19b4954f8	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر 2026D-002	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	2026D-002	\N	2026-08-04 12:53:35.516362+00
250abaf0-3827-474f-ac9b-a5b37bd478c1	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف العرض 2026D-001 — السبب: فقط للتجربة	quote	9ac83342-e490-4896-93fb-04fc3f70b0cb	2026D-001	\N	2026-08-04 12:54:04.495206+00
e0b573dd-01b1-4ac8-9891-53ea506752ea	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0034 إلى "تم إصدار فاتورة"	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-04 13:01:35.598115+00
6bc1fe9a-c93d-43b1-aeb4-18412cfd24e5	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0034 إلى "قيد الدراسة"	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-04 13:01:52.565321+00
6955734a-50e2-4fca-98f5-07846c747610	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0034 إلى "مُعتمد"	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-04 13:01:57.984653+00
5ae69e7f-3418-4ff8-9515-abbd451013ee	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0034 إلى "تم إصدار فاتورة"	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-04 13:02:01.322254+00
3f47818b-8552-4d55-b517-d4925e258937	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0034 إلى "قيد الدراسة"	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-04 13:02:05.791819+00
07734837-7c33-4ae0-bd6e-9b89f7a254b9	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0038 إلى "مُعتمد"	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0038	\N	2026-08-04 13:04:42.0032+00
1532554e-3e73-45ec-8f65-af8a85aa2c25	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0038 إلى "قيد الدراسة"	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0038	\N	2026-08-04 13:04:45.853201+00
a917cb24-d105-4509-8a78-aaff7bb9959f	6f484e98-e110-4ceb-8070-e61810c5f108	Eng. Ahlam Alyamani	عدّل عرض السعر QT-2026-0037	quote	e7dec721-47fa-4b65-9d98-6519600bc45d	QT-2026-0037	\N	2026-08-04 13:47:54.871077+00
abacb805-3aad-465f-a61f-ee247ccbdc0a	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل الطلبية ORD-2026-007	order	823b33c4-edc2-4922-96e3-ea790aaadc1d	ORD-2026-007	\N	2026-08-04 15:09:32.201112+00
5cdbea1e-a936-479d-9aa9-19c519c7fabc	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0037	quote	e7dec721-47fa-4b65-9d98-6519600bc45d	QT-2026-0037	\N	2026-08-05 08:00:53.666534+00
52b48b62-22d7-4ff3-807a-f407a08fda06	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0038	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0038	\N	2026-08-05 09:39:11.9267+00
7227cc73-5f8e-4c78-88b2-c782ec4ec127	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	\N	\N	2026-08-05 09:57:42.669388+00
7355b6df-204a-47af-9635-117951707d7f	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0038	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0038	\N	2026-08-05 10:21:39.248649+00
bc1011cd-802f-4fe2-b287-335bc84fdd23	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0038	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0038	\N	2026-08-05 10:28:54.744817+00
0a90f9b8-2d2e-4ccc-8a02-0043f6075990	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0038	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0038	\N	2026-08-05 12:07:25.883105+00
8c59ef91-b0d1-4a61-b1a3-1baa4c607ff4	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0034	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-05 12:36:04.600591+00
\.


--
-- Data for Name: archive_reasons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.archive_reasons (id, reason, last_used_at, created_at) FROM stdin;
567238e6-1c19-48b3-81d8-91a6d5a0e22e	الادعاء من العميل بان العينات المرسلة غير مطابقة حيث تم طلب ان تكون مدرجة ومفتوحة من الطرفين	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
bf460edd-8fe3-4af7-a880-9636a94bf255	الادعاء من المصنع بان المطلوب ليس نفس العينة المرسلة علما انه تم ارسال العينة الى مالك الخوالدة لكن تم رفضه من المختبرات	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
098a62d5-6312-416b-bfc0-eba866a469f2	التاخر في ارسال عرض السعر للعميل وتم الشراء من مصدر اخر	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
e88930d1-d9d6-44ce-b10f-7cc5068e4fcc	التاخر في ارسال عرض السعر للعميل وتم الطلب من مصدر اخر	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
206b8d5c-a2a2-4ab6-98ab-322cce0e8405	تم احالة الطلبية بشكل كلي على المؤسسة ولله الحمد	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
5ed2f8bb-a5ba-4bc6-9db2-1920b5eb8dca	تم الشراء من جهة اخرى بسبب السعر	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
cc22c025-c041-40c3-828b-e814c45bffc0	تم تحويله الى طلب اخر من المؤسسة بموجب عرض سعر رقم 22/2026	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
7e132473-6ca5-4643-bc57-fefeefb4dc98	تم تقديم العرض لجهة وسيطة ولم يتم احالة العرض	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
918b8b5b-fce6-44fa-8db9-53c57d692a2d	تمت احالة جزئية للعرض والغاء باقي البنود	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
dc1f5d5e-edd5-4f92-a14d-773a51b05039	تمت احالة كامل الطلبية على المؤسسة ولله الحمد	2026-08-04 07:32:38.3189+00	2026-08-04 07:32:38.3189+00
6eed9369-6a27-492f-b289-beb4cb4b59ce	تم تسليم الطلبية للعميل بموجب فاتورة مفوترة رقم 471	2026-08-04 12:03:41.941+00	2026-08-04 12:03:42.993113+00
f9b37d8b-304e-4065-8985-558320c64204	تم اعتماد الطلب	2026-08-04 12:50:52.435+00	2026-08-04 12:50:53.527187+00
\.


--
-- Data for Name: catalog_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalog_categories (id, name, sort_order, created_at, created_by) FROM stdin;
a8191ad2-22c0-4bf0-8fdd-03d6e9be1b41	العناية بالسكري	1	2026-06-06 15:22:33.478508+00	\N
db7766df-1df7-4b22-a255-8315293d1f3c	أجهزة ضغط الدم	2	2026-06-06 15:22:33.478508+00	\N
b833d870-cddc-45a0-b45f-f308396168d5	أجهزة طبية منزلية	3	2026-06-06 15:22:33.478508+00	\N
72f62ef3-ab8e-4d1f-9e3f-c3c3900b9821	المضخات الطبية	4	2026-06-06 15:22:33.478508+00	\N
c64e2af9-bee7-4ee6-86c3-722d6514c5af	أحذية طبية	5	2026-06-06 15:22:33.478508+00	\N
c1515375-2b09-40ce-b581-3dc45855ba0c	تجهيز عيادات	6	2026-06-06 15:22:33.478508+00	\N
eb1f1c70-bac3-404d-8b25-3aca07e632d9	المستهلكات	7	2026-06-06 15:22:33.478508+00	\N
b79228c3-90b5-452c-8864-bdb603ef86c5	إسعافات أولية	8	2026-06-06 15:22:33.478508+00	\N
73c50d80-b705-4de8-a621-7fad14d026ce	ملابس طبية ومخبرية	9	2026-06-06 15:22:33.478508+00	\N
d5294c2b-128c-4031-bcec-de22a568f806	المشدات الطبية والتجميلية	10	2026-06-06 15:22:33.478508+00	\N
df864ccd-c6af-424d-b633-ff69b589911e	المجاهر	11	2026-06-06 15:22:33.478508+00	\N
338565d6-5ed3-46a3-ac7a-14b8ccd4f478	أدوات زجاجية	12	2026-06-06 15:22:33.478508+00	\N
2f5decb4-be96-4538-bd5e-50d70b630ceb	أدوات بلاستيكية	13	2026-06-06 15:22:33.478508+00	\N
1aec4032-d64b-4873-bbca-53f525d829a8	فحص المياه	14	2026-06-06 15:22:33.478508+00	\N
491c8313-fea3-427a-a322-a765c8b52d19	الكروماتوغرافيا	15	2026-06-06 15:22:33.478508+00	\N
c886d41c-b305-4148-98f1-4551947ea634	تجهيز مختبرات	16	2026-06-06 15:22:33.478508+00	\N
690c09a1-960f-42ba-b04a-a2498f0a1262	مستهلكات مخبرية	17	2026-06-06 15:22:33.478508+00	\N
50348ac4-4320-4c8d-a007-9f7343a3f48d	الهيكل العظمي وأجزاءه	18	2026-06-06 15:22:33.478508+00	\N
bc3f0f8f-230a-44c4-b935-b00c1681ebb4	المجسمات التشريحية	19	2026-06-06 15:22:33.478508+00	\N
ba42aa30-2ad3-4f56-a984-8cab6712bf9f	الدمى والتدريس الطبي	20	2026-06-06 15:22:33.478508+00	\N
7a99e21d-a2e5-4fea-80f9-ef780d06d9bd	المجسمات التعليمية	21	2026-06-06 15:22:33.478508+00	\N
e1e17485-5001-48f7-a348-3c6082827a75	النباتات	22	2026-06-06 15:22:33.478508+00	\N
f58ecd34-32a9-4ba0-b9d8-60ea6e3813a8	اللوحات التعليمية	23	2026-06-06 15:22:33.478508+00	\N
ec53b69a-c2ba-4526-80a8-e93a1e45675d	غيرهم	24	2026-06-06 15:22:33.478508+00	\N
\.


--
-- Data for Name: catalog_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalog_items (id, name, description, unit, unit_price, origin, delivery, category, notes, is_active, created_by, created_at, updated_at) FROM stdin;
55497b6c-d0d2-481e-9052-99e48188c869	Disposable Syringes 10ml high quality	\N	Each	0.0525	CHINA	PROMPT	\N	\N	t	445bc65d-256f-48d3-9367-464a408e657b	2026-05-20 11:16:13.991172+00	2026-05-20 14:55:08.404+00
07b2981f-0eba-47cb-9c3d-fe5a8196081a	Disposables Coat  Non-Woven	\N	EACH	0.65	CHINA	PROMPT	\N	\N	t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-03 11:04:09.752827+00	2026-06-03 11:04:09.752827+00
30075507-d8bf-4b6a-85f8-143d1f89ac7a	Digital Micromter	\N	EACH	0	CHINA	PROMPT	\N	\N	t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-06 14:38:31.243975+00	2026-06-06 14:38:31.243975+00
8e900fe5-2072-4d19-a0c2-704af4142658	Digital Balance 0.1-2000gm with adaptor	\N	EACH	35	CHINA	PROMPT	\N	\N	t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-06 14:41:15.196926+00	2026-06-06 14:41:15.196926+00
4dee0e92-795f-4b1d-9a0b-63822de42775	Disposables Coat Nylon	\N	Each	0.065	CHINA	PROMPT	المستهلكات	\N	t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-03 11:02:07.317611+00	2026-06-06 14:48:43.372+00
e693f6d4-cad9-467b-812b-b58117e9b56a	Digital Balance 0.01-620gm with adaptor	\N	EACH	0	CHINA	PROMPT	\N	\N	t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-07 08:27:59.590763+00	2026-06-07 08:27:59.590763+00
897b87b4-c05c-4dc1-b484-0f513a577f61	1\tHeating Incubator Digital Control 20liter		EACH	240	CHINA	PROMPT	تجهيز مختبرات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-07 10:41:54.4184+00	2026-06-07 10:41:54.4184+00
bfe09e69-a402-44ba-a92a-69754869a8bd	3\t Analytical Balance, 4 Digits Up to 120gm		EACH	455	CHINA	PROMPT	Balances		t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-07 10:43:41.215941+00	2026-06-07 10:43:41.215941+00
0a0580f1-9e01-4ff1-8366-2dac4732f853	3\t Analytical Balance, 3 Digits Up to 220gm		EACH	355	CHINA	PROMPT	Balances		t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-07 10:44:45.925217+00	2026-06-07 10:44:45.925217+00
5f2b1f0d-8f52-4f05-82ae-5f4d6808ba3b	Hot Plate with stirrer Manual Control Up to 180C		EACH	165	CHINA	PROMPT	تجهيز مختبرات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-07 10:46:29.98915+00	2026-06-07 10:46:29.98915+00
c32f67e7-69e3-4312-ab34-40068ff81a3c	Disposable Face Mask		pk/50	1.15	CHINA	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:38:08.779093+00	2026-07-27 07:38:08.779093+00
6d909003-460f-4d5c-a912-5d536f843407	Latex Gloves Disposable White Large Size HAYAT Brand		pk/100	2.66	THAILAND	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:40:21.10522+00	2026-07-27 07:40:21.10522+00
5c68d9f8-046a-4d0d-9882-c4ace310a90d	Latex Gloves Disposable White Medium Size HAYAT Brand		PK/100	2.66	THAILAND	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:41:11.792724+00	2026-07-27 07:41:11.792724+00
21a22179-12aa-4453-b61f-6407f3998ec5	Latex Gloves Disposable White Small Size HAYAT Brand		PK/100	2.66	THAILAND	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:42:14.419207+00	2026-07-27 07:42:14.419207+00
5f6182a4-e959-47ff-865c-456d0032111e	Disposable Long Sleeve Gloves Transparent Vergin heavy duty		PK/100	4.65	CHINA	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:43:14.157337+00	2026-07-27 07:43:14.157337+00
5a77d1d5-fe8d-494c-b199-d4928968bba1	Nitrile Gloves Disposable Blue color Small size HAYAT brand		PK/100	2.66	THAILAND	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:44:36.710807+00	2026-07-27 07:44:36.710807+00
a265c1af-1525-48ae-8776-9b9d46e7ff94	Nitrile Gloves Disposable Blue color Medium size HAYAT brand		PK/100	2.66	THAILAND	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:45:14.394161+00	2026-07-27 07:45:14.394161+00
af5b41fc-9334-4d99-91b6-089d2d58fade	Nitrile Gloves Disposable Blue color Large size HAYAT brand		PK/100	2.66	THAILAND	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:45:47.951579+00	2026-07-27 07:45:47.951579+00
2678b22a-2abb-48eb-92a7-74f1af345fc9	Disposable Shoes Cover CPE 3.8gm heavy duty		PK/100	2.65	CHINA	PROMPT	المستهلكات		t	445bc65d-256f-48d3-9367-464a408e657b	2026-07-27 07:46:40.055013+00	2026-07-27 07:46:40.055013+00
10f50bd7-dd1b-4adf-bae0-985c97647b11	Vertical Electric Heating Air Blast Drying Oven 20Lit Model WGL-20BE		EACH	250	CHINA	PROMPT	تجهيز مختبرات		t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 08:18:26.607993+00	2026-08-03 08:18:26.607993+00
2a55bacb-fa62-429b-b000-802cf68894f7	Biological Microscope BIO-001		EACH	245.69	CHINA	PROMPT	تجهيز مختبرات		t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 08:18:38.454049+00	2026-08-03 08:18:38.454049+00
1397ab78-23f4-4476-98de-d6124038dfaa	Disposable Arm Sleeve		EACH	12.07	CHINA	PROMPT	المستهلكات		t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 13:08:53.513315+00	2026-08-03 13:08:53.513315+00
f8b7c0bd-1057-4f09-8b03-5db9914261cb	Disposable Head Cover		EACH	1.25	CHINA	PROMPT	المستهلكات		t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 13:12:05.55876+00	2026-08-03 13:12:05.55876+00
\.


--
-- Data for Name: custom_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_origins (id, name, created_at) FROM stdin;
1	THAILAND	2026-07-27 08:58:29.192748+00
2	THA	2026-07-27 08:58:37.363277+00
29	FISHER - EUROPE	2026-08-02 06:31:17.589484+00
39	N.A	2026-08-05 11:44:41.413265+00
\.


--
-- Data for Name: custom_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_units (id, name, created_at) FROM stdin;
1	PK/50	2026-07-27 07:37:52.628012+00
2	PK/100	2026-07-27 07:39:22.570291+00
10	مجموعة	2026-07-28 09:25:27.383802+00
11	علبة	2026-07-28 09:26:11.648285+00
12	مجموعة/10	2026-07-28 09:26:52.750267+00
13	باكيت	2026-07-28 09:28:44.076636+00
16	طقم	2026-07-28 09:31:30.665412+00
25	KIT	2026-08-03 12:35:27.828204+00
29	500GM	2026-08-04 11:41:35.143599+00
31	250GM	2026-08-04 11:42:34.764954+00
32	150GM	2026-08-04 11:44:12.713582+00
34	500ML	2026-08-04 11:46:36.808562+00
35	LITRE	2026-08-04 11:47:14.722755+00
41	طقم/25	2026-08-05 09:42:41.015307+00
44	20لتر	2026-08-05 09:45:38.788835+00
45	لتر	2026-08-05 09:46:25.444482+00
46	100مل	2026-08-05 09:47:00.509172+00
47	جهاز	2026-08-05 09:47:39.258976+00
64	PK	2026-08-05 10:46:25.418507+00
66	100GM	2026-08-05 10:48:01.646127+00
67	25GM	2026-08-05 10:54:33.149645+00
\.


--
-- Data for Name: customer_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_categories (id, name, sort_order, created_at) FROM stdin;
6f730288-e5f2-4644-881a-8bdc49aaacfd	مركز طبي	4	2026-06-07 10:10:29.632642+00
b9f2ca0c-1e4f-4b8b-8d35-27cab7b2b6d6	عيادة خاصة	5	2026-06-07 10:10:29.632642+00
df6e9b3e-270b-43ba-a5f5-8b133450cad2	صيدلية	6	2026-06-07 10:10:29.632642+00
dca8d888-ca6c-4e58-a0a5-9dfcce0dba25	مختبر طبي	7	2026-06-07 10:10:29.632642+00
891ca2f3-3b3d-410e-bf0f-b5948da44a1e	جهة حكومية	10	2026-06-07 10:10:29.632642+00
471c5355-8441-4333-941b-94aa07809a39	جامعة / كلية	11	2026-06-07 10:10:29.632642+00
910cd5da-6e1a-492e-ac07-6de142510cee	جمعية خيرية	13	2026-06-07 10:10:29.632642+00
2c498a07-8888-4161-a62d-49e9a20ca015	أخرى	14	2026-06-07 10:10:29.632642+00
f984e554-1bc1-4f33-b2af-146d924d5845	مصنع ادوية	1	2026-06-07 10:10:29.632642+00
8c2a5777-70e3-4cd7-88ee-6c10131b68ba	مصانع اخرى	2	2026-06-07 10:10:29.632642+00
\.


--
-- Data for Name: customer_districts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_districts (id, governorate, name, sort_order, created_at) FROM stdin;
51e94180-ef75-45e3-9075-5e4c3f4fe280	عمان	وسط البلد	1	2026-06-07 10:10:29.632642+00
abe2ffeb-f00a-4fe5-99de-5745adb2115c	عمان	الشميساني	2	2026-06-07 10:10:29.632642+00
2065f6ca-e04a-4271-9f7f-8368cd5e36ed	عمان	الجبيهة	3	2026-06-07 10:10:29.632642+00
9a900eae-42b6-4422-9e7b-39ddbf00501b	عمان	وادي السير	4	2026-06-07 10:10:29.632642+00
334e025b-9bf7-42af-a743-290cf08abce8	عمان	تلاع العلي	5	2026-06-07 10:10:29.632642+00
afb54031-dc0d-490b-82c8-e08fbc8db9fc	عمان	ضاحية الحسين	6	2026-06-07 10:10:29.632642+00
731db725-f24c-462d-a55d-02349040a731	عمان	الرابية	7	2026-06-07 10:10:29.632642+00
e02f178b-f899-45c9-98e5-fcb6173463a8	عمان	دابوق	8	2026-06-07 10:10:29.632642+00
b694c44a-2d68-4a39-bad2-0f0fbc877585	عمان	صويلح	9	2026-06-07 10:10:29.632642+00
c39d4d0a-eb71-4b89-9d13-aeaed1835f52	عمان	شفا بدران	10	2026-06-07 10:10:29.632642+00
8a701dbe-0821-4aaa-8e0a-ccb6c053a076	عمان	طارق	11	2026-06-07 10:10:29.632642+00
1dba54a1-8c91-448f-a2e0-a3e83c3a1111	عمان	النزهة	12	2026-06-07 10:10:29.632642+00
aa75138b-8fc4-4641-9a01-93a0a1709bc7	عمان	الروضة	13	2026-06-07 10:10:29.632642+00
84ad0541-6f7a-4439-8ae9-33637396e784	عمان	الأشرفية	14	2026-06-07 10:10:29.632642+00
403f767f-c8e3-4821-a7f9-4c16f8683c33	عمان	ماركا	15	2026-06-07 10:10:29.632642+00
882e39e5-f556-4296-b133-e18187292b6a	عمان	أبو نصير	16	2026-06-07 10:10:29.632642+00
6550ac18-000a-4153-9130-26cbd6da1537	عمان	خلدا	17	2026-06-07 10:10:29.632642+00
71b7315e-025f-4d5c-8fd4-f24e145e0b7b	عمان	الصويفية	18	2026-06-07 10:10:29.632642+00
8c81f960-97c3-4dd6-b0f6-ecc3ba5d87df	عمان	مرج الحمام	19	2026-06-07 10:10:29.632642+00
278310e2-14f6-4cc5-a425-3a38897cd930	عمان	حي الأمير حمزة	20	2026-06-07 10:10:29.632642+00
79c0405c-2857-4e95-beb0-bfe8223f0a2e	عمان	الزهور	21	2026-06-07 10:10:29.632642+00
4361295c-ab2f-437c-ad25-46602966d2bf	عمان	السواقة	22	2026-06-07 10:10:29.632642+00
54e12a58-f36c-4a23-ac35-b069949a0798	عمان	أم أذينة	23	2026-06-07 10:10:29.632642+00
fe9f7a79-9f6a-4af7-ba16-8703156fb93d	عمان	سحاب	24	2026-06-07 10:10:29.632642+00
b35ec1c5-1f86-4b61-9ac3-048a4e885e6d	عمان	القويسمة	25	2026-06-07 10:10:29.632642+00
85cc2bfe-1633-44b1-ae9b-9b0cc0d58503	عمان	ناعور	26	2026-06-07 10:10:29.632642+00
d3fad404-b864-4517-a084-ec06e3b95d9b	عمان	الجويدة	27	2026-06-07 10:10:29.632642+00
9ea4a997-0788-481f-9fa8-6622d151696e	إربد	مركز إربد	1	2026-06-07 10:10:29.632642+00
4f8275f8-dd38-4ca4-bdde-2f2435e4fdb7	إربد	الحصن	2	2026-06-07 10:10:29.632642+00
cf4b016b-6df4-44ff-bd93-62a83a9a93f3	إربد	بيت راس	3	2026-06-07 10:10:29.632642+00
6931ecbf-199e-49f3-abed-078296df2b37	إربد	المزار الشمالي	4	2026-06-07 10:10:29.632642+00
fa4fc64b-9274-419d-b5b5-4e11ec2cd968	إربد	الرمثا	5	2026-06-07 10:10:29.632642+00
010e7a8c-0618-4bd7-8cd4-1c697c622de1	إربد	بني كنانة	6	2026-06-07 10:10:29.632642+00
24332a31-eb5d-441c-9bd6-5a3c5a884014	إربد	الكورة	7	2026-06-07 10:10:29.632642+00
cfacfdb8-489f-437c-b2ab-d1820609a258	إربد	الأغوار الشمالية	8	2026-06-07 10:10:29.632642+00
25156a30-9a32-4a54-b76c-28d05971ed02	إربد	باعون	9	2026-06-07 10:10:29.632642+00
859fea56-aa70-487b-a522-0c9d83be3a21	إربد	المغير	10	2026-06-07 10:10:29.632642+00
874a9d25-c2dc-44d4-8d17-39b83be2aa99	إربد	طبقة فحل	11	2026-06-07 10:10:29.632642+00
9ae2177a-5b19-4aac-8172-415ba4631369	إربد	النعيمة	12	2026-06-07 10:10:29.632642+00
29631b77-e3bb-4d48-af3e-360105d7a131	إربد	حي الجامعة	13	2026-06-07 10:10:29.632642+00
36cd9864-2096-4f6b-83cf-4d1fb1a5fb0a	إربد	حي البتراوي	14	2026-06-07 10:10:29.632642+00
e9e2b668-92ac-4fdb-95af-368e1c086b45	إربد	ريمون	15	2026-06-07 10:10:29.632642+00
313c1542-8e47-4c1e-8bba-53b0c9d75c51	الزرقاء	مركز الزرقاء	1	2026-06-07 10:10:29.632642+00
27a7f3c6-51b6-49fd-905e-a72a3d43dda6	الزرقاء	الرصيفة	2	2026-06-07 10:10:29.632642+00
4a238839-2682-4cc9-b465-6d28da6ccbc7	الزرقاء	الهاشمية	3	2026-06-07 10:10:29.632642+00
84f231a8-c9d3-43b3-997d-d6ffbd5ddb9e	الزرقاء	الأزرق	4	2026-06-07 10:10:29.632642+00
381e2693-912f-4d04-8ac1-5eca356a9f1d	الزرقاء	ضليل	5	2026-06-07 10:10:29.632642+00
b2abf6ee-4bf4-48ea-bc16-79d12259b661	الزرقاء	الزرقاء الجديدة	6	2026-06-07 10:10:29.632642+00
3ecef46b-981c-4238-afdc-ed55cec5897c	الزرقاء	حي الأمير حسن	7	2026-06-07 10:10:29.632642+00
9b4a99e3-792d-44d6-99b2-c9226d6e503b	الزرقاء	حي الإسكان	8	2026-06-07 10:10:29.632642+00
7125826f-24a3-4505-8997-6b62fc047aea	الزرقاء	حي النزهة	9	2026-06-07 10:10:29.632642+00
57aa32d3-975e-4bfa-bb11-0b074235df2d	الزرقاء	خربة السمرا	10	2026-06-07 10:10:29.632642+00
10258360-7907-4bfc-91af-45d2693d5116	الزرقاء	بسيرا	11	2026-06-07 10:10:29.632642+00
29a655d0-dd24-4c79-98f0-05519d0676a5	الزرقاء	حي اليرموك	12	2026-06-07 10:10:29.632642+00
a9686347-fb82-44af-ab94-939cf92a1cce	البلقاء	السلط	1	2026-06-07 10:10:29.632642+00
77757df6-92fd-4884-8db5-2555a0c67066	البلقاء	ماحص	2	2026-06-07 10:10:29.632642+00
20bdda78-c892-4f1c-bf62-015b4d007217	البلقاء	عين الباشا	3	2026-06-07 10:10:29.632642+00
8395ab3b-7438-4f38-9afe-1582e5b5b5d8	البلقاء	دير علا	4	2026-06-07 10:10:29.632642+00
40334e98-9afa-4983-95bc-a75ec5f31edd	البلقاء	الشونة الجنوبية	5	2026-06-07 10:10:29.632642+00
7906bf32-9bfe-49ec-823d-296878d3459d	البلقاء	الكرامة	6	2026-06-07 10:10:29.632642+00
77ac3873-004e-4ec4-8971-a5f0ac332cc9	البلقاء	عيرا	7	2026-06-07 10:10:29.632642+00
86a2ae35-0bbb-46aa-9cf8-93eefc88c14b	البلقاء	وادي شعيب	8	2026-06-07 10:10:29.632642+00
efd0e5db-de5f-45c7-9f3a-a5df88654b74	البلقاء	نادر	9	2026-06-07 10:10:29.632642+00
c3f5b190-9271-4a99-96a2-dfc248f2639e	البلقاء	عمواس	10	2026-06-07 10:10:29.632642+00
f228aa4f-945c-4630-ade9-54c82b2a185e	البلقاء	عراق الأمير	11	2026-06-07 10:10:29.632642+00
ed27c6ec-3fbd-492c-aad9-fd591a825cf5	البلقاء	الفحيص	12	2026-06-07 10:10:29.632642+00
14461b2e-4aa9-47c3-8007-9018f3ab4977	المفرق	مركز المفرق	1	2026-06-07 10:10:29.632642+00
e77082af-eb01-43e1-850e-81416ef3726b	المفرق	الرويشد	2	2026-06-07 10:10:29.632642+00
5b10d0f1-70af-47e4-85ba-080ab27a1f9c	المفرق	الزعتري	3	2026-06-07 10:10:29.632642+00
44aa56cc-e01a-4d7a-9f21-96fcb0770b32	المفرق	بديعة	4	2026-06-07 10:10:29.632642+00
13cbcd37-6490-4874-9d79-e99b886d0cf9	المفرق	الخالدية	5	2026-06-07 10:10:29.632642+00
2e49a902-0aee-4d0c-be1b-15d6ce9e67bb	المفرق	الحمراء	6	2026-06-07 10:10:29.632642+00
64377dfa-a31a-42dc-8e4d-f0acd78003ba	المفرق	أم الجمال	7	2026-06-07 10:10:29.632642+00
48368980-d684-4fd4-86f0-a70cf34971a0	المفرق	الصفاوي	8	2026-06-07 10:10:29.632642+00
e5c084c6-ce80-44b8-8dac-c6f1c33150d4	المفرق	رحاب	9	2026-06-07 10:10:29.632642+00
4a8edce1-17c3-4d71-b025-d2994c15fda2	الكرك	مركز الكرك	1	2026-06-07 10:10:29.632642+00
53a2e904-57c9-4a93-bacb-201c5599172f	الكرك	الغور الكركي	2	2026-06-07 10:10:29.632642+00
696c5167-c9b6-4866-8d01-a19ec80f09dd	الكرك	المزار الجنوبي	3	2026-06-07 10:10:29.632642+00
b797e7f3-bdda-43aa-975f-e5b8ff6f1532	الكرك	القصر	4	2026-06-07 10:10:29.632642+00
e074c729-d001-49d7-bc52-a76414f834b7	الكرك	الربة	5	2026-06-07 10:10:29.632642+00
014cc8e3-93d6-426d-b953-9f3f6aa4a31c	الكرك	عي	6	2026-06-07 10:10:29.632642+00
bcd167c0-a001-497a-8d74-69a099c2c0a5	الكرك	فقوع	7	2026-06-07 10:10:29.632642+00
e855c04f-99f0-43ab-bc9e-64b48fa70218	الكرك	المؤتة	8	2026-06-07 10:10:29.632642+00
95baa8b5-8061-45a0-9a15-97cd1866510b	الكرك	القطرانة	9	2026-06-07 10:10:29.632642+00
893221df-4583-4f0e-8041-e73157e394b4	الكرك	العراق	10	2026-06-07 10:10:29.632642+00
8d0fa15a-946f-4e58-9822-3bf5c157601c	مادبا	مركز مادبا	1	2026-06-07 10:10:29.632642+00
0279f45a-b41c-4e47-bbdb-33239a2833e1	مادبا	ذيبان	2	2026-06-07 10:10:29.632642+00
bb8d629b-d766-46c7-94f2-1a5181836291	مادبا	ليجون	3	2026-06-07 10:10:29.632642+00
3b1a2304-4285-4edb-a3ec-b32f651f74cb	مادبا	جرف الدراويش	4	2026-06-07 10:10:29.632642+00
bef04d42-bff7-4548-ab39-59bb33e986e1	مادبا	النصيب	5	2026-06-07 10:10:29.632642+00
922679d8-c5c1-42eb-9346-63f3288d1974	مادبا	المليح	6	2026-06-07 10:10:29.632642+00
885c7cde-1475-41ac-ae88-908a81d4f08c	مادبا	طبان	7	2026-06-07 10:10:29.632642+00
07224819-60c6-403a-b757-27b43e8ada88	مادبا	أم الرصاص	8	2026-06-07 10:10:29.632642+00
d7f083f4-ded7-4d82-8153-842f5f216464	جرش	مركز جرش	1	2026-06-07 10:10:29.632642+00
0a86e76a-54c8-4f40-86c1-674c84b719ec	جرش	برما	2	2026-06-07 10:10:29.632642+00
eca3d663-5f1b-46e2-b5e3-87507b769621	جرش	سوف	3	2026-06-07 10:10:29.632642+00
80842b09-6b27-48a2-9f71-df3e6240247b	جرش	صخرة	4	2026-06-07 10:10:29.632642+00
51f2e163-ffc5-452b-bee0-1ecd9d89f67e	جرش	كفر راجب	5	2026-06-07 10:10:29.632642+00
dce10771-6117-40bb-ab0d-159b35dfdd0e	جرش	المصطبة	6	2026-06-07 10:10:29.632642+00
01ce6688-798e-457c-9d99-9194b6544905	عجلون	مركز عجلون	1	2026-06-07 10:10:29.632642+00
13717a46-e4d5-4c2f-a5f7-8329df9c90fe	عجلون	كفرنجة	2	2026-06-07 10:10:29.632642+00
93279aed-ab17-413e-abc7-4a474b6b93c8	عجلون	عنجرة	3	2026-06-07 10:10:29.632642+00
19cd5586-7103-4a41-81a3-cab8d2d89874	عجلون	عرجان	4	2026-06-07 10:10:29.632642+00
77302f86-3233-4a71-bd6d-ffb03c1c142b	عجلون	راجب	5	2026-06-07 10:10:29.632642+00
cb2b9909-28da-4c97-987b-c174813a335b	عجلون	حلاوة	6	2026-06-07 10:10:29.632642+00
56ffc175-8093-41d7-96bf-84dbf4ce55f1	عجلون	سوفا	7	2026-06-07 10:10:29.632642+00
1471c477-211a-46ed-b0eb-656e53bb0d32	العقبة	مركز العقبة	1	2026-06-07 10:10:29.632642+00
be4be768-a895-4aa7-8c8f-77ee7c9a0bd5	العقبة	القويرة	2	2026-06-07 10:10:29.632642+00
6a82e6df-743a-48c9-8a0e-6251a6c0f8ce	العقبة	رم	3	2026-06-07 10:10:29.632642+00
ab8eb821-476f-46fa-b3f2-a0c531ee27af	العقبة	الشيدية	4	2026-06-07 10:10:29.632642+00
b1e0b852-6c30-4d4e-92ef-715d834371f1	العقبة	حي الورود	5	2026-06-07 10:10:29.632642+00
a0c3d0c8-e74d-4f1c-9bb1-3377aeda5e0c	العقبة	حي الشلالة	6	2026-06-07 10:10:29.632642+00
7d6524bd-a6ad-4723-8f72-f54830b1c076	العقبة	حي البلد	7	2026-06-07 10:10:29.632642+00
f4ca7db6-6056-4f63-9191-3db635fae4fa	العقبة	الخريبة	8	2026-06-07 10:10:29.632642+00
0f271d9a-0596-4e0c-9330-feda8924b54f	العقبة	المدينة الصناعية	9	2026-06-07 10:10:29.632642+00
da26f54c-1383-4eb9-a2b5-11ba96f47d2d	الطفيلة	مركز الطفيلة	1	2026-06-07 10:10:29.632642+00
a48c496d-7363-49c6-87b6-14e7df96991d	الطفيلة	بصيرا	2	2026-06-07 10:10:29.632642+00
aac157b3-35d9-4c00-8b75-65b6aa5816c0	الطفيلة	الحسا	3	2026-06-07 10:10:29.632642+00
c9f91ffc-a929-4d5a-98ae-baa730c37381	الطفيلة	قادس	4	2026-06-07 10:10:29.632642+00
940e68ca-4f0a-48b0-a18d-49e468ba4a20	الطفيلة	العين البيضا	5	2026-06-07 10:10:29.632642+00
3f34e147-3a49-4610-bbc1-18b426c1ff0e	الطفيلة	صير	6	2026-06-07 10:10:29.632642+00
7e66a524-c6ca-413c-9708-46525268f50f	معان	مركز معان	1	2026-06-07 10:10:29.632642+00
dead2953-3150-4f1a-97d6-9b1f13d6b1fb	معان	البتراء	2	2026-06-07 10:10:29.632642+00
e441ccdb-e441-4213-aea5-ce3d17f620d7	معان	وادي موسى	3	2026-06-07 10:10:29.632642+00
97659953-29f0-4d8c-b274-a192ef611807	معان	الشوبك	4	2026-06-07 10:10:29.632642+00
7e7a98f3-1c18-4bd5-978d-7639784d7383	معان	غران	5	2026-06-07 10:10:29.632642+00
3390ddd6-dc88-43c3-ad95-b8ed3d7ea6ca	معان	الجفر	6	2026-06-07 10:10:29.632642+00
116891b8-09fa-492b-8410-7345a385125c	معان	الحميمة	7	2026-06-07 10:10:29.632642+00
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, name, phone, alt_phone, address, website, notes, assigned_to, created_by, created_at, updated_at, customer_code, fax, mobile, email, city, category, tags, contact1_name, contact1_title, contact1_phone, contact1_mobile, contact1_email, contact1_ext, contact1_notes, contact2_name, contact2_title, contact2_phone, contact2_mobile, contact2_email, contact2_ext, contact2_notes, rep_name, contact1_last_name, contact1_mobile2, contact2_last_name, contact2_mobile2) FROM stdin;
9b8362b9-9253-4971-b79f-be458d346b26	مدارس اكاديمية الاتفاق الدولية	\N	\N	\N	\N	\N	\N	445bc65d-256f-48d3-9367-464a408e657b	2026-07-20 08:32:49.108399+00	2026-07-20 08:32:46.947+00	C-0006	\N	\N	\N	عمان	\N	\N	اسامة	مدير المشتريات	0795571721	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	احمد تنيرة	\N	\N	\N	\N
98c85065-5320-477e-b78c-83ad9270728a	شركة المناصير لتكنولوجيا المعلومات	\N	\N	\N	\N	\N	ee095348-a2de-4906-a078-0e8a3f3560a9	445bc65d-256f-48d3-9367-464a408e657b	2026-08-01 16:27:38.913882+00	2026-08-01 16:27:39.827+00	C-0009	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Eng. Osama Alawy	\N	\N	\N	\N
cf5c4b24-cf21-4602-b569-5f069d914ee5	مدارس عمان الاهلية	0797901489	\N	\N	\N	\N	\N	445bc65d-256f-48d3-9367-464a408e657b	2026-08-02 06:46:37.439437+00	2026-08-02 06:46:37.702+00	C-0010	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
cd40c449-f543-4142-8804-dcc8838ac95e	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	00962790117273	\N	\N	\N	\N	ee095348-a2de-4906-a078-0e8a3f3560a9	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 07:41:41.1477+00	2026-08-03 07:41:41.572+00	C-0011	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Eng. Osama Alawy	\N	\N	\N	\N
739a0229-8e24-4988-9731-58c9c8cd56b6	شركة سحاب لمواد التجميل 	00962778760786	\N	سحاب	\N	\N	ee095348-a2de-4906-a078-0e8a3f3560a9	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 12:58:23.743579+00	2026-08-03 12:58:24.221+00	C-0012	\N	\N	\N	عمان	أخرى	\N	حازم 	أخرى	00962778760786	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Eng. Osama Alawy	الدروبي 	\N	\N	\N
c188bbff-81c5-4dfb-a0ad-7e985f6c8d6a	مؤسسة الموارد للتجهيزات الطبية	\N	\N	العبدلي - العبدلي	\N	\N	445bc65d-256f-48d3-9367-464a408e657b	445bc65d-256f-48d3-9367-464a408e657b	2026-06-07 10:38:28.035241+00	2026-06-07 13:00:10.801+00	C-0002	\N	\N	\N	عمان	مؤسسة خاصة	خاص	بسام الزبن	صاحب عمل	0798736387	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	د. محمد جوابرة	\N	\N	\N	\N
30c5f5ec-0d68-46fe-a969-36926ac21235	شركة الحياة للصناعات الدوائية	\N	064162607	سحاب	\N	\N	445bc65d-256f-48d3-9367-464a408e657b	445bc65d-256f-48d3-9367-464a408e657b	2026-06-07 11:44:44.109338+00	2026-06-07 13:00:29.977+00	C-0003	\N	\N	\N	عمان	مصنع ادوية	\N	مالك	منسق مشتريات	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	د. محمد جوابرة	\N	\N	\N	\N
8b9b4c0a-eede-4acb-9e59-8eefab8e4375	الجامعة الأردنية	\N	\N	\N	\N	\N	\N	445bc65d-256f-48d3-9367-464a408e657b	2026-07-04 07:02:43.361054+00	2026-07-04 07:02:40.84+00	C-0005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
a75c3c0c-7657-4be5-9db9-8879815e77ff	الشركة النوعية للكرتون	\N	\N	الموقر - الموقر	www.zalatimoindustries.com	\N	445bc65d-256f-48d3-9367-464a408e657b	445bc65d-256f-48d3-9367-464a408e657b	2026-06-06 14:37:28.390089+00	2026-07-21 08:41:59.532+00	C-0001	064024825	\N	\N	عمان	مصانع اخرى	نشط	يوسف دياب	مسؤول المشتريات	0797311208	\N	procurement@zalatimoindustries.com>	ْْْ000	\N	عبد الله طوقان	مسؤول المشتريات	0798144434	\N	\N	\N	\N	د. محمد جوابرة	\N	\N	\N	\N
2d8619b2-afd9-4a41-a81c-3eefc0f15722	شركة دار الدواء	\N	062222200 	\N	www.dadgroup.com	\N	445bc65d-256f-48d3-9367-464a408e657b	445bc65d-256f-48d3-9367-464a408e657b	2026-07-21 09:35:04.25857+00	2026-07-21 09:35:01.875+00	C-0007	\N	\N	\N	\N	مصنع ادوية	\N	ياسر عودة	مسؤول المشتريات	0770052617	\N	Yasser.odeh@dadgroup.com	680	\N	\N	\N	\N	\N	\N	\N	\N	د. محمد جوابرة	\N	\N	\N	\N
75cd4de7-e08c-430e-8291-6226da18a49a	جامعة الشرق الاوسط 	\N	\N	طريق المطار	\N	\N	\N	445bc65d-256f-48d3-9367-464a408e657b	2026-07-23 11:38:43.86075+00	2026-07-23 11:38:42.415+00	C-0008	\N	\N	\N	عمان	جامعة / كلية	\N	جهاد	مسؤول المشتريات	0791421492	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: hr_attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hr_attendance (id, employee_id, date, status, notes, created_at) FROM stdin;
e13c65d8-3f0a-40fb-ab7e-9db07b7c8f38	0c9b0d96-b9d9-4147-a041-732d5b4a0208	2026-08-06	leave_annual	\N	2026-08-04 14:16:55.084012+00
6b853c68-046c-4b11-bbcc-e0d438cfae7a	0c9b0d96-b9d9-4147-a041-732d5b4a0208	2026-08-04	leave_sick	\N	2026-08-04 14:16:55.084012+00
d9f45a2b-3357-4873-b907-f68e3b9c70b7	0c9b0d96-b9d9-4147-a041-732d5b4a0208	2026-08-02	leave_personal	\N	2026-08-04 14:16:55.084012+00
c40ddb2f-5fef-48a1-8cd6-0f0c5610fb12	0c9b0d96-b9d9-4147-a041-732d5b4a0208	2026-08-01	absent	\N	2026-08-04 14:16:55.084012+00
46b0efaa-586d-4a78-927f-bdc8d933b951	0c9b0d96-b9d9-4147-a041-732d5b4a0208	2026-08-08	late	\N	2026-08-04 14:16:55.084012+00
cd14d1ed-4477-4d16-9b82-4a29ea46727e	0c9b0d96-b9d9-4147-a041-732d5b4a0208	2026-08-11	holiday	\N	2026-08-04 14:16:55.084012+00
\.


--
-- Data for Name: hr_employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hr_employees (id, full_name, job_title, department, hire_date, base_salary, phone, national_id, status, notes, created_at, updated_at) FROM stdin;
0c9b0d96-b9d9-4147-a041-732d5b4a0208	خالد محمد خالد 	محاسب 	المحاسبة 	2022-12-12	1000.00	0123456789	1222112	active		2026-08-04 13:55:46.865559+00	2026-08-04 13:55:46.692+00
\.


--
-- Data for Name: hr_letters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hr_letters (id, employee_id, letter_type, title, content, issued_date, created_by, created_at) FROM stdin;
47030bdc-9b63-4b3b-9dc3-febd9b6bdfc6	0c9b0d96-b9d9-4147-a041-732d5b4a0208	warning	إنذار رسمي — خالد محمد خالد 	يُخطَر الموظف / خالد محمد خالد ، محاسب ، بهذا الإنذار الرسمي بسبب:\n[أسباب الإنذار]\n\nوعليه الالتزام الفوري بلوائح المؤسسة وأنظمتها، وإلا سيُتخذ بحقه الإجراء النظامي.	2026-08-04	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-04 13:56:43.641836+00
\.


--
-- Data for Name: hr_salaries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hr_salaries (id, employee_id, month, year, base_salary, bonus, deductions, status, paid_at, notes, created_at) FROM stdin;
3c3e2110-469e-4ddb-8c3d-80312c84a605	0c9b0d96-b9d9-4147-a041-732d5b4a0208	8	2026	1000.00	0.00	0.00	paid	2026-08-04 14:39:17.749+00		2026-08-04 13:57:02.503525+00
\.


--
-- Data for Name: letter_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.letter_contacts (id, name, contact_type, created_at) FROM stdin;
844f4bbe-6ccd-40d0-83ff-eda96eb5848c	مدير التسويق	attention	2026-06-24 14:29:43.072927+00
7617a13d-e196-4123-b7a0-10e318bad442	مدير التسويق	attention	2026-06-24 14:30:14.553334+00
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, user_id, title, body, type, link_type, link_id, is_read, created_at) FROM stdin;
d51ac880-1fa4-495b-bd6e-9e99ae8a59e3	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Osama Alawy	info	quote	c2ece74c-a5df-4ea3-9907-e54b2e5567ad	f	2026-05-21 14:42:34.689735+00
d2e40b30-0e16-4bf9-82e1-957ee0ec25ae	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: السلام — المُصدِر: Osama Alawy	info	quote	19276c37-9a91-48b0-af67-f9f8a99e8795	f	2026-05-21 15:29:55.994501+00
dee59a86-f4ae-45a0-9b50-3878cacf2601	ee095348-a2de-4906-a078-0e8a3f3560a9	تم تغيير حالة العرض QT-2026-0001	الحالة الجديدة: مرفوض — العميل: شركة الحياة للصناعات الدوائية	danger	quote	c2ece74c-a5df-4ea3-9907-e54b2e5567ad	f	2026-06-03 10:59:49.499317+00
a5001ae9-c8f5-410e-a1eb-a2eb5f431978	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الشركة النوعية للكرتون — المُصدِر: د. محمد جوابرة	info	quote	deb11bf4-fad8-4379-a302-25be8454c7b3	f	2026-06-06 14:41:20.566371+00
a6211a1e-3ef4-4505-b73a-ffa476cec06e	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مؤسسة الموارد للتجهيزات الطبية — المُصدِر: د. محمد جوابرة	info	quote	c22be163-9877-485c-8053-e3dfbf094862	f	2026-06-07 10:47:15.186862+00
4d6263f6-964c-45a7-ac70-3fae7371fece	ee095348-a2de-4906-a078-0e8a3f3560a9	تم تغيير حالة العرض QT-2026-0001	الحالة الجديدة: مرفوض — العميل: شركة الحياة للصناعات الدوائية	danger	quote	c2ece74c-a5df-4ea3-9907-e54b2e5567ad	f	2026-06-07 11:45:23.648058+00
9fd139dc-070c-4f5e-af37-95d4aafc5711	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0003	العميل: الشركة النوعية للكرتون	info	quote	deb11bf4-fad8-4379-a302-25be8454c7b3	f	2026-06-18 14:50:41.542391+00
ca770704-7598-4e62-816d-c271ae710296	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الجامعة الأردنية المحترمين — المُصدِر: د. محمد جوابرة	info	quote	f4484ac3-fe41-4a73-8379-80a9257a185e	f	2026-06-30 10:19:22.162313+00
806c0271-65f1-441d-a708-7f17a80e5994	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: د. محمد جوابرة	info	quote	a3215728-2478-4155-b0a2-d4342a61e744	f	2026-07-18 17:18:58.067113+00
b176d640-c0c1-479c-8f36-11b562558d17	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدارس اكاديمية الاتفاق الدولية — المُصدِر: د. محمد جوابرة	info	quote	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	f	2026-07-20 08:40:06.089982+00
81999a16-7209-4be7-b95d-13c6f18ef66e	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الشركة النوعية للكرتون — المُصدِر: د. محمد جوابرة	info	quote	0a15f774-f2b6-4308-9887-8530a3ccfc5e	f	2026-07-21 07:41:43.978631+00
491ed8be-a0e2-4cb3-ae48-ad7ee8a24374	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدارس جمعية خليل الرحمن -العقبة  — المُصدِر: د. محمد جوابرة	info	quote	c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1	f	2026-07-21 08:38:57.56391+00
b9f5c8f5-0a8c-44e3-85ce-d5977bc15bb5	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل:  جمعية خليل الرحمن - النزهة  — المُصدِر: د. محمد جوابرة	info	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	f	2026-07-21 09:18:32.507871+00
62ad5dd1-c22c-42a8-a011-0b5d48cb7084	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة دار الدواء — المُصدِر: د. محمد جوابرة	info	quote	f61ede0a-f287-4823-9f93-08362eae21f2	f	2026-07-21 09:38:37.40889+00
b3ed8cca-e5e7-4d8b-8781-e29a87d140b7	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جمعية خليل الرحمن -النزهة  — المُصدِر: د. محمد جوابرة	info	quote	c54c7220-b131-41cb-a654-d9fca2056792	f	2026-07-21 09:48:35.971653+00
79584a40-30e8-412b-8a70-9348e7578a77	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جمعية خليل الرحمن -النزهة  — المُصدِر: د. محمد جوابرة	info	quote	25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	f	2026-07-21 09:55:53.820341+00
fad952b2-b4ac-4831-b968-2c8b53dcd1a3	445bc65d-256f-48d3-9367-464a408e657b	تم تغيير حالة العرض QT-2026-0004	الحالة الجديدة: قيد الدراسة — العميل: مؤسسة الموارد للتجهيزات الطبية	info	quote	c22be163-9877-485c-8053-e3dfbf094862	t	2026-06-10 02:50:50.574956+00
8de894e4-f475-4c42-b55f-a002a7eabcb3	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0003	العميل: الشركة النوعية للكرتون	info	quote	deb11bf4-fad8-4379-a302-25be8454c7b3	t	2026-06-18 14:50:41.542391+00
f4a01615-9276-4b7d-9940-fff847aee4a6	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الجامعة الأردنية المحترمين — المُصدِر: د. محمد جوابرة	info	quote	f4484ac3-fe41-4a73-8379-80a9257a185e	t	2026-06-30 10:19:22.162313+00
b8d0be17-c4c2-45a5-ac37-e7963bda1f0e	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: د. محمد جوابرة	info	quote	a3215728-2478-4155-b0a2-d4342a61e744	t	2026-07-18 17:18:58.067113+00
7f47fff4-95b4-44eb-88cb-389bda6c0ad7	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدارس اكاديمية الاتفاق الدولية — المُصدِر: د. محمد جوابرة	info	quote	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	t	2026-07-20 08:40:06.089982+00
74aed9b1-7fca-4548-81ad-6526aaf98454	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الشركة النوعية للكرتون — المُصدِر: د. محمد جوابرة	info	quote	0a15f774-f2b6-4308-9887-8530a3ccfc5e	t	2026-07-21 07:41:43.978631+00
e5e39b96-37a3-4179-bc66-0f7b68464122	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدارس جمعية خليل الرحمن -العقبة  — المُصدِر: د. محمد جوابرة	info	quote	c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1	t	2026-07-21 08:38:57.56391+00
dee271d8-4957-46d5-a8e6-01379b7051dc	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جمعية خليل الرحمن -النزهه  — المُصدِر: د. محمد جوابرة	info	quote	df81a005-5d86-4bd2-a92e-555c33891d12	f	2026-07-21 09:59:18.328421+00
60ab14bb-05fe-429f-b965-4a472e8a9cce	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0007	العميل: مدارس اكاديمية الاتفاق الدولية	info	quote	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	f	2026-07-21 13:56:42.320454+00
f4f98305-8cf9-4a9f-96fc-4c36632e8749	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الجامعة الأردنية — المُصدِر: د. محمد جوابرة	info	quote	c93f894e-3ecb-40d4-a5f8-6bbfbe2f205d	f	2026-07-22 10:01:25.189706+00
2bd8788e-27b5-40fa-8129-a56e6430d505	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: د. محمد جوابرة	info	quote	7f415e1f-baf2-412b-b49d-7437453aeb95	f	2026-07-22 10:13:34.577346+00
89ffd35d-d6a7-47bf-b3a1-0926d7267467	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جاكعة العلوم التطبيقية الخاصة — المُصدِر: د. محمد جوابرة	info	quote	c9e4f3b0-9a34-44b9-8526-de6755caff8a	f	2026-07-22 10:55:20.981627+00
2a6f2dbd-fa44-4c13-9faa-083ca9f95d25	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مصنع الخميرة  — المُصدِر: د. محمد جوابرة	info	quote	7d636c37-c439-4ec6-9020-5e11691791b2	f	2026-07-22 12:53:25.670892+00
6297627f-242c-4005-8222-c9672169f9be	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: د. محمد جوابرة	info	quote	18aa97f7-211d-484d-b844-76a42a4e742e	f	2026-07-23 06:51:16.871289+00
54650a87-4a75-45f6-b36e-5dcd45aef4ff	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جامعة الشرق الاوسط  — المُصدِر: د. محمد جوابرة	info	quote	65badfea-3e6c-48ed-82d0-890b09317b59	f	2026-07-23 11:41:09.543045+00
b0b7e7a9-d1c7-46d1-bec1-c25a06621f71	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدارس جمعية خليل الرحمن- العقبة المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	f	2026-07-27 06:09:32.411197+00
e6009f5c-f9d1-406a-9eed-be01cea2a1d1	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدارس جمعية خليل الرحمن- العقبة المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	f	2026-07-27 06:09:32.411197+00
966771b4-7ddd-42fc-a0b1-a52b0e1cfb0d	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	f	2026-07-27 07:46:49.152546+00
31dac7e4-f4a4-4a05-8177-14afd0832929	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	f	2026-07-27 07:46:49.152546+00
a318d618-57f9-48fc-b90f-65604af275f9	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جمعية مؤسسة الزكاة الأمريكية — المُصدِر: Eng. Ahlam Alyamani	info	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	f	2026-07-27 14:42:02.302525+00
dae42d5a-6b32-4b06-b784-27a224f095a7	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: جمعية مؤسسة الزكاة الأمريكية — المُصدِر: Eng. Ahlam Alyamani	info	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	f	2026-07-27 14:42:02.302525+00
fefb0257-5666-48c1-a947-f6363131db14	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدارس عمان الاهلية المحترمين — المُصدِر: Dr. Ahmad tannerah	info	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	f	2026-07-28 09:32:47.260644+00
7154e37c-7aed-4a7c-bf46-8d948b499fd0	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدارس عمان الاهلية المحترمين — المُصدِر: Dr. Ahmad tannerah	info	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	f	2026-07-28 09:32:47.260644+00
78d649d7-816b-40a7-b07b-b340cae45c9f	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جمعية هيلفيتاس السويسرية HELVETAS — المُصدِر: Eng. Ahlam Alyamani	info	quote	219269a5-5fdf-4a4a-ad24-5551d478bc55	f	2026-07-28 14:07:07.603371+00
bc844fd0-5063-4982-b845-98764637e377	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: جمعية هيلفيتاس السويسرية HELVETAS — المُصدِر: Eng. Ahlam Alyamani	info	quote	219269a5-5fdf-4a4a-ad24-5551d478bc55	f	2026-07-28 14:07:07.603371+00
2a3d32ea-c2b2-4fc9-9b74-b4bb120e2243	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مديرية الخدمات الطبية الملكية  — المُصدِر: Eng. Ahlam Alyamani	info	quote	95edd244-8e7a-47ce-9210-d8d3595a72fb	f	2026-07-29 10:01:04.829918+00
0421fe1f-1a83-4a40-93ba-325b68858454	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مديرية الخدمات الطبية الملكية  — المُصدِر: Eng. Ahlam Alyamani	info	quote	95edd244-8e7a-47ce-9210-d8d3595a72fb	f	2026-07-29 10:01:04.829918+00
bb139404-a457-40af-b971-697f5e32d092	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: جامعة جرش الاهلية المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	f	2026-07-29 11:01:49.988563+00
4f098ad0-e93f-4be9-988f-a85faf68a09c	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: جامعة جرش الاهلية المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	f	2026-07-29 11:01:49.988563+00
3bf03f35-588f-4484-bd3c-4cc66b56a2d3	6f484e98-e110-4ceb-8070-e61810c5f108	تم تغيير حالة العرض QT-2026-0023	الحالة الجديدة: محوّل لطلب — العميل: جمعية مؤسسة الزكاة الأمريكية	info	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	f	2026-08-01 12:00:24.040018+00
c04b196d-2ca0-4739-861f-ee8496954abd	6f484e98-e110-4ceb-8070-e61810c5f108	تم تغيير حالة العرض QT-2026-0023	الحالة الجديدة: قيد الدراسة — العميل: جمعية مؤسسة الزكاة الأمريكية	info	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	f	2026-08-01 12:00:35.14367+00
af8c3523-a935-49d6-b4eb-dcf8f1a0f5ef	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: Manaseer Information Technology — المُصدِر: Eng. Osama Alawy	info	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	f	2026-08-01 15:50:39.027413+00
0983cd64-7f0f-4a0c-9a12-569245ad1476	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: Manaseer Information Technology — المُصدِر: Eng. Osama Alawy	info	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	f	2026-08-01 15:50:39.027413+00
55671777-927a-47ac-989d-4514fe2771ed	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	f	2026-08-02 06:27:25.887017+00
827c1509-c5f4-44af-9caf-3cacfee66547	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	f	2026-08-02 06:27:25.887017+00
98250646-3c55-470f-a6bc-f7f3279563c7	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	f	2026-08-02 06:33:17.093174+00
529a6d28-7665-4790-b08f-fd7abb0a7b0f	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	f	2026-08-02 06:33:17.093174+00
d3143cb9-db1b-4450-84f9-0abe3bd8d02b	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	0877fc34-9ecb-4956-9fbe-8818861c219c	f	2026-08-02 06:38:14.805617+00
33fb94de-816f-4b5e-b888-22e8a1813c3c	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	0877fc34-9ecb-4956-9fbe-8818861c219c	f	2026-08-02 06:38:14.805617+00
7b122eb4-0c24-49c6-ba26-4779a906c77b	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0021	الحالة الجديدة: قيد الدراسة — العميل: مدارس جمعية خليل الرحمن- العقبة	info	quote	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	f	2026-08-02 06:48:40.0761+00
2eb345e5-5de2-4ca7-adf5-624b0e4cc7d5	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0024	الحالة الجديدة: قيد الدراسة — العميل: مدارس عمان الاهلية	info	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	f	2026-08-02 06:48:46.387417+00
4c0def8e-4a0a-4ec9-b841-5ef312dc1406	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0027	الحالة الجديدة: قيد الدراسة — العميل: جامعة جرش الاهلية	info	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	f	2026-08-02 06:49:26.18802+00
fd22785c-eae6-40ef-aa1a-c4d000499c4f	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الكهرباء الوطنية المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	50143d1a-360b-484f-8d5a-23172401aa7d	f	2026-08-03 06:12:58.683582+00
2196d7fa-095e-4c1d-946f-3cd84edfc737	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الكهرباء الوطنية المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	50143d1a-360b-484f-8d5a-23172401aa7d	f	2026-08-03 06:12:58.683582+00
541d27d3-006e-4495-a30a-79d407663ea4	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	f	2026-08-03 07:46:52.291272+00
f9072eeb-d0bc-4dd7-a9b5-e62fb1578613	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	f	2026-08-03 07:46:52.291272+00
df212682-4a1d-4e8f-8f4f-9be9d0001b95	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: تلسكوب / المختبرات الطبية  — المُصدِر: Dr. Ahmad tannerah	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-03 12:42:12.250981+00
dfe89631-1501-46e7-8c13-e6e9f0d17883	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: تلسكوب / المختبرات الطبية  — المُصدِر: Dr. Ahmad tannerah	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-03 12:42:12.250981+00
cdb0057c-f7fa-4e12-84d8-64cac9dad8ae	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة سحاب لمواد التجميل  — المُصدِر: Eng. Osama Alawy	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-03 13:12:29.888989+00
d1060c48-a619-483f-9bb6-af577fab5e8d	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة سحاب لمواد التجميل  — المُصدِر: Eng. Osama Alawy	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-03 13:12:29.888989+00
740d5668-edfd-4d32-b48a-1e439b362c15	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Ahlam Alyamani	info	quote	505e698c-09ce-4610-8d79-772e36f62ec1	f	2026-08-03 13:41:05.258441+00
f2165df9-1657-46f6-9616-11c1b8145a91	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Ahlam Alyamani	info	quote	505e698c-09ce-4610-8d79-772e36f62ec1	f	2026-08-03 13:41:05.258441+00
2596b85c-d07e-495e-ad6a-c0ac581e87bd	ee095348-a2de-4906-a078-0e8a3f3560a9	تم تغيير حالة العرض QT-2026-0002	الحالة الجديدة: ملغي — العميل: شركة الحياة للصناعات الدوائية	danger	quote	19276c37-9a91-48b0-af67-f9f8a99e8795	f	2026-08-03 13:44:59.301815+00
5c86cd79-636c-4801-a101-09bdfdefca13	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل:  جمعية خليل الرحمن - النزهة  — المُصدِر: د. محمد جوابرة	info	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	t	2026-07-21 09:18:32.507871+00
83511c11-79a6-40b4-a2af-ba391dd2e105	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة دار الدواء — المُصدِر: د. محمد جوابرة	info	quote	f61ede0a-f287-4823-9f93-08362eae21f2	t	2026-07-21 09:38:37.40889+00
4d140318-0dcc-4fbc-bcde-3fc558902100	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جمعية خليل الرحمن -النزهة  — المُصدِر: د. محمد جوابرة	info	quote	c54c7220-b131-41cb-a654-d9fca2056792	t	2026-07-21 09:48:35.971653+00
69611e9c-8ccf-4e16-bfb3-d5e5683aca94	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جمعية خليل الرحمن -النزهة  — المُصدِر: د. محمد جوابرة	info	quote	25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	t	2026-07-21 09:55:53.820341+00
bcbe0dbb-d4ba-44f5-a1d8-5add46721122	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جمعية خليل الرحمن -النزهه  — المُصدِر: د. محمد جوابرة	info	quote	df81a005-5d86-4bd2-a92e-555c33891d12	t	2026-07-21 09:59:18.328421+00
1e2fd169-7d00-4440-9978-68099f091867	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0007	العميل: مدارس اكاديمية الاتفاق الدولية	info	quote	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	t	2026-07-21 13:56:42.320454+00
d4567064-d4ca-49f5-993c-e4dfc6c7f5da	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الجامعة الأردنية — المُصدِر: د. محمد جوابرة	info	quote	c93f894e-3ecb-40d4-a5f8-6bbfbe2f205d	t	2026-07-22 10:01:25.189706+00
002e0643-c8a9-4eac-b025-d09b840ff792	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: د. محمد جوابرة	info	quote	7f415e1f-baf2-412b-b49d-7437453aeb95	t	2026-07-22 10:13:34.577346+00
510c4d55-d769-495d-b39f-b870df1a5eb0	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جاكعة العلوم التطبيقية الخاصة — المُصدِر: د. محمد جوابرة	info	quote	c9e4f3b0-9a34-44b9-8526-de6755caff8a	t	2026-07-22 10:55:20.981627+00
5c983756-556e-46c6-9a64-9c82bff9f054	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مصنع الخميرة  — المُصدِر: د. محمد جوابرة	info	quote	7d636c37-c439-4ec6-9020-5e11691791b2	t	2026-07-22 12:53:25.670892+00
415d4b83-41d7-4932-9d70-320aba0849c4	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: د. محمد جوابرة	info	quote	18aa97f7-211d-484d-b844-76a42a4e742e	t	2026-07-23 06:51:16.871289+00
9bf0b38b-d9ab-46bf-8a90-906c3a60ad18	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جامعة الشرق الاوسط  — المُصدِر: د. محمد جوابرة	info	quote	65badfea-3e6c-48ed-82d0-890b09317b59	t	2026-07-23 11:41:09.543045+00
022114d7-0d68-4675-b083-a5f520192ef4	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدارس جمعية خليل الرحمن- العقبة المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	t	2026-07-27 06:09:32.411197+00
daf1493d-1521-4972-95d0-1d37b947ff37	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	ab3be0df-3b5d-4283-bab0-631e54cc76cd	t	2026-07-27 07:46:49.152546+00
fef7169a-268d-4288-b21d-65d6df6e12c0	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جمعية مؤسسة الزكاة الأمريكية — المُصدِر: Eng. Ahlam Alyamani	info	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	t	2026-07-27 14:42:02.302525+00
20d1eba5-6ca7-4f5a-8320-12009ddc5280	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدارس عمان الاهلية المحترمين — المُصدِر: Dr. Ahmad tannerah	info	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	t	2026-07-28 09:32:47.260644+00
64706c0c-1456-43a5-9dcf-0f0cfffdd08e	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جمعية هيلفيتاس السويسرية HELVETAS — المُصدِر: Eng. Ahlam Alyamani	info	quote	219269a5-5fdf-4a4a-ad24-5551d478bc55	t	2026-07-28 14:07:07.603371+00
9c48a2c8-747d-4ce0-aeae-729fb6e81bae	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مديرية الخدمات الطبية الملكية  — المُصدِر: Eng. Ahlam Alyamani	info	quote	95edd244-8e7a-47ce-9210-d8d3595a72fb	t	2026-07-29 10:01:04.829918+00
e77a5acf-e1a6-40f2-a1a9-4be597c4fb02	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: جامعة جرش الاهلية المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	t	2026-07-29 11:01:49.988563+00
6e2f9490-a09a-4fa0-96d6-e017110db030	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: Manaseer Information Technology — المُصدِر: Eng. Osama Alawy	info	quote	0460215c-ff4b-486f-b4b8-d780c6931ef2	t	2026-08-01 15:50:39.027413+00
c455541b-4ec9-4e74-bf30-284778f2384e	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	t	2026-08-02 06:27:25.887017+00
90200501-b1f1-4367-87b3-51dcbc2824c0	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	t	2026-08-02 06:33:17.093174+00
4af722e2-703f-4460-a4f0-76325187d259	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	0877fc34-9ecb-4956-9fbe-8818861c219c	t	2026-08-02 06:38:14.805617+00
f8f4b17b-352d-4556-9f87-f6c3b3663a0f	445bc65d-256f-48d3-9367-464a408e657b	تم تغيير حالة العرض QT-2026-0029	الحالة الجديدة: محوّل لطلب — العميل: شركة الحياة للصناعات الدوائية	info	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	t	2026-08-02 10:15:17.990509+00
b1a9c837-8a16-4fbc-a081-2e9186351d60	445bc65d-256f-48d3-9367-464a408e657b	تم تغيير حالة العرض QT-2026-0029	الحالة الجديدة: قيد الدراسة — العميل: شركة الحياة للصناعات الدوائية	info	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	t	2026-08-02 10:15:39.3995+00
afaf2961-5919-44d4-8507-9e32452c852f	445bc65d-256f-48d3-9367-464a408e657b	تم تغيير حالة العرض QT-2026-0029	الحالة الجديدة: قيد الدراسة — العميل: شركة الحياة للصناعات الدوائية	info	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	t	2026-08-02 10:45:22.235627+00
b8f48148-3034-4ede-be3c-cbff49aa3ec4	445bc65d-256f-48d3-9367-464a408e657b	تم تغيير حالة العرض QT-2026-0029	الحالة الجديدة: قيد الدراسة — العميل: شركة الحياة للصناعات الدوائية	info	quote	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	t	2026-08-02 10:58:41.139686+00
b7fd56b5-671d-4aeb-bf76-9b35aed80ac3	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الكهرباء الوطنية المحترمين  — المُصدِر: Dr. Ahmad tannerah	info	quote	50143d1a-360b-484f-8d5a-23172401aa7d	t	2026-08-03 06:12:58.683582+00
85a1712d-c2ed-45fd-b858-164c9f59e476	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	t	2026-08-03 07:46:52.291272+00
fea4dfaf-d07f-48d2-bbb7-da356a193bff	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: تلسكوب / المختبرات الطبية  — المُصدِر: Dr. Ahmad tannerah	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	t	2026-08-03 12:42:12.250981+00
f85482b2-57b0-4d88-be26-0c83afd480f1	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة سحاب لمواد التجميل  — المُصدِر: Eng. Osama Alawy	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	t	2026-08-03 13:12:29.888989+00
b77cdbd3-4fb8-4dcb-844e-1e8683f40644	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Ahlam Alyamani	info	quote	505e698c-09ce-4610-8d79-772e36f62ec1	t	2026-08-03 13:41:05.258441+00
e622c469-bc24-4835-96ce-2145baca1e87	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	9ac83342-e490-4896-93fb-04fc3f70b0cb	f	2026-08-04 09:25:46.649312+00
fef42f2d-ef2f-4eec-892c-16ba6c0ad7e7	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	9ac83342-e490-4896-93fb-04fc3f70b0cb	f	2026-08-04 09:25:46.649312+00
a9280bff-b195-45be-a004-8bc4e5d4cf88	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	9ac83342-e490-4896-93fb-04fc3f70b0cb	t	2026-08-04 09:25:46.649312+00
0a3f453f-8722-4c3b-a240-09b069639f29	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:10:39.734726+00
9d1957ed-21e3-461b-aafe-5fc01135110b	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:10:39.734726+00
5f31b8c2-244d-4ee3-8de3-a59d62af4565	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:10:39.734726+00
a4603eb6-6566-48d3-b3e6-0e1f1b03e0ff	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:13:00.857814+00
3d94ac5d-f541-4120-a90f-0ed951206e5b	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:13:00.857814+00
91d192cd-338c-4cb6-9695-ba6cf09e89f7	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:13:00.857814+00
2f037425-d66a-4891-9dae-2c55ddd65dd7	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:20:49.235132+00
4b9573fa-113d-4e4e-ab5e-5fc7e21f413e	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:20:49.235132+00
ec49ea1a-8b22-410a-9b78-851add69cc6d	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:20:49.235132+00
d85b0f9f-bbd0-4222-920d-b9f294eacfe1	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:23:36.568196+00
6f63b54c-9135-4454-b80c-e2a2b302b618	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:23:36.568196+00
40fc0e54-9783-4f91-8392-1d3cfe51a095	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:23:36.568196+00
25a1791e-803e-4a02-913d-ce3166b1c1bb	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:24:03.863434+00
755b51a8-32f9-4138-9ad9-d84dabf36051	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:24:03.863434+00
23552291-84da-4ec9-b5a6-f4e575e0b1af	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:24:03.863434+00
c1bda790-efbd-4005-b931-06fe43678d4b	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:26:19.41742+00
43132458-de1b-47c6-b8ab-0edbe424b72e	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:26:19.41742+00
3b341165-54a5-4f83-8a8f-9f67628bc7ae	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 10:26:19.41742+00
5d7798e7-6324-43d4-8a4b-e306468da8df	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 11:05:03.596732+00
7c3bfde7-37bd-4d72-9c5b-1b8b0a236258	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 11:05:03.596732+00
4da08f4c-f40b-487a-84e2-05096085151e	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-04 11:05:03.596732+00
35c5e054-fa8c-41f5-ba3b-52f0ab39c718	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة روابي الاردن للمستلزمات و المستهلكات و الاجهزة الطبية — المُصدِر: Eng. Ahlam Alyamani	info	quote	e7dec721-47fa-4b65-9d98-6519600bc45d	f	2026-08-04 11:16:03.845443+00
ac39390e-48b3-4ff9-abea-17c7b5c92326	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة روابي الاردن للمستلزمات و المستهلكات و الاجهزة الطبية — المُصدِر: Eng. Ahlam Alyamani	info	quote	e7dec721-47fa-4b65-9d98-6519600bc45d	f	2026-08-04 11:16:03.845443+00
3f4e0a73-28ce-4c35-b4e1-ae17925b6a76	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة روابي الاردن للمستلزمات و المستهلكات و الاجهزة الطبية — المُصدِر: Eng. Ahlam Alyamani	info	quote	e7dec721-47fa-4b65-9d98-6519600bc45d	f	2026-08-04 11:16:03.845443+00
8ea876c4-fc4c-4fe4-93af-8ec8532b5a98	6f484e98-e110-4ceb-8070-e61810c5f108	تم تغيير حالة العرض QT-2026-0036	الحالة الجديدة: مُعتمد — العميل: شركة الحياة للصناعات الدوائية	success	quote	505e698c-09ce-4610-8d79-772e36f62ec1	f	2026-08-04 11:19:00.43643+00
ab0590bc-56b0-43a8-a42a-6cb9d762e834	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0036	العميل: شركة الحياة للصناعات الدوائية	info	quote	505e698c-09ce-4610-8d79-772e36f62ec1	f	2026-08-04 11:19:00.715496+00
8e016afa-f56b-457e-87a9-4a222b35de5c	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0036	العميل: شركة الحياة للصناعات الدوائية	info	quote	505e698c-09ce-4610-8d79-772e36f62ec1	f	2026-08-04 11:19:00.715496+00
5ab29c5e-4ad5-49cd-a1a7-0383b8e30bf4	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0036	العميل: شركة الحياة للصناعات الدوائية	info	quote	505e698c-09ce-4610-8d79-772e36f62ec1	f	2026-08-04 11:19:00.715496+00
767c9c8d-7cdc-40af-85ca-96804bf23865	6f484e98-e110-4ceb-8070-e61810c5f108	تم تغيير حالة العرض QT-2026-0036	الحالة الجديدة: قيد الدراسة — العميل: شركة الحياة للصناعات الدوائية	info	quote	505e698c-09ce-4610-8d79-772e36f62ec1	f	2026-08-04 11:19:03.726072+00
c0c72674-9ab0-4fde-9e54-abec4ed219fa	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة مياهنا/مادبا  — المُصدِر: Dr. Ahmad tannerah	info	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 12:32:47.517694+00
7fb52684-62b8-4aa1-ba27-7064906ce527	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة مياهنا/مادبا  — المُصدِر: Dr. Ahmad tannerah	info	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 12:32:47.517694+00
6ce12b10-0abe-45ae-9115-ce7c8a2dc684	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة مياهنا/مادبا  — المُصدِر: Dr. Ahmad tannerah	info	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 12:32:47.517694+00
edbc879a-c732-439e-adc3-56311eebda78	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0006	العميل: شركة الحياة للصناعات الدوائية	info	quote	a3215728-2478-4155-b0a2-d4342a61e744	f	2026-08-04 12:50:17.29708+00
044fd9e5-0f8f-406d-9b9e-0cd6e0361bba	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0006	العميل: شركة الحياة للصناعات الدوائية	info	quote	a3215728-2478-4155-b0a2-d4342a61e744	f	2026-08-04 12:50:17.29708+00
c5e4f1b3-f0ed-471d-a84b-8ffecfbbc236	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0006	العميل: شركة الحياة للصناعات الدوائية	info	quote	a3215728-2478-4155-b0a2-d4342a61e744	f	2026-08-04 12:50:17.29708+00
b5f57d9c-e30b-4c9f-bec4-64ee4ca34a1c	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0034	الحالة الجديدة: تم إصدار فاتورة — العميل: تلسكوب / المختبرات الطبية 	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:01:35.607194+00
6c9bb9fb-24ed-4f28-9ef1-a98e89c1e10a	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0034	الحالة الجديدة: قيد الدراسة — العميل: تلسكوب / المختبرات الطبية 	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:01:52.56301+00
c7d9bb60-e57a-488c-9d3b-af15dff9f646	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0034	الحالة الجديدة: مُعتمد — العميل: تلسكوب / المختبرات الطبية 	success	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:01:57.992821+00
bc713a18-9839-470e-926e-90eff41b0ae6	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0034	العميل: تلسكوب / المختبرات الطبية 	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:01:58.297163+00
c277bd29-44db-410b-8fed-96bbf3dac503	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0034	العميل: تلسكوب / المختبرات الطبية 	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:01:58.297163+00
f275c27c-fbbf-4275-96b6-5c9d5fb91ae4	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0034	العميل: تلسكوب / المختبرات الطبية 	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:01:58.297163+00
625ff5af-8974-4d66-99fb-ff56d9193c27	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0034	الحالة الجديدة: تم إصدار فاتورة — العميل: تلسكوب / المختبرات الطبية 	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:02:01.347515+00
1f93f495-d104-4211-ad8a-64b944ebc1a3	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0034	الحالة الجديدة: قيد الدراسة — العميل: تلسكوب / المختبرات الطبية 	info	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	f	2026-08-04 13:02:05.801218+00
6844c4e0-676d-44de-be21-f2cb5892d424	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0038	الحالة الجديدة: مُعتمد — العميل: شركة مياهنا/مادبا 	success	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 13:04:42.004439+00
4a2b714d-0c30-4fe8-9a41-3e025406001d	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0038	العميل: شركة مياهنا/مادبا 	info	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 13:04:42.316033+00
d78e8211-58f4-4ba5-9dce-39f157bb5a50	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0038	العميل: شركة مياهنا/مادبا 	info	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 13:04:42.316033+00
b830e195-fd4b-49df-95e6-6cba0e598770	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0038	العميل: شركة مياهنا/مادبا 	info	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 13:04:42.316033+00
573a0e8d-81db-4b8d-b483-baa117901a47	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0038	الحالة الجديدة: قيد الدراسة — العميل: شركة مياهنا/مادبا 	info	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	f	2026-08-04 13:04:45.861892+00
d589c36d-5f59-4f78-a22d-56a6435116ef	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: المدارس الاردنية الدولية  — المُصدِر: Dr. Ahmad tannerah	info	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	f	2026-08-05 09:57:43.68041+00
6d2c793e-1b4f-4421-ad8f-c1c6d8e3daa8	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: المدارس الاردنية الدولية  — المُصدِر: Dr. Ahmad tannerah	info	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	f	2026-08-05 09:57:43.68041+00
fb2be780-2380-4fd3-9725-7e820f4dde62	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: المدارس الاردنية الدولية  — المُصدِر: Dr. Ahmad tannerah	info	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	f	2026-08-05 09:57:43.68041+00
\.


--
-- Data for Name: number_sequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.number_sequences (id, prefix, current_value, year) FROM stdin;
order	ORD	11	2026
customer	C	12	2026
draft	2026D	2	2026
quotation	QT	40	2026
\.


--
-- Data for Name: official_letters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.official_letters (id, number, recipient, attention, date, subject, category, body, signer_name, signer_title, use_letterhead, created_by, created_at, updated_at) FROM stdin;
a0daf7ec-1996-400e-ab68-4afdf35355eb	1	جامعة العلوم الاسلامية العالمية	لمن يهمه الأمر	2025-10-22	كتاب انهاء عمل	other	<b>تحية طيبة وبعد :</b><div><b><br></b></div><div><b>يرجى العلم بانه تم الانتهاء من توريد وتوصيل وفحص ومعايرة ادوات واجهزة ومعدات المواد الكيماوية الخاصة بمختبر الكيمياء في مبنى القاعات الصفية وذلك حسب طلب الشراء رقم P.O(Ch-lab-4-00)&nbsp; &nbsp;تاريخ 21/10/2025 وحيث تم التوريد والتسليم في المختبر حسب الاصول</b></div><div><b><br></b></div><div style="text-align: center;"><b>واقبلوا الاحترام والتقدير</b></div>	الدكتور محمد عقاب الجوابرة	الادارة	t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-06-24 14:32:07.654072+00	2026-06-24 14:32:07.654072+00
399e79d2-6f05-45f1-b31b-5618020b5bdc	2	موظفي مؤسسة الحياة العلمية		2012-07-04	تعميم 1/2012	circular	<p class="MsoNormal" align="center" dir="RTL" style="text-align:center"><span lang="AR-JO" style="font-size:48.0pt;mso-bidi-language:AR-JO">تعميم 1/2012</span><span lang="EN-US" dir="LTR" style="font-size:48.0pt;mso-bidi-language:AR-JO"><o:p></o:p></span></p>\n\n<p class="MsoNormal" dir="RTL"><span lang="AR-JO">&nbsp;</span></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">1-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">قال\nرسول الله صلى الله عليه وسلم&nbsp; (اذا كانت\nليلة النصف من شعبان فقوموا ليله وصوموا نهاره ) وعملا بحديث النبي فان جمعية\nالثقافة العربية الاسلامية تدعوكم لحضور قيام ليلة النصف من شعبان اليوم الاربعاء\n4-7-2012 ببرنامج يبدأ بعد صلاة المغرب ويمتد لبعد العشاء يتخلله صلاة المغرب\nجماعة ثم درس ثم مديح ثم صلاة العشاء ثم قيام 8 ركعات والموقع في مصلى مدرسة\nالثقافة العربية في شفا بدران .<o:p></o:p></span></font></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">2-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">ندعوكم\nلحضور بازار جمعية الثقافة العربية الاسلامية في مدرسة الجبيهة التابعة للجمعية\nوذلك يوم الجمعة الموافق 6-07-2012 يتخلله عرض الكتب والاقراص المدمجة والطبق\nالخيري وذلك من بعد صلاة الجمعة ولغاية المغرب </span><span lang="EN-US" dir="LTR" style=""><o:p></o:p></span></font></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">3-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">بمناسبة\nقرب قدوم شهر رمضان نود اعلامكم بقيام الجمعية بتوزيع منشورات خاصة باحكام الصيام\nمع الامساكية ثمن كل 100 نسخة خمس دنانير وهو من الصدقة الجارية ويمكن توكيل\nالجمعية بالتوزيع لمن يرغب بالدفع والتبرع ارجو ان يتواصل مع الدكتور محمد</span><span lang="EN-US" dir="LTR" style=""><o:p></o:p></span></font></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">4-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">بمناسبة\nقرب دخول رمضان نود اعلامكم بقيام الجمعية بعمل حملة تفطير الصائم ثمن كل 100 صرة\nهو 15 دينار ويمكن توكيل الجمعية بالتوزيع لمن يرغب بالتسجيل التواصل مع الدكتور\nمحمد</span></font><span lang="EN-US" dir="LTR" style="font-size:20.0pt;mso-bidi-language:\nAR-JO"><o:p></o:p></span></p>	الدكتور محمد عقاب الجوابرة	الادارة	t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-25 07:37:11.881029+00	2026-06-25 07:37:11.881029+00
c9aca185-3138-479b-a4cf-7e660cce84f8	3	الدكتور خالد احمد طالب شواقفة		2026-06-28	شهادة خبرة	other	<p class="isSelectedEnd"><font size="4" style="">تشهد إدارة <b>مؤسسة الحياة العلمية الطبية الكيماوية</b> بأن&nbsp;</font><font size="4"><b>الدكتور خالد احمد طالب شواقفة</b></font><span style="font-size: large;">&nbsp;</span><b style="font-size: large;">&nbsp;</b><span style="font-size: large;">&nbsp;قد تدرب لديها خلال الفترة من </span><b style="font-size: large;">01/04/2026</b><span style="font-size: large;"> ولغاية </span><b style="font-size: large;">28/06/2026</b><span style="font-size: large;">، بوظيفة مسؤول معرض التجهيزات الطبية والعلمية، بالإضافة إلى مسؤول إدارة التواصل عبر صفحات المؤسسة على منصات التواصل الاجتماعي.</span></p><p class="isSelectedEnd"><font size="4">وخلال فترة تدريبه، أظهر الدكتور خالد مستوىً عالياً من الجدية والالتزام، وكان مجدًّا ومجتهدًا في أداء مهامه، وتميز بحسن السيرة والسلوك، وأدى جميع المسؤوليات الموكلة إليه بكفاءة واقتدار وعلى أكمل وجه.</font></p><p class="isSelectedEnd"><font size="4"><br></font></p><p class="isSelectedEnd"><font size="4">وقد أُعطيت له هذه الشهادة بناءً على طلبه، دون أن يترتب عليها أي مسؤولية تجاه المؤسسة.</font></p><p class="isSelectedEnd"><font size="4"><br></font></p><p><font size="4">وتفضلوا بقبول فائق الاحترام والتقدير.</font></p>\n\n<p class="MsoNormal" align="right" dir="RTL" style="text-align:left;line-height:200%"><br></p>	الدكتور محمد عقاب الجوابرة	الادارة	f	445bc65d-256f-48d3-9367-464a408e657b	2026-06-27 16:59:05.305906+00	2026-06-27 16:59:05.305906+00
41f93b6c-5821-4d3e-85d8-9cc3be56e4d6	4	جامعة العلوم التطبيقية الخاصة 	عميد كلية الاعمال المحترم 	2026-08-03	قبول تدريب 	other	<b>تحية واحتراماً وبعد,<br></b>لا مانع لدينا من قبول تدريب الطالب ايمن رباح محمد علي ورقمه الجامعي 202210186 في أقسامنا المالية الختلفة في الفترة الواقعة ما بين 13\\9\\2026 الى 8\\10\\2026 بواقع 96 ساعة تدريبية.<br><br><b>وتفضلوا بقبول فائق الاحترام.<br></b><br><b>مؤسسة الحياة العلمية الطبية الكيماوية.</b>	الدكتور محمد عقاب الجوابرة	الادارة	t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 09:21:46.514084+00	2026-08-03 09:21:46.514084+00
c6cc8273-29fd-48fe-853e-8284b01298d1	5		To Whom It May Concern	2026-08-05	Employment Certificate	other	<p class="isSelectedEnd" style="text-align: center;"><b><font size="4">Employment Certificate</font></b></p><p class="isSelectedEnd" style="text-align: center;"><strong><br></strong></p><p class="isSelectedEnd" style="text-align: left;"><strong>,To Whom It May Concern</strong></p><p class="isSelectedEnd" style="text-align: left;">This is to certify that <strong>Mr. Osama Taha Alawi</strong> is employed by <strong>Hayat Scientific Medical &amp; Chemical&nbsp; Corp.</strong> as an <strong>Information Technology and Digital Transformation Officer</strong></p><p class="isSelectedEnd" style="text-align: left;">He&nbsp;is currently employed with us on a full-time basis</p><p class="isSelectedEnd" style="text-align: left;">This certificate has been issued upon his request for official purposes</p><p class="isSelectedEnd" style="text-align: left;">Should you require any further information, please do not hesitate to contact us</p><p style="text-align: left;"><br></p>	Dr. Mohammad U.Jawabreh	CEO	t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-04 14:30:45.771037+00	2026-08-04 14:30:45.771037+00
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, sort_order, item_name, description, unit, quantity, unit_price, total_price, origin, delivery, notes, tax_pct) FROM stdin;
493b925a-d4c4-4bdc-ad46-50174139ba2a	823b33c4-edc2-4922-96e3-ea790aaadc1d	0	Disposables Coat  Non-Woven	\N	EACH	220.000	0.650	143.000	CHINA	PROMPT	\N	16.00
f7fadc9c-35b9-4529-bc6b-b53ccca6f0da	823b33c4-edc2-4922-96e3-ea790aaadc1d	1	Disposables Coat Nylon	\N	Each	2000.000	0.065	130.000	CHINA	PROMPT	\N	16.00
392a1a9d-73f6-42fc-9284-9bd5a88bc27c	823b33c4-edc2-4922-96e3-ea790aaadc1d	2	Disposable Face Mask	\N	pk/50	320.000	1.150	368.000	CHINA	PROMPT	\N	16.00
4a5ec599-95ea-4297-bcb1-3c2b4563e8ad	823b33c4-edc2-4922-96e3-ea790aaadc1d	3	Latex Gloves Disposable White Large Size HAYAT Brand	\N	pk/100	350.000	2.660	931.000	THAILAND	PROMPT	\N	16.00
33d77b0f-d472-4da0-82f5-8c2523d9f0f8	823b33c4-edc2-4922-96e3-ea790aaadc1d	4	Latex Gloves Disposable White Medium Size HAYAT Brand	\N	PK/100	500.000	2.660	1330.000	THAILAND	PROMPT	\N	16.00
11c0a639-9a77-4565-9c20-316812fa8c13	823b33c4-edc2-4922-96e3-ea790aaadc1d	5	Latex Gloves Disposable White Small Size HAYAT Brand	\N	PK/100	30.000	2.660	79.800	THAILAND	PROMPT	\N	16.00
cd564ad6-192c-4042-a510-f24224754066	823b33c4-edc2-4922-96e3-ea790aaadc1d	6	Disposable Long Sleeve Gloves Transparent Vergin heavy duty	\N	PK/100	420.000	4.650	1953.000	CHINA	PROMPT	\N	16.00
218dc0a3-bd47-4352-853b-247c3601ef6a	823b33c4-edc2-4922-96e3-ea790aaadc1d	7	Nitrile Gloves Disposable Blue color Small size HAYAT brand	\N	PK/100	30.000	2.660	79.800	THAILAND	PROMPT	\N	16.00
3242649f-b3a8-4466-b197-006fe39467c3	823b33c4-edc2-4922-96e3-ea790aaadc1d	8	Nitrile Gloves Disposable Blue color Medium size HAYAT brand	\N	PK/100	60.000	2.660	159.600	THAILAND	PROMPT	\N	16.00
7f736085-18f2-47de-a33a-5a837e7817fc	823b33c4-edc2-4922-96e3-ea790aaadc1d	9	Nitrile Gloves Disposable Blue color Large size HAYAT brand	\N	PK/100	50.000	2.660	133.000	THAILAND	PROMPT	\N	16.00
b23b77c9-22b0-4cb5-9994-e1262ccef2ed	823b33c4-edc2-4922-96e3-ea790aaadc1d	10	Disposable Shoes Cover CPE 3.8gm heavy duty	\N	PK/100	30.000	2.650	79.500	CHINA	PROMPT	\N	16.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, number, quotation_id, quotation_number, customer_name, currency, total_amount, status, notes, expected_delivery, actual_delivery, created_by, archived, archived_at, created_at, updated_at, archive_note, prepared_by, delivered_by) FROM stdin;
823b33c4-edc2-4922-96e3-ea790aaadc1d	ORD-2026-007	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	شركة الحياة للصناعات الدوائية	JOD	6248.572	delivered	\N	2026-08-02	\N	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-08-01 12:02:12.266131+00	2026-08-04 15:09:31.133247+00	تم تسليم الطلبية للعميل بموجب فاتورة مفوترة رقم 471	عبد الحكيم صمادي 	عبد الصمد 
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, quotation_id, amount, payment_date, method, reference_no, notes, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, username, full_name, email, phone, role, is_active, avatar_url, created_at, updated_at, permissions) FROM stdin;
65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	ahmad	Dr. Ahmad tannerah	hmest1969@gmail.com	\N	employee	t	\N	2026-07-23 13:35:58.415005+00	2026-07-23 13:37:49.306177+00	{"orders_edit": false, "catalog_edit": false, "orders_access": true, "orders_create": true, "orders_delete": false, "quotes_create": true, "quotes_delete": false, "archive_access": false, "catalog_access": true, "customers_edit": true, "letters_access": true, "activity_access": false, "quotes_edit_all": false, "quotes_view_all": true, "customers_access": true, "customers_create": true, "customers_delete": false}
6f484e98-e110-4ceb-8070-e61810c5f108	ahlam	Eng. Ahlam Alyamani	hmest121981@gmail.com	\N	admin	t	\N	2026-07-23 13:50:50.459273+00	2026-07-23 13:50:50.948839+00	{}
445bc65d-256f-48d3-9367-464a408e657b	hmest	Dr. Mohammad U Jawabreh	hmest19811@gmail.com	0798807000	admin	t	\N	2026-05-14 13:37:47.517893+00	2026-07-26 07:24:16.140958+00	{}
ee095348-a2de-4906-a078-0e8a3f3560a9	osama	Eng. Osama Alawy	o.alawy.oa@gmail.com	\N	admin	t	\N	2026-05-14 13:37:47.517893+00	2026-08-01 11:51:51.467388+00	{}
\.


--
-- Data for Name: quotation_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotation_items (id, quotation_id, sort_order, item_name, description, unit, quantity, unit_price, origin, delivery, notes, created_at, tax_pct, option_group) FROM stdin;
1cecc396-165e-4aff-8f2c-c548841cfad6	e35fadc5-6138-42a1-84b2-9b2063825ee7	0	Ammonium Ferrous Sulfate		500gm	1.000	12.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
13c9bca6-567e-45a5-87bb-04d5de0ffe2c	e35fadc5-6138-42a1-84b2-9b2063825ee7	1	potassium Dichromate		500gm	1.000	18.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
f1fbcdce-76a8-4be8-9e5f-917527fe9424	e35fadc5-6138-42a1-84b2-9b2063825ee7	2	Mercuric Sulfate		100gm	1.000	25.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
9c881479-1839-45b2-9f84-a9e432aeb522	e35fadc5-6138-42a1-84b2-9b2063825ee7	3	Silver Sulfate		25gm	1.000	35.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
eec21c0e-bb6f-4fe9-810d-d35d57a6c42a	c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1	0	مجهر بيولوجي عينيتين واربع شيئيات مع كامل اكسسواراته وصندوق خشبي 		جهاز 	1.000	210.000	CHINA	PROMPT		2026-07-21 09:37:54.749606+00	16.00	\N
a7b039dc-9c37-43b3-a142-0ee3238cb4d1	e35fadc5-6138-42a1-84b2-9b2063825ee7	4	-1,10Phene throline Monohydrate		150gm	1.000	0.000	N.A	غير متوفر 		2026-08-05 12:07:25.056958+00	16.00	gmsel9hbm2st7
26cd31d4-1a84-40fb-bf89-1de59d159f3a	e35fadc5-6138-42a1-84b2-9b2063825ee7	5	Ferrous Sulfate Heptahydrate		250gm	1.000	15.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	gmsel9hbm2st7
a24657dd-0a4f-47aa-992c-b24694a4ab70	1032638a-9a54-49ef-bf84-0adb4862a10d	0	كرسي اسنان Ziann Cart		EACH	1.000	5875.000	CHINA	PROMPT		2026-07-21 09:40:57.971919+00	16.00	\N
09c8e3f4-6a27-4172-87b2-81aeecebfcf5	c22be163-9877-485c-8053-e3dfbf094862	0	1\tHeating Incubator Digital Control 20liter		EACH	1.000	235.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
1d119759-8df6-403c-81a2-4ddd39557967	c22be163-9877-485c-8053-e3dfbf094862	1	3\t Analytical Balance, 4 Digits Up to 120gm		EACH	1.000	455.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
96f1ae1d-6ebf-4645-96ec-d0c9560fa2e2	c22be163-9877-485c-8053-e3dfbf094862	2	3\t Analytical Balance, 3 Digits Up to 220gm		EACH	1.000	355.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
152fd349-5d42-48e4-83ae-5d3a907f87fb	c22be163-9877-485c-8053-e3dfbf094862	3	 Hot Plate with stirrer Manual Control Up to 180C		EACH	1.000	165.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
9b2ca220-3585-4f4f-80f6-e9b5ff61e953	c22be163-9877-485c-8053-e3dfbf094862	4	7\tWater Bath with gable cover 7liter		EACH	1.000	110.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
9565e7e3-1c31-43aa-9279-1575734d78a0	c22be163-9877-485c-8053-e3dfbf094862	5	8\tBenchtop pH Meter		EACH	1.000	165.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
9da04dee-1c71-4610-8cf4-33c918ecfcab	c22be163-9877-485c-8053-e3dfbf094862	6	9\tDigital Microscope with LCD screen		EACH	1.000	685.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
8dc4b0d2-c982-4023-89cc-852af4dd8fd9	c22be163-9877-485c-8053-e3dfbf094862	7	Visible Spectrophotometer		EACH	1.000	850.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
2fbfbcbb-1913-43f5-ac73-8c5c050c6cd4	c54c7220-b131-41cb-a654-d9fca2056792	0	كرسي اسنان  Ziann Jumbo 		EACH	1.000	5000.000	CHINA	PROMPT		2026-07-21 09:48:34.892697+00	16.00	\N
b00aa2d7-c977-4763-b52d-0012617d8169	25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	0	كرسي اسنان Ziann Chair  		EACH	1.000	5250.000	CHINA	PROMPT		2026-07-21 09:55:52.787808+00	16.00	\N
7d97dd9c-a7f9-45ce-bf81-df891a639adb	df81a005-5d86-4bd2-a92e-555c33891d12	0	كرسي اسنان Keju Chair 		EACH	1.000	2625.000	CHINA	PROMPT		2026-07-21 09:59:17.311679+00	16.00	\N
6e05c2b0-2136-400b-a827-4ea993f83398	f4484ac3-fe41-4a73-8379-80a9257a185e	0	Low Temperature Circulator RECL30-5		EACH	1.000	2284.000	CHINA	4-8 weeks		2026-07-04 07:02:58.807073+00	16.00	\N
50d3e53e-3030-47dd-a0c7-9a265d05a022	a3215728-2478-4155-b0a2-d4342a61e744	0	Disposable Plastic Scoops 25ml		EACH	200.000	0.790	EUROPE	8-12 WEEKS		2026-07-18 17:18:57.120347+00	16.00	\N
e103e84c-f1a2-45ba-b91f-749d47267be1	e35fadc5-6138-42a1-84b2-9b2063825ee7	6	Total Organic Carbon		500ml	1.000	0.000	N.A	غير متوفر		2026-08-05 12:07:25.056958+00	16.00	gmsel9hbm2st7
62dee6a7-fc40-43c5-9f91-c274b8f100a7	c93f894e-3ecb-40d4-a5f8-6bbfbe2f205d	0	Hydrodistillation ( clevenger apparatus with heating mantle and its accessories) 500ml		EACH	2.000	387.931	CHINA	PROMPT		2026-07-22 10:03:52.100395+00	16.00	\N
4fc664aa-7a81-44a0-aa86-3a62d6358510	7f415e1f-baf2-412b-b49d-7437453aeb95	0	Hydrodistillation (clevenger apparatus with heating mantle and its accessories) 500ml		EACH	1.000	388.000	CHINA	PROMPT		2026-07-22 10:13:33.634196+00	16.00	\N
1c0ba79a-9741-42a0-ac89-5ecbeee70e5f	9ac83342-e490-4896-93fb-04fc3f70b0cb	0	1\tHeating Incubator Digital Control 20liter		EACH	1.000	240.000	CHINA	PROMPT		2026-08-04 09:25:45.72137+00	16.00	\N
22e7068a-08c6-4098-9d0c-ff70cbc5a273	e7dec721-47fa-4b65-9d98-6519600bc45d	0	   BT-TR002 Manual Transfer Stretcher 		EACH	9.000	639.000	CHINA	3-4 months		2026-08-05 08:00:53.015269+00	16.00	gmsepp8xpsjon
b794408e-82fc-4fd7-ba4b-196aba2eeae9	e7dec721-47fa-4b65-9d98-6519600bc45d	1	   YA-AS01 Collapsible ambulance stretcher		EACH	9.000	625.000	CHINA	3-4 months		2026-08-05 08:00:53.015269+00	16.00	gmsepp8xpsjon
1d3444bf-aed1-4e4b-8ec3-6d30857015b1	e7dec721-47fa-4b65-9d98-6519600bc45d	2	MK-B07 Cot		EACH	2.000	300.000	CHINA	3-4 months		2026-08-05 08:00:53.015269+00	16.00	\N
ed6b373f-14f5-4f40-8ff5-97952a0656e7	e7dec721-47fa-4b65-9d98-6519600bc45d	3	MK-P11 Hospital Lockable Medication Trolley		EACH	4.000	490.000	CHINA	3-4 months		2026-08-05 08:00:53.015269+00	16.00	\N
52396ccc-ab87-4db8-a22a-d32a481687d8	e7dec721-47fa-4b65-9d98-6519600bc45d	4	MK-P02 Emergency Trolley		EACH	1.000	350.000	CHINA	3-4 months		2026-08-05 08:00:53.015269+00	16.00	\N
63a7e818-dc06-4eb8-ac0f-c622838a40a0	e7dec721-47fa-4b65-9d98-6519600bc45d	5	SP950 Syringe Pump		EACH	10.000	345.000	CHINA	4-6 WEEKS		2026-08-05 08:00:53.015269+00	16.00	\N
a6a6bc1d-0561-4688-a52e-37552043726b	e7dec721-47fa-4b65-9d98-6519600bc45d	6	SP750 Infusion pump		EACH	3.000	325.000	CHINA	4-6 WEEKS		2026-08-05 08:00:53.015269+00	16.00	\N
3db1a05a-e055-422e-8b25-8393d375c1e4	e7dec721-47fa-4b65-9d98-6519600bc45d	7	TS13 Patient Monitor		EACH	2.000	2130.000	CHINA	4-6 WEEKS		2026-08-05 08:00:53.015269+00	16.00	\N
d646f300-5cbe-4c7d-ae81-19bb41dd2952	deb11bf4-fad8-4379-a302-25be8454c7b3	0	Digital Micromter		EACH	2.000	60.000	CHINA	PROMPT		2026-06-07 08:28:17.182361+00	16.00	\N
e6af06c8-df78-4505-be85-d8d9cf6eaa5f	deb11bf4-fad8-4379-a302-25be8454c7b3	1	Digital Balance 0.1-2000gm with adaptor		EACH	1.000	35.000	CHINA	PROMPT		2026-06-07 08:28:17.182361+00	16.00	\N
167e96fb-bb49-43f7-a535-76d5f01f039c	deb11bf4-fad8-4379-a302-25be8454c7b3	2	Digital Balance 0.01-620gm with adaptor		EACH	1.000	165.000	CHINA	PROMPT		2026-06-07 08:28:17.182361+00	16.00	\N
a2555e5f-3188-445b-a4cf-1e8e1ecac9f9	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	0	يود سائل		500مل	1.000	5.000	HAYAT™	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
16fc20f8-4d9d-447f-8d07-adae4674d6de	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	1	محلول هيدوكسيد الكالسيوم		500مل	1.000	7.000	HAYAT™	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
bc02f5f1-c60c-425a-8a29-648a107343a3	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	2	محلول كربونات الصوديوم		500مل	1.000	5.000	CHINA	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
8b665fea-f8de-47eb-b5cf-18d2cf42b7ce	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	3	يوديد البوتاسيوم		100غم	1.000	18.000	CHINA	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
7dd09109-8ab1-4fd6-8c49-774ca6d17b76	19276c37-9a91-48b0-af67-f9f8a99e8795	0	Disposables Coat Nylon		Each	1450.000	0.065	CHINA	PROMPT		2026-06-07 11:44:49.486971+00	16.00	\N
f1d87333-0a39-4ca2-9c22-44192a6558f9	19276c37-9a91-48b0-af67-f9f8a99e8795	1	Disposables Coat  Non-Woven		EACH	155.000	0.650	CHINA	PROMPT		2026-06-07 11:44:49.486971+00	16.00	\N
2f347d14-7651-4559-b244-fc24be2b8469	c2ece74c-a5df-4ea3-9907-e54b2e5567ad	0	Disposable Syringes 10ml high quality		Each	5000.000	0.053	CHINA	PROMPT		2026-06-07 11:45:08.314915+00	16.00	\N
f5702a0f-a821-4494-8e1f-5713cb053fbf	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	4	هيدروجين بيروكسيد		لتر	1.000	22.000	CHINA	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
4000c031-56c4-473f-8356-06a230a996e1	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	5	ماء مقطر		لتر 	1.000	1.000	HAYAT™	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
aa7ab65f-8c95-42d4-9a8d-6630fc76cd54	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	6	طقم فحص الدم		طقم 	1.000	12.000	JORDAN	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
546b5463-33b8-40b4-97c5-defe780dc1ef	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	7	برادة حديد		500غم	1.000	5.000	HAYAT™	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
84bcd794-9c9d-4201-b1c2-8491841509fa	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	8	شرائح فارغة 		علبة 	1.000	1.000	CHINA	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
47e34282-798e-4d67-b680-ff2860eef489	4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	9	مجسم نصفي 85سم 		EACH	1.000	80.000	INDIA	PROMPT		2026-07-20 09:21:13.211145+00	16.00	\N
dcdaba8f-b920-45ec-adb7-7a813651b3ef	0a15f774-f2b6-4308-9887-8530a3ccfc5e	0	Digital Micromter		EACH	2.000	60.000	CHINA	PROMPT		2026-07-21 07:43:39.749529+00	16.00	\N
78a69207-0a49-4bb6-bc0c-183744f517c5	0a15f774-f2b6-4308-9887-8530a3ccfc5e	1	 PH meter Digital Pen Type superior qulaity With Calibration Solution		EACH	2.000	35.000	CHINA	PROMPT		2026-07-21 07:43:39.749529+00	16.00	\N
059b8569-f5b9-4a54-a412-437883452e42	0a15f774-f2b6-4308-9887-8530a3ccfc5e	2	 PH meter Digital Pen Type With Calibration Solution		EACH	2.000	20.000	CHINA	PROMPT		2026-07-21 07:43:39.749529+00	16.00	\N
82f6824f-cbbf-4fbf-b085-2f798e998a5b	e35fadc5-6138-42a1-84b2-9b2063825ee7	7	Sulfuric Acid		litre	10.000	5.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	gmsel9hbm2st7
424dd1c9-d6be-4121-aff5-b087a0709b58	e35fadc5-6138-42a1-84b2-9b2063825ee7	8	Dipotassium Hydrogen Phosphate		250gm	1.000	20.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
27785212-8052-4d15-9822-4c81b8ba7f08	219269a5-5fdf-4a4a-ad24-5551d478bc55	0	YSB-R10V Pregnancy Testing Device with convex probe and micro-convex probe - (Ysenmed)		EACH	1.000	3440.000	CHINA	4-6 WEEKS		2026-07-28 14:07:06.07801+00	16.00	\N
4ef51fe6-2b01-4e35-b20d-50d7fd64ab2f	219269a5-5fdf-4a4a-ad24-5551d478bc55	1	Slite Veterinary Ultrasound Diagnostic System with convex probe and micro-convex probe - (Dawei)		EACH	1.000	1470.000	CHINA	4-6 WEEKS		2026-07-28 14:07:06.07801+00	16.00	\N
5e545866-17cc-4394-97ee-ed5d409db12d	219269a5-5fdf-4a4a-ad24-5551d478bc55	2	YSMJ-DGT-N23 Class N Instrument sterilizer - (Ysenmed)		EACH	2.000	690.000	CHINA	8-12 WEEKS		2026-07-28 14:07:06.07801+00	16.00	\N
2352c30a-ca78-4eaa-b2b8-1fee0fc9379f	ab3be0df-3b5d-4283-bab0-631e54cc76cd	0	Disposables Coat  Non-Woven		EACH	220.000	0.650	CHINA	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
34455479-3489-4820-8bdc-cbaed067d0c3	ab3be0df-3b5d-4283-bab0-631e54cc76cd	1	Disposables Coat Nylon		Each	2000.000	0.065	CHINA	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
96e34e8b-a73c-4574-b0a4-3b3854cb40b5	ab3be0df-3b5d-4283-bab0-631e54cc76cd	2	Disposable Face Mask		pk/50	320.000	1.150	CHINA	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
cef0c932-ce52-4405-964c-fa39e18d2b54	ab3be0df-3b5d-4283-bab0-631e54cc76cd	3	 Latex Gloves Disposable White Large Size HAYAT Brand		pk/100	350.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
352010c4-802c-44bd-b31b-b2ec78861c14	ab3be0df-3b5d-4283-bab0-631e54cc76cd	4	 Latex Gloves Disposable White Medium Size HAYAT Brand		PK/100	500.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
0a97e9ad-b4ec-4940-8172-0f4dbe39c62d	ab3be0df-3b5d-4283-bab0-631e54cc76cd	5	 Latex Gloves Disposable White Small Size HAYAT Brand		PK/100	30.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
2fc01396-d7d0-4035-8240-60d84e5f9759	ab3be0df-3b5d-4283-bab0-631e54cc76cd	6	Disposable Long Sleeve Gloves Transparent Vergin heavy duty		PK/100	420.000	4.650	CHINA	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
e8d3da72-560b-4ec6-a45e-64c423ab53c1	c9e4f3b0-9a34-44b9-8526-de6755caff8a	0	Paracetamol (fine powder)  		KG	2.000	16.380	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
ad62d1ae-336a-4805-b12b-34d901c736d3	c9e4f3b0-9a34-44b9-8526-de6755caff8a	1	Broken glass plastic box 		EACH	20.000	5.300	JORDAN	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
240bebc1-bfa5-4bf9-a028-ba88707047b2	c9e4f3b0-9a34-44b9-8526-de6755caff8a	2	كفوف كتان		PAIR	10.000	4.310	CHINA	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
4df94a57-f12e-48be-b8ec-4ff70a4e598e	c9e4f3b0-9a34-44b9-8526-de6755caff8a	3	Lanoline wax		KG	5.000	16.380	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
a0f082f2-b672-4d04-b694-e4634e0dc4d2	c9e4f3b0-9a34-44b9-8526-de6755caff8a	4	Sodium borate		KG	2.000	22.410	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
751ec7c7-93a1-4529-b6bf-90aaeb0ee44e	c9e4f3b0-9a34-44b9-8526-de6755caff8a	5	Mineral Oil		KG	10.000	5.600	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
a8bb6c26-1df4-4c76-8e48-99380760432b	c9e4f3b0-9a34-44b9-8526-de6755caff8a	6	KOH		KG	2.000	7.970	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
6fcb8788-53e6-42bb-b7a8-8638451f02e8	c9e4f3b0-9a34-44b9-8526-de6755caff8a	7	Methyl salicylate		LITER	2.000	22.410	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
2fbeb066-b33f-42a3-8c7c-e9c30ff16919	c9e4f3b0-9a34-44b9-8526-de6755caff8a	8	Theobroma oil		KG	2.000	25.000	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
acecc05e-95de-46cd-a288-4881d3b57129	c9e4f3b0-9a34-44b9-8526-de6755caff8a	9	Glycerin		LITER	5.000	5.950	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
29da9cb8-dac1-4317-a7fe-0a6cadfd5b4b	c9e4f3b0-9a34-44b9-8526-de6755caff8a	10	Ethanol 99%		5LITER	10.000	14.560	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
227659dd-d611-4d0c-bebc-950d90ec84ad	c9e4f3b0-9a34-44b9-8526-de6755caff8a	11	Propylene glycol		Liter	1.000	5.950	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
f8702167-df8a-4a3b-bd01-b43440613e54	c9e4f3b0-9a34-44b9-8526-de6755caff8a	12	Cetyl alcohol		KG	5.000	22.410	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
fcf2a9b5-aa3e-443a-beb0-9f7f33f2166e	c9e4f3b0-9a34-44b9-8526-de6755caff8a	13	Empty capsules (size00)		BOX/1000	3.000	22.410	CHINA	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
0fcf424b-65b9-4814-acc9-978e624dfd10	c9e4f3b0-9a34-44b9-8526-de6755caff8a	14	Isopropyl alcohol		LITER	3.000	5.950	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
ff885ef1-215e-4590-bba3-37625c2d6e30	c9e4f3b0-9a34-44b9-8526-de6755caff8a	15	Reagent bottle (100ml)		100ml	100.000	0.845	INDIA	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
00cfebe2-1cef-4b19-a837-5a787c3c347a	c9e4f3b0-9a34-44b9-8526-de6755caff8a	16	Plastic dropper 3ml		500/BOX	5.000	7.850	CHINA	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
7483e900-274b-4649-a21a-4624284ea6d7	c9e4f3b0-9a34-44b9-8526-de6755caff8a	17	Lactose		500g	1.000	5.950	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
1a3d1c06-b567-4953-aca4-eb36c2a9636b	c9e4f3b0-9a34-44b9-8526-de6755caff8a	18	Alpha naphthol		250g	1.000	22.410	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
ec3ce8f5-dec7-4979-b659-5418661337ce	c9e4f3b0-9a34-44b9-8526-de6755caff8a	19	wire loop with holder		EACH	25.000	2.240	INDIA	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
53712698-3e99-417c-a762-717c740b89ef	c9e4f3b0-9a34-44b9-8526-de6755caff8a	20	Rhubarb plant		KG	1.000	142.240	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
f7132e6e-98f7-4f64-8369-2054d1dc213b	c9e4f3b0-9a34-44b9-8526-de6755caff8a	21	Squill plant		KG	1.000	142.240	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
37462a13-81ef-4010-bbe0-4ef242a01b98	c9e4f3b0-9a34-44b9-8526-de6755caff8a	22	A.Absinthium plant		KG	1.000	77.580	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
845d3e91-eeaf-48bf-a8bd-3c4c2e5cbb1a	c9e4f3b0-9a34-44b9-8526-de6755caff8a	23	3.5-dinitrobenzoic acid reagent		LITER	1.000	56.000	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
7b06d1c4-0641-408d-a525-47bc4af59896	c9e4f3b0-9a34-44b9-8526-de6755caff8a	24	Magnesium ribbon		250gram	1.000	56.000	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
79275401-0df2-481f-8373-df07a07674f2	c9e4f3b0-9a34-44b9-8526-de6755caff8a	25	Wanger reagent 		LITER	1.000	163.790	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
2cf87452-f42b-4857-b606-b7aae8de7d53	c9e4f3b0-9a34-44b9-8526-de6755caff8a	26	Dragandorff.s reagent		LITER	1.000	163.790	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
2f696a04-3152-45f8-a825-c711e81592a3	c9e4f3b0-9a34-44b9-8526-de6755caff8a	27	Quillaja bark plant		KG	1.000	142.240	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
4509de30-ac9d-4550-afea-9e206dfe20f4	c9e4f3b0-9a34-44b9-8526-de6755caff8a	28	vanillin		1gram	5.000	5.170	HAYAT™	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
2c9ce348-6861-47d4-9080-7524893034cb	c9e4f3b0-9a34-44b9-8526-de6755caff8a	29	White Lable 0.5x2cm (small)		100/BOX	10.000	9.480	CHINA	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
8b6f8ade-901a-4f3c-bd12-f94ca0fbc964	c9e4f3b0-9a34-44b9-8526-de6755caff8a	30	Paraffin roll		ROLL	5.000	24.140	USA	PROMPT		2026-07-22 11:11:33.920451+00	16.00	\N
39c07fcf-f4a3-49d2-b646-69a072867737	7d636c37-c439-4ec6-9020-5e11691791b2	0	Aluminium Dishes		EACH	100.000	0.100	CHINA	PROMPT		2026-07-22 12:53:24.093947+00	16.00	\N
324492ee-27e3-4ab0-94ec-a7eebc1af2f1	7d636c37-c439-4ec6-9020-5e11691791b2	1	Cylinder glass 100ml		500gm	6.000	3.000	CHINA	PROMPT		2026-07-22 12:53:24.093947+00	16.00	\N
7454dec7-8eec-4e71-906a-e8c2aa48ee36	7d636c37-c439-4ec6-9020-5e11691791b2	2	Ammonium Sulfate		EACH	3.000	18.000	CHINA	PROMPT		2026-07-22 12:53:24.093947+00	16.00	\N
4581c5b1-5755-47aa-8ef0-b893ab71c874	ab3be0df-3b5d-4283-bab0-631e54cc76cd	7	Nitrile Gloves Disposable Blue color Small size HAYAT brand		PK/100	30.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
6468e87a-a2c2-4a45-ac98-e2cea66dfd82	ab3be0df-3b5d-4283-bab0-631e54cc76cd	8	Nitrile Gloves Disposable Blue color Medium size HAYAT brand		PK/100	60.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
60fd27a3-7561-4ac5-970c-908e749b2add	ab3be0df-3b5d-4283-bab0-631e54cc76cd	9	Nitrile Gloves Disposable Blue color Large size HAYAT brand		PK/100	50.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
30c09130-910d-49a6-9ee9-fc82e5d34c37	ab3be0df-3b5d-4283-bab0-631e54cc76cd	10	Disposable Shoes Cover CPE 3.8gm heavy duty		PK/100	30.000	2.650	CHINA	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
559a4f8c-94f7-43c5-8fc6-047cd180a160	65badfea-3e6c-48ed-82d0-890b09317b59	0	Electrode For PH meter BNC type		EACH	9.000	47.000	CHINA	PROMPT		2026-07-23 11:42:57.707417+00	16.00	\N
ffe7beea-415f-4345-986b-df52c3bf2532	18aa97f7-211d-484d-b844-76a42a4e742e	0	Heating Mantle 1000ml digital display		EACH	1.000	165.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
c7b468a0-d576-4c13-a07b-281b5e456f14	18aa97f7-211d-484d-b844-76a42a4e742e	1	Ultrasonic bath 2lit		EACH	1.000	118.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
f5fcaa15-e50c-4989-8f59-83dfdc230374	18aa97f7-211d-484d-b844-76a42a4e742e	2	Hot plate with magnatic stirror		EACH	1.000	165.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
bc1bfddb-3a80-4be8-a57d-fa22100a7a4d	18aa97f7-211d-484d-b844-76a42a4e742e	3	Analytical balance 4 digits		EACH	1.000	460.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
df863e17-4324-429b-b5f1-af189ef605de	e35fadc5-6138-42a1-84b2-9b2063825ee7	9	Potassium diHydrogen Phosphate		250gm	1.000	32.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
1e321249-64f0-42fd-a872-b9f9660b20dd	e35fadc5-6138-42a1-84b2-9b2063825ee7	10	Disodium Hydrogen Phosphate		500gm	1.000	28.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
86e52855-f813-4d42-bf19-dc009fb22e5f	e35fadc5-6138-42a1-84b2-9b2063825ee7	11	Ammonium Chloride		150gm	1.000	12.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
2515b84a-a1b6-4b98-b0e5-6eb1db6fc605	e35fadc5-6138-42a1-84b2-9b2063825ee7	12	Magnesium Sulfate		150gm	1.000	10.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
a38bcc93-b1de-41b5-a478-2528916a00af	e35fadc5-6138-42a1-84b2-9b2063825ee7	13	Calcium Chloride		150gm	1.000	10.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
50f24d0d-4ba8-4453-86b8-d55b2d6cae29	e35fadc5-6138-42a1-84b2-9b2063825ee7	14	Ferric Chloride		150gm	1.000	13.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
888a4a2b-612f-4be6-a2df-40747991f3e5	e35fadc5-6138-42a1-84b2-9b2063825ee7	15	SodiumHydroxide		kg	2.000	7.500	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
ff847f2f-7b4c-430e-9406-e1bcafb77931	198b8bc1-3ab8-4330-883b-79bb6f577b37	0	Latex Gloves Disposable White Medium Size HAYAT Brand		PK/100	1.000	2.660	THAILAND	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
c795c106-ff75-477a-b500-e6f5168a6e48	198b8bc1-3ab8-4330-883b-79bb6f577b37	1	Disposable Arm Sleeve		PK/100	1.000	12.070	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
403c70d4-1f1a-4ba0-9cac-9acf6c3051a1	198b8bc1-3ab8-4330-883b-79bb6f577b37	2	Disposable Face Mask		pk/50	1.000	1.150	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
90b08b4a-f6c1-4d0d-8659-41f3eabe60ef	198b8bc1-3ab8-4330-883b-79bb6f577b37	3	Disposables Coat  Non-Woven		EACH	1.000	0.650	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
454d03b0-355f-4b40-88b7-409b63fa1dc7	198b8bc1-3ab8-4330-883b-79bb6f577b37	4	Disposables Coat Nylon		EACH	1.000	0.070	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
4a58adbf-04a5-41ff-947a-c4432a625cf0	198b8bc1-3ab8-4330-883b-79bb6f577b37	5	Disposable Head Cover		PK/100	1.000	1.250	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
3e151562-7911-4cde-aee2-b13c0fc17de5	e35fadc5-6138-42a1-84b2-9b2063825ee7	16	Sodium Azide		100gm	12.000	40.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
2c432b62-d332-46c8-84ba-7ab3d2912251	e35fadc5-6138-42a1-84b2-9b2063825ee7	17	Sodium Iodide		500gm	1.000	25.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
021fd54d-7412-4056-98b4-776bb082faf3	e35fadc5-6138-42a1-84b2-9b2063825ee7	18	Manganese Sulfate		250gm	2.000	28.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
aa9a5767-4660-408f-b304-fe693d07e2fa	e35fadc5-6138-42a1-84b2-9b2063825ee7	19	Potassium Iodide		500gm	1.000	75.000	INDIA	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
1a488724-c74a-409e-8c83-4a0e415ba27c	e35fadc5-6138-42a1-84b2-9b2063825ee7	20	Sodium Thiosulfate		500gm	1.000	32.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
7b21d50c-76fd-4d91-a6a1-00eb174aa69c	db3a3d6c-b5a0-455d-a33e-1d6222455860	0	Medical Trolley, 2 shelves, one drawer		EACH	1.000	73.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
4e367df6-a025-4f7a-9ab2-1275ea8b3d27	db3a3d6c-b5a0-455d-a33e-1d6222455860	1	Medical Examination Couch		EACH	1.000	86.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
17ac3b1d-28ca-443f-81b1-44c4a52e4f19	db3a3d6c-b5a0-455d-a33e-1d6222455860	2	IV stand , S.S		EACH	1.000	30.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
8b487f04-5693-40a3-871f-1e18894498e6	db3a3d6c-b5a0-455d-a33e-1d6222455860	3	Otoscope		EACH	1.000	58.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
0abf1fd7-d48b-470a-b8cd-6d3cf29534c2	db3a3d6c-b5a0-455d-a33e-1d6222455860	4	CONTEC CMS8000 Multi-Parameter Patient Monitor - without stand		EACH	1.000	754.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
3c1bd5d7-7ea9-4db8-adf2-83b8899bb90f	db3a3d6c-b5a0-455d-a33e-1d6222455860	5	CONTEC CMS5100 Patient Monitor - without stand		EACH	1.000	504.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
03b03e0d-c64a-40f9-a781-9aa80a1d5fb6	db3a3d6c-b5a0-455d-a33e-1d6222455860	6	DW-F3 Trolley Color Ultrasonic\nDiagnostic Apparatus : with convex probe and linear probe		EACH	1.000	5600.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
06c58a70-3929-4630-b953-fcf80dfb36c9	db3a3d6c-b5a0-455d-a33e-1d6222455860	7	Trans Vaginal probe (optional)		EACH	1.000	750.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
fe289de7-6221-49e2-826c-77edb2d3713f	db3a3d6c-b5a0-455d-a33e-1d6222455860	8	Phased array probe (cardiac probe) (optional)		EACH	1.000	970.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
adea6c8c-9f4a-4a85-9548-5f8689bed64a	db3a3d6c-b5a0-455d-a33e-1d6222455860	9	Trans-rectal probe (optional)		EACH	1.000	970.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
cd09058f-d41f-4506-a1aa-9fb2466c4af5	db3a3d6c-b5a0-455d-a33e-1d6222455860	10	Micro convex array probe (optional)		EACH	1.000	6100.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
eb251576-d5f6-4079-af3c-c772e345ff26	db3a3d6c-b5a0-455d-a33e-1d6222455860	11	Thermal printer (optional)		EACH	1.000	980.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
821afc9f-d880-4ea6-9da7-c28d447385d5	db3a3d6c-b5a0-455d-a33e-1d6222455860	12	RD-500A Portable Digital X-ray Radiography System - wired FPD and manual bucky		EACH	1.000	12600.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
41d7a76f-6e59-4f51-80f4-2ce86dd8da2b	db3a3d6c-b5a0-455d-a33e-1d6222455860	13	RD-550C Portable Digital X-ray Radiography System, wireless FPD and All-in-One Trolley/case		EACH	1.000	18000.000	CHINA	4-6 WEEKS		2026-07-27 14:43:42.606658+00	16.00	\N
98d3a92e-3dfe-425c-be00-39d7349b28a7	db3a3d6c-b5a0-455d-a33e-1d6222455860	14	Medical Curtains, 4 folds		EACH	1.000	56.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
c222d6f9-aa86-4cc2-954d-b055330ec0af	db3a3d6c-b5a0-455d-a33e-1d6222455860	15	Examination light		EACH	1.000	142.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
51bdd4cb-a1a7-465b-81b6-b8cb48a7b0f1	db3a3d6c-b5a0-455d-a33e-1d6222455860	16	CONTEC Portable Medical Phlegm Suction Unit		EACH	1.000	56.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
f5ae396d-d52d-4e0b-a2e0-bea55fe3146d	db3a3d6c-b5a0-455d-a33e-1d6222455860	17	Non-contact medical infrared thermometer with LCD display		EACH	1.000	13.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
49d5b3e7-8cf5-43db-a13b-483f85576b9c	db3a3d6c-b5a0-455d-a33e-1d6222455860	18	Compressor Nebulizer		EACH	1.000	24.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
00cde1a1-af80-422c-b3f7-f44e8be4600d	db3a3d6c-b5a0-455d-a33e-1d6222455860	19	Precision Digital White Bathroom Scale		EACH	1.000	13.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
0a9d60fc-8a0e-40c3-8e00-2721c2ede36f	db3a3d6c-b5a0-455d-a33e-1d6222455860	20	Accu-Chek Instant Blood Glucose Meter 		EACH	1.000	15.000	USA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
6c34620a-75fd-476c-8259-398063231553	db3a3d6c-b5a0-455d-a33e-1d6222455860	21	Accu-chek test strips  (pk/50)		EACH	1.000	15.000	USA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
54323ce1-ebde-4cc8-b2a0-0b9d87b46de1	db3a3d6c-b5a0-455d-a33e-1d6222455860	22	Backless Adjustable Lab Chair		EACH	1.000	16.000	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
d7d17f16-8f21-47fc-bcae-93f5256d2525	db3a3d6c-b5a0-455d-a33e-1d6222455860	23	Fire Blanket 100x100cm		EACH	1.000	15.500	CHINA	PROMPT		2026-07-27 14:43:42.606658+00	16.00	\N
b2746a86-1352-46f1-8426-ecd57946ab37	e35fadc5-6138-42a1-84b2-9b2063825ee7	21	Potassium Hydrogen di Iodate		150gm	1.000	0.000	N.A	غير متوفر 		2026-08-05 12:07:25.056958+00	16.00	\N
0287a45c-c928-450f-98b7-6e81800a8ed1	e35fadc5-6138-42a1-84b2-9b2063825ee7	22	Starch Soluble		250gm	1.000	8.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
55454d97-9409-43d8-8659-59b7a8310b9f	e35fadc5-6138-42a1-84b2-9b2063825ee7	23	Salysalic Acid		150gm	1.000	12.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
e52e20ae-9c6d-4d33-9af9-de26052311fd	e35fadc5-6138-42a1-84b2-9b2063825ee7	24	Glucose		150gm	1.000	6.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
8ae58088-562b-4f7b-8022-43f26e971a6b	e35fadc5-6138-42a1-84b2-9b2063825ee7	25	Glutamic Acid		150gm	1.000	18.000	HAYAT™	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
fc66206b-37d0-4b0a-b3ae-c435bd56a26d	e35fadc5-6138-42a1-84b2-9b2063825ee7	26	Celite 545		500gm	1.000	0.000	N.A	غير متوفر 		2026-08-05 12:07:25.056958+00	16.00	\N
f3fe1579-6e6e-4dd4-8137-8e0eec807627	e35fadc5-6138-42a1-84b2-9b2063825ee7	27	Sodium Chloride		250gm	1.000	6.000	INDIA	PROMPT		2026-08-05 12:07:25.056958+00	16.00	\N
352be787-3f44-411d-835d-3d39f78e46c1	e35fadc5-6138-42a1-84b2-9b2063825ee7	28	Formazin Turbidity Standard (4000 NTU)		250GM	1.000	0.000	N.A	غير متوفر 		2026-08-05 12:07:25.056958+00	16.00	gmsfyms8390kw
b889675b-f5b8-4061-97d6-43cb20f00fd2	e35fadc5-6138-42a1-84b2-9b2063825ee7	29	Glass Microfiber Filters		pk	50.000	0.000	N.A	غير متوفر		2026-08-05 12:07:25.056958+00	16.00	gmsfyms8390kw
6017ac18-6e3f-49bc-81bf-e0381a141a8e	95edd244-8e7a-47ce-9210-d8d3595a72fb	0	Patient Gown, elastic, 30gsm, dark blue, XL (length 130 cm, width 150cm)		EACH	50000.000	0.440	JORDAN	3-4 weeks		2026-08-01 11:56:52.283043+00	0.00	\N
f410d008-3367-449b-bb0e-f8dc6295e08f	c02833fb-95b8-4e6b-af6d-2104455d0623	0	Safety Chemical Cabinet 12L		EACH	1.000	410.000	CHINA	PROMPT		2026-08-05 12:36:03.934582+00	16.00	\N
bd5a0726-4e0f-479f-9258-e29cc69d64ed	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	0	Vertical Electric Heating Air Blast Drying Oven 20Lit Model WGL-20BE		EACH	1.000	250.000	CHINA	PROMPT		2026-08-04 11:09:52.325033+00	16.00	\N
f241a4fe-141c-491a-ad12-84a2a75520ea	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	1	Biological Microscope BIO-001		EACH	1.000	245.690	CHINA	PROMPT		2026-08-04 11:09:52.325033+00	16.00	\N
3b92fbc6-c5be-440e-995b-5ad9c990ac21	0460215c-ff4b-486f-b4b8-d780c6931ef2	0	Nuclear Radiation Detector HFS-10 		EACH	1.000	465.000	CHINA	PROMPT		2026-08-04 11:10:23.463736+00	16.00	\N
fa439fef-fccc-4819-a0ea-0f67b250a78f	0460215c-ff4b-486f-b4b8-d780c6931ef2	1	Electromagnetic Radiation Tester		EACH	1.000	265.000	CHINA	PROMPT		2026-08-04 11:10:23.463736+00	16.00	\N
113c7833-64b7-44f8-9493-1c8f2e141147	c02833fb-95b8-4e6b-af6d-2104455d0623	1	Chemical Spill Kit		kit	1.000	145.000	CHINA	PROMPT		2026-08-05 12:36:03.934582+00	16.00	\N
96e92e4a-c155-4a4b-9592-b963db7946d7	c02833fb-95b8-4e6b-af6d-2104455d0623	2	Biological Spill Kit		kit	1.000	85.000	CHINA	PROMPT		2026-08-05 12:36:03.934582+00	16.00	\N
9a1b8821-39f0-4b75-af23-524eed28b3ef	c02833fb-95b8-4e6b-af6d-2104455d0623	3	حاويات نفايات طبية مغلقة في اماكن العمل 		EACH	5.000	20.000	CHINA	PROMPT		2026-08-05 12:36:03.934582+00	16.00	\N
924223e6-e8ab-44c5-b2e5-cd991a6444d7	c02833fb-95b8-4e6b-af6d-2104455d0623	4	حاويات نفايات طبية مغلقة للدم 5لتر 		EACH	5.000	4.500	CHINA	PROMPT		2026-08-05 12:36:03.934582+00	16.00	\N
43c748de-23fe-426b-b342-fffa5f6a5385	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	10	رف تجفيف 		EACH	1.000	25.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
baf488cb-d8f1-4269-87da-820a340195f2	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	11	لوح حكاكة 		EACH	1.000	4.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
89e5037f-00bb-4d42-a260-53359c57ac48	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	12	جهاز انبوب الطيف 		جهاز 	1.000	85.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
6cb70da2-12c6-4783-b33e-f2c15e29d3d0	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	13	تلسكوب فلكي  		جهاز	1.000	150.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
f17bb877-8572-4a30-b4a9-e4ae77bc5a27	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	14	نموذج جلد الانسان 		EACH	1.000	22.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
a9022558-14c2-46ac-9fcb-a8a68c7e3143	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	15	نموذج الجهاز العضلي  		EACH	1.000	85.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
90129493-6733-49f1-8cc3-36dc522352f9	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	16	نموذج الجهاز الهضمي 		EACH	1.000	22.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
bb7b2ee1-93b2-4668-86cf-30a0077cb95b	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	17	مرآة مسطحة 		EACH	4.000	1.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
dafa26b3-4a1f-4f07-9415-ab4a9bcc99b2	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	18	مصابيح كهربائية صغيرة 		EACH	40.000	0.180	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
6f91d4fa-5d1e-4ecd-9c08-c1cd156b5cb3	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	19	حامل بطاريات 		EACH	10.000	2.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	gmsfwspwgfui9
fcd67e81-81ca-4074-9fd3-5f9c1fe3e960	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	20	حامل مصابيح 		EACH	10.000	0.350	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	gmsfwspwgfui9
35711f6d-0ff2-4d44-a0a4-0ddc14980930	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	21	مفتاح 		EACH	10.000	0.500	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
36a855d9-1955-4eb3-923a-ea7afee2cd05	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	22	اسلاك فم التمساح 		EACH	30.000	0.350	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
1ba15d71-de91-4ca9-adf9-d2ba0396e56d	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	23	ماتور صغير 		EACH	5.000	2.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
62967ae0-c6eb-4e30-add8-69049ed69bc0	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	24	جرس صغير 		EACH	5.000	2.500	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	gmsfwvu7yaryf
c0a3d49c-1d56-4a5d-bea2-07723e4f8ee9	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	25	انابيب اختبار 		EACH	30.000	0.250	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	gmsfwvu7yaryf
ee8e9871-fc6e-45b7-bedf-027b16eddb5a	505e698c-09ce-4610-8d79-772e36f62ec1	0	Digital Heating Mantle (1 Liter)		EACH	1.000	165.000	CHINA	PROMPT		2026-08-03 14:14:21.642604+00	16.00	\N
5d9d81ac-8c61-4dc4-b758-62103f56d75a	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	0	Capillary Tube For TLC 1-5 ul		PK/100	2.000	14.000	EUROPE	PROMPT		2026-08-02 06:27:24.91528+00	16.00	\N
0546ebbc-7372-47dc-a6ec-b0d26de0c0c7	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	1	Capillary Tube For TLC 10-50 ul		PK/100	2.000	14.000	EUROPE	PROMPT		2026-08-02 06:27:24.91528+00	16.00	\N
c2e9eeb4-af0f-48a1-89d6-3c0ef085cea5	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	0	Amber Vials Glass Screw Top 2ml		PK/100	100.000	14.000	FISHER - EUROPE	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
520b269c-7f61-4263-89c1-aad07d00cc50	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	1	Clear Vials Glass Screw Top 2ml		PK/100	100.000	11.000	FISHER - EUROPE	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
f98fe0a2-7ab0-4ad2-9f9f-ccdf36e02787	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	2	Parafilm 100 Feet Not 50 Feet		EACH	20.000	24.000	USA	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
e8aa084c-d4b3-42c9-a253-7028e1134085	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	3	Plastic Dropper Graduated 3ml		PK/100	30.000	8.750	CHINA	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
6320ddd4-b4e4-4f6e-b2d1-c55aef9cafa5	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	4	Vials  Rack		EACH	10.000	8.750	CHINA	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
013e9a72-a64b-4dc1-8222-0450009b41b5	0877fc34-9ecb-4956-9fbe-8818861c219c	0	 Nylon Disposable filter Syringe 0.45ul Non Sterile 		PK/100	5.000	28.000	CHINA	PROMPT		2026-08-02 06:38:13.860324+00	16.00	\N
d73308eb-41be-4a36-8edc-c0580b707205	0877fc34-9ecb-4956-9fbe-8818861c219c	1	 Nylon Disposable filter Syringe 0.45ul Sterile 		PK/50	5.000	28.000	CHINA	PROMPT		2026-08-02 06:38:13.860324+00	16.00	\N
3d2bbfbd-505c-4e23-9a42-3d5549a83f94	75bb058a-1ceb-4c1e-b843-c5006a930fd6	0	مجهر بيولوجي عينية واربع شيئيات مع حقيبة وكامل ملحقاته		جهاز	1.000	110.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
c00c3ee0-20cb-4250-a2c0-e14d91bad00c	75bb058a-1ceb-4c1e-b843-c5006a930fd6	1	عدسات محدبة ومقعرة 		EACH	6.000	1.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
088d99f5-edfe-4229-9776-23bd3545ce11	75bb058a-1ceb-4c1e-b843-c5006a930fd6	2	مرايا محدبة ومقعرة ومستوية 		EACH	6.000	1.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
d731d96c-e714-4e1d-a617-a5766cca609a	75bb058a-1ceb-4c1e-b843-c5006a930fd6	3	حامل عدسات 		EACH	3.000	1.250	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
0b6e7a8f-0ab5-47b0-98af-c004d87289a9	75bb058a-1ceb-4c1e-b843-c5006a930fd6	4	ضوء ليزر		EACH	1.000	5.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
c271f606-ce5f-495a-a8f7-848fb1634e06	75bb058a-1ceb-4c1e-b843-c5006a930fd6	5	جهاز الناقوس والجرس كامل 		EACH	1.000	38.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
9644e18f-4a2e-4dc6-943b-5c17905c4b20	75bb058a-1ceb-4c1e-b843-c5006a930fd6	6	بطاريات متنوعة 		مجموعة 	1.000	8.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
8f32e3db-058b-4045-9452-f6987152e840	75bb058a-1ceb-4c1e-b843-c5006a930fd6	7	مصابيح صغيرة 		علبة 	1.000	5.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
426ffa3f-e0a7-435d-8b7c-a9e11a6be670	75bb058a-1ceb-4c1e-b843-c5006a930fd6	8	أسلاك فم التمساح 		مجموعة/10	1.000	4.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
f5c279c3-f788-462f-9ccb-ffb95056d63b	75bb058a-1ceb-4c1e-b843-c5006a930fd6	9	انابيب اختبار 		EACH	10.000	0.300	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
27080bb6-b25c-43d9-9498-a4d2957ce700	75bb058a-1ceb-4c1e-b843-c5006a930fd6	10	حاما انابيب 		EACH	1.000	5.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
a3c7b35d-7a4f-49ee-8690-9f6771e436e5	75bb058a-1ceb-4c1e-b843-c5006a930fd6	11	ورق تباع الشمس الاحمر والازرق 		باكيت 	2.000	1.500	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
ba71fae7-bf4e-461f-8657-48ac6f1a715b	75bb058a-1ceb-4c1e-b843-c5006a930fd6	12	قفازات لاتكس		باكيت	1.000	3.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
b4328a0a-7832-4878-8304-15c2f3c07df1	75bb058a-1ceb-4c1e-b843-c5006a930fd6	13	نظارات واقية 		EACH	1.000	1.500	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
8ac3d34f-4cab-44a5-879e-5d35106900cf	75bb058a-1ceb-4c1e-b843-c5006a930fd6	14	كمامات 		باكيت	1.000	1.500	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
168c2704-cbe7-4da6-a77c-19765b6669e2	75bb058a-1ceb-4c1e-b843-c5006a930fd6	15	معطف ابيض 		EACH	1.000	8.500	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
17a780bf-05e0-4bf4-9ccb-666207b5bbf3	75bb058a-1ceb-4c1e-b843-c5006a930fd6	16	طقم صخور متنوعة 		طقم	1.000	20.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
86363b0d-823f-42e4-900f-02ec1f537472	75bb058a-1ceb-4c1e-b843-c5006a930fd6	17	لوحة السلامة العامة في المختبرات 		EACH	1.000	10.000	CHINA	PROMPT		2026-08-02 06:47:02.804531+00	16.00	\N
545bc365-320b-4599-887e-bde32839f8af	79f9499f-31c6-4226-91d4-6c05ba279ab8	0	Potometer		EACH	2.000	25.000	CHINA	PROMPT		2026-08-02 06:47:12.99672+00	16.00	\N
9126d7e9-6ed6-41f3-9c5c-188d601bd758	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	0	Van de Graff generater		EACH	1.000	205.000	CHINA	PROMPT		2026-08-02 06:47:22.641945+00	16.00	\N
269352e6-1d55-4b05-9ec2-141a74614d6f	f61ede0a-f287-4823-9f93-08362eae21f2	0	Latex Gloves 5.3gm white HAYAT brand		pk/100	2000.000	2.390	THAILAND	PROMPT		2026-08-02 08:19:51.95556+00	16.00	\N
9ac211df-2a5c-448b-a8dd-c10d8c08af40	50143d1a-360b-484f-8d5a-23172401aa7d	0	Basic CPR Model Half Body  XC-404		EACH	1.000	690.000	CHINA	PROMPT		2026-08-03 06:15:06.347553+00	16.00	\N
afb7f895-3a93-4221-abb1-c19b9ee20007	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	0	مضخة تفريغ هواء		EACH	1.000	20.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
52b8d351-92e9-47e0-a929-015e3986272f	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	1	ناقوس 		EACH	1.000	25.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
a82d2b73-d3bc-4cfc-a2b9-cc19ad1cb85b	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	2	شرائح مجهرية جاهزة 		طقم/25	2.000	30.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
99304cef-a1c0-454d-b10a-fc31bd9088d7	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	3	أطباق بتري 		EACH	20.000	0.100	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
a7ccdc78-782f-4142-98a5-b13a262c35d0	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	4	أوراق تباع الشمس احمر وازرق		باكيت	4.000	1.250	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
d087076c-b70b-46eb-a932-9a678da105f1	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	5	قفازات لاتكس		باكيت	4.000	3.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
40ace392-73cf-4ecf-8900-bc9e6b386942	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	6	ماء مقطر 		20لتر	1.000	8.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
3f3bacb7-b532-4d85-a90b-4e757de63068	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	7	بيروكسيد الهيدروجين 		لتر	1.000	15.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
2a0a35b4-8e73-4cee-928b-54b90f9b89bb	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	8	كاشف الفينوافثالين 		100مل	1.000	6.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
a5be517e-4433-41ba-908e-1b16bc3c0f4a	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	9	ميكروسكوب  		جهاز 	4.000	100.000	CHINA	PROMPT		2026-08-05 09:57:41.925896+00	16.00	\N
\.


--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotations (id, number, customer_name, attention, phone, address, date, reference, currency, delivery, subtotal, discount_pct, discount_amt, grand_total, tax_pct, tax_amt, nett_price, notes, terms, prepared_by, status, created_by, archived, archived_at, created_at, updated_at, customer_id, valid_until, discount_type, discount_fixed, deleted_at, deleted_by, delete_reason, quote_type, detailed_layout, archive_note) FROM stdin;
8d865c1b-7081-4faf-b0c6-2b4877aaadb4	QT-2026-0039	المدارس الاردنية الدولية 	قسم المشتريات المحترمين	0796972176		2026-08-05		JOD	2-4 WEEKS	1015.200	0.00	0.000	0.000	16.00	162.432	1177.632	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة 		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-05 09:57:41.476817+00	2026-08-05 09:57:41.476817+00	\N	2026-09-04	pct	0	\N	\N	\N	quote	f	\N
f61ede0a-f287-4823-9f93-08362eae21f2	QT-2026-0011	شركة دار الدواء	قسم المشتريات المحترمين			2026-07-21	-	JOD	PROMPT	4780.000	0.00	0.000	0.000	16.00	764.800	5544.800			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 09:38:35.574845+00	2026-08-02 08:19:51.055511+00	2d8619b2-afd9-4a41-a81c-3eefc0f15722	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
c2ece74c-a5df-4ea3-9907-e54b2e5567ad	QT-2026-0001	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين 	064162607		2026-05-21	Disposable Syringes 10ml	JOD	PROMPT	265.000	0.00	0.000	0.000	16.00	42.400	307.400			\N	rejected	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 06:53:45.923+00	2026-05-21 14:42:33.327369+00	2026-08-03 06:53:46.500058+00	\N	2026-07-01	pct	0	\N	\N	\N	quote	t	تم الشراء من جهة اخرى بسبب السعر
c22be163-9877-485c-8053-e3dfbf094862	QT-2026-0004	مؤسسة الموارد للتجهيزات الطبية	قسم المشتريات المحترمين	\N		2026-06-07	Lab Equipments	JOD	PROMPT	3020.000	0.00	0.000	0.000	16.00	483.200	3503.200	\N		\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:54:45.979+00	2026-06-07 10:47:13.820927+00	2026-08-03 06:54:46.830964+00	c188bbff-81c5-4dfb-a0ad-7e985f6c8d6a	2026-08-30	pct	0	\N	\N	\N	quote	t	تم تقديم العرض لجهة وسيطة ولم يتم احالة العرض
4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	QT-2026-0007	مدارس اكاديمية الاتفاق الدولية	قسم المشتريات المحترمين			2026-07-20	عرض النادي الصيفي	JOD	PROMPT	156.000	0.00	0.000	0.000	16.00	24.960	180.960	للاستفسار والتواصل مع الدكتور احمد تنيرة على موبايل 0798802031		\N	approved	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:55:04.193+00	2026-07-20 08:40:04.187543+00	2026-08-03 06:55:04.982939+00	9b8362b9-9253-4971-b79f-be458d346b26	2026-09-30	pct	0	\N	\N	\N	quote	t	تمت احالة كامل الطلبية على المؤسسة ولله الحمد
19276c37-9a91-48b0-af67-f9f8a99e8795	QT-2026-0002	شركة الحياة للصناعات الدوائية	قسم المشتريات	064162607		2026-05-21	Disposable Coats	JOD	PROMPT	195.000	0.00	0.000	0.000	16.00	31.200	226.200			\N	cancelled	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 13:45:29.243+00	2026-05-21 15:29:54.721504+00	2026-08-03 13:45:30.223546+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-07-30	pct	0	\N	\N	\N	quote	t	تم تحويله الى طلب اخر من المؤسسة بموجب عرض سعر رقم 22/2026
5f8785a4-1258-4ca3-ac8e-91a692e48ba5	QT-2026-0033	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	قسم المشتريات المحترمين	00962790117273		2026-08-03	Microscope -Drying Oven	JOD	PROMPT	495.690	0.00	0.000	0.000	16.00	79.310	575.000			\N	sent	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-03 07:46:50.672363+00	2026-08-04 11:09:51.702105+00	cd40c449-f543-4142-8804-dcc8838ac95e	2026-09-02	pct	0	\N	\N	\N	quote	t	\N
a3215728-2478-4155-b0a2-d4342a61e744	QT-2026-0006	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-18	Scoops 25ml	JOD	PROMPT	158.000	0.00	0.000	0.000	16.00	25.280	183.280	From ISO LAB		\N	approved	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-18 17:18:56.640512+00	2026-08-04 12:51:05.305563+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	t	تم اعتماد الطلب
c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1	QT-2026-0009	مدارس جمعية خليل الرحمن -العقبة 	إدارة المشتريات	0795845888		2026-07-21		JOD	PROMPT	210.000	0.00	0.000	0.000	0.00	0.000	210.000	لاي استفسار الاتصال على 0798802031  د. احمد تنيرة 		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 08:38:56.027224+00	2026-07-21 09:37:54.044099+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	\N
f4484ac3-fe41-4a73-8379-80a9257a185e	QT-2026-0005	الجامعة الأردنية	دائرة اللوازم المركزية - شعبة تأمين مستلزمات البحث العلمي			2026-06-30	مناقصة طلب شراء رقم (262202)  بحث د. يحيى طبازه - كلية الصيدلة - قسم العلوم الصيدلانية	JOD	4-8 weeks	2284.000	0.00	0.000	0.000	16.00	365.440	2649.440	الدفع خلال (60) يوم من تاريخ التوريد		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-06-30 10:19:20.795436+00	2026-07-04 07:02:58.240069+00	8b9b4c0a-eede-4acb-9e59-8eefab8e4375	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	 جمعية خليل الرحمن - النزهة 	إدارة المشتريات	0795845888		2026-07-21		JOD	PROMPT	5875.000	0.00	0.000	0.000	16.00	940.000	6815.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 09:18:30.544996+00	2026-07-21 09:40:57.305516+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	\N
0a15f774-f2b6-4308-9887-8530a3ccfc5e	QT-2026-0008	الشركة النوعية للكرتون	قسم المشتريات المحترمين	0797311208		2026-07-21	REQ20260939 - Micrometer	JOD	PROMPT	230.000	0.00	0.000	0.000	16.00	36.800	266.800			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 07:41:42.683116+00	2026-07-21 07:43:39.153405+00	a75c3c0c-7657-4be5-9db9-8879815e77ff	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
c9e4f3b0-9a34-44b9-8526-de6755caff8a	QT-2026-0017	جامعة العلوم التطبيقية الخاصة	قسم المشتريات المحترمين			2026-07-22	RFQ-ASU-58	JOD	PROMPT	2247.110	0.00	0.000	0.000	16.00	359.538	2606.648			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-22 10:55:19.069966+00	2026-07-22 11:11:33.26947+00	\N	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
c54c7220-b131-41cb-a654-d9fca2056792	QT-2026-0012	جمعية خليل الرحمن -النزهة 	مدير المشتريات			2026-07-21		JOD	PROMPT	5000.000	0.00	0.000	0.000	16.00	800.000	5800.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره\n		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 09:48:34.463945+00	2026-07-21 09:48:34.463945+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	\N
25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	QT-2026-0013	جمعية خليل الرحمن -النزهة 	إدارة المشتريات			2026-07-21		JOD	PROMPT	5250.000	0.00	0.000	0.000	16.00	840.000	6090.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 09:55:52.297358+00	2026-07-21 09:55:52.297358+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	\N
df81a005-5d86-4bd2-a92e-555c33891d12	QT-2026-0014	جمعية خليل الرحمن -النزهه 	إدارة المشتريات	0795845888		2026-07-21		JOD	PROMPT	2625.000	0.00	0.000	0.000	16.00	420.000	3045.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره 		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 09:59:16.931125+00	2026-07-21 09:59:16.931125+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	\N
7d636c37-c439-4ec6-9020-5e11691791b2	QT-2026-0018	مصنع الخميرة 	إدارة المشتريات	0792221816		2026-07-22		JOD	PROMPT	82.000	0.00	0.000	0.000	16.00	13.120	95.120	لاي استفسار الرجاء الاتصال على 0798802031 		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-22 12:53:23.593863+00	2026-07-22 12:53:23.593863+00	\N	2026-08-22	pct	0	\N	\N	\N	quote	t	\N
c93f894e-3ecb-40d4-a5f8-6bbfbe2f205d	QT-2026-0015	الجامعة الأردنية	قسم المشتريات المحترمين			2026-07-22	مخصصات رقم 262324 حاجة د. راميا بقاعين	JOD	PROMPT	775.862	0.00	0.000	0.000	16.00	124.138	900.000			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-22 10:01:23.782863+00	2026-07-22 10:03:51.511449+00	8b9b4c0a-eede-4acb-9e59-8eefab8e4375	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
65badfea-3e6c-48ed-82d0-890b09317b59	QT-2026-0020	جامعة الشرق الاوسط 	قسم المشتريات المحترمين			2026-07-23	PH electrode	JOD	PROMPT	423.000	0.00	0.000	0.000	16.00	67.680	490.680			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-23 11:41:08.138111+00	2026-07-23 11:42:57.079923+00	75cd4de7-e08c-430e-8291-6226da18a49a	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
18aa97f7-211d-484d-b844-76a42a4e742e	QT-2026-0019	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-23	Lab Equipments - Mantle	JOD	PROMPT	908.000	0.00	0.000	0.000	16.00	145.280	1053.280	المواد متوفر للمعاينة حالا في حال رغبتكم 		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-23 06:51:15.445682+00	2026-07-27 07:33:23.752566+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	QT-2026-0021	مدارس جمعية خليل الرحمن- العقبة	مدير المشتريات			2026-07-27		JOD	PROMPT	205.000	0.00	0.000	0.000	0.00	32.800	237.800	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-07-27 06:09:30.914774+00	2026-08-02 06:48:39.770517+00	\N	2026-08-27	pct	0	\N	\N	\N	quote	t	\N
7f415e1f-baf2-412b-b49d-7437453aeb95	QT-2026-0016	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-22		JOD	PROMPT	388.000	0.00	0.000	0.000	16.00	62.080	450.080			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 13:40:59.069+00	2026-07-22 10:13:33.294016+00	2026-08-03 13:41:00.302192+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	t	الادعاء من المصنع بان المطلوب ليس نفس العينة المرسلة علما انه تم ارسال العينة الى مالك الخوالدة لكن تم رفضه من المختبرات
db3a3d6c-b5a0-455d-a33e-1d6222455860	QT-2026-0023	جمعية مؤسسة الزكاة الأمريكية	قسم المشتريات المحترمين			2026-07-27	عطاء رقم 301/2026 : شراء وتوريد معدات طبية لصالح العيادة الخيرية التابعة للجمعية في مخيم غزة - جرش	JOD		47840.500	0.00	0.000	0.000	16.00	7654.480	55494.980	الدفع 50% عند توقيع الاتفاقية ، 25% عند الاستلام ، 25% بعد انتهاء المشروع\nالدفع عن طريق حوالة بنكية أو شيك بنكي		\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-07-27 14:42:00.930163+00	2026-08-01 12:00:34.839934+00	\N	2026-10-30	pct	0	\N	\N	\N	quote	t	\N
219269a5-5fdf-4a4a-ad24-5551d478bc55	QT-2026-0025	جمعية هيلفيتاس السويسرية HELVETAS	قسم المشتريات المحترمين			2026-07-28	ٌRFQ Ref: 11-26	JOD	4-6 WEEKS	6290.000	0.00	0.000	0.000	16.00	1006.400	7296.400			\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-07-28 14:07:05.648253+00	2026-07-28 14:07:05.648253+00	\N	2026-09-30	pct	0	\N	\N	\N	quote	t	\N
c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	تلسكوب / المختبرات الطبية 	قسم المشتريات المحترمين	0785699076		2026-08-03		JOD	PROMPT	762.500	0.00	0.000	0.000	16.00	122.000	884.500	لاي استفسار الاتصال على 0798802031 احمد تنيره		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-03 12:42:10.558812+00	2026-08-05 12:36:03.303501+00	\N	2026-09-02	pct	0	\N	\N	\N	quote	t	\N
e7dec721-47fa-4b65-9d98-6519600bc45d	QT-2026-0037	شركة روابي الاردن للمستلزمات و الاجهزة الطبية	قسم المشتريات المحترمين			2026-08-04		JOD		17346.000	0.00	0.000	0.000	16.00	2775.360	20121.360			\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-08-04 11:16:02.05324+00	2026-08-05 08:00:52.376986+00	\N	2026-09-03	pct	0	\N	\N	\N	quote	t	\N
e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0040	شركة مياهنا/مادبا 	السيد رمزي فراج 	0772467253		2026-08-04		JOD	PROMPT	998.000	0.00	0.000	0.000	16.00	159.680	1157.680	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيره		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-04 12:32:45.484673+00	2026-08-05 12:07:24.263886+00	\N	2026-09-03	pct	0	\N	\N	\N	quote	f	\N
95edd244-8e7a-47ce-9210-d8d3595a72fb	QT-2026-0026	مديرية الخدمات الطبية الملكية 				2026-07-29	Patient Gown	JOD	3-4 weeks	22000.000	0.00	0.000	0.000	0.00	0.000	22000.000	* السعر أعلاه للكمية المذكورة تحديدا\n* مدة صلاحية العرض 30 يوم\n* مدة التسليم خلال 3 الى 4 أسابيع\n* الأسعار بالدينار الأردني غير شامل الضريبة العامة على المبيعات واصل مستودعاتكم		\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-07-29 10:01:03.423827+00	2026-08-01 11:56:51.693217+00	\N	2026-08-30	pct	0	\N	\N	\N	quote	t	\N
0877fc34-9ecb-4956-9fbe-8818861c219c	QT-2026-0031	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-02	Filter Syringes 0.45	JOD	PROMPT	280.000	0.00	0.000	0.000	16.00	44.800	324.800			\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 13:08:23.765+00	2026-08-02 06:38:13.498991+00	2026-08-02 13:08:23.502204+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	التاخر في ارسال عرض السعر للعميل وتم الشراء من مصدر اخر
4e71dbec-a2b7-4edc-8a71-b5a850689dfe	QT-2026-0030	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-02	Vials - Parafilm	JOD	PROMPT	3330.000	0.00	0.000	0.000	16.00	532.800	3862.800			\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 13:08:55.19+00	2026-08-02 06:33:15.804239+00	2026-08-02 13:08:55.074315+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	التاخر في ارسال عرض السعر للعميل وتم الطلب من مصدر اخر
50143d1a-360b-484f-8d5a-23172401aa7d	QT-2026-0032	شركة الكهرباء الوطنية 	قسم المشتريات المحترمين	0787356764		2026-08-03		JOD	PROMPT	690.000	0.00	0.000	0.000	16.00	110.400	800.400	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة 		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-03 06:12:56.613452+00	2026-08-03 06:15:05.563682+00	\N	2026-09-02	pct	0	\N	\N	\N	quote	t	\N
deb11bf4-fad8-4379-a302-25be8454c7b3	QT-2026-0003	الشركة النوعية للكرتون	قسم المشتريات المحترمين			2026-06-06	Micrometer - Balance	JOD	PROMPT	320.000	0.00	0.000	0.000	0.00	0.000	320.000	الشركة النوعية للكرتون معفاة من الضريبة العامة للمبيعات بموجب كتاب رئاسة الوزراء		\N	partial_referral	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:54:13.176+00	2026-06-06 14:41:19.289009+00	2026-08-03 06:54:13.766419+00	\N	2026-07-01	pct	0	\N	\N	\N	quote	t	تمت احالة جزئية للعرض والغاء باقي البنود
8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-02	Capillary Tube	JOD	PROMPT	56.000	0.00	0.000	0.000	16.00	8.960	64.960			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 13:41:56.707+00	2026-08-02 06:27:24.548531+00	2026-08-03 13:41:57.879536+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	الادعاء من العميل بان العينات المرسلة غير مطابقة حيث تم طلب ان تكون مدرجة ومفتوحة من الطرفين
505e698c-09ce-4610-8d79-772e36f62ec1	QT-2026-0036	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-03	Heating Mantle	JOD	PROMPT	165.000	0.00	0.000	0.000	16.00	26.400	191.400			\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-08-03 13:41:03.938552+00	2026-08-04 11:19:03.431152+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-09-02	pct	0	\N	\N	\N	quote	t	\N
75bb058a-1ceb-4c1e-b843-c5006a930fd6	QT-2026-0024	مدارس عمان الاهلية	إدارة المشتريات	0797901489		2026-07-28		JOD	PROMPT	241.250	0.00	0.000	0.000	16.00	38.600	279.850	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة 		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-07-28 09:32:31.784458+00	2026-08-02 06:48:46.086291+00	cf5c4b24-cf21-4602-b569-5f069d914ee5	2026-08-28	pct	0	\N	\N	\N	quote	t	\N
79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	جامعة جرش الاهلية	قسم المشتريات المحترمين	0778450550		2026-07-29		JOD	PROMPT	50.000	0.00	0.000	0.000	16.00	8.000	58.000	لاي استفسار الرجاء الاتصال على 0798802031		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-07-29 11:01:48.503883+00	2026-08-02 06:49:25.89055+00	\N	2026-08-29	pct	0	\N	\N	\N	quote	t	\N
ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-27	Disposables - Gloves	JOD	PROMPT	5386.700	0.00	0.000	0.000	16.00	861.872	6248.572			\N	converted	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 14:16:52.43+00	2026-07-27 07:46:47.894622+00	2026-08-03 14:16:53.483704+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	تم احالة الطلبية بشكل كلي على المؤسسة ولله الحمد
198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	شركة سحاب لمواد التجميل 	قسم المشتريات المحترمين	00962778760786		2026-08-03	 Disposables	JOD	PROMPT	17.850	0.00	0.000	0.000	16.00	2.856	20.706			\N	sent	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-03 13:12:28.072125+00	2026-08-04 11:08:37.437485+00	739a0229-8e24-4988-9731-58c9c8cd56b6	2026-09-02	pct	0	\N	\N	\N	quote	t	\N
0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	شركة المناصير لتكنولوجيا المعلومات	قسم المشتريات المحترمين	0096265813700		2026-08-01	Radiation Detector 	JOD	PROMPT	730.000	0.00	0.000	0.000	16.00	116.800	846.800			\N	sent	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-01 15:50:36.892492+00	2026-08-04 11:10:22.862846+00	98c85065-5320-477e-b78c-83ad9270728a	2026-09-30	pct	0	\N	\N	\N	quote	t	\N
9ac83342-e490-4896-93fb-04fc3f70b0cb	2026D-001	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	قسم المشتريات المحترمين	00962790117273		2026-08-04	-	JOD	PROMPT	240.000	0.00	0.000	0.000	16.00	38.400	278.400			\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-04 09:25:45.361952+00	2026-08-04 12:54:04.179841+00	cd40c449-f543-4142-8804-dcc8838ac95e	2026-09-03	pct	0	2026-08-04 12:54:03.084+00	445bc65d-256f-48d3-9367-464a408e657b	فقط للتجربة	quote	t	\N
\.


--
-- Data for Name: quote_followups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quote_followups (id, quotation_id, note, created_by, created_at) FROM stdin;
7b7bb866-dc22-4833-b26b-14a7b3ee394c	198b8bc1-3ab8-4330-883b-79bb6f577b37	تم التواصل مع الزبون بشكل كامل و إرسال كافة التفاصيل المطلوبة	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-04 09:53:35.597527+00
538bcc38-d2d0-44dd-9099-bda2ae95f3de	198b8bc1-3ab8-4330-883b-79bb6f577b37	هذه الملاحظة لغايات التجربة فقط !	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-04 09:54:34.555361+00
ece4c890-1fa3-4eaf-b682-d8bd211dec30	505e698c-09ce-4610-8d79-772e36f62ec1	تم ارسال العينة الى المصنع وبناءا عليه تم طلب عرض السعر	445bc65d-256f-48d3-9367-464a408e657b	2026-08-04 12:58:14.427363+00
f0bb3b2b-0c1b-43ed-bac9-dfd7a4f6e262	505e698c-09ce-4610-8d79-772e36f62ec1	بينمسكبنسيكمبنسيكمبنسيمك	445bc65d-256f-48d3-9367-464a408e657b	2026-08-04 12:58:56.87187+00
67d5d9ee-c6fe-4557-adc0-901676bb9a06	505e698c-09ce-4610-8d79-772e36f62ec1	بميسبمسيبطم	445bc65d-256f-48d3-9367-464a408e657b	2026-08-04 12:59:12.361087+00
f22eb4a8-c262-44f5-8948-55d0fa99d6e6	505e698c-09ce-4610-8d79-772e36f62ec1	كطيمشسطيمشسطيمكشسكط	445bc65d-256f-48d3-9367-464a408e657b	2026-08-04 12:59:16.134622+00
570e631e-c93d-430a-86e4-9d41403044eb	505e698c-09ce-4610-8d79-772e36f62ec1	كطيمشسيمكشصط\nكيمضصط\nكثصض	445bc65d-256f-48d3-9367-464a408e657b	2026-08-04 12:59:19.917126+00
c74afe28-7c76-499d-8ab8-06479ab30ccb	505e698c-09ce-4610-8d79-772e36f62ec1	نؤسيكمنشسكمينشكمينشسمكينشسم	445bc65d-256f-48d3-9367-464a408e657b	2026-08-04 12:59:24.910584+00
6308c176-977b-4ca8-86c3-9b021c11f990	505e698c-09ce-4610-8d79-772e36f62ec1	وئءطؤوسطمضصدحمضصد	445bc65d-256f-48d3-9367-464a408e657b	2026-08-04 12:59:28.865312+00
\.


--
-- Data for Name: messages_2026_08_02; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_02 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_03; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_03 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_04; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_04 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_05; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_05 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_06; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_06 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_07; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_07 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_08; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_08 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-05-14 08:03:41
20211116045059	2026-05-14 08:03:42
20211116050929	2026-05-14 08:03:42
20211116051442	2026-05-14 08:03:43
20211116212300	2026-05-14 08:03:44
20211116213355	2026-05-14 08:03:45
20211116213934	2026-05-14 08:03:45
20211116214523	2026-05-14 08:03:46
20211122062447	2026-05-14 08:03:47
20211124070109	2026-05-14 08:03:47
20211202204204	2026-05-14 08:03:48
20211202204605	2026-05-14 08:03:49
20211210212804	2026-05-14 08:03:51
20211228014915	2026-05-14 08:03:52
20220107221237	2026-05-14 08:03:52
20220228202821	2026-05-14 08:03:53
20220312004840	2026-05-14 08:03:54
20220603231003	2026-05-14 08:03:55
20220603232444	2026-05-14 08:03:55
20220615214548	2026-05-14 08:03:56
20220712093339	2026-05-14 08:03:57
20220908172859	2026-05-14 08:03:57
20220916233421	2026-05-14 08:03:58
20230119133233	2026-05-14 08:03:59
20230128025114	2026-05-14 08:04:00
20230128025212	2026-05-14 08:04:00
20230227211149	2026-05-14 08:04:01
20230228184745	2026-05-14 08:04:02
20230308225145	2026-05-14 08:04:02
20230328144023	2026-05-14 08:04:03
20231018144023	2026-05-14 08:04:04
20231204144023	2026-05-14 08:04:05
20231204144024	2026-05-14 08:04:06
20231204144025	2026-05-14 08:04:06
20240108234812	2026-05-14 08:04:07
20240109165339	2026-05-14 08:04:08
20240227174441	2026-05-14 08:04:09
20240311171622	2026-05-14 08:04:10
20240321100241	2026-05-14 08:04:11
20240401105812	2026-05-14 08:04:13
20240418121054	2026-05-14 08:04:14
20240523004032	2026-05-14 08:04:16
20240618124746	2026-05-14 08:04:17
20240801235015	2026-05-14 08:04:18
20240805133720	2026-05-14 08:04:18
20240827160934	2026-05-14 08:04:19
20240919163303	2026-05-14 08:04:20
20240919163305	2026-05-14 08:04:21
20241019105805	2026-05-14 08:04:21
20241030150047	2026-05-14 08:04:24
20241108114728	2026-05-14 08:04:25
20241121104152	2026-05-14 08:04:26
20241130184212	2026-05-14 08:04:26
20241220035512	2026-05-14 08:04:27
20241220123912	2026-05-14 08:04:28
20241224161212	2026-05-14 08:04:28
20250107150512	2026-05-14 08:04:29
20250110162412	2026-05-14 08:04:30
20250123174212	2026-05-14 08:04:30
20250128220012	2026-05-14 08:04:31
20250506224012	2026-05-14 08:04:32
20250523164012	2026-05-14 08:04:32
20250714121412	2026-05-14 08:04:33
20250905041441	2026-05-14 08:04:33
20251103001201	2026-05-14 08:04:34
20251120212548	2026-05-14 08:04:35
20251120215549	2026-05-14 08:04:36
20260218120000	2026-05-14 08:04:36
20260326120000	2026-05-14 08:04:37
20260514120000	2026-06-03 01:14:28
20260527120000	2026-06-03 01:14:29
20260528120000	2026-06-03 01:14:30
20260603120000	2026-06-04 08:29:55
20260605120000	2026-06-17 06:43:13
20260606110000	2026-06-17 06:43:13
20260616120000	2026-06-24 23:46:01
20260624120000	2026-06-25 00:09:27
20260626120000	2026-07-03 23:43:34
20260706120000	2026-07-07 08:02:17
20260707120000	2026-07-15 08:13:09
20260709120000	2026-07-15 08:13:10
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-05-14 01:48:24.207236
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-05-14 01:48:24.237599
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-05-14 01:48:24.24304
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-05-14 01:48:24.265056
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-05-14 01:48:24.276977
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-05-14 01:48:24.281735
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-05-14 01:48:24.286751
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-05-14 01:48:24.291987
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-05-14 01:48:24.296629
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-05-14 01:48:24.30155
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-05-14 01:48:24.306397
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-05-14 01:48:24.312246
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-05-14 01:48:24.317309
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-05-14 01:48:24.322414
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-05-14 01:48:24.327519
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-05-14 01:48:24.353981
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-05-14 01:48:24.358739
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-05-14 01:48:24.363483
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-05-14 01:48:24.36809
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-05-14 01:48:24.374058
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-05-14 01:48:24.378866
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-05-14 01:48:24.385963
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-05-14 01:48:24.402845
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-05-14 01:48:24.413181
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-05-14 01:48:24.418436
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-05-14 01:48:24.423394
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-05-14 01:48:24.428819
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-05-14 01:48:24.433491
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-05-14 01:48:24.438063
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-05-14 01:48:24.4426
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-05-14 01:48:24.447155
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-05-14 01:48:24.451663
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-05-14 01:48:24.45629
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-05-14 01:48:24.460851
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-05-14 01:48:24.465526
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-05-14 01:48:24.470009
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-05-14 01:48:24.474623
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-05-14 01:48:24.479236
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-05-14 01:48:24.484848
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-05-14 01:48:24.50082
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-05-14 01:48:24.506339
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-05-14 01:48:24.51093
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-05-14 01:48:24.516228
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-05-14 01:48:24.520986
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-05-14 01:48:24.52574
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-05-14 01:48:24.531043
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-05-14 01:48:24.54324
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-05-14 01:48:24.548561
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-05-14 01:48:24.553285
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-05-14 01:48:24.570122
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-05-14 01:48:24.57537
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-05-14 01:48:24.636491
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-05-14 01:48:24.638502
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-05-14 01:48:24.649356
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-05-14 01:48:24.652313
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-05-14 01:48:24.654262
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-05-14 01:48:24.660251
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-05-14 01:48:24.666268
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-05-14 01:48:24.671735
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-05-14 01:48:24.677103
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-05-14 01:48:24.682195
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 536, true);


--
-- Name: custom_origins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_origins_id_seq', 48, true);


--
-- Name: custom_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_units_id_seq', 69, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1389, true);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: archive_reasons archive_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archive_reasons
    ADD CONSTRAINT archive_reasons_pkey PRIMARY KEY (id);


--
-- Name: archive_reasons archive_reasons_reason_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archive_reasons
    ADD CONSTRAINT archive_reasons_reason_key UNIQUE (reason);


--
-- Name: catalog_categories catalog_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_categories
    ADD CONSTRAINT catalog_categories_name_key UNIQUE (name);


--
-- Name: catalog_categories catalog_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_categories
    ADD CONSTRAINT catalog_categories_pkey PRIMARY KEY (id);


--
-- Name: catalog_items catalog_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_items
    ADD CONSTRAINT catalog_items_pkey PRIMARY KEY (id);


--
-- Name: custom_origins custom_origins_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_origins
    ADD CONSTRAINT custom_origins_name_key UNIQUE (name);


--
-- Name: custom_origins custom_origins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_origins
    ADD CONSTRAINT custom_origins_pkey PRIMARY KEY (id);


--
-- Name: custom_units custom_units_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_units
    ADD CONSTRAINT custom_units_name_key UNIQUE (name);


--
-- Name: custom_units custom_units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_units
    ADD CONSTRAINT custom_units_pkey PRIMARY KEY (id);


--
-- Name: customer_categories customer_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_categories
    ADD CONSTRAINT customer_categories_name_key UNIQUE (name);


--
-- Name: customer_categories customer_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_categories
    ADD CONSTRAINT customer_categories_pkey PRIMARY KEY (id);


--
-- Name: customer_districts customer_districts_governorate_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_districts
    ADD CONSTRAINT customer_districts_governorate_name_key UNIQUE (governorate, name);


--
-- Name: customer_districts customer_districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_districts
    ADD CONSTRAINT customer_districts_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: hr_attendance hr_attendance_employee_id_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_attendance
    ADD CONSTRAINT hr_attendance_employee_id_date_key UNIQUE (employee_id, date);


--
-- Name: hr_attendance hr_attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_attendance
    ADD CONSTRAINT hr_attendance_pkey PRIMARY KEY (id);


--
-- Name: hr_employees hr_employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_employees
    ADD CONSTRAINT hr_employees_pkey PRIMARY KEY (id);


--
-- Name: hr_letters hr_letters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_letters
    ADD CONSTRAINT hr_letters_pkey PRIMARY KEY (id);


--
-- Name: hr_salaries hr_salaries_employee_id_month_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_salaries
    ADD CONSTRAINT hr_salaries_employee_id_month_year_key UNIQUE (employee_id, month, year);


--
-- Name: hr_salaries hr_salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_salaries
    ADD CONSTRAINT hr_salaries_pkey PRIMARY KEY (id);


--
-- Name: letter_contacts letter_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.letter_contacts
    ADD CONSTRAINT letter_contacts_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: number_sequences number_sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.number_sequences
    ADD CONSTRAINT number_sequences_pkey PRIMARY KEY (id);


--
-- Name: official_letters official_letters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.official_letters
    ADD CONSTRAINT official_letters_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_number_key UNIQUE (number);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_username_key UNIQUE (username);


--
-- Name: quotation_items quotation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_pkey PRIMARY KEY (id);


--
-- Name: quotations quotations_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_number_key UNIQUE (number);


--
-- Name: quotations quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (id);


--
-- Name: quote_followups quote_followups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote_followups
    ADD CONSTRAINT quote_followups_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_02 messages_2026_08_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_02
    ADD CONSTRAINT messages_2026_08_02_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_03 messages_2026_08_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_03
    ADD CONSTRAINT messages_2026_08_03_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_04 messages_2026_08_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_04
    ADD CONSTRAINT messages_2026_08_04_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_05 messages_2026_08_05_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_05
    ADD CONSTRAINT messages_2026_08_05_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_06 messages_2026_08_06_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_06
    ADD CONSTRAINT messages_2026_08_06_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_07 messages_2026_08_07_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_07
    ADD CONSTRAINT messages_2026_08_07_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_08 messages_2026_08_08_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_08
    ADD CONSTRAINT messages_2026_08_08_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages messages_payload_exclusive; Type: CHECK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages
    ADD CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL))) NOT VALID;


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: catalog_items_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catalog_items_name_idx ON public.catalog_items USING gin (to_tsvector('simple'::regconfig, name));


--
-- Name: idx_logs_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logs_at ON public.activity_logs USING btree (created_at DESC);


--
-- Name: idx_logs_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logs_uid ON public.activity_logs USING btree (user_id);


--
-- Name: idx_o_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_o_by ON public.orders USING btree (created_by);


--
-- Name: idx_o_qid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_o_qid ON public.orders USING btree (quotation_id);


--
-- Name: idx_o_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_o_status ON public.orders USING btree (status);


--
-- Name: idx_oi_oid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_oi_oid ON public.order_items USING btree (order_id);


--
-- Name: idx_q_archived; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_q_archived ON public.quotations USING btree (archived);


--
-- Name: idx_q_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_q_by ON public.quotations USING btree (created_by);


--
-- Name: idx_q_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_q_customer ON public.quotations USING btree (customer_name);


--
-- Name: idx_q_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_q_date ON public.quotations USING btree (date);


--
-- Name: idx_q_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_q_status ON public.quotations USING btree (status);


--
-- Name: idx_qi_qid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_qi_qid ON public.quotation_items USING btree (quotation_id);


--
-- Name: notif_created_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notif_created_idx ON public.notifications USING btree (created_at DESC);


--
-- Name: notif_user_read_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notif_user_read_idx ON public.notifications USING btree (user_id, is_read);


--
-- Name: payments_quotation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payments_quotation_id_idx ON public.payments USING btree (quotation_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_02_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_02_inserted_at_topic_idx ON realtime.messages_2026_08_02 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_03_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_03_inserted_at_topic_idx ON realtime.messages_2026_08_03 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_04_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_04_inserted_at_topic_idx ON realtime.messages_2026_08_04 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_05_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_05_inserted_at_topic_idx ON realtime.messages_2026_08_05 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_06_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_06_inserted_at_topic_idx ON realtime.messages_2026_08_06 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_07_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_07_inserted_at_topic_idx ON realtime.messages_2026_08_07 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_08_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_08_inserted_at_topic_idx ON realtime.messages_2026_08_08 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_selec; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_selec ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter, COALESCE(selected_columns, '{}'::text[]));


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: messages_2026_08_02_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_02_inserted_at_topic_idx;


--
-- Name: messages_2026_08_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_02_pkey;


--
-- Name: messages_2026_08_03_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_03_inserted_at_topic_idx;


--
-- Name: messages_2026_08_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_03_pkey;


--
-- Name: messages_2026_08_04_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_04_inserted_at_topic_idx;


--
-- Name: messages_2026_08_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_04_pkey;


--
-- Name: messages_2026_08_05_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_05_inserted_at_topic_idx;


--
-- Name: messages_2026_08_05_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_05_pkey;


--
-- Name: messages_2026_08_06_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_06_inserted_at_topic_idx;


--
-- Name: messages_2026_08_06_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_06_pkey;


--
-- Name: messages_2026_08_07_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_07_inserted_at_topic_idx;


--
-- Name: messages_2026_08_07_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_07_pkey;


--
-- Name: messages_2026_08_08_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_08_inserted_at_topic_idx;


--
-- Name: messages_2026_08_08_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_08_pkey;


--
-- Name: quotation_summary _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.quotation_summary AS
 SELECT q.id,
    q.number,
    q.customer_name,
    q.date,
    q.status,
    q.nett_price,
    q.currency,
    p.full_name AS created_by_name,
    count(qi.id) AS item_count,
    q.created_at,
    q.archived
   FROM ((public.quotations q
     LEFT JOIN public.profiles p ON ((p.id = q.created_by)))
     LEFT JOIN public.quotation_items qi ON ((qi.quotation_id = q.id)))
  GROUP BY q.id, p.full_name;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: quotations quotation_confirm_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER quotation_confirm_trigger BEFORE UPDATE ON public.quotations FOR EACH ROW EXECUTE FUNCTION public.confirm_draft_quotation();


--
-- Name: orders trg_order_number; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_order_number BEFORE INSERT ON public.orders FOR EACH ROW EXECUTE FUNCTION public.set_order_number();


--
-- Name: orders trg_orders_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: profiles trg_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: quotations trg_quotation_number; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_quotation_number BEFORE INSERT ON public.quotations FOR EACH ROW EXECUTE FUNCTION public.set_quotation_number();


--
-- Name: quotations trg_quotations_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_quotations_updated_at BEFORE UPDATE ON public.quotations FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: activity_logs activity_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id);


--
-- Name: catalog_categories catalog_categories_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_categories
    ADD CONSTRAINT catalog_categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: catalog_items catalog_items_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_items
    ADD CONSTRAINT catalog_items_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: customers customers_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: customers customers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: hr_attendance hr_attendance_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_attendance
    ADD CONSTRAINT hr_attendance_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.hr_employees(id) ON DELETE CASCADE;


--
-- Name: hr_letters hr_letters_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_letters
    ADD CONSTRAINT hr_letters_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: hr_letters hr_letters_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_letters
    ADD CONSTRAINT hr_letters_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.hr_employees(id) ON DELETE SET NULL;


--
-- Name: hr_salaries hr_salaries_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hr_salaries
    ADD CONSTRAINT hr_salaries_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.hr_employees(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: official_letters official_letters_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.official_letters
    ADD CONSTRAINT official_letters_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders orders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: orders orders_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(id);


--
-- Name: payments payments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: payments payments_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: quotation_items quotation_items_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(id) ON DELETE CASCADE;


--
-- Name: quotations quotations_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: quotations quotations_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE SET NULL;


--
-- Name: quotations quotations_deleted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_deleted_by_fkey FOREIGN KEY (deleted_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: quote_followups quote_followups_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote_followups
    ADD CONSTRAINT quote_followups_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: quote_followups quote_followups_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote_followups
    ADD CONSTRAINT quote_followups_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: activity_logs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.activity_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: archive_reasons; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.archive_reasons ENABLE ROW LEVEL SECURITY;

--
-- Name: archive_reasons authenticated can insert archive_reasons; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated can insert archive_reasons" ON public.archive_reasons FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: custom_units authenticated can insert units; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated can insert units" ON public.custom_units FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- Name: custom_units authenticated can read units; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated can read units" ON public.custom_units FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- Name: archive_reasons authenticated can select archive_reasons; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated can select archive_reasons" ON public.archive_reasons FOR SELECT TO authenticated USING (true);


--
-- Name: archive_reasons authenticated can update archive_reasons; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated can update archive_reasons" ON public.archive_reasons FOR UPDATE TO authenticated USING (true);


--
-- Name: custom_origins authenticated users can insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated users can insert" ON public.custom_origins FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: custom_origins authenticated users can read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated users can read" ON public.custom_origins FOR SELECT TO authenticated USING (true);


--
-- Name: catalog_categories cat_admin; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cat_admin ON public.catalog_categories USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- Name: catalog_categories cat_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cat_select ON public.catalog_categories FOR SELECT TO authenticated USING (true);


--
-- Name: catalog_categories; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.catalog_categories ENABLE ROW LEVEL SECURITY;

--
-- Name: catalog_items catalog_delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY catalog_delete ON public.catalog_items FOR DELETE USING ((public.get_my_role() = ANY (ARRAY['admin'::text, 'manager'::text])));


--
-- Name: catalog_items catalog_insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY catalog_insert ON public.catalog_items FOR INSERT WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: catalog_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.catalog_items ENABLE ROW LEVEL SECURITY;

--
-- Name: catalog_items catalog_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY catalog_select ON public.catalog_items FOR SELECT USING ((auth.uid() IS NOT NULL));


--
-- Name: catalog_items catalog_update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY catalog_update ON public.catalog_items FOR UPDATE USING (((created_by = auth.uid()) OR (public.get_my_role() = ANY (ARRAY['admin'::text, 'manager'::text]))));


--
-- Name: customer_categories cust_cat_admin; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cust_cat_admin ON public.customer_categories USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- Name: customer_categories cust_cat_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cust_cat_select ON public.customer_categories FOR SELECT TO authenticated USING (true);


--
-- Name: customer_districts cust_dist_admin; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cust_dist_admin ON public.customer_districts USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- Name: customer_districts cust_dist_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cust_dist_select ON public.customer_districts FOR SELECT TO authenticated USING (true);


--
-- Name: custom_origins; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.custom_origins ENABLE ROW LEVEL SECURITY;

--
-- Name: custom_units; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.custom_units ENABLE ROW LEVEL SECURITY;

--
-- Name: customer_categories; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_categories ENABLE ROW LEVEL SECURITY;

--
-- Name: customer_districts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_districts ENABLE ROW LEVEL SECURITY;

--
-- Name: customers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;

--
-- Name: customers customers_all_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_all_auth ON public.customers USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: hr_attendance; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.hr_attendance ENABLE ROW LEVEL SECURITY;

--
-- Name: hr_attendance hr_attendance_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hr_attendance_policy ON public.hr_attendance USING (true) WITH CHECK (true);


--
-- Name: hr_employees; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.hr_employees ENABLE ROW LEVEL SECURITY;

--
-- Name: hr_employees hr_employees_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hr_employees_policy ON public.hr_employees USING (true) WITH CHECK (true);


--
-- Name: hr_letters; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.hr_letters ENABLE ROW LEVEL SECURITY;

--
-- Name: hr_letters hr_letters_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hr_letters_policy ON public.hr_letters USING (true) WITH CHECK (true);


--
-- Name: hr_salaries; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.hr_salaries ENABLE ROW LEVEL SECURITY;

--
-- Name: hr_salaries hr_salaries_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hr_salaries_policy ON public.hr_salaries USING (true) WITH CHECK (true);


--
-- Name: letter_contacts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.letter_contacts ENABLE ROW LEVEL SECURITY;

--
-- Name: letter_contacts letter_contacts_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY letter_contacts_all ON public.letter_contacts USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: official_letters letters_delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY letters_delete ON public.official_letters FOR DELETE USING ((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = ANY (ARRAY['admin'::text, 'manager'::text])));


--
-- Name: official_letters letters_insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY letters_insert ON public.official_letters FOR INSERT WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: official_letters letters_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY letters_select ON public.official_letters FOR SELECT USING ((auth.uid() IS NOT NULL));


--
-- Name: official_letters letters_update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY letters_update ON public.official_letters FOR UPDATE USING (((( SELECT profiles.role
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) = ANY (ARRAY['admin'::text, 'manager'::text])) OR (created_by = auth.uid())));


--
-- Name: activity_logs logs_all_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY logs_all_auth ON public.activity_logs USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: notifications notif_delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY notif_delete ON public.notifications FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: notifications notif_insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY notif_insert ON public.notifications FOR INSERT WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: notifications notif_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY notif_select ON public.notifications FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: notifications notif_update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY notif_update ON public.notifications FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: notifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

--
-- Name: number_sequences; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.number_sequences ENABLE ROW LEVEL SECURITY;

--
-- Name: official_letters; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.official_letters ENABLE ROW LEVEL SECURITY;

--
-- Name: order_items oitems_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY oitems_access ON public.order_items USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: order_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;

--
-- Name: orders; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

--
-- Name: orders orders_all_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY orders_all_auth ON public.orders USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: payments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

--
-- Name: payments payments_delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY payments_delete ON public.payments FOR DELETE USING ((public.get_my_role() = ANY (ARRAY['admin'::text, 'manager'::text])));


--
-- Name: payments payments_insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY payments_insert ON public.payments FOR INSERT WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: payments payments_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY payments_select ON public.payments FOR SELECT USING ((auth.uid() IS NOT NULL));


--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles profiles_admin_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY profiles_admin_all ON public.profiles USING ((public.get_my_role() = 'admin'::text));


--
-- Name: profiles profiles_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY profiles_select ON public.profiles FOR SELECT USING ((auth.uid() IS NOT NULL));


--
-- Name: profiles profiles_update_own; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY profiles_update_own ON public.profiles FOR UPDATE USING ((id = auth.uid()));


--
-- Name: quotation_items qitems_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY qitems_access ON public.quotation_items USING ((EXISTS ( SELECT 1
   FROM public.quotations q
  WHERE ((q.id = quotation_items.quotation_id) AND ((q.created_by = auth.uid()) OR (q.created_by IS NULL) OR (public.get_my_role() = ANY (ARRAY['admin'::text, 'manager'::text]))))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.quotations q
  WHERE ((q.id = quotation_items.quotation_id) AND ((q.created_by = auth.uid()) OR (q.created_by IS NULL) OR (public.get_my_role() = ANY (ARRAY['admin'::text, 'manager'::text])))))));


--
-- Name: quotation_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.quotation_items ENABLE ROW LEVEL SECURITY;

--
-- Name: quotations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.quotations ENABLE ROW LEVEL SECURITY;

--
-- Name: quotations quotations_delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY quotations_delete ON public.quotations FOR DELETE USING ((public.get_my_role() = 'admin'::text));


--
-- Name: quotations quotations_insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY quotations_insert ON public.quotations FOR INSERT WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: quotations quotations_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY quotations_select ON public.quotations FOR SELECT USING (((created_by = auth.uid()) OR (created_by IS NULL) OR (public.get_my_role() = ANY (ARRAY['admin'::text, 'manager'::text])) OR ((public.get_my_role() = 'employee'::text) AND (( SELECT ((profiles.permissions ->> 'quotes_view_all'::text))::boolean AS bool
   FROM public.profiles
  WHERE (profiles.id = auth.uid())) IS TRUE))));


--
-- Name: quotations quotations_update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY quotations_update ON public.quotations FOR UPDATE USING (((created_by = auth.uid()) OR (created_by IS NULL) OR (public.get_my_role() = ANY (ARRAY['admin'::text, 'manager'::text]))));


--
-- Name: quote_followups; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.quote_followups ENABLE ROW LEVEL SECURITY;

--
-- Name: quote_followups users can manage followups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "users can manage followups" ON public.quote_followups USING (true) WITH CHECK (true);


--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- Name: supabase_realtime notifications; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.notifications;


--
-- Name: supabase_realtime orders; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.orders;


--
-- Name: supabase_realtime quotations; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.quotations;


--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION confirm_draft_quotation(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.confirm_draft_quotation() TO anon;
GRANT ALL ON FUNCTION public.confirm_draft_quotation() TO authenticated;
GRANT ALL ON FUNCTION public.confirm_draft_quotation() TO service_role;


--
-- Name: FUNCTION create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean) TO anon;
GRANT ALL ON FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean) TO authenticated;
GRANT ALL ON FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean) TO service_role;


--
-- Name: FUNCTION create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean, p_username text, p_permissions jsonb); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean, p_username text, p_permissions jsonb) TO anon;
GRANT ALL ON FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean, p_username text, p_permissions jsonb) TO authenticated;
GRANT ALL ON FUNCTION public.create_user_with_profile(p_email text, p_password text, p_full_name text, p_role text, p_is_active boolean, p_username text, p_permissions jsonb) TO service_role;


--
-- Name: FUNCTION delete_user_completely(p_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_user_completely(p_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.delete_user_completely(p_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.delete_user_completely(p_user_id uuid) TO service_role;


--
-- Name: FUNCTION generate_customer_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_customer_number() TO anon;
GRANT ALL ON FUNCTION public.generate_customer_number() TO authenticated;
GRANT ALL ON FUNCTION public.generate_customer_number() TO service_role;


--
-- Name: FUNCTION generate_draft_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_draft_number() TO anon;
GRANT ALL ON FUNCTION public.generate_draft_number() TO authenticated;
GRANT ALL ON FUNCTION public.generate_draft_number() TO service_role;


--
-- Name: FUNCTION generate_order_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_order_number() TO anon;
GRANT ALL ON FUNCTION public.generate_order_number() TO authenticated;
GRANT ALL ON FUNCTION public.generate_order_number() TO service_role;


--
-- Name: FUNCTION generate_quotation_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_quotation_number() TO anon;
GRANT ALL ON FUNCTION public.generate_quotation_number() TO authenticated;
GRANT ALL ON FUNCTION public.generate_quotation_number() TO service_role;


--
-- Name: FUNCTION get_email_by_username(p_username text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_email_by_username(p_username text) TO anon;
GRANT ALL ON FUNCTION public.get_email_by_username(p_username text) TO authenticated;
GRANT ALL ON FUNCTION public.get_email_by_username(p_username text) TO service_role;


--
-- Name: FUNCTION get_my_role(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_my_role() TO anon;
GRANT ALL ON FUNCTION public.get_my_role() TO authenticated;
GRANT ALL ON FUNCTION public.get_my_role() TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION reset_user_password(p_user_id uuid, p_new_password text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.reset_user_password(p_user_id uuid, p_new_password text) TO anon;
GRANT ALL ON FUNCTION public.reset_user_password(p_user_id uuid, p_new_password text) TO authenticated;
GRANT ALL ON FUNCTION public.reset_user_password(p_user_id uuid, p_new_password text) TO service_role;


--
-- Name: FUNCTION set_order_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_order_number() TO anon;
GRANT ALL ON FUNCTION public.set_order_number() TO authenticated;
GRANT ALL ON FUNCTION public.set_order_number() TO service_role;


--
-- Name: FUNCTION set_quotation_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_quotation_number() TO anon;
GRANT ALL ON FUNCTION public.set_quotation_number() TO authenticated;
GRANT ALL ON FUNCTION public.set_quotation_number() TO service_role;


--
-- Name: FUNCTION setup_new_user_profile(p_user_id uuid, p_email text, p_full_name text, p_username text, p_role text, p_is_active boolean, p_permissions jsonb); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.setup_new_user_profile(p_user_id uuid, p_email text, p_full_name text, p_username text, p_role text, p_is_active boolean, p_permissions jsonb) TO anon;
GRANT ALL ON FUNCTION public.setup_new_user_profile(p_user_id uuid, p_email text, p_full_name text, p_username text, p_role text, p_is_active boolean, p_permissions jsonb) TO authenticated;
GRANT ALL ON FUNCTION public.setup_new_user_profile(p_user_id uuid, p_email text, p_full_name text, p_username text, p_role text, p_is_active boolean, p_permissions jsonb) TO service_role;


--
-- Name: FUNCTION update_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO service_role;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION send_binary(payload bytea, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION wal2json_escape_identifier(name text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO postgres;
GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE activity_logs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.activity_logs TO anon;
GRANT ALL ON TABLE public.activity_logs TO authenticated;
GRANT ALL ON TABLE public.activity_logs TO service_role;


--
-- Name: TABLE archive_reasons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.archive_reasons TO anon;
GRANT ALL ON TABLE public.archive_reasons TO authenticated;
GRANT ALL ON TABLE public.archive_reasons TO service_role;


--
-- Name: TABLE catalog_categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.catalog_categories TO anon;
GRANT ALL ON TABLE public.catalog_categories TO authenticated;
GRANT ALL ON TABLE public.catalog_categories TO service_role;


--
-- Name: TABLE catalog_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.catalog_items TO anon;
GRANT ALL ON TABLE public.catalog_items TO authenticated;
GRANT ALL ON TABLE public.catalog_items TO service_role;


--
-- Name: TABLE custom_origins; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.custom_origins TO anon;
GRANT ALL ON TABLE public.custom_origins TO authenticated;
GRANT ALL ON TABLE public.custom_origins TO service_role;


--
-- Name: SEQUENCE custom_origins_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.custom_origins_id_seq TO anon;
GRANT ALL ON SEQUENCE public.custom_origins_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.custom_origins_id_seq TO service_role;


--
-- Name: TABLE custom_units; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.custom_units TO anon;
GRANT ALL ON TABLE public.custom_units TO authenticated;
GRANT ALL ON TABLE public.custom_units TO service_role;


--
-- Name: SEQUENCE custom_units_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.custom_units_id_seq TO anon;
GRANT ALL ON SEQUENCE public.custom_units_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.custom_units_id_seq TO service_role;


--
-- Name: TABLE customer_categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customer_categories TO anon;
GRANT ALL ON TABLE public.customer_categories TO authenticated;
GRANT ALL ON TABLE public.customer_categories TO service_role;


--
-- Name: TABLE customer_districts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customer_districts TO anon;
GRANT ALL ON TABLE public.customer_districts TO authenticated;
GRANT ALL ON TABLE public.customer_districts TO service_role;


--
-- Name: TABLE customers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customers TO anon;
GRANT ALL ON TABLE public.customers TO authenticated;
GRANT ALL ON TABLE public.customers TO service_role;


--
-- Name: TABLE hr_attendance; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hr_attendance TO anon;
GRANT ALL ON TABLE public.hr_attendance TO authenticated;
GRANT ALL ON TABLE public.hr_attendance TO service_role;


--
-- Name: TABLE hr_employees; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hr_employees TO anon;
GRANT ALL ON TABLE public.hr_employees TO authenticated;
GRANT ALL ON TABLE public.hr_employees TO service_role;


--
-- Name: TABLE hr_letters; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hr_letters TO anon;
GRANT ALL ON TABLE public.hr_letters TO authenticated;
GRANT ALL ON TABLE public.hr_letters TO service_role;


--
-- Name: TABLE hr_salaries; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hr_salaries TO anon;
GRANT ALL ON TABLE public.hr_salaries TO authenticated;
GRANT ALL ON TABLE public.hr_salaries TO service_role;


--
-- Name: TABLE letter_contacts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.letter_contacts TO anon;
GRANT ALL ON TABLE public.letter_contacts TO authenticated;
GRANT ALL ON TABLE public.letter_contacts TO service_role;


--
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.notifications TO anon;
GRANT ALL ON TABLE public.notifications TO authenticated;
GRANT ALL ON TABLE public.notifications TO service_role;


--
-- Name: TABLE number_sequences; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.number_sequences TO anon;
GRANT ALL ON TABLE public.number_sequences TO authenticated;
GRANT ALL ON TABLE public.number_sequences TO service_role;


--
-- Name: TABLE official_letters; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.official_letters TO anon;
GRANT ALL ON TABLE public.official_letters TO authenticated;
GRANT ALL ON TABLE public.official_letters TO service_role;


--
-- Name: TABLE order_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.order_items TO anon;
GRANT ALL ON TABLE public.order_items TO authenticated;
GRANT ALL ON TABLE public.order_items TO service_role;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.orders TO anon;
GRANT ALL ON TABLE public.orders TO authenticated;
GRANT ALL ON TABLE public.orders TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE order_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.order_summary TO anon;
GRANT ALL ON TABLE public.order_summary TO authenticated;
GRANT ALL ON TABLE public.order_summary TO service_role;


--
-- Name: TABLE payments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payments TO anon;
GRANT ALL ON TABLE public.payments TO authenticated;
GRANT ALL ON TABLE public.payments TO service_role;


--
-- Name: TABLE quotation_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.quotation_items TO anon;
GRANT ALL ON TABLE public.quotation_items TO authenticated;
GRANT ALL ON TABLE public.quotation_items TO service_role;


--
-- Name: TABLE quotation_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.quotation_summary TO anon;
GRANT ALL ON TABLE public.quotation_summary TO authenticated;
GRANT ALL ON TABLE public.quotation_summary TO service_role;


--
-- Name: TABLE quotations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.quotations TO anon;
GRANT ALL ON TABLE public.quotations TO authenticated;
GRANT ALL ON TABLE public.quotations TO service_role;


--
-- Name: TABLE quote_followups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.quote_followups TO anon;
GRANT ALL ON TABLE public.quote_followups TO authenticated;
GRANT ALL ON TABLE public.quote_followups TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2026_08_02; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_02 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_02 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_03; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_03 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_03 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_04; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_04 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_04 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_05; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_05 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_05 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_06; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_06 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_06 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_07; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_07 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_07 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_08; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_08 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_08 TO dashboard_user;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict PggnPUKaZIqTEhgtdValLLhpTnMFhV3OvPba4cDERZtSrUyJ2MLpG0PnaYe25U7

