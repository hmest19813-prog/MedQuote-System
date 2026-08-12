--
-- PostgreSQL database dump
--

\restrict ETZNTyuDlZ8KeJEQYQ1iEud3iNvbsWsCcp0oc3JBqLYqkThrwvEjRAQxyZzFgrk

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
-- Name: next_po_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.next_po_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN 'PO-' || LPAD(nextval('po_number_seq')::TEXT, 4, '0');
END;
$$;


ALTER FUNCTION public.next_po_number() OWNER TO postgres;

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
-- Name: set_po_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_po_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    NEW.number := next_po_number();
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_po_number() OWNER TO postgres;

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
-- Name: update_vouchers_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_vouchers_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END; $$;


ALTER FUNCTION public.update_vouchers_updated_at() OWNER TO postgres;

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
-- Name: item_name_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_name_history (
    name text NOT NULL,
    last_used_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.item_name_history OWNER TO postgres;

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
    customer_ref text,
    po_number text,
    deleted_at timestamp with time zone,
    deleted_by uuid,
    delete_reason text,
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
-- Name: po_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.po_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.po_number_seq OWNER TO postgres;

--
-- Name: prospects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prospects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    phone text,
    source text,
    interest_level text DEFAULT 'lead'::text,
    notes text,
    assigned_to uuid,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    converted boolean DEFAULT false,
    customer_id uuid
);


ALTER TABLE public.prospects OWNER TO postgres;

--
-- Name: purchase_order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_order_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    po_id uuid,
    item_name text NOT NULL,
    description text,
    unit text DEFAULT 'EACH'::text,
    quantity numeric(12,3) DEFAULT 1,
    unit_price numeric(12,3) DEFAULT 0,
    tax_pct numeric(5,2) DEFAULT 0,
    total numeric(12,3) DEFAULT 0,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.purchase_order_items OWNER TO postgres;

--
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    number text,
    supplier_id uuid,
    supplier_name text NOT NULL,
    date date DEFAULT CURRENT_DATE,
    expected_delivery date,
    status text DEFAULT 'draft'::text,
    currency text DEFAULT 'JOD'::text,
    subtotal numeric(12,3) DEFAULT 0,
    tax_pct numeric(5,2) DEFAULT 0,
    tax_amt numeric(12,3) DEFAULT 0,
    total numeric(12,3) DEFAULT 0,
    notes text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.purchase_orders OWNER TO postgres;

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
    quote_lang text DEFAULT 'ar'::text,
    requester_name text,
    requester_phone text,
    requester_phone2 text,
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
-- Name: supplier_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier_invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    number text,
    supplier_invoice_no text,
    supplier_id uuid,
    supplier_name text,
    po_id uuid,
    po_number text,
    date date DEFAULT CURRENT_DATE,
    due_date date,
    status text DEFAULT 'pending'::text,
    currency text DEFAULT 'JOD'::text,
    total numeric(12,3) DEFAULT 0,
    paid_amount numeric(12,3) DEFAULT 0,
    notes text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.supplier_invoices OWNER TO postgres;

--
-- Name: supplier_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    supplier_id uuid,
    invoice_id uuid,
    date date DEFAULT CURRENT_DATE,
    amount numeric(12,3) NOT NULL,
    method text DEFAULT 'bank_transfer'::text,
    reference text,
    notes text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.supplier_payments OWNER TO postgres;

--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code text,
    name text NOT NULL,
    phone text,
    email text,
    address text,
    city text,
    country text DEFAULT 'الاردن'::text,
    contact_name text,
    contact_phone text,
    payment_terms integer DEFAULT 30,
    notes text,
    is_active boolean DEFAULT true,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: vouchers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vouchers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type text NOT NULL,
    number text NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    amount numeric(14,3) DEFAULT 0 NOT NULL,
    currency text DEFAULT 'JOD'::text NOT NULL,
    party text,
    description text,
    payment_method text DEFAULT 'نقداً'::text NOT NULL,
    reference text,
    prepared_by text,
    approved_by text,
    notes text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    archive_reason text,
    CONSTRAINT vouchers_type_check CHECK ((type = ANY (ARRAY['payment'::text, 'receipt'::text])))
);


ALTER TABLE public.vouchers OWNER TO postgres;

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
-- Name: messages_2026_08_09; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_09 (
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


ALTER TABLE realtime.messages_2026_08_09 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_10; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_10 (
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


ALTER TABLE realtime.messages_2026_08_10 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_11; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_11 (
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


ALTER TABLE realtime.messages_2026_08_11 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_12; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_12 (
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


ALTER TABLE realtime.messages_2026_08_12 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_13; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_13 (
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


ALTER TABLE realtime.messages_2026_08_13 OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_08_14; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages_2026_08_14 (
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


ALTER TABLE realtime.messages_2026_08_14 OWNER TO supabase_realtime_admin;

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
-- Name: messages_2026_08_08; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_08 FOR VALUES FROM ('2026-08-08 00:00:00') TO ('2026-08-09 00:00:00');


--
-- Name: messages_2026_08_09; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_09 FOR VALUES FROM ('2026-08-09 00:00:00') TO ('2026-08-10 00:00:00');


--
-- Name: messages_2026_08_10; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_10 FOR VALUES FROM ('2026-08-10 00:00:00') TO ('2026-08-11 00:00:00');


--
-- Name: messages_2026_08_11; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_11 FOR VALUES FROM ('2026-08-11 00:00:00') TO ('2026-08-12 00:00:00');


--
-- Name: messages_2026_08_12; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_12 FOR VALUES FROM ('2026-08-12 00:00:00') TO ('2026-08-13 00:00:00');


--
-- Name: messages_2026_08_13; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_13 FOR VALUES FROM ('2026-08-13 00:00:00') TO ('2026-08-14 00:00:00');


--
-- Name: messages_2026_08_14; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_08_14 FOR VALUES FROM ('2026-08-14 00:00:00') TO ('2026-08-15 00:00:00');


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
2391cd86-3240-4851-a328-a52ed8ee7323	2026-08-08 07:33:42.530494+00	2026-08-08 07:33:42.530494+00	password	9da1ae64-2096-4efe-a8b0-490d1ccf0f12
73105b2b-4ec0-48f1-9e08-dd01c7f10989	2026-08-08 10:16:42.495704+00	2026-08-08 10:16:42.495704+00	password	63a7c3c5-e8cf-496c-ac11-5e434a86dd1d
095a4dbd-b9dc-4de1-b56e-8a6d18632771	2026-08-08 14:23:28.898989+00	2026-08-08 14:23:28.898989+00	password	e081fa72-5517-4b6a-829e-0a5a5960876d
1d13f54e-dff9-48b3-96af-5df8d8a40126	2026-08-09 09:26:03.730403+00	2026-08-09 09:26:03.730403+00	password	7e398332-541a-4f12-8620-a7ffd690907b
990e98a1-d1ca-4ee6-a3fd-be336f1432f5	2026-08-10 14:36:50.49883+00	2026-08-10 14:36:50.49883+00	password	d2813230-8084-48af-ad41-30e1ee1d0aad
bb4d963b-0fbf-4987-ac7b-25046f553eb0	2026-07-26 09:35:23.10056+00	2026-07-26 09:35:23.10056+00	password	89d81b8b-3d01-4a7f-92a9-98b8f37e0ce9
23da44c1-e0a4-412c-9b16-06ebd0a10dc5	2026-08-07 13:21:04.923344+00	2026-08-07 13:21:04.923344+00	password	cf494e71-c013-4a66-aa2c-daa3cd505da6
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
00000000-0000-0000-0000-000000000000	574	sha5qdjnlgwm	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-07 14:53:18.467767+00	2026-08-07 14:53:18.467767+00	vqh5wzhetvap	23da44c1-e0a4-412c-9b16-06ebd0a10dc5
00000000-0000-0000-0000-000000000000	381	4kqoq2bp34ut	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-28 09:17:44.300995+00	2026-07-29 10:53:51.273182+00	vdvspcfvxy7u	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	589	42qsrwnj24fv	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 13:26:58.59746+00	2026-08-08 14:26:01.447369+00	ft7nlpadimvk	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	658	4mkbx6eqifly	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 10:37:15.132705+00	2026-08-10 11:36:15.109205+00	rddse74f3zzm	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	601	pf42gdpqks4z	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 22:15:28.198247+00	2026-08-08 23:14:28.204207+00	44dpntputufa	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	664	bqytbifmpcbk	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-10 14:26:56.027906+00	2026-08-10 16:27:02.421312+00	gq3tss4nurxc	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	607	6mkux7ul3332	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 04:09:28.434842+00	2026-08-09 05:08:28.439313+00	b535tbcw2fxg	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	613	puw4grwuj5vc	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 08:07:12.055182+00	2026-08-09 09:06:12.02592+00	6gofmuvdlmf2	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	670	ysyqdnymeidc	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 16:31:15.487977+00	2026-08-10 17:30:15.522568+00	pkrpxfubudfp	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	595	pwguimo6aqdk	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-08 16:59:38.470244+00	2026-08-09 11:15:17.630232+00	4ieh4jfuqgwj	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	619	er2totorixmx	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-09 10:24:17.479982+00	2026-08-09 11:23:43.937563+00	tmk4azxvxz25	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	625	5wjhuvxg72cy	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 12:03:40.645679+00	2026-08-09 13:02:40.461802+00	njeidut53ga3	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	676	hey2vtuelkr2	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-10 22:04:58.130704+00	2026-08-10 23:03:28.69888+00	neyu4bgr4god	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	631	rcv6zjjdjxcr	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 15:00:40.485111+00	2026-08-09 15:59:40.574254+00	3pwb6vumau4h	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	637	tivpiiezggdk	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 18:54:14.506406+00	2026-08-09 19:53:14.439173+00	5yh6bnmejx5q	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	682	zpk7jyl3k74a	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 02:21:15.948429+00	2026-08-11 03:20:15.867548+00	unk4ygjhibkk	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	643	b3nfqhvaq4ag	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 22:50:14.582139+00	2026-08-09 23:49:14.649548+00	ux4665a4ym7v	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	649	ob3ojab23otl	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 04:44:14.844878+00	2026-08-10 05:43:14.81799+00	yw6wsyjbf7cx	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	655	r5nesminqn54	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	2026-08-10 08:41:21.162209+00	2026-08-10 08:41:21.162209+00	udnaoj3sljct	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	688	yn44sgldev4s	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 07:16:16.20098+00	2026-08-11 08:15:16.108048+00	jww5q2wzg2yj	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	695	4j4rijamn3io	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 09:35:26.465999+00	2026-08-11 11:18:23.33364+00	thz4jinkpuqc	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	700	lzrzrorkgahk	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 11:18:23.343539+00	2026-08-11 12:16:59.187214+00	4j4rijamn3io	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	706	tpjeqy2vtqrz	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 13:09:01.47068+00	2026-08-11 14:08:16.372398+00	h4ei3ix46e6h	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	712	fd5xsjukegbe	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 15:07:16.537488+00	2026-08-11 16:05:44.328907+00	a3iby7exyfi7	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	718	qfhymzcmwljg	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 17:04:16.485753+00	2026-08-11 18:03:16.690498+00	47jost7nt53n	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	724	ohajupcrncd2	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 21:59:17.042555+00	2026-08-11 22:58:16.800351+00	bz4fwx674taf	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	346	ku4yo3rn5vts	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-26 09:35:23.090851+00	2026-07-26 11:09:09.078081+00	\N	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	348	gsrouiz2mevm	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-26 11:09:09.084999+00	2026-07-27 06:04:14.164877+00	ku4yo3rn5vts	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	365	vdvspcfvxy7u	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-27 06:04:14.179866+00	2026-07-28 09:17:44.296718+00	gsrouiz2mevm	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	587	ft7nlpadimvk	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 12:28:22.760031+00	2026-08-08 13:26:58.583878+00	j2hem7z4qz6j	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	575	ot3xisly62im	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 07:33:42.487525+00	2026-08-08 08:32:23.124794+00	\N	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	656	rddse74f3zzm	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 09:38:15.103858+00	2026-08-10 10:37:15.114755+00	mggpoaczkri7	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	581	objndlixqqwy	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 10:30:00.700911+00	2026-08-08 11:29:22.703137+00	kzuq3z5fbvjy	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	590	bpntfsj427aq	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 14:23:28.856085+00	2026-08-08 15:22:13.829015+00	\N	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	596	zvpnpdvskijy	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 17:20:28.372443+00	2026-08-08 18:19:27.943944+00	kahm573hug3n	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	665	mfhp4z7o4dj7	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 14:33:15.381201+00	2026-08-10 15:32:15.475885+00	ze5vhs7ba7rh	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	602	avxisleco2wp	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 23:14:28.222372+00	2026-08-09 00:13:28.300816+00	pf42gdpqks4z	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	608	uzwwwrxxyvk4	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 05:08:28.450132+00	2026-08-09 06:07:28.513651+00	6mkux7ul3332	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	671	2fzwtjuxguzh	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 17:30:15.550919+00	2026-08-10 18:29:15.476832+00	ysyqdnymeidc	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	614	2gzmde2ldpkt	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 09:04:13.93434+00	2026-08-09 10:03:13.87676+00	d55wychchrf2	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	659	neyu4bgr4god	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-10 11:05:26.313883+00	2026-08-10 22:04:58.117555+00	bahucydzjlch	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	620	ckbkwxckwpno	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 11:02:14.061886+00	2026-08-09 12:01:14.103913+00	auqwthi5b4zk	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	626	s46mmdxeuxkw	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 13:00:14.236168+00	2026-08-09 13:59:14.142429+00	7bdt6contbzz	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	677	2rvhehpwxhc3	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 22:25:15.680171+00	2026-08-10 23:24:15.759934+00	j7w6ze4vimsi	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	632	npt4azlof6n4	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 15:57:14.509372+00	2026-08-09 16:56:14.346824+00	woqlkr7m4g4t	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	638	k42b4pjo4zrc	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 19:53:14.460949+00	2026-08-09 20:52:14.554472+00	tivpiiezggdk	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	683	m2fgxn36rgnf	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 03:20:15.884742+00	2026-08-11 04:19:15.943543+00	zpk7jyl3k74a	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	644	p4uedq2b6y2l	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 23:49:14.662003+00	2026-08-10 00:48:14.766046+00	b3nfqhvaq4ag	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	650	qy3zguhad5to	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 05:43:14.831693+00	2026-08-10 06:42:15.028099+00	ob3ojab23otl	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	689	f6bizjhhysbw	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-11 07:30:36.438054+00	2026-08-11 08:28:39.018461+00	gj3mcvzmy5bh	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	694	ef7dhbb7jqrq	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 09:35:26.466038+00	2026-08-11 10:34:36.495094+00	xk4xteyoanl3	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	701	hr5wj4kek6qx	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 11:33:36.537072+00	2026-08-11 12:32:36.441131+00	nkwew732a6xg	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	707	f5banuherapa	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 13:15:36.485854+00	2026-08-11 14:13:41.564701+00	vzzblxiqkuv7	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	713	nuq5gtsbbeug	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 15:12:36.47332+00	2026-08-11 16:11:36.429559+00	uwjd53r7c4ws	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	719	akk6yafbby7x	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 18:03:16.710343+00	2026-08-11 19:02:16.594887+00	qfhymzcmwljg	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	725	yplzmk56tqju	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 22:58:16.824282+00	2026-08-11 23:57:16.863961+00	ohajupcrncd2	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	393	l6qrkyq2quna	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-07-29 10:53:51.288553+00	2026-08-03 06:07:06.367455+00	4kqoq2bp34ut	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	424	fkrhygs65sos	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-03 06:07:06.388497+00	2026-08-03 11:32:30.010468+00	l6qrkyq2quna	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	436	ihncblxigqtx	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-03 11:32:30.021009+00	2026-08-03 12:30:30.72588+00	fkrhygs65sos	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	437	bdebts5vhi2c	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-03 12:30:30.748297+00	2026-08-04 11:28:50.265995+00	ihncblxigqtx	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	657	bahucydzjlch	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-10 10:07:16.561134+00	2026-08-10 11:05:26.291125+00	opuso6bn4nqm	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	591	kx3cjr745x7y	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 14:26:01.453982+00	2026-08-08 15:25:22.627743+00	42qsrwnj24fv	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	455	t7qbvrgyxtn5	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-04 11:28:50.281474+00	2026-08-04 12:27:06.873011+00	bdebts5vhi2c	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	576	skxxirc5varn	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 08:32:23.153394+00	2026-08-08 09:31:22.855799+00	ot3xisly62im	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	582	4ieh4jfuqgwj	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-08 11:03:29.277559+00	2026-08-08 16:59:38.451567+00	hsg2ax5iacyl	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	660	ptwblnwdi4he	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 11:36:15.122289+00	2026-08-10 12:35:15.199998+00	4mkbx6eqifly	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	597	nzop36jj5uf6	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 18:19:27.967853+00	2026-08-08 19:18:28.043788+00	zvpnpdvskijy	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	603	ar5zdu3ddumi	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 00:13:28.322646+00	2026-08-09 01:12:28.376354+00	avxisleco2wp	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	666	pmh26h6nxb6r	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-10 14:36:50.481071+00	2026-08-10 16:27:02.422064+00	\N	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	609	hxu6y5ld6e2u	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 06:07:28.533273+00	2026-08-09 07:06:28.657835+00	uzwwwrxxyvk4	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	615	47xoj7mub6en	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 09:06:12.032138+00	2026-08-09 10:05:40.612886+00	puw4grwuj5vc	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	672	5bkw4wqox3ah	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 18:29:15.495983+00	2026-08-10 19:28:15.555827+00	2fzwtjuxguzh	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	621	njeidut53ga3	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 11:04:40.846213+00	2026-08-09 12:03:40.63669+00	kzzllvbyjzgl	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	627	kbzhp6lj2egl	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 13:02:40.472467+00	2026-08-09 14:01:40.867277+00	5wjhuvxg72cy	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	633	m5qexm4vfqsy	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 15:59:40.58288+00	2026-08-09 17:23:08.829125+00	rcv6zjjdjxcr	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	684	yz44b5pfcrmg	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 04:19:15.962013+00	2026-08-11 05:18:15.911819+00	m2fgxn36rgnf	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	639	3gufzu2oym2j	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 19:59:19.370706+00	2026-08-09 20:58:14.20013+00	k6vc3xyqgoz5	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	678	mlbn6cpehk2k	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-10 23:03:28.717469+00	2026-08-11 05:36:02.461445+00	hey2vtuelkr2	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	645	kymwuixqlff3	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 00:48:14.784743+00	2026-08-10 01:47:14.837595+00	p4uedq2b6y2l	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	651	auu3e4mj7qwk	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 06:42:15.04972+00	2026-08-10 07:40:42.582132+00	qy3zguhad5to	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	690	edv75u3ksku3	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 08:15:16.127986+00	2026-08-11 09:13:49.58546+00	yn44sgldev4s	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	696	rehuw3qvgsf5	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 10:13:16.187119+00	2026-08-11 11:12:16.201923+00	hf74x73uw6aw	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	708	pw6p67p2pyyt	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 13:31:36.55449+00	2026-08-11 14:30:36.452957+00	q7jsguysowaq	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	714	imahdik2dsmz	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-11 15:29:36.476718+00	2026-08-11 15:29:36.476718+00	mjnm2276znxp	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	702	s6pg5hhoygox	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-11 11:40:10.506195+00	2026-08-11 15:41:55.391182+00	rl7evhpsa2ye	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	720	iaczv4wbtutu	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 19:02:16.614204+00	2026-08-11 20:01:16.741659+00	akk6yafbby7x	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	726	p2gvmxclwz6d	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 23:57:16.882343+00	2026-08-12 00:56:16.978384+00	yplzmk56tqju	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	459	h4r4pxrkscmf	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-04 12:27:06.893316+00	2026-08-05 09:36:14.784991+00	t7qbvrgyxtn5	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	592	5q6rv4yetaot	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 15:22:13.848205+00	2026-08-08 16:21:27.854239+00	bpntfsj427aq	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	652	itp6efzremur	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-10 07:22:45.39866+00	2026-08-10 13:28:08.42699+00	3uzoxpduuxua	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	598	a2zxo7etluap	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 19:18:28.055981+00	2026-08-08 20:17:28.054295+00	nzop36jj5uf6	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	661	sqpeaq3v2c6x	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 12:35:15.217931+00	2026-08-10 13:33:54.006509+00	ptwblnwdi4he	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	540	hsg2ax5iacyl	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-06 07:14:56.196284+00	2026-08-08 11:03:29.261346+00	yjemgpuvxdal	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	496	k5gcyvd4btup	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-05 09:36:14.796308+00	2026-08-05 10:34:42.565941+00	h4r4pxrkscmf	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	583	z7y2ry32s5e7	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-08 11:15:22.896137+00	2026-08-08 11:15:22.896137+00	cvlgucnbnivz	73105b2b-4ec0-48f1-9e08-dd01c7f10989
00000000-0000-0000-0000-000000000000	604	nndhx4zox7bi	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 01:12:28.399491+00	2026-08-09 02:11:28.335531+00	ar5zdu3ddumi	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	610	avxn6pjwalud	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 07:06:28.671962+00	2026-08-09 08:05:28.570088+00	hxu6y5ld6e2u	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	667	pkrpxfubudfp	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 15:32:15.496588+00	2026-08-10 16:31:15.48019+00	mfhp4z7o4dj7	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	616	tmk4azxvxz25	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-09 09:26:03.686242+00	2026-08-09 10:24:17.469944+00	\N	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	498	x2w6tzsw2ror	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-05 10:34:42.576766+00	2026-08-05 11:32:42.733364+00	k5gcyvd4btup	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	673	nxhw7ckqbtkc	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 19:28:15.573229+00	2026-08-10 20:27:15.561603+00	5bkw4wqox3ah	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	628	72j2odngtedn	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 13:59:14.16501+00	2026-08-09 14:57:47.262772+00	s46mmdxeuxkw	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	503	bwm72jbtp7yd	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-05 11:32:42.743702+00	2026-08-05 12:30:43.318207+00	x2w6tzsw2ror	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	634	6kbhnkuqm5vn	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 16:56:14.363497+00	2026-08-09 17:55:14.443795+00	npt4azlof6n4	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	679	jmulwhuvq5gz	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 23:24:15.770724+00	2026-08-11 00:23:15.980694+00	2rvhehpwxhc3	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	640	6q7n22cg4qp5	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 20:52:14.576849+00	2026-08-09 21:51:14.477392+00	k42b4pjo4zrc	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	646	fnr7mjpwhyfd	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 01:47:14.856236+00	2026-08-10 02:46:14.737354+00	kymwuixqlff3	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	622	udnaoj3sljct	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-09 11:15:17.638985+00	2026-08-10 08:41:21.149371+00	pwguimo6aqdk	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	685	22yujslxddku	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 05:18:15.926369+00	2026-08-11 06:17:16.093475+00	yz44b5pfcrmg	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	691	6x5cmvfmfi2d	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-11 08:28:39.028351+00	2026-08-11 09:26:51.60147+00	f6bizjhhysbw	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	697	rl7evhpsa2ye	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-11 10:25:22.973888+00	2026-08-11 11:40:10.498172+00	4d7pe2i66r7q	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	703	h4ei3ix46e6h	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 12:10:22.092244+00	2026-08-11 13:09:01.447523+00	uybw6g6bdbar	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	709	a3iby7exyfi7	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 14:08:16.389002+00	2026-08-11 15:07:16.516676+00	tpjeqy2vtqrz	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	721	jbh5sj27wwe3	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 20:01:16.762818+00	2026-08-11 21:00:16.754577+00	iaczv4wbtutu	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	715	a6k27yj4afzw	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-11 15:41:55.403298+00	2026-08-11 21:16:27.998953+00	s6pg5hhoygox	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	727	qff42eq6kq3v	445bc65d-256f-48d3-9367-464a408e657b	f	2026-08-12 00:56:17.004401+00	2026-08-12 00:56:17.004401+00	p2gvmxclwz6d	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	505	yjemgpuvxdal	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-05 12:30:43.324687+00	2026-08-06 07:14:56.190067+00	bwm72jbtp7yd	bb4d963b-0fbf-4987-ac7b-25046f553eb0
00000000-0000-0000-0000-000000000000	573	vqh5wzhetvap	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-07 13:21:04.88855+00	2026-08-07 14:53:18.440681+00	\N	23da44c1-e0a4-412c-9b16-06ebd0a10dc5
00000000-0000-0000-0000-000000000000	662	gq3tss4nurxc	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-10 13:28:08.43779+00	2026-08-10 14:26:56.012922+00	itp6efzremur	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	578	kzuq3z5fbvjy	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 09:31:22.863093+00	2026-08-08 10:30:00.692519+00	skxxirc5varn	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	599	hm3yto7dpq6i	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 20:17:28.071184+00	2026-08-08 21:16:28.253579+00	a2zxo7etluap	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	605	bh7rjpvitojy	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 02:11:28.356308+00	2026-08-09 03:10:28.426165+00	nndhx4zox7bi	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	593	aqommcafokje	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 15:25:22.635347+00	2026-08-09 07:08:40.117433+00	kx3cjr745x7y	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	611	6gofmuvdlmf2	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 07:08:40.122699+00	2026-08-09 08:07:12.04901+00	aqommcafokje	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	674	cyzarehmg7mg	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 20:27:15.574552+00	2026-08-10 21:26:15.647554+00	nxhw7ckqbtkc	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	617	auqwthi5b4zk	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 10:03:13.89487+00	2026-08-09 11:02:14.039665+00	2gzmde2ldpkt	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	680	iy5vbybnbidh	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 00:23:16.008941+00	2026-08-11 01:22:15.811878+00	jmulwhuvq5gz	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	629	3pwb6vumau4h	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 14:01:40.881021+00	2026-08-09 15:00:40.478248+00	kbzhp6lj2egl	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	635	k6vc3xyqgoz5	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 17:23:08.847744+00	2026-08-09 19:59:19.364982+00	m5qexm4vfqsy	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	686	gj3mcvzmy5bh	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-11 05:36:02.467386+00	2026-08-11 07:30:36.430588+00	mlbn6cpehk2k	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	647	ymmzkr6mp2t2	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 02:46:14.750157+00	2026-08-10 03:45:14.734068+00	fnr7mjpwhyfd	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	641	3uzoxpduuxua	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 20:58:14.209073+00	2026-08-10 07:22:45.386818+00	3gufzu2oym2j	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	669	thz4jinkpuqc	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-10 16:27:02.437172+00	2026-08-11 09:35:26.458933+00	pmh26h6nxb6r	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	653	yjfld546vpgq	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 07:40:42.601687+00	2026-08-10 08:38:58.136195+00	auu3e4mj7qwk	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	623	opuso6bn4nqm	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-09 11:23:43.944833+00	2026-08-10 10:07:16.544328+00	er2totorixmx	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	692	hf74x73uw6aw	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 09:13:49.600151+00	2026-08-11 10:13:16.170545+00	edv75u3ksku3	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	698	nkwew732a6xg	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 10:34:36.516586+00	2026-08-11 11:33:36.524971+00	ef7dhbb7jqrq	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	704	vzzblxiqkuv7	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 12:16:59.192757+00	2026-08-11 13:15:36.468671+00	lzrzrorkgahk	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	710	uwjd53r7c4ws	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 14:13:41.580439+00	2026-08-11 15:12:36.460219+00	f5banuherapa	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	716	47jost7nt53n	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 16:05:44.351126+00	2026-08-11 17:04:16.466548+00	fd5xsjukegbe	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	722	bz4fwx674taf	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 21:00:16.775209+00	2026-08-11 21:59:17.020183+00	jbh5sj27wwe3	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	594	kahm573hug3n	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 16:21:27.869519+00	2026-08-08 17:20:28.354493+00	5q6rv4yetaot	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	579	cvlgucnbnivz	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 10:16:42.472406+00	2026-08-08 11:15:22.877819+00	\N	73105b2b-4ec0-48f1-9e08-dd01c7f10989
00000000-0000-0000-0000-000000000000	663	ze5vhs7ba7rh	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 13:33:54.012594+00	2026-08-10 14:33:15.370903+00	sqpeaq3v2c6x	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	585	j2hem7z4qz6j	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-08 11:29:22.714017+00	2026-08-08 12:28:22.756447+00	objndlixqqwy	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	600	44dpntputufa	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 21:16:28.275351+00	2026-08-08 22:15:28.174972+00	hm3yto7dpq6i	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	606	b535tbcw2fxg	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 03:10:28.441388+00	2026-08-09 04:09:28.415767+00	bh7rjpvitojy	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	612	d55wychchrf2	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 08:05:28.59023+00	2026-08-09 09:04:13.919482+00	avxn6pjwalud	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	675	j7w6ze4vimsi	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 21:26:15.671379+00	2026-08-10 22:25:15.659977+00	cyzarehmg7mg	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	618	kzzllvbyjzgl	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-09 10:05:40.621218+00	2026-08-09 11:04:40.833172+00	47xoj7mub6en	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	624	7bdt6contbzz	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 12:01:14.116524+00	2026-08-09 13:00:14.218994+00	ckbkwxckwpno	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	681	unk4ygjhibkk	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 01:22:15.822941+00	2026-08-11 02:21:15.937153+00	iy5vbybnbidh	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	630	woqlkr7m4g4t	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 14:57:47.281464+00	2026-08-09 15:57:14.490226+00	72j2odngtedn	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	636	5yh6bnmejx5q	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 17:55:14.459553+00	2026-08-09 18:54:14.479148+00	6kbhnkuqm5vn	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	687	jww5q2wzg2yj	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 06:17:16.112968+00	2026-08-11 07:16:16.173282+00	22yujslxddku	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	642	ux4665a4ym7v	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-09 21:51:14.496318+00	2026-08-09 22:50:14.568428+00	6q7n22cg4qp5	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	648	yw6wsyjbf7cx	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 03:45:14.749412+00	2026-08-10 04:44:14.829995+00	ymmzkr6mp2t2	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	668	xk4xteyoanl3	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-10 16:27:02.437163+00	2026-08-11 09:35:26.457425+00	bqytbifmpcbk	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	654	mggpoaczkri7	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-10 08:38:58.163655+00	2026-08-10 09:38:15.080301+00	yjfld546vpgq	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	693	4d7pe2i66r7q	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-11 09:26:51.617193+00	2026-08-11 10:25:22.961242+00	6x5cmvfmfi2d	1d13f54e-dff9-48b3-96af-5df8d8a40126
00000000-0000-0000-0000-000000000000	699	uybw6g6bdbar	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-11 11:12:16.218003+00	2026-08-11 12:10:22.080323+00	rehuw3qvgsf5	095a4dbd-b9dc-4de1-b56e-8a6d18632771
00000000-0000-0000-0000-000000000000	705	q7jsguysowaq	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 12:32:36.459388+00	2026-08-11 13:31:36.53124+00	hr5wj4kek6qx	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	711	mjnm2276znxp	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-11 14:30:36.468012+00	2026-08-11 15:29:36.468204+00	pw6p67p2pyyt	2391cd86-3240-4851-a328-a52ed8ee7323
00000000-0000-0000-0000-000000000000	717	a7rwpr5uh3pa	ee095348-a2de-4906-a078-0e8a3f3560a9	f	2026-08-11 16:11:36.437974+00	2026-08-11 16:11:36.437974+00	nuq5gtsbbeug	990e98a1-d1ca-4ee6-a3fd-be336f1432f5
00000000-0000-0000-0000-000000000000	723	ushrvljryzbz	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	2026-08-11 21:16:28.019745+00	2026-08-11 21:16:28.019745+00	a6k27yj4afzw	1d13f54e-dff9-48b3-96af-5df8d8a40126
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
23da44c1-e0a4-412c-9b16-06ebd0a10dc5	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-07 13:21:04.854533+00	2026-08-07 14:53:18.494459+00	\N	aal1	\N	2026-08-07 14:53:18.494349	Mozilla/5.0 (iPhone; CPU iPhone OS 26_5_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/151.0.7922.57 Mobile/15E148 Safari/604.1	86.108.16.40	\N	\N	\N	\N	\N
bb4d963b-0fbf-4987-ac7b-25046f553eb0	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	2026-07-26 09:35:23.061376+00	2026-08-10 08:41:21.182228+00	\N	aal1	\N	2026-08-10 08:41:21.182116	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	46.185.190.189	\N	\N	\N	\N	\N
2391cd86-3240-4851-a328-a52ed8ee7323	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-08 07:33:42.458867+00	2026-08-11 15:29:36.492999+00	\N	aal1	\N	2026-08-11 15:29:36.4929	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	86.108.19.138	\N	\N	\N	\N	\N
990e98a1-d1ca-4ee6-a3fd-be336f1432f5	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-10 14:36:50.461022+00	2026-08-11 16:11:36.45658+00	\N	aal1	\N	2026-08-11 16:11:36.45645	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	86.108.19.138	\N	\N	\N	\N	\N
1d13f54e-dff9-48b3-96af-5df8d8a40126	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	2026-08-09 09:26:03.646581+00	2026-08-11 21:16:28.049438+00	\N	aal1	\N	2026-08-11 21:16:28.049319	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	94.249.58.7	\N	\N	\N	\N	\N
095a4dbd-b9dc-4de1-b56e-8a6d18632771	445bc65d-256f-48d3-9367-464a408e657b	2026-08-08 14:23:28.81872+00	2026-08-12 00:56:17.037097+00	\N	aal1	\N	2026-08-12 00:56:17.036985	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36	86.108.19.138	\N	\N	\N	\N	\N
73105b2b-4ec0-48f1-9e08-dd01c7f10989	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-08 10:16:42.453812+00	2026-08-08 11:15:22.928268+00	\N	aal1	\N	2026-08-08 11:15:22.927633	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	86.108.21.228	\N	\N	\N	\N	\N
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
00000000-0000-0000-0000-000000000000	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	authenticated	authenticated	hmest1969@gmail.com	$2a$10$xOcTVCdJlssGGoyPoF.2ueG.WSKTYZOV.e6fg4qox/fqfLbqcCNrq	2026-07-23 13:35:58.478749+00	\N		\N		\N			\N	2026-08-09 09:26:03.646476+00	{"provider": "email", "providers": ["email"]}	{"sub": "65ce1c8f-6151-402a-8bcd-4270b3cf6d0a", "email": "hmest1969@gmail.com", "full_name": "Dr.Ahmad tannerah", "email_verified": true, "phone_verified": false}	\N	2026-07-23 13:35:58.417249+00	2026-08-11 21:16:28.034465+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	445bc65d-256f-48d3-9367-464a408e657b	authenticated	authenticated	hmest19811@gmail.com	$2a$06$c5UtrCnK6voqm8quZtzUV.oJI50h6.e8va7ovkmSt8y7D.EOHAGjC	2026-05-14 08:52:11.008535+00	\N		\N		2026-07-26 07:16:36.112426+00			\N	2026-08-08 14:23:28.81742+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-05-14 08:52:10.987135+00	2026-08-12 00:56:17.023479+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6f484e98-e110-4ceb-8070-e61810c5f108	authenticated	authenticated	hmest121981@gmail.com	$2a$10$cswVSqKwOlj9ZePnOwu0mOrCQw.aKIVszm5jz8JFeTYNTCkQCzv6i	2026-07-23 13:50:50.499033+00	\N		\N		\N			\N	2026-08-06 09:01:43.810235+00	{"provider": "email", "providers": ["email"]}	{"sub": "6f484e98-e110-4ceb-8070-e61810c5f108", "email": "hmest121981@gmail.com", "full_name": "Eng. Ahlam Alyamani", "email_verified": true, "phone_verified": false}	\N	2026-07-23 13:50:50.460703+00	2026-08-06 09:01:43.841707+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ee095348-a2de-4906-a078-0e8a3f3560a9	authenticated	authenticated	o.alawy.oa@gmail.com	$2a$06$7NtFUAULFUU6tQEmJJGtAeHNSV13DaBM1jWuXE2OVXVJWOMPGC6Jm	2026-05-14 08:04:06.72541+00	\N		\N		2026-07-13 18:58:51.966934+00			\N	2026-08-10 14:36:50.460922+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-05-14 08:04:06.685428+00	2026-08-11 16:11:36.44429+00	\N	\N			\N		0	\N		\N	f	\N	f
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
5b125caa-c319-484b-b4d5-d202ff806b3b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0010	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	\N	2026-08-08 11:47:15.202292+00
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
c90cff32-3ea2-4327-a85a-0dfc969bc3b3	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0034	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-06 07:17:02.762024+00
963db9e3-d6ec-41b0-b6e5-11f945e3a711	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0034	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-06 07:18:24.422818+00
842b3a53-6df3-44b7-ae06-e777429e0926	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "مُعتمد"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-06 07:59:14.228128+00
70ca7bb5-bf12-47e9-852c-93830eab40db	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	غيّر حالة العرض QT-2026-0035 إلى "قيد الدراسة"	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	\N	2026-08-06 07:59:23.023537+00
6faa7f36-11d2-4d0b-9344-50767827a111	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حوّل العرض QT-2026-0034 إلى الطلبية ORD-2026-012	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-06 09:07:04.320289+00
eedf522c-eee7-4cfb-8cf1-387ad842a522	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0034 — تم اصدار فاتورة رقم 476	quote	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	\N	2026-08-06 09:07:40.193977+00
a04b4b50-7436-4b42-88d2-033ca5e4df43	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	873a3454-5c39-4fcb-8304-349c14e2bab3	\N	\N	2026-08-06 10:13:22.556463+00
85437aac-fd8b-46d2-9a38-5a60f2b04839	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	6aa4a2de-104e-4303-9638-0f23d2348d0b	\N	\N	2026-08-06 10:16:42.648243+00
6f1ee8af-4c7d-458b-87ea-55cc9000ab18	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر 2026D-004	quote	6aa4a2de-104e-4303-9638-0f23d2348d0b	2026D-004	\N	2026-08-06 10:17:12.998036+00
cd42ba4d-851b-457f-9eef-4a0309418d55	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر 2026D-004	quote	6aa4a2de-104e-4303-9638-0f23d2348d0b	2026D-004	\N	2026-08-06 10:21:49.072974+00
4f58ec60-23bc-485c-b6c3-f3edb763541e	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر 2026D-003	quote	873a3454-5c39-4fcb-8304-349c14e2bab3	2026D-003	\N	2026-08-06 10:23:49.165348+00
14f59bee-0a01-47a9-bfce-94f98c7942fb	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أنشأ عرض سعر جديد 	quote	ec6f990e-5f00-4426-af28-f533ae5796be	\N	\N	2026-08-06 10:28:50.728035+00
d228bfed-651a-4d61-95d1-11a2b5a20300	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0039 إلى "إحالة جزئية"	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	QT-2026-0039	\N	2026-08-06 13:31:57.469429+00
031cae55-bd9d-48e1-b13e-6fc65491617b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أنشأ عرض سعر جديد 	quote	7a84e616-f098-46ab-8b3a-0fffad9b86d4	\N	\N	2026-08-06 13:33:15.001542+00
dd582950-5562-480c-a047-b7deb4c2411b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف العرض 2026D-005 — السبب: تجربة	quote	7a84e616-f098-46ab-8b3a-0fffad9b86d4	2026D-005	\N	2026-08-06 13:33:49.548274+00
340be26e-c15e-461f-a3d7-39f60b25e970	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة الطلبية ORD-2026-012 إلى "مؤكد"	order	c1e9dc76-fb59-4f58-884c-a7fbec058895	ORD-2026-012	\N	2026-08-06 13:36:58.83633+00
9ecf271f-f187-48f5-932f-8b269d2d6f0a	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر 2026D-006	quote	3e155eba-5c80-4fef-b02f-97d65d0e3628	2026D-006	\N	2026-08-08 10:05:57.748742+00
621ad44b-6b52-46d7-b029-2ab402bf8d96	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف العرض 2026D-004 — السبب: للتجربة	quote	6aa4a2de-104e-4303-9638-0f23d2348d0b	2026D-004	\N	2026-08-08 10:06:15.468108+00
7101fe41-c005-44ef-a896-c6e81754f34f	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف العرض 2026D-003 — السبب: للتجربة	quote	873a3454-5c39-4fcb-8304-349c14e2bab3	2026D-003	\N	2026-08-08 10:06:22.709738+00
ed259880-a464-4f9c-ba86-ef4e2b47347c	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0042	quote	3e155eba-5c80-4fef-b02f-97d65d0e3628	QT-2026-0042	\N	2026-08-08 10:06:48.922513+00
fa54a5f3-16f4-4e62-a246-687b6abcd3ca	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0042	quote	3e155eba-5c80-4fef-b02f-97d65d0e3628	QT-2026-0042	\N	2026-08-08 10:12:13.77172+00
b30ccd2b-00f2-422d-b2f2-c1a3ca9d3f2f	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف الطلبية ORD-2026-007 — تم تسليم الطلبية كاملة بموجب فاتورة	order	823b33c4-edc2-4922-96e3-ea790aaadc1d	ORD-2026-007	\N	2026-08-08 10:14:03.586479+00
eaf8b085-2546-435e-941f-0c531ebcda1b	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0039 إلى "قيد الدراسة"	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	QT-2026-0039	\N	2026-08-08 11:37:41.214328+00
0569870b-60ea-42d4-9aa8-b890d65af8df	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0008 إلى "إحالة جزئية"	quote	0a15f774-f2b6-4308-9887-8530a3ccfc5e	QT-2026-0008	\N	2026-08-08 11:43:05.183726+00
a3d442c5-26af-465f-95f1-0226ef643f20	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حوّل العرض QT-2026-0008 إلى الطلبية ORD-2026-013	quote	0a15f774-f2b6-4308-9887-8530a3ccfc5e	QT-2026-0008	\N	2026-08-08 11:43:29.381674+00
d21f7200-218e-4e4a-8170-658a93e8c73f	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0008 — تم اصدار فاتورة فوترة وارسال الطلبية مع النقل	quote	0a15f774-f2b6-4308-9887-8530a3ccfc5e	QT-2026-0008	\N	2026-08-08 11:43:58.980498+00
de641bd1-544a-42d0-ba11-4c9114e1a0b1	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0010 إلى "ملغي"	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	\N	2026-08-08 11:44:29.689007+00
6257693b-d876-4ba3-9da4-367e4b8bc459	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0010	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	\N	2026-08-08 11:45:10.553866+00
442d1b73-bee6-490a-861e-b212e077e2bf	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0010 إلى "ملغي"	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	\N	2026-08-08 11:45:25.139055+00
b26a733f-fecc-4b9a-8c77-3f87ec19ece4	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0010 — سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	\N	2026-08-08 11:45:58.157198+00
7de00ef8-531d-4183-bea9-1bc8223aba41	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0012	quote	c54c7220-b131-41cb-a654-d9fca2056792	QT-2026-0012	\N	2026-08-08 11:46:26.284319+00
7f75ce8b-9118-4c64-9676-9c439fa919da	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0012 إلى "ملغي"	quote	c54c7220-b131-41cb-a654-d9fca2056792	QT-2026-0012	\N	2026-08-08 11:46:32.956352+00
6e14db79-47f2-4136-a85f-955c3a68c23d	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0012 — سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	quote	c54c7220-b131-41cb-a654-d9fca2056792	QT-2026-0012	\N	2026-08-08 11:46:44.985865+00
226f87bd-280a-4753-a0c1-4c6ef5ca0eaa	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0010 إلى "ملغي"	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	\N	2026-08-08 11:47:25.847192+00
b54ffe0a-c6ff-476d-980d-a1c0095d0edc	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0013	quote	25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	QT-2026-0013	\N	2026-08-08 11:48:09.930314+00
38c885eb-8bf8-40c5-bc4f-c00144014a9f	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0010 — سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	quote	1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	\N	2026-08-08 11:47:32.816532+00
276b7f67-4b3b-4c72-9f03-7386d19c2419	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0013 إلى "ملغي"	quote	25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	QT-2026-0013	\N	2026-08-08 11:48:15.770655+00
cd640677-b4b9-4a51-a0a3-24e864d602f6	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0013 — سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	quote	25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	QT-2026-0013	\N	2026-08-08 11:48:26.772625+00
4b0f4452-50bc-4250-af12-f305393c3506	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0014	quote	df81a005-5d86-4bd2-a92e-555c33891d12	QT-2026-0014	\N	2026-08-08 11:49:02.748416+00
6b801152-af83-4690-8d57-146de4e92ecc	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0014 إلى "ملغي"	quote	df81a005-5d86-4bd2-a92e-555c33891d12	QT-2026-0014	\N	2026-08-08 11:49:08.731855+00
c2625698-94ad-4c03-b878-106d60d32450	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0014 — سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	quote	df81a005-5d86-4bd2-a92e-555c33891d12	QT-2026-0014	\N	2026-08-08 11:49:15.836448+00
000f18c9-4d75-4507-a2a0-16f8589eaae2	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0009	quote	c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1	QT-2026-0009	\N	2026-08-08 11:49:45.179706+00
4729cda1-541e-48d9-9e59-241c5b4c6cb1	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0021	quote	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	QT-2026-0021	\N	2026-08-08 11:50:44.881892+00
ec228977-edca-4411-9670-28aaf84c3426	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	غيّر حالة العرض QT-2026-0027 إلى "مرفوض"	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	\N	2026-08-08 11:51:21.87945+00
76b9eca8-ffe9-4617-b109-f0ebd5297cc7	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف العرض QT-2026-0027 — تم الشراء من جهة اخرى بسبب التاخر في ارسال عرض السعر	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	\N	2026-08-08 11:51:42.001158+00
c473e79d-6f1d-4c27-a711-14d129b12e08	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0040	quote	e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0040	\N	2026-08-08 11:52:20.280628+00
c78a9d67-f0c5-4289-af92-5b7e635c4876	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف العرض 2026D-007 — السبب: تم اعتماده	quote	95434668-ce79-4841-8844-ec778967671e	2026D-007	\N	2026-08-08 11:52:56.435936+00
419e475f-7e1a-4c6a-a359-d2c365bc896d	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أرشف الطلبية ORD-2026-012 — تم اصدار فاتورة مفوترة وتنفيذ الطلب	order	c1e9dc76-fb59-4f58-884c-a7fbec058895	ORD-2026-012	\N	2026-08-08 14:23:57.950278+00
74235d1b-3e79-471d-bf58-9bd789719521	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0018	quote	7d636c37-c439-4ec6-9020-5e11691791b2	QT-2026-0018	\N	2026-08-08 14:24:28.105529+00
51b88767-63e9-4678-84d0-a60729eb19ba	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0011	quote	f61ede0a-f287-4823-9f93-08362eae21f2	QT-2026-0011	\N	2026-08-08 14:24:55.776842+00
5956211a-91b8-4a2f-91db-d17aee9aeb2e	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0005	quote	f4484ac3-fe41-4a73-8379-80a9257a185e	QT-2026-0005	\N	2026-08-08 14:25:18.885464+00
7573a654-27ea-4569-ad11-7e3ad87285eb	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0023	quote	db3a3d6c-b5a0-455d-a33e-1d6222455860	QT-2026-0023	\N	2026-08-08 14:26:01.567817+00
a617cc24-b6cf-4f0f-97c9-e1b936531c77	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0024	quote	75bb058a-1ceb-4c1e-b843-c5006a930fd6	QT-2026-0024	\N	2026-08-08 14:26:22.5593+00
7c25cbd6-e91e-471b-9df9-aef190ae5d80	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0025	quote	219269a5-5fdf-4a4a-ad24-5551d478bc55	QT-2026-0025	\N	2026-08-08 14:26:37.966361+00
a83d18e3-ace8-4bd8-bcb3-e12d8c48ace0	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0042	quote	3e155eba-5c80-4fef-b02f-97d65d0e3628	QT-2026-0042	\N	2026-08-08 14:27:01.183636+00
e2d08ca7-8a06-40e0-8726-af8fd429aa7a	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0041	quote	ec6f990e-5f00-4426-af28-f533ae5796be	QT-2026-0041	\N	2026-08-08 14:27:20.10431+00
632a14d9-4007-4bad-ba85-364e5c5529bd	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0025	quote	219269a5-5fdf-4a4a-ad24-5551d478bc55	QT-2026-0025	\N	2026-08-08 14:28:05.02645+00
8eaccdc5-dca0-4b2a-8ea7-4fedc81717a5	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	4f367a05-a990-4efe-967b-bebf1407c4e8	\N	\N	2026-08-08 17:18:49.179231+00
a862012b-6373-45f4-8d4a-d4c9d138a51e	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	5a276011-0db0-40c1-ad6d-4f9971aea927	\N	\N	2026-08-08 17:44:08.63339+00
e30e2216-aca2-4d75-810e-1b3c5014597e	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أضاف صنفاً للكتالوج: ورق ترشيح	catalog	\N	ورق ترشيح	\N	2026-08-09 08:24:24.312625+00
e7479706-e4be-4868-a7f2-a0d2a17ea862	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	عدّل عرض السعر QT-2026-0044	quote	5a276011-0db0-40c1-ad6d-4f9971aea927	QT-2026-0044	\N	2026-08-09 08:32:55.676689+00
9431c86c-f42d-4d18-a2b4-ac06692901cd	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	\N	\N	2026-08-09 11:38:07.006359+00
a9658932-5b63-48d6-bd07-ba529d401760	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر 2026D-008	quote	89b49bc4-0135-43a2-a74b-3861ed5d8430	2026D-008	\N	2026-08-09 11:55:22.555511+00
e8bf27cf-6da2-4d8a-a729-21035b844be7	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	اعتمد المسودة 2026D-008 كعرض رسمي	quote	89b49bc4-0135-43a2-a74b-3861ed5d8430	2026D-008	\N	2026-08-09 11:56:59.849686+00
62d30caa-d880-4f89-b403-0fed97c5779c	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0046	quote	89b49bc4-0135-43a2-a74b-3861ed5d8430	QT-2026-0046	\N	2026-08-09 11:58:22.749873+00
078f2253-65ba-44d2-83ff-7501cb3f42b3	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف العرض 2026D-009 — السبب: تجربة	quote	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	2026D-009	\N	2026-08-10 07:27:24.639807+00
edfcff7e-7a97-49d4-b18f-9dc68bc686ea	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	d9cf0468-761e-426f-bd09-2d4d10c36f8a	\N	\N	2026-08-10 22:15:58.127053+00
2f03806f-cdab-4a1d-b226-36eb26b9309f	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	\N	\N	2026-08-10 22:52:32.298976+00
50efb2cd-804b-40f2-a85c-67530f57b703	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	حوّل العرض QT-2026-0048 إلى الطلبية ORD-2026-014	quote	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	QT-2026-0048	\N	2026-08-10 23:13:42.48582+00
82b2b657-419c-4cc4-849d-6692e39614d0	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	حوّل العرض QT-2026-0047 إلى الطلبية ORD-2026-015	quote	d9cf0468-761e-426f-bd09-2d4d10c36f8a	QT-2026-0047	\N	2026-08-10 23:16:04.411554+00
e583ed55-07c7-4eab-ad1a-20791b39d683	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	e5a5e969-c9f3-4764-bf44-58a3b10a8818	\N	\N	2026-08-11 06:06:47.034375+00
de5a3b72-d0a8-46c8-98c0-b5fc4c10bbc4	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	\N	\N	2026-08-11 06:18:40.964644+00
e982477f-4781-4360-8edb-7aa206053a18	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	7b053b6e-5c57-4498-930d-0869cfcab2fa	\N	\N	2026-08-11 08:45:49.28943+00
20454c81-b7e6-4ec0-96c9-d983580d9884	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	اعتمد المسودة 2026D-010 كعرض رسمي	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	2026D-010	\N	2026-08-11 09:07:34.337359+00
32b9833d-87fa-40d1-b054-9425e61d3ec0	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0051	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	QT-2026-0051	\N	2026-08-11 09:08:02.529617+00
691c99e8-4ca3-4a64-89cd-e686231f19e3	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0051	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	QT-2026-0051	\N	2026-08-11 10:07:26.349119+00
9e719066-e730-400e-a8f4-5d4a4647fedc	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0051	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	QT-2026-0051	\N	2026-08-11 10:08:57.772393+00
3766f026-1658-4f82-bb72-66e6e84933f7	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0051	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	QT-2026-0051	\N	2026-08-11 10:27:40.267871+00
8c5b5aec-76c4-4bd5-9417-43d285a3cdd3	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0049	quote	e5a5e969-c9f3-4764-bf44-58a3b10a8818	QT-2026-0049	\N	2026-08-11 10:43:25.136162+00
c22c8c6c-fbce-4f45-a17d-f913b08b4fee	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0051	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	QT-2026-0051	\N	2026-08-11 11:43:31.822282+00
746fcf2d-aa02-4fd6-8c5e-f21b6843a184	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0047	quote	d9cf0468-761e-426f-bd09-2d4d10c36f8a	QT-2026-0047	\N	2026-08-11 11:50:46.144504+00
a821c81f-557a-49cf-b8fb-cc1e41fccff2	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	أنشأ عرض سعر جديد 	quote	da22b830-27c5-425d-bbc9-17f0ab63a83c	\N	\N	2026-08-11 12:07:40.855294+00
da2502cc-4ecd-4968-81a9-447e9bd3efb0	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	حذف العرض 2026D-011 — السبب: تجربة	quote	da22b830-27c5-425d-bbc9-17f0ab63a83c	2026D-011	\N	2026-08-11 12:11:36.714768+00
e6ac62f8-165c-4132-9e4d-7373be61fd10	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	94435f61-38f3-40e5-88a2-be37057a238b	\N	\N	2026-08-11 14:49:52.416537+00
b038879a-80db-4305-b581-d89e69c1652b	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	حذف العرض 2026D-012 — السبب: تجربة	quote	94435f61-38f3-40e5-88a2-be37057a238b	2026D-012	\N	2026-08-11 14:50:02.796906+00
fba45c1b-4bb7-4aa3-80d1-7e01b6698693	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	أنشأ عرض سعر جديد 	quote	a5a1c783-79f6-41b7-9eed-498bfb502031	\N	\N	2026-08-11 14:59:35.451618+00
14857bd5-3b85-496d-b777-b9f6c2c97d20	ee095348-a2de-4906-a078-0e8a3f3560a9	Eng. Osama Alawy	حذف العرض 2026D-013 — السبب: تجربة	quote	a5a1c783-79f6-41b7-9eed-498bfb502031	2026D-013	\N	2026-08-11 15:00:07.687969+00
c82ed9b6-c3c8-4999-9e89-7ef4fb76d2b5	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0050	quote	7b053b6e-5c57-4498-930d-0869cfcab2fa	QT-2026-0050	\N	2026-08-11 15:25:11.975862+00
a34f109e-b9a5-41e2-87f5-154f5c44e1e6	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0042	quote	3e155eba-5c80-4fef-b02f-97d65d0e3628	QT-2026-0042	\N	2026-08-11 15:58:03.679413+00
a3049935-2671-47bb-97ae-caecc1211a62	445bc65d-256f-48d3-9367-464a408e657b	Dr. Mohammad U Jawabreh	عدّل عرض السعر QT-2026-0042	quote	3e155eba-5c80-4fef-b02f-97d65d0e3628	QT-2026-0042	\N	2026-08-11 15:59:08.752654+00
8e587254-4c6f-4167-8a69-70236f6d9dff	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أضاف عميلاً جديداً: مدرسة هالة بنت خويلد  (#C-0013)	customer	99256d7a-4d68-4685-851c-49565f38e8a7	مدرسة هالة بنت خويلد 	\N	2026-08-11 16:09:36.89669+00
ff060e13-3724-4dd9-a3e6-9a12c452a63e	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	أنشأ عرض سعر جديد 	quote	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	\N	\N	2026-08-11 16:10:24.495292+00
90838b72-a941-467a-b557-ef0b004d95f1	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	Dr. Ahmad tannerah	عدّل عرض السعر QT-2026-0049	quote	e5a5e969-c9f3-4764-bf44-58a3b10a8818	QT-2026-0049	\N	2026-08-11 21:32:51.780311+00
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
3429d220-cf12-4b46-a5ab-1837be460bfb	تم اصدار فاتورة رقم 476	2026-08-06 09:07:38.623+00	2026-08-06 09:07:39.606932+00
97170174-03f8-45e2-b43f-0a7e801a8333	تم تسليم الطلبية كاملة بموجب فاتورة	2026-08-08 10:14:02.521+00	2026-08-08 10:14:02.942829+00
88c221ad-94f7-41cc-8dea-7d84a2219c98	تم اصدار فاتورة فوترة وارسال الطلبية مع النقل	2026-08-08 11:43:57.902+00	2026-08-08 11:43:58.383514+00
5f0be0d0-4404-4524-a8fa-e0a5b6f73855	سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	2026-08-08 11:49:14.775+00	2026-08-08 11:45:57.520685+00
dd1243b4-8e8e-44ec-a8c0-59e1d3a5bb12	تم الشراء من جهة اخرى بسبب التاخر في ارسال عرض السعر	2026-08-08 11:51:40.931+00	2026-08-08 11:51:41.414834+00
5e377de2-5203-445e-a8b5-483d67b60be8	تم اصدار فاتورة مفوترة وتنفيذ الطلب	2026-08-08 14:23:56.703+00	2026-08-08 14:23:57.32422+00
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
1dc90413-e1ab-4fb3-a66a-6971d4ae41a4	ورق ترشيح		باكيت	3	CHINA	PROMPT	المستهلكات		t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-09 08:24:23.92781+00	2026-08-09 08:24:23.92781+00
\.


--
-- Data for Name: custom_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_origins (id, name, created_at) FROM stdin;
1	THAILAND	2026-07-27 08:58:29.192748+00
2	THA	2026-07-27 08:58:37.363277+00
29	FISHER - EUROPE	2026-08-02 06:31:17.589484+00
39	N.A	2026-08-05 11:44:41.413265+00
52	KOREA	2026-08-08 09:56:29.527121+00
67	GERMANY	2026-08-09 11:36:44.34519+00
\.


--
-- Data for Name: custom_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_units (id, name, created_at) FROM stdin;
1	PK/50	2026-07-27 07:37:52.628012+00
2	PK/100	2026-07-27 07:39:22.570291+00
75	طقم/4	2026-08-08 17:24:07.950729+00
79	250غم	2026-08-08 17:27:00.382247+00
10	مجموعة	2026-07-28 09:25:27.383802+00
11	علبة	2026-07-28 09:26:11.648285+00
12	مجموعة/10	2026-07-28 09:26:52.750267+00
13	باكيت	2026-07-28 09:28:44.076636+00
16	طقم	2026-07-28 09:31:30.665412+00
85	50غم	2026-08-08 17:37:05.678906+00
88	25غم	2026-08-08 17:37:49.246832+00
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
99256d7a-4d68-4685-851c-49565f38e8a7	مدرسة هالة بنت خويلد 	0795744934	\N	\N	\N	\N	\N	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	2026-08-11 16:09:36.273209+00	2026-08-11 16:09:35.149+00	C-0013	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
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
-- Data for Name: item_name_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_name_history (name, last_used_at) FROM stdin;
كرسي اسنان  Ziann Jumbo	2026-08-08 11:46:25.518+00
كرسي اسنان Ziann Cart	2026-08-08 11:47:14.45+00
Amber Glass Vials Screw Top 2ml	2026-08-08 14:27:19.186+00
Digital Balance 0.01-620gm with adaptor	2026-08-06 10:21:48.683+00
1\tHeating Incubator Digital Control 20liter	2026-08-11 14:49:52.012+00
3\t Analytical Balance, 3 Digits Up to 220gm	2026-08-06 10:23:48.772+00
صنف للتجربة	2026-08-06 13:33:13.516+00
حقنة شرجية  rectal enema	2026-08-09 11:58:21.231+00
قطرة العين	2026-08-09 11:58:21.231+00
مرهم للعين	2026-08-09 11:58:21.231+00
بلاستر طبي	2026-08-09 11:58:21.231+00
يود طبي 5 %	2026-08-09 11:58:21.231+00
سرنجات انسولين   1ml	2026-08-09 11:58:21.231+00
فيوسيدين كريم للحروق	2026-08-09 11:58:21.231+00
لاصقات طبية للغيار على الحروق والجروح  مختلف الاحجام	2026-08-09 11:58:21.231+00
Paraffin gauze dressing	2026-08-09 11:58:21.231+00
مشد طبي  crepe pandage\r\n(small - Medium - Large )	2026-08-09 11:58:21.231+00
ضمادات soft bandage\r\n(Small - Medium - Large)	2026-08-09 11:58:21.231+00
انبوب معدي بقياساتNasogastric tube \r\nSize 10 - 12 - 18 - 20	2026-08-09 11:58:21.231+00
بربيش بول \r\nSize 18 - 12 - 8	2026-08-09 11:58:21.231+00
Folys catheter 3 way size 18 - 20	2026-08-09 11:58:21.231+00
كيس بول	2026-08-09 11:58:21.231+00
كوندوم كاثيتير للبولflash catheter(انثوي , ذكري ) Medium	2026-08-09 11:58:21.231+00
محلول ملحي  ringer lactate	2026-08-09 11:58:21.231+00
Normal saline 0.9 %	2026-08-09 11:58:21.231+00
Glucose saline	2026-08-09 11:58:21.231+00
اسوارة تعريفيه للمريض	2026-08-09 11:58:21.231+00
كرسي اسنان Ziann Chair	2026-08-08 11:48:09.159+00
كرسي اسنان Keju Chair	2026-08-08 11:49:01.996+00
مجهر بيولوجي عينيتين واربع شيئيات مع كامل اكسسواراته وصندوق خشبي	2026-08-08 11:49:44.416+00
Van de Graff generater	2026-08-08 11:50:44.115+00
Ammonium Ferrous Sulfate	2026-08-08 11:52:19.481+00
potassium Dichromate	2026-08-08 11:52:19.481+00
Mercuric Sulfate	2026-08-08 11:52:19.481+00
Silver Sulfate	2026-08-08 11:52:19.481+00
-1,10Phene throline Monohydrate	2026-08-08 11:52:19.481+00
Ferrous Sulfate Heptahydrate	2026-08-08 11:52:19.481+00
Total Organic Carbon	2026-08-08 11:52:19.481+00
Sulfuric Acid	2026-08-08 11:52:19.481+00
Dipotassium Hydrogen Phosphate	2026-08-08 11:52:19.481+00
Potassium diHydrogen Phosphate	2026-08-08 11:52:19.481+00
Disodium Hydrogen Phosphate	2026-08-08 11:52:19.481+00
Ammonium Chloride	2026-08-08 11:52:19.481+00
Magnesium Sulfate	2026-08-08 11:52:19.481+00
Calcium Chloride	2026-08-08 11:52:19.481+00
Ferric Chloride	2026-08-08 11:52:19.481+00
SodiumHydroxide	2026-08-08 11:52:19.481+00
Sodium Azide	2026-08-08 11:52:19.481+00
Glass Vials Screw Top 2ml	2026-08-08 14:27:19.186+00
Sodium Iodide	2026-08-08 11:52:19.481+00
Manganese Sulfate	2026-08-08 11:52:19.481+00
Nylon Disposable Filter syringe Sterile 0.45um	2026-08-08 14:27:19.186+00
Nylon Disposable Filter syringe Sterile 0.22um	2026-08-08 14:27:19.186+00
Sterile Centerfuge Tube 15ml	2026-08-08 14:27:19.186+00
تيوبات فحص الدم حمراء	2026-08-09 11:58:21.231+00
تيوبات فحص الدم بنفسجي	2026-08-09 11:58:21.231+00
تيوبات فحص الدم زرقاء	2026-08-09 11:58:21.231+00
Potassium Iodide	2026-08-08 11:52:19.481+00
تيوبات فحص الدم خضراء	2026-08-09 11:58:21.231+00
تيوبات فحص الدم صفراء	2026-08-09 11:58:21.231+00
شاش طبي معقم  4*4	2026-08-09 11:58:21.231+00
Sodium Thiosulfate	2026-08-08 11:52:19.481+00
Potassium Hydrogen di Iodate	2026-08-08 11:52:19.481+00
Starch Soluble	2026-08-08 11:52:19.481+00
شاش 2*2 صغير جاهز للسكري	2026-08-09 11:58:21.231+00
قطن طبي رول	2026-08-09 11:58:21.231+00
دمية بحجم طفل سنتين	2026-08-11 11:50:45.564+00
دمية بحجم طفل رضيع	2026-08-11 11:50:45.564+00
خزانة تخزين خشبية	2026-08-11 11:50:45.564+00
دمية لتطبيق الإسعاف الأولي الرئوي Electronic Half body Tupe	2026-08-11 15:59:07.232+00
دمية لتطبيق الإسعاف الأولي الرئوي Basic Type	2026-08-11 15:59:07.232+00
دمية لتطبيق الإسعاف الأولي الرئوي Regular Type Without Press	2026-08-11 15:59:07.232+00
اكسيليفون موسيقى	2026-08-11 16:10:23.458+00
الة مثلث موسيقي	2026-08-11 16:10:23.458+00
ستارة	2026-08-11 21:32:49.899+00
Salysalic Acid	2026-08-08 11:52:19.481+00
Glucose	2026-08-08 11:52:19.481+00
Glutamic Acid	2026-08-08 11:52:19.481+00
Celite 545	2026-08-08 11:52:19.481+00
Sodium Chloride	2026-08-08 11:52:19.481+00
Formazin Turbidity Standard (4000 NTU)	2026-08-08 11:52:19.481+00
Glass Microfiber Filters	2026-08-08 11:52:19.481+00
Aluminium Dishes	2026-08-08 14:24:27.177+00
Cylinder glass 100ml	2026-08-08 14:24:27.177+00
Ammonium Sulfate	2026-08-08 14:24:27.177+00
Latex Gloves 5.3gm white HAYAT brand	2026-08-08 14:24:54.845+00
Low Temperature Circulator RECL30-5	2026-08-08 14:25:17.972+00
Medical Trolley, 2 shelves, one drawer	2026-08-08 14:26:00.623+00
Medical Examination Couch	2026-08-08 14:26:00.623+00
IV stand , S.S	2026-08-08 14:26:00.623+00
Otoscope	2026-08-08 14:26:00.623+00
CONTEC CMS8000 Multi-Parameter Patient Monitor - without stand	2026-08-08 14:26:00.623+00
CONTEC CMS5100 Patient Monitor - without stand	2026-08-08 14:26:00.623+00
DW-F3 Trolley Color Ultrasonic\nDiagnostic Apparatus : with convex probe and linear probe	2026-08-08 14:26:00.623+00
Trans Vaginal probe (optional)	2026-08-08 14:26:00.623+00
Phased array probe (cardiac probe) (optional)	2026-08-08 14:26:00.623+00
Trans-rectal probe (optional)	2026-08-08 14:26:00.623+00
Micro convex array probe (optional)	2026-08-08 14:26:00.623+00
Thermal printer (optional)	2026-08-08 14:26:00.623+00
RD-500A Portable Digital X-ray Radiography System - wired FPD and manual bucky	2026-08-08 14:26:00.623+00
RD-550C Portable Digital X-ray Radiography System, wireless FPD and All-in-One Trolley/case	2026-08-08 14:26:00.623+00
خزانة لحفظ الالعاب رفوف مفتوحة	2026-08-11 11:50:45.564+00
سرير وفرشة بيبي 0-3 سنوات	2026-08-11 11:50:45.564+00
Medical Curtains, 4 folds	2026-08-08 14:26:00.623+00
Examination light	2026-08-08 14:26:00.623+00
CONTEC Portable Medical Phlegm Suction Unit	2026-08-08 14:26:00.623+00
Non-contact medical infrared thermometer with LCD display	2026-08-08 14:26:00.623+00
Compressor Nebulizer	2026-08-08 14:26:00.623+00
Precision Digital White Bathroom Scale	2026-08-08 14:26:00.623+00
Accu-Chek Instant Blood Glucose Meter	2026-08-08 14:26:00.623+00
Accu-chek test strips  (pk/50)	2026-08-08 14:26:00.623+00
Backless Adjustable Lab Chair	2026-08-08 14:26:00.623+00
Fire Blanket 100x100cm	2026-08-08 14:26:00.623+00
مجهر بيولوجي عينية واربع شيئيات مع حقيبة وكامل ملحقاته	2026-08-08 14:26:21.632+00
مرايا محدبة ومقعرة ومستوية	2026-08-08 14:26:21.632+00
حامل عدسات	2026-08-08 14:26:21.632+00
ضوء ليزر	2026-08-08 14:26:21.632+00
جهاز الناقوس والجرس كامل	2026-08-08 14:26:21.632+00
بطاريات متنوعة	2026-08-08 14:26:21.632+00
مصابيح صغيرة	2026-08-08 14:26:21.632+00
أسلاك فم التمساح	2026-08-08 14:26:21.632+00
انابيب اختبار	2026-08-08 14:26:21.632+00
حاما انابيب	2026-08-08 14:26:21.632+00
نظارات واقية	2026-08-08 14:26:21.632+00
معطف ابيض	2026-08-08 14:26:21.632+00
طقم صخور متنوعة	2026-08-08 14:26:21.632+00
لوحة السلامة العامة في المختبرات	2026-08-08 14:26:21.632+00
100 yard gauze رول	2026-08-09 11:58:21.231+00
Canula \r\nBlue 22 - 50 pcs\r\nPink 20 - 50pcs\r\nGreen 18 - 20 pcs\r\nYellow - 20pcs	2026-08-09 11:58:21.231+00
Salem syringe	2026-08-09 11:58:21.231+00
IV GIVING SET	2026-08-09 11:58:21.231+00
عدسات محدبة ومقعرة	2026-08-09 08:32:56.366+00
قفازات لاتكس	2026-08-09 08:32:56.366+00
أقلام بورد ومساحة	2026-08-11 14:59:35.034+00
ورق تباع الشمس الاحمر والازرق	2026-08-09 08:32:56.366+00
MICRO DRIP	2026-08-09 11:58:21.231+00
EXTENTION TUEB	2026-08-09 11:58:21.231+00
INFUSION PUMP (SYRING PUMPE) جهاز	2026-08-09 11:58:21.231+00
ASENA  جهاز	2026-08-09 11:58:21.231+00
Disposable Syringes 3ML	2026-08-09 11:58:21.231+00
Disposable Syringes 5ML	2026-08-09 11:58:21.231+00
Disposable Syringes 10ML	2026-08-09 11:58:21.231+00
Disposable Syringes 20ML	2026-08-09 11:58:21.231+00
اكياس نفايات اصفر طبي تشريحية طبية	2026-08-09 11:58:21.231+00
اكياس نفايات اسود طبية غير خطرة	2026-08-09 11:58:21.231+00
اكياس نفايات ازرق نفايات سامة	2026-08-09 11:58:21.231+00
اكياس نفايات احمر شديد عدوى	2026-08-09 11:58:21.231+00
اكياس نفايات البني كيماوية	2026-08-09 11:58:21.231+00
BLOOD CULTURE BOTTLE	2026-08-09 11:58:21.231+00
TEGADERM	2026-08-09 11:58:21.231+00
COLOSTOMY BAG & BASE	2026-08-09 11:58:21.231+00
ILEOSTOMY BAG& BASE	2026-08-09 11:58:21.231+00
ANIOS	2026-08-09 11:58:21.231+00
CUTASEPT	2026-08-09 11:58:21.231+00
CHEST TEUB	2026-08-09 11:58:21.231+00
CHEST BOTTEL	2026-08-09 11:58:21.231+00
CYCTO CATH	2026-08-09 11:58:21.231+00
STICH	2026-08-09 11:58:21.231+00
NYLON 0.0	2026-08-09 11:58:21.231+00
SILK 0.0	2026-08-09 11:58:21.231+00
VICRYL 0.0	2026-08-09 11:58:21.231+00
SUCTION CONECTION TEUBE	2026-08-09 11:58:21.231+00
SUCTION TEUBE size 16 - 8	2026-08-09 11:58:21.231+00
AIRWAY YELLOW	2026-08-09 11:58:21.231+00
AIRWAY RED	2026-08-09 11:58:21.231+00
AIRWAY .WHITE	2026-08-09 11:58:21.231+00
BUTTER FLY	2026-08-09 11:58:21.231+00
VETURE MASK ADULT	2026-08-09 11:58:21.231+00
VETURE MASK PEDIATRIC	2026-08-09 11:58:21.231+00
NASAL CANULA  ADULT	2026-08-09 11:58:21.231+00
NASAL CANULA  PEDIATRIC	2026-08-09 11:58:21.231+00
NON-REBREATHING MASK  ADULT	2026-08-09 11:58:21.231+00
NON-REBREATHING MASK  PEDIATRIC	2026-08-09 11:58:21.231+00
REBREATHING MASK  ADULT	2026-08-09 11:58:21.231+00
REBREATHING MASK  PEDIATRIC	2026-08-09 11:58:21.231+00
ورق تغليف للتعقيم  REEL 30	2026-08-09 11:58:21.231+00
ورق تغليف للتعقيم  15	2026-08-09 11:58:21.231+00
ورق تغليف للتعقيم  SHEET	2026-08-09 11:58:21.231+00
PLATER AUTOCLAVE	2026-08-09 11:58:21.231+00
مقص جراحي	2026-08-09 11:58:21.231+00
Artery Forceps	2026-08-09 11:58:21.231+00
Dressing forceps	2026-08-09 11:58:21.231+00
Allis forceps	2026-08-09 11:58:21.231+00
Kidney dish	2026-08-09 11:58:21.231+00
Needell holder	2026-08-09 11:58:21.231+00
Thoth forceps	2026-08-09 11:58:21.231+00
Surgical bladesشفرات جراحية  10	2026-08-09 11:58:21.231+00
Surgical bladesشفرات جراحية 20	2026-08-09 11:58:21.231+00
Surgical bladesشفرات جراحية 11	2026-08-09 11:58:21.231+00
Skin traction set	2026-08-09 11:58:21.231+00
ECG electrode	2026-08-09 11:58:21.231+00
Tracheostomy set	2026-08-09 11:58:21.231+00
Adult Ambu bag	2026-08-09 11:58:21.231+00
Pediatric Ambu bag	2026-08-09 11:58:21.231+00
Rubber Tourniquet	2026-08-09 11:58:21.231+00
نموذج حاضنة خداج	2026-08-09 11:58:21.231+00
عربة علاجاات	2026-08-09 11:58:21.231+00
حذاء + رباط احذية	2026-08-11 14:59:35.034+00
YSB-R10V Pregnancy Testing Device with convex probe and micro-convex probe - (Ysenmed)	2026-08-08 14:28:04.117+00
Slite Veterinary Ultrasound Diagnostic System with convex probe and micro-convex probe - (Dawei)	2026-08-08 14:28:04.117+00
YSMJ-DGT-N23 Class N Instrument sterilizer - (Ysenmed)	2026-08-08 14:28:04.117+00
جهاز الرطوبة والحرارة	2026-08-08 17:18:48.645+00
جهاز قياس اللزوجة Viscometer Digital	2026-08-08 17:18:48.645+00
Micrometer Digital	2026-08-08 17:18:48.645+00
ميزان حرارة حساس مع مجس  -50-300c	2026-08-08 17:18:48.645+00
جهاز قياس الرطوبة رقمي	2026-08-08 17:18:48.645+00
بطاؤيات انواع محتلفة	2026-08-08 17:44:08.066+00
مغانط اشكال متنوعة	2026-08-09 08:32:56.366+00
برادة حديد	2026-08-09 08:32:56.366+00
شمع	2026-08-09 08:32:56.366+00
ورق ترشيح	2026-08-09 08:32:56.366+00
بطاريات انواع محتلفة	2026-08-09 08:32:56.366+00
فازلين طبي	2026-08-09 08:32:56.366+00
قطارات بلاستيكية	2026-08-09 08:32:56.366+00
سلايدات زجاجية	2026-08-09 08:32:56.366+00
عنصر النحاس	2026-08-09 08:32:56.366+00
عنصر حديد	2026-08-09 08:32:56.366+00
عنصر المنيوم	2026-08-09 08:32:56.366+00
عنصر صوديوم	2026-08-09 08:32:56.366+00
عنصر اليود	2026-08-09 08:32:56.366+00
اقطاب جرافيت	2026-08-09 08:32:56.366+00
هيدروكسيد الصوديوم	2026-08-09 08:32:56.366+00
شرائح مجهرية جاهزة	2026-08-09 08:32:56.366+00
كاس زجاجي مدرج 100مل	2026-08-09 08:32:56.366+00
كاس زجاجي مدرج 250مل	2026-08-09 08:32:56.366+00
كرة ارضية	2026-08-09 08:32:56.366+00
قضيب تحريك زجاجي	2026-08-09 08:32:56.366+00
لزقات جروح	2026-08-09 08:32:56.366+00
باندج مع شاش	2026-08-09 08:32:56.366+00
جهاز ضغط رقمي  beurer	2026-08-09 11:38:07.165+00
جهاز قياس الحرارة بالأذن	2026-08-09 11:38:07.165+00
جهاز قياس الاكسجين	2026-08-09 11:38:07.165+00
جهاز قياس السكر Glucolab	2026-08-09 11:38:07.165+00
سرير طبي	2026-08-09 11:38:07.165+00
درج سرير	2026-08-09 11:38:07.165+00
ستارة طبية	2026-08-09 11:38:07.165+00
ميزان قياس الوزن والطول  عادي	2026-08-09 11:38:07.165+00
ميزان حرارة رقمي طبي Medical Digital Thermometer Gun type slim	2026-08-11 15:59:07.231+00
اسطوانة اكسجين مع منظم	2026-08-09 11:38:07.165+00
سماعة طبية  وجهين	2026-08-09 11:38:07.165+00
Trolly stanless steel	2026-08-09 11:38:07.166+00
Ice Box	2026-08-09 11:38:07.166+00
جهاز تبخيره	2026-08-09 11:38:07.166+00
حرام	2026-08-09 11:38:07.166+00
Tourch	2026-08-09 11:38:07.166+00
ادوات مطبخ (تبرويرات - صحون اطفال- ملاعق اطفال )	2026-08-11 14:59:35.034+00
جهاز ضغط الرقمي Digital sphygmomanometer Wrist type	2026-08-11 15:59:07.232+00
جهاز قياس مستوى سكر الدم Blood Glucose Meter with 25 test strips	2026-08-11 15:59:07.232+00
محضرة طعام	2026-08-11 14:59:35.034+00
جهاز قياس الأكسجين Pulse oximetry superior type JIKIZ	2026-08-11 15:59:07.232+00
علب صابون معلقة بالحائط	2026-08-09 11:58:21.231+00
جهاز سحب الفاين كهربائيا بدون اللمس	2026-08-09 11:58:21.231+00
معقم ايدي   hand sanitizer	2026-08-09 11:58:21.231+00
معقم ( خاص بالغسول الجراحي) غسول CHLORHEXIDINE	2026-08-09 11:58:21.231+00
معقم اسطح ترالين جالون 5 لتر	2026-08-09 11:58:21.231+00
SURGICAL BRUSH	2026-08-09 11:58:21.231+00
غطاء الرأس عادي	2026-08-09 11:58:21.231+00
غطاء رأس جراحي	2026-08-09 11:58:21.231+00
مريول جراحي قماش	2026-08-09 11:58:21.231+00
غطاء للقدم  cover shoes	2026-08-09 11:58:21.231+00
قفازات جراحية معقمة 6.5	2026-08-09 11:58:21.231+00
جهاز تبخيرة Medical Nebulizer high effective	2026-08-11 15:59:07.232+00
نموذج الهيكل العظمي 85cm on stand	2026-08-11 15:59:07.232+00
نموذج تشريح ذو أعضاء قابلة للفك والتركيب 85cm anatomical	2026-08-11 15:59:07.232+00
عربة حمل الأدوات والتجهيزات الطبية Medical trolley stainless steel	2026-08-11 15:59:07.232+00
ميزان حرارة رقمي Digital Thermometer for materials	2026-08-11 15:59:07.232+00
صندوق اسعافات اولية	2026-08-11 11:50:45.564+00
نموذج الفك والأسنان Movable	2026-08-11 15:59:07.232+00
معقم هايجين	2026-08-11 14:59:35.034+00
كمامات	2026-08-11 14:59:35.034+00
قفازات	2026-08-11 14:59:35.034+00
سحابات مختلفة القياسات	2026-08-11 14:59:35.034+00
ازرار مختلفة الأحجام	2026-08-11 14:59:35.034+00
مماسح وفوط	2026-08-11 14:59:35.034+00
ادوات تنظيف وتعقيم (شامبو -كريم - زيت اطفال - فاين مبلل )	2026-08-11 14:59:35.034+00
مخدة طبية مع غطاء Medical pillow with Cover	2026-08-11 15:59:07.232+00
ستارة 4 Folded with Blue screen	2026-08-11 15:59:07.232+00
قفازات جراحية معقمة 7.5	2026-08-09 11:58:21.231+00
قفازات جراحية معقمة 8.0	2026-08-09 11:58:21.231+00
وعاء استحمام ( للماء والصابون )	2026-08-09 11:58:21.231+00
كاسات معدنية للاستحمام	2026-08-09 11:58:21.231+00
ميزان حرارة الكتروني عن بعد ( الجبين )	2026-08-09 11:58:21.231+00
اكسيليفون موسيقي	2026-08-09 17:57:39.299+00
آلة المثلث الموسيقي	2026-08-09 17:57:39.299+00
طبلة	2026-08-11 16:10:23.458+00
دف	2026-08-11 16:10:23.458+00
سرير فحص طبي يدوي Manual Medical Examination Bed	2026-08-11 21:32:49.899+00
شرشف سرير Bed Sheet	2026-08-11 21:32:49.899+00
مخدة طبية مع غطاء medical pillow with Cover	2026-08-11 21:32:49.899+00
ادوات النظافة الشخصية  معقمات ومعطرات	2026-08-11 11:43:31.208+00
لوحة توضح مفهوم المخاطر	2026-08-11 11:43:31.208+00
منشورات عن الادوية والمواد الكيميائية	2026-08-11 11:43:31.208+00
نموذج علامات تحذيرية	2026-08-11 11:43:31.208+00
تقرير الحوادث والاصابات	2026-08-11 11:43:31.208+00
ادوات تعقيم الادوات الطبية	2026-08-11 11:43:31.208+00
قفازات طبية	2026-08-11 11:43:31.208+00
سي دي تعليمي	2026-08-11 11:43:31.208+00
كتب عن الثقافة	2026-08-11 11:43:31.208+00
ادوات رسم	2026-08-11 11:43:31.208+00
ادوات حرف يدوية	2026-08-11 11:43:31.208+00
ادوات بستنة	2026-08-11 11:43:31.208+00
العاب التفكير مثل الشطرنج	2026-08-11 11:43:31.208+00
لوحة توضح انواع المواد الغذائية	2026-08-11 11:43:31.208+00
علب حليب اطفال	2026-08-11 11:43:31.208+00
زجاجات رضاعة	2026-08-11 11:43:31.208+00
لوحات ارشادية	2026-08-11 11:43:31.208+00
تطبيقات حاسوبية	2026-08-11 11:43:31.208+00
ادوات مطبخ	2026-08-11 11:43:31.208+00
سخان لغلي الماء	2026-08-11 14:59:35.034+00
غطاء سرير اطفال	2026-08-11 14:59:35.034+00
مخدة اطفال	2026-08-11 14:59:35.034+00
رشق سريراطفال	2026-08-11 14:59:35.034+00
افرهول من (0 -3 )اشهر	2026-08-11 14:59:35.034+00
عربة حمل الأدوات والتجهيزات الطبية Medical trolley	2026-08-11 21:32:49.899+00
Spare Parts for Rotary Evaporator	2026-08-11 15:25:10.481+00
(ميزان حرارة رقمي) Digital Thermometer	2026-08-11 21:32:49.899+00
نموذج الفك والأسنان	2026-08-11 21:32:49.899+00
جهاز قياس قوة التدفق الزفيري	2026-08-11 21:32:49.899+00
صندوق التخلص من الأدوات الحادة Sharps Disposal Container	2026-08-11 21:32:49.899+00
صندوق فرز النفايات الطبية Medical WasteBox	2026-08-11 21:32:49.899+00
حرام سرير Bed Blanket	2026-08-11 21:32:49.899+00
ميزان حرارة رقمي طبي Digital Medical Thermometer	2026-08-11 21:32:49.899+00
ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale	2026-08-11 21:32:49.899+00
جهاز فحص الضغط اليدوي Manual Pressure Test Device	2026-08-11 21:32:49.899+00
الوان خشبية وزيتية ومائية	2026-08-11 14:59:35.034+00
فراشي الوان متنوعة القياس	2026-08-11 14:59:35.034+00
الوان امنة للرسم على الوجوه	2026-08-11 14:59:35.034+00
صوف	2026-08-11 14:59:35.034+00
طعام اطفال 0-1.1-2.2-6	2026-08-11 14:59:35.034+00
ادوات النظافة الشخصية شامبو ليفة  نكاشات اذن كريم	2026-08-11 14:59:35.034+00
حفاضات مختلفة القياس 0-2 سنة	2026-08-11 14:59:35.034+00
فوط قماشية للطعام	2026-08-11 14:59:35.034+00
فرشاة اسنان خاصة بالطفل	2026-08-11 14:59:35.034+00
معجون اسنان خاص بالطفل	2026-08-11 14:59:35.034+00
صافرة	2026-08-11 14:59:35.034+00
فرشاة خاصة لتنظيف زجاجات الرضاعة	2026-08-11 14:59:35.034+00
فرشاة خاصة لتنظيف حلمة الإرضاع	2026-08-11 14:59:35.034+00
دبابيس امان	2026-08-11 14:59:35.034+00
مريول بلاستيكي	2026-08-11 14:59:35.034+00
فرشاة تنظيف الخضار	2026-08-11 14:59:35.034+00
غطاء طاولة بلاستيكي	2026-08-11 14:59:35.034+00
بشكير او منشفة	2026-08-11 14:59:35.034+00
قرطاسية (اوراق - كراتين - اقلام - لاسق - غراء - صمغ )	2026-08-11 14:59:35.034+00
ابر خياطة	2026-08-11 14:59:35.034+00
ماسورة خياطة مختلفة الألوان	2026-08-11 14:59:35.034+00
فاين للغرف والحمامات والمطبخ - وفاين مبلل	2026-08-11 14:59:35.034+00
جهاز ضغط الرقمي digital sphygmomanometer	2026-08-11 21:32:49.899+00
جهاز قياس مستوى سكر الدم (Blood Glucose Meter)	2026-08-11 21:32:49.899+00
جهاز قياس الأكسجين Pulse oximetry	2026-08-11 21:32:49.899+00
جهاز تبخيرة Medical Nebulizer	2026-08-11 21:32:49.899+00
نموذج الهيكل العظمي	2026-08-11 21:32:49.899+00
نموذج تشريح ذو أعضاء قابلة للفك والتركيب	2026-08-11 21:32:49.899+00
دمية لتطبيق الإسعاف الأولي الرئوي	2026-08-11 21:32:49.899+00
ميزان حرارة الكتروني  حساس مع غطاء	2026-08-09 11:58:21.231+00
مسحة طبية  swap culture	2026-08-09 11:58:21.231+00
علبة عينة بول	2026-08-09 11:58:21.231+00
علبة عينة براز	2026-08-09 11:58:21.231+00
دواء على شكل شراب	2026-08-09 11:58:21.231+00
دواء على شكل حبوب	2026-08-09 11:58:21.231+00
دواء على شكل كبسولات	2026-08-09 11:58:21.231+00
دواء على شكل كريم	2026-08-09 11:58:21.231+00
دواء على شكل امبولة	2026-08-09 11:58:21.231+00
دواء على شكل فايال	2026-08-09 11:58:21.231+00
تحاميل اطفال وبالغين	2026-08-09 11:58:21.231+00
ادوية للتبخيرة  Pulmicort , Combivent	2026-08-09 11:58:21.231+00
\.


--
-- Data for Name: letter_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.letter_contacts (id, name, contact_type, created_at) FROM stdin;
844f4bbe-6ccd-40d0-83ff-eda96eb5848c	مدير التسويق	attention	2026-06-24 14:29:43.072927+00
7617a13d-e196-4123-b7a0-10e318bad442	مدير التسويق	attention	2026-06-24 14:30:14.553334+00
8b7b3eb8-8c98-4502-8083-294669fe9512	الى من يهمه الأمر	recipient	2026-08-06 14:58:39.291195+00
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
3c625d5d-780d-44be-b3dc-74f44c587f53	6f484e98-e110-4ceb-8070-e61810c5f108	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-06 07:59:14.651003+00
051af064-9f29-4082-a66a-37c519608879	445bc65d-256f-48d3-9367-464a408e657b	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-06 07:59:14.651003+00
17ed1bdf-e078-4576-92b8-114931b56adb	ee095348-a2de-4906-a078-0e8a3f3560a9	✅ تم اعتماد العرض QT-2026-0035	العميل: شركة سحاب لمواد التجميل 	info	quote	198b8bc1-3ab8-4330-883b-79bb6f577b37	f	2026-08-06 07:59:14.651003+00
c122eac3-2409-4a27-af20-e935c57bddc7	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Osama Alawy	info	quote	873a3454-5c39-4fcb-8304-349c14e2bab3	f	2026-08-06 10:13:22.853085+00
f8c3341a-e2be-484c-98d6-b6fc9475b609	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Osama Alawy	info	quote	873a3454-5c39-4fcb-8304-349c14e2bab3	f	2026-08-06 10:13:22.853085+00
41f26acc-ef5e-4fc8-9053-6775a0ef15c1	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Osama Alawy	info	quote	873a3454-5c39-4fcb-8304-349c14e2bab3	f	2026-08-06 10:13:22.853085+00
0dc18420-5e98-43ba-b09f-75a3b6d5c983	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Osama Alawy	info	quote	6aa4a2de-104e-4303-9638-0f23d2348d0b	f	2026-08-06 10:16:42.937548+00
57b52a85-7552-4cb7-80bd-e25f27ddd537	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Osama Alawy	info	quote	6aa4a2de-104e-4303-9638-0f23d2348d0b	f	2026-08-06 10:16:42.937548+00
e25a68a9-8291-41ef-9b0d-f9f04f9e2b07	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Eng. Osama Alawy	info	quote	6aa4a2de-104e-4303-9638-0f23d2348d0b	f	2026-08-06 10:16:42.937548+00
624a6a86-0a1f-4dd3-9648-1f230e5d2db4	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	ec6f990e-5f00-4426-af28-f533ae5796be	f	2026-08-06 10:28:51.027555+00
16ba4303-8537-4259-9bba-fb1984e83b45	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	ec6f990e-5f00-4426-af28-f533ae5796be	f	2026-08-06 10:28:51.027555+00
f5c8236b-0702-4cc8-be32-e67245fb8c7d	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	ec6f990e-5f00-4426-af28-f533ae5796be	f	2026-08-06 10:28:51.027555+00
a7b9b3ce-55fe-4151-ab93-e64a39278ec9	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0039	الحالة الجديدة: إحالة جزئية — العميل: المدارس الاردنية الدولية 	info	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	f	2026-08-06 13:31:57.472625+00
0df44a3a-2eb7-4c2a-81cb-a6605cceb41c	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	7a84e616-f098-46ab-8b3a-0fffad9b86d4	f	2026-08-06 13:33:15.336979+00
4a80c6dc-0c84-459c-8ed6-810c60ae1be0	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	7a84e616-f098-46ab-8b3a-0fffad9b86d4	f	2026-08-06 13:33:15.336979+00
b3480e86-adef-4dba-8816-9547df36598f	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	7a84e616-f098-46ab-8b3a-0fffad9b86d4	f	2026-08-06 13:33:15.336979+00
d8d4c1a0-8020-416c-ad43-f1a2de19111c	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0039	الحالة الجديدة: قيد الدراسة — العميل: المدارس الاردنية الدولية 	info	quote	8d865c1b-7081-4faf-b0c6-2b4877aaadb4	f	2026-08-08 11:37:41.214734+00
dccd410b-bb92-433e-85ed-44936c638e7c	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	تم تغيير حالة العرض QT-2026-0027	الحالة الجديدة: مرفوض — العميل: جامعة جرش الاهلية	danger	quote	79f9499f-31c6-4226-91d4-6c05ba279ab8	f	2026-08-08 11:51:21.887802+00
f8c3656d-4840-4078-9d72-a346701f4d15	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة القيمة المتميزة للصناعات الغذائية  — المُصدِر: Dr. Ahmad tannerah	info	quote	4f367a05-a990-4efe-967b-bebf1407c4e8	f	2026-08-08 17:18:49.756965+00
2141799f-0d22-4ecf-a7b6-513f556de444	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة القيمة المتميزة للصناعات الغذائية  — المُصدِر: Dr. Ahmad tannerah	info	quote	4f367a05-a990-4efe-967b-bebf1407c4e8	f	2026-08-08 17:18:49.756965+00
06250e8e-d3d0-4563-bc33-55e9bb7610f1	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة القيمة المتميزة للصناعات الغذائية  — المُصدِر: Dr. Ahmad tannerah	info	quote	4f367a05-a990-4efe-967b-bebf1407c4e8	f	2026-08-08 17:18:49.756965+00
f7d9eaeb-0a55-460f-a261-c861e3af0a34	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدارس المشاهير  — المُصدِر: Dr. Ahmad tannerah	info	quote	5a276011-0db0-40c1-ad6d-4f9971aea927	f	2026-08-08 17:44:09.069539+00
e16fa024-d8e2-488f-8419-89e696baa1de	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدارس المشاهير  — المُصدِر: Dr. Ahmad tannerah	info	quote	5a276011-0db0-40c1-ad6d-4f9971aea927	f	2026-08-08 17:44:09.069539+00
837d08cd-6f79-45e2-9329-76c7421b8c1f	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدارس المشاهير  — المُصدِر: Dr. Ahmad tannerah	info	quote	5a276011-0db0-40c1-ad6d-4f9971aea927	f	2026-08-08 17:44:09.069539+00
8c1c8244-c831-49d3-bb5b-373e10fd0ee1	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدارس ميار الدولية الثانية  — المُصدِر: Dr. Ahmad tannerah	info	quote	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	f	2026-08-09 11:38:07.318019+00
78d67736-1910-4d3a-bd77-a5a76af183bc	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدارس ميار الدولية الثانية  — المُصدِر: Dr. Ahmad tannerah	info	quote	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	f	2026-08-09 11:38:07.318019+00
4cdebc1d-d2c8-451a-bd89-b6a0b641c323	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدارس ميار الدولية الثانية  — المُصدِر: Dr. Ahmad tannerah	info	quote	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	f	2026-08-09 11:38:07.318019+00
2667ed23-129e-477e-a799-b0c44c4db1b9	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	d9cf0468-761e-426f-bd09-2d4d10c36f8a	f	2026-08-10 22:15:58.696366+00
40627844-4ca3-4c6e-a21f-0d696e1ad12d	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	d9cf0468-761e-426f-bd09-2d4d10c36f8a	f	2026-08-10 22:15:58.696366+00
90235a49-4649-44a9-b0c9-a101810840de	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	d9cf0468-761e-426f-bd09-2d4d10c36f8a	f	2026-08-10 22:15:58.696366+00
6e85791e-6dc2-4137-bc97-75773a0aee57	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	f	2026-08-10 22:52:32.630827+00
d4a2d543-25d3-4f37-9a5a-6139297be120	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	f	2026-08-10 22:52:32.630827+00
abf827fe-50d8-4361-a9cb-a069b7d0991a	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	f	2026-08-10 22:52:32.630827+00
1ea29880-ddcc-4125-a348-75b1d6dbc92f	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	e5a5e969-c9f3-4764-bf44-58a3b10a8818	f	2026-08-11 06:06:47.405341+00
3d3cb768-aacf-4c43-9d30-e8506ed00c41	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	e5a5e969-c9f3-4764-bf44-58a3b10a8818	f	2026-08-11 06:06:47.405341+00
790a8e72-0c6f-4e33-b594-95717480b400	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	e5a5e969-c9f3-4764-bf44-58a3b10a8818	f	2026-08-11 06:06:47.405341+00
7346d54d-aae0-4851-b62b-d5fd29564373	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	f	2026-08-11 06:18:41.342312+00
6833e283-2f72-4c66-822d-2ad1e6b49510	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	f	2026-08-11 06:18:41.342312+00
9c02966d-c427-4872-9b15-1750568a0140	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدرسة عجلون الثانوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	6cbd075c-65c8-4703-9c35-9b28f5017259	f	2026-08-11 06:18:41.342312+00
7cb72005-cd62-4b07-8fd8-9a1b7e92f710	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: الشركة الاردنية لانتاج الادوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	7b053b6e-5c57-4498-930d-0869cfcab2fa	f	2026-08-11 08:45:49.730247+00
f6c40725-61d8-4f23-aac3-15897cd3532c	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الشركة الاردنية لانتاج الادوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	7b053b6e-5c57-4498-930d-0869cfcab2fa	f	2026-08-11 08:45:49.730247+00
8879e0da-bce7-49e9-9c39-11ebae47cf58	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الشركة الاردنية لانتاج الادوية  — المُصدِر: Dr. Ahmad tannerah	info	quote	7b053b6e-5c57-4498-930d-0869cfcab2fa	f	2026-08-11 08:45:49.730247+00
3fa98bad-b7cd-40da-83d2-988f7bc3f79d	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	da22b830-27c5-425d-bbc9-17f0ab63a83c	f	2026-08-11 12:07:41.178147+00
df6b4598-9a5b-41a2-8406-ce3be52db19f	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	da22b830-27c5-425d-bbc9-17f0ab63a83c	f	2026-08-11 12:07:41.178147+00
58d67f3c-8900-4a93-9008-e1038dfe1e68	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: شركة الحياة للصناعات الدوائية — المُصدِر: Dr. Mohammad U Jawabreh	info	quote	da22b830-27c5-425d-bbc9-17f0ab63a83c	f	2026-08-11 12:07:41.178147+00
bbae0e79-984e-4951-9d62-c4850c5b7141	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	94435f61-38f3-40e5-88a2-be37057a238b	f	2026-08-11 14:49:52.732257+00
babf8bdc-b730-4256-b6b6-72fc4d850db9	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	94435f61-38f3-40e5-88a2-be37057a238b	f	2026-08-11 14:49:52.732257+00
42e7c34a-b900-4ae9-86e6-a4eef2531865	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	94435f61-38f3-40e5-88a2-be37057a238b	f	2026-08-11 14:49:52.732257+00
5f9420f1-64f9-4a82-bef2-d7a1e68113ff	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	a5a1c783-79f6-41b7-9eed-498bfb502031	f	2026-08-11 14:59:35.743497+00
7e5dc111-9fd4-4090-ac76-ee50bb03c2cf	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	a5a1c783-79f6-41b7-9eed-498bfb502031	f	2026-08-11 14:59:35.743497+00
100bb5e5-81f4-46b3-8c71-bfa15c696de6	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: الثلاثية المتخصصة لتجهيزات المنشئات والمحلات — المُصدِر: Eng. Osama Alawy	info	quote	a5a1c783-79f6-41b7-9eed-498bfb502031	f	2026-08-11 14:59:35.743497+00
e77087fa-660c-4c29-9f6d-fb564ddbedd3	6f484e98-e110-4ceb-8070-e61810c5f108	📋 عرض جديد 	العميل: مدرسة هالة بنت خويلد  — المُصدِر: Dr. Ahmad tannerah	info	quote	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	f	2026-08-11 16:10:25.025994+00
553ca527-5f02-4089-bb9d-5db4e359db42	445bc65d-256f-48d3-9367-464a408e657b	📋 عرض جديد 	العميل: مدرسة هالة بنت خويلد  — المُصدِر: Dr. Ahmad tannerah	info	quote	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	f	2026-08-11 16:10:25.025994+00
7b15fd52-e388-45cb-a157-41b03b9510cf	ee095348-a2de-4906-a078-0e8a3f3560a9	📋 عرض جديد 	العميل: مدرسة هالة بنت خويلد  — المُصدِر: Dr. Ahmad tannerah	info	quote	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	f	2026-08-11 16:10:25.025994+00
\.


--
-- Data for Name: number_sequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.number_sequences (id, prefix, current_value, year) FROM stdin;
order	ORD	15	2026
draft	2026D	13	2026
customer	C	13	2026
quotation	QT	52	2026
\.


--
-- Data for Name: official_letters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.official_letters (id, number, recipient, attention, date, subject, category, body, signer_name, signer_title, use_letterhead, created_by, created_at, updated_at) FROM stdin;
a0daf7ec-1996-400e-ab68-4afdf35355eb	1	جامعة العلوم الاسلامية العالمية	لمن يهمه الأمر	2025-10-22	كتاب انهاء عمل	other	<b>تحية طيبة وبعد :</b><div><b><br></b></div><div><b>يرجى العلم بانه تم الانتهاء من توريد وتوصيل وفحص ومعايرة ادوات واجهزة ومعدات المواد الكيماوية الخاصة بمختبر الكيمياء في مبنى القاعات الصفية وذلك حسب طلب الشراء رقم P.O(Ch-lab-4-00)&nbsp; &nbsp;تاريخ 21/10/2025 وحيث تم التوريد والتسليم في المختبر حسب الاصول</b></div><div><b><br></b></div><div style="text-align: center;"><b>واقبلوا الاحترام والتقدير</b></div>	الدكتور محمد عقاب الجوابرة	الادارة	t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-06-24 14:32:07.654072+00	2026-06-24 14:32:07.654072+00
399e79d2-6f05-45f1-b31b-5618020b5bdc	2	موظفي مؤسسة الحياة العلمية		2012-07-04	تعميم 1/2012	circular	<p class="MsoNormal" align="center" dir="RTL" style="text-align:center"><span lang="AR-JO" style="font-size:48.0pt;mso-bidi-language:AR-JO">تعميم 1/2012</span><span lang="EN-US" dir="LTR" style="font-size:48.0pt;mso-bidi-language:AR-JO"><o:p></o:p></span></p>\n\n<p class="MsoNormal" dir="RTL"><span lang="AR-JO">&nbsp;</span></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">1-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">قال\nرسول الله صلى الله عليه وسلم&nbsp; (اذا كانت\nليلة النصف من شعبان فقوموا ليله وصوموا نهاره ) وعملا بحديث النبي فان جمعية\nالثقافة العربية الاسلامية تدعوكم لحضور قيام ليلة النصف من شعبان اليوم الاربعاء\n4-7-2012 ببرنامج يبدأ بعد صلاة المغرب ويمتد لبعد العشاء يتخلله صلاة المغرب\nجماعة ثم درس ثم مديح ثم صلاة العشاء ثم قيام 8 ركعات والموقع في مصلى مدرسة\nالثقافة العربية في شفا بدران .<o:p></o:p></span></font></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">2-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">ندعوكم\nلحضور بازار جمعية الثقافة العربية الاسلامية في مدرسة الجبيهة التابعة للجمعية\nوذلك يوم الجمعة الموافق 6-07-2012 يتخلله عرض الكتب والاقراص المدمجة والطبق\nالخيري وذلك من بعد صلاة الجمعة ولغاية المغرب </span><span lang="EN-US" dir="LTR" style=""><o:p></o:p></span></font></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">3-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">بمناسبة\nقرب قدوم شهر رمضان نود اعلامكم بقيام الجمعية بتوزيع منشورات خاصة باحكام الصيام\nمع الامساكية ثمن كل 100 نسخة خمس دنانير وهو من الصدقة الجارية ويمكن توكيل\nالجمعية بالتوزيع لمن يرغب بالدفع والتبرع ارجو ان يتواصل مع الدكتور محمد</span><span lang="EN-US" dir="LTR" style=""><o:p></o:p></span></font></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-indent:-18.0pt;\nmso-list:l0 level1 lfo1"><!--[if !supportLists]--><font size="4"><span lang="EN-US" style="">4-<span style="font-style: normal; font-variant: normal; font-size-adjust: none; font-language-override: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-stretch: normal; line-height: normal; font-family: &quot;Times New Roman&quot;;"> </span></span><!--[endif]--><span dir="RTL"></span><span lang="AR-JO" style="">بمناسبة\nقرب دخول رمضان نود اعلامكم بقيام الجمعية بعمل حملة تفطير الصائم ثمن كل 100 صرة\nهو 15 دينار ويمكن توكيل الجمعية بالتوزيع لمن يرغب بالتسجيل التواصل مع الدكتور\nمحمد</span></font><span lang="EN-US" dir="LTR" style="font-size:20.0pt;mso-bidi-language:\nAR-JO"><o:p></o:p></span></p>	الدكتور محمد عقاب الجوابرة	الادارة	t	445bc65d-256f-48d3-9367-464a408e657b	2026-06-25 07:37:11.881029+00	2026-06-25 07:37:11.881029+00
c9aca185-3138-479b-a4cf-7e660cce84f8	3	الدكتور خالد احمد طالب شواقفة		2026-06-28	شهادة خبرة	other	<p class="isSelectedEnd"><font size="4" style="">تشهد إدارة <b>مؤسسة الحياة العلمية الطبية الكيماوية</b> بأن&nbsp;</font><font size="4"><b>الدكتور خالد احمد طالب شواقفة</b></font><span style="font-size: large;">&nbsp;</span><b style="font-size: large;">&nbsp;</b><span style="font-size: large;">&nbsp;قد تدرب لديها خلال الفترة من </span><b style="font-size: large;">01/04/2026</b><span style="font-size: large;"> ولغاية </span><b style="font-size: large;">28/06/2026</b><span style="font-size: large;">، بوظيفة مسؤول معرض التجهيزات الطبية والعلمية، بالإضافة إلى مسؤول إدارة التواصل عبر صفحات المؤسسة على منصات التواصل الاجتماعي.</span></p><p class="isSelectedEnd"><font size="4">وخلال فترة تدريبه، أظهر الدكتور خالد مستوىً عالياً من الجدية والالتزام، وكان مجدًّا ومجتهدًا في أداء مهامه، وتميز بحسن السيرة والسلوك، وأدى جميع المسؤوليات الموكلة إليه بكفاءة واقتدار وعلى أكمل وجه.</font></p><p class="isSelectedEnd"><font size="4"><br></font></p><p class="isSelectedEnd"><font size="4">وقد أُعطيت له هذه الشهادة بناءً على طلبه، دون أن يترتب عليها أي مسؤولية تجاه المؤسسة.</font></p><p class="isSelectedEnd"><font size="4"><br></font></p><p><font size="4">وتفضلوا بقبول فائق الاحترام والتقدير.</font></p>\n\n<p class="MsoNormal" align="right" dir="RTL" style="text-align:left;line-height:200%"><br></p>	الدكتور محمد عقاب الجوابرة	الادارة	f	445bc65d-256f-48d3-9367-464a408e657b	2026-06-27 16:59:05.305906+00	2026-06-27 16:59:05.305906+00
41f93b6c-5821-4d3e-85d8-9cc3be56e4d6	4	جامعة العلوم التطبيقية الخاصة 	عميد كلية الاعمال المحترم 	2026-08-03	قبول تدريب 	other	<b>تحية واحتراماً وبعد,<br></b>لا مانع لدينا من قبول تدريب الطالب ايمن رباح محمد علي ورقمه الجامعي 202210186 في أقسامنا المالية الختلفة في الفترة الواقعة ما بين 13\\9\\2026 الى 8\\10\\2026 بواقع 96 ساعة تدريبية.<br><br><b>وتفضلوا بقبول فائق الاحترام.<br></b><br><b>مؤسسة الحياة العلمية الطبية الكيماوية.</b>	الدكتور محمد عقاب الجوابرة	الادارة	t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-03 09:21:46.514084+00	2026-08-03 09:21:46.514084+00
73d4c002-16bd-44b6-aff8-f63bedf8aaf6	6	مديرية الخدمات الطبية الملكية	لمن يهمه الأمر	2026-08-06	براءة ذمة	other	تحية طبية وبعد،،،<div><br></div><div>نحيطكم علما أنه لا يوجد أي مطالبة مالية لغاية 31/12/2024 فما دون.&nbsp;</div><div><br></div><div>ويوجد مطالبات مالية بعد تاريخ 31/12/2024.</div><div><br></div><div>وتفضلوا بقبول فائق الاحترام....</div>	الدكتور محمد عقاب الجوابرة	الادارة	t	6f484e98-e110-4ceb-8070-e61810c5f108	2026-08-06 08:36:46.395384+00	2026-08-06 08:36:46.395384+00
c6cc8273-29fd-48fe-853e-8284b01298d1	5	الى من يهمه الأمر	To Whom It May Concern	2026-08-05	Employment Certificate	other	<p class="isSelectedEnd" style="text-align: center;"><b><font size="4">Employment Certificate</font></b></p><p class="isSelectedEnd" style="text-align: center;"><strong><br></strong></p><p class="isSelectedEnd" style="text-align: left;"><strong>,To Whom It May Concern</strong></p><p class="isSelectedEnd" style="text-align: left;">This is to certify that <strong>Mr. Osama Taha Alawi</strong> is employed by <strong>Hayat Scientific Medical &amp; Chemical&nbsp; Corp.</strong> as an <strong>Information Technology and Digital Transformation Officer</strong></p><p class="isSelectedEnd" style="text-align: left;">He&nbsp;is currently employed with us on a full-time basis</p><p class="isSelectedEnd" style="text-align: left;">This certificate has been issued upon his request for official purposes</p><p class="isSelectedEnd" style="text-align: left;">Should you require any further information, please do not hesitate to contact us</p><p style="text-align: left;"><br></p>	Dr. Mohammad U.Jawabreh	CEO	t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-04 14:30:45.771037+00	2026-08-04 14:30:45.771037+00
fc01da13-5224-48a1-a11a-6625173c241c	7	لمن يهمه الأمر 		2026-08-06	بيانات الحساب البنكي (يسمى البنك الاسلامي الاردني)	templates	<p data-start="28" data-end="48" class="PDq2pG_selectionAnchorContainer"><strong data-start="28" data-end="48">تحية طيبة وبعد،،</strong><span aria-hidden="true" class="PDq2pG_selectionAnchor"></span></p><p data-start="50" data-end="212">نفيدكم بأن بيانات الحساب البنكي العائدة لـ <strong data-start="93" data-end="161">مؤسسة الحياة العلمية الطبية الكيماوية / محمد عقاب مصطفى الجوابرة</strong> لدى <strong data-start="166" data-end="200">البنك </strong>هي كما يلي:</p><p data-start="50" data-end="212"><br></p><p data-start="165" data-end="181" class="PDq2pG_selectionAnchorContainer">\n\n</p><table><thead><tr><th>البيان</th><th>التفاصيل</th></tr></thead><tbody><tr><td><strong>اسم المستفيد</strong></td><td style="text-align: center;"><b>مؤسسة الحياة العلمية الطبية الكيماوية / محمد عقاب مصطفى الجوابرة</b></td></tr><tr><td><strong>اسم البنك</strong></td><td style="text-align: center;"><b>يسمى البنك الإسلامي الأردني</b></td></tr><tr><td><strong>الفرع</strong></td><td style="text-align: center;"><b>العبدلي مول – عمان – الأردن</b></td></tr><tr><td><strong>رقم الحساب (دينار أردني - JOD)</strong></td><td style="text-align: center;"><b>0080672984410400003</b></td></tr><tr><td><strong>رقم الحساب (دولار أمريكي - USD)</strong></td><td style="text-align: center;"><b>0080672984410840004</b></td></tr><tr><td><strong>رقم الآيبان (IBAN)</strong></td><td style="text-align: center;"><b>JO78JIBA0080000672984410400003</b></td></tr><tr><td><strong>رمز السويفت (SWIFT Code)</strong></td><td style="text-align: center;"><b>JIBAJOAMXXX</b></td></tr><tr><td><strong>الرقم الضريبي</strong></td><td style="text-align: center;"><b>1450972</b></td></tr></tbody></table><div class="TyagGW_tableContainer"><div tabindex="-1" class="group TyagGW_tableWrapper flex flex-col-reverse w-fit"></div></div>\n<p data-start="1113" data-end="1131"></p>		-	t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-06 09:56:25.254423+00	2026-08-06 09:56:25.254423+00
bab93630-ef48-4e1b-9dc0-451ddb6e5f20	8	لمن يهمه الأمر 	-	2026-08-06	بيانات الحساب البنكي (بنك الاتحاد)	templates	<p data-start="110" data-end="126" class="PDq2pG_selectionAnchorContainer"><b>تحية طيبة وبعد،،<span aria-hidden="true" class="PDq2pG_selectionAnchor"></span></b></p>\n<p data-start="128" data-end="271"><b>نفيدكم بأن بيانات الحساب البنكي العائدة لـ <span data-start="171" data-end="239">مؤسسة الحياة العلمية الطبية الكيماوية / محمد عقاب مصطفى الجوابرة</span> لدى <span data-start="244" data-end="259">بنك الاتحاد</span> هي كما يلي:<br></b></p><table><thead><tr><th><strong>البيان</strong></th><th><strong>التفاصيل</strong></th></tr></thead><tbody><tr><td><strong>اسم المستفيد</strong></td><td style="text-align: center;"><b>مؤسسة الحياة العلمية الطبية الكيماوية / محمد عقاب مصطفى الجوابرة</b></td></tr><tr><td><strong>اسم البنك</strong></td><td style="text-align: center;"><b>بنك الاتحاد</b></td></tr><tr><td><strong>الفرع</strong></td><td style="text-align: center;"><b>اللويبدة – عمان – الأردن</b></td></tr><tr><td><strong>رقم الحساب (دينار أردني - JOD)</strong></td><td style="text-align: center;"><b>0670168615815101</b></td></tr><tr><td><strong>رقم الحساب (دولار أمريكي - USD)</strong></td><td style="text-align: center;"><b>0670276861581001</b></td></tr><tr><td><strong>رقم الآيبان (IBAN) - دينار أردني</strong></td><td style="text-align: center;"><b>JO30UBSI6700000670168615815101</b></td></tr><tr><td><strong>رقم الآيبان (IBAN) - دولار أمريكي</strong></td><td style="text-align: center;"><b>JO25UBSI6700000670276861581001</b></td></tr><tr><td><strong>رمز السويفت (SWIFT Code)</strong></td><td style="text-align: center;"><b>UBSIJOAX</b></td></tr><tr><td><strong>الرقم الضريبي</strong></td><td style="text-align: center;"><b>1450972</b></td></tr></tbody></table>\n<div class="TyagGW_tableContainer"><div tabindex="-1" class="group TyagGW_tableWrapper flex flex-col-reverse w-fit"></div></div>			t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-06 14:46:36.939007+00	2026-08-06 14:46:36.939007+00
05bc2015-5f82-4c58-b69d-8a43e005efe2	9	الى من يهمه الأمر	-	2026-08-06	قنوات الدفع المعتمدة	templates	<p data-start="97" data-end="113" class="PDq2pG_selectionAnchorContainer"><b>تحية طيبة وبعد،،<span aria-hidden="true" class="PDq2pG_selectionAnchor"></span></b></p>\n<p data-start="115" data-end="231"><b>نفيدكم بأن قنوات الدفع المعتمدة لدى <span data-start="151" data-end="219">مؤسسة الحياة العلمية الطبية الكيماوية / محمد عقاب مصطفى الجوابرة</span>&nbsp; هي كما يلي:</b></p>\n<div class="TyagGW_tableContainer"><div tabindex="-1" class="group TyagGW_tableWrapper flex flex-col-reverse w-fit"></div></div><table><thead><tr><th><strong>وسيلة الدفع</strong></th><th><strong>التفاصيل<br></strong></th></tr></thead><tbody><tr><td><strong>اسم المستفيد</strong></td><td style="text-align: center;"><b>مؤسسة الحياة العلمية الطبية الكيماوية / محمد عقاب مصطفى الجوابرة</b></td></tr><tr><td><strong>بنك الاتحاد</strong></td><td style="text-align: center;"><b>رقم الحساب (دينار أردني)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0670168615815101</b></td></tr><tr><td><strong>يسمى البنك الإسلامي الأردني</strong></td><td style="text-align: center;"><b>رقم الحساب (دينار أردني)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0080672984410400003</b></td></tr><tr><td><strong>خدمة الدفع الفوري (CliQ)</strong></td><td style="text-align: center;"><b>المعرّف: HMEST&nbsp; &nbsp; &nbsp;-&nbsp; &nbsp; &nbsp; &nbsp;مزود الخدمة: بنك الاتحاد</b></td></tr><tr><td><strong>محفظة UWallet</strong></td><td style="text-align: center;"><b>رقم المحفظة: 00962798801000</b></td></tr></tbody></table>			t	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-06 14:59:10.237369+00	2026-08-06 14:59:10.237369+00
f3b713f6-50cc-4df7-bd94-9ce77149be46	11	مؤسسة الحياة العلمية الطبية الكيماوية	الدكتور محمد عقاب مصطفى الجوابرة	2026-08-09	مخالصة وتسوية نهائية	clearance	<h1 dir="RTL" style="margin-right:144.0pt;text-align:justify;text-indent:36.0pt;\nline-height:150%"><b><u><span lang="AR-SA" style="font-size:18.0pt;mso-ansi-font-size:\n10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">مخالصة وتسوية نهائية<o:p></o:p></span></u></b></h1>\n\n<p class="MsoBlockText" dir="RTL" style="margin-right:0cm;text-align:justify;\ntext-indent:36.0pt;line-height:150%"><span lang="AR-SA" style="font-size:8.0pt;\nline-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">&nbsp;</span></p>\n\n<p class="MsoBlockText" dir="RTL" style="margin-right:0cm;text-align:justify;\nline-height:150%"><span lang="AR-SA" style="font-size:18.0pt;mso-ansi-font-size:\n10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">أنا الموقع أدناه / محمود كمال جميل سمحة&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>\n\n<p class="MsoBlockText" dir="RTL" style="margin-right:0cm;text-align:justify;\nline-height:150%"><span lang="AR-SA" style="font-size:18.0pt;mso-ansi-font-size:\n10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">&nbsp;أحمل رقم وطني / &nbsp; &nbsp;9761027013<o:p></o:p></span></p>\n\n<p class="MsoBlockText" dir="RTL" style="margin-right:0cm;text-align:justify;\nline-height:150%"><span lang="AR-SA" style="font-size:18.0pt;mso-ansi-font-size:\n10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">أقر وأعترف إنني\nابريء ذمة الدكتور</span><span lang="AR-JO" style="font-size:18.0pt;mso-ansi-font-size:\n10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-bidi-language:\nAR-JO"> محمد عقاب مصطفى الجوابر</span><span lang="AR-SA" style="font-size:18.0pt;\nmso-ansi-font-size:10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;\nmso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">ه\n/ مؤسسة الحياة العلمية الطبية الكيماوية إبراءا عاما كاملاً شاملاً ومطلقا لا رجعة\nفيه وأتنازل عن أي حق أو أي مطالبة مالية مهما كاننت قيمتها سواء أكانت معروفة أو\nغير معروفة لدي وذكرت أم لم تذكر ولم يعد لي أي حق أو مطلب بهذا الخصوص ولا يحق لي\nالرجوع عن هذه المخالصة النهائية والشاملة والتي تتضمن تسوية نهائية لكافة حقوقي ومستحقاتي\nالمالية والمادية واية عقود او اتفاقيات تم توقيعها بيننا أو بين أي أشخاص أو أية\nمطالبات مالية بأي شكل كانت ، مسقطاً حقي بالتمسك بأي دفع شكلي أو موضوعي حول ما\nجاء في هذه المخالصة أو الطعن بأنها لم تشمل أي حق لي أستحقه ولم أطالب به لدى\nتنظيم هذه المخالصة والاقرار الوارد فيها والصادر عني والموقع مني بمحض إرادتي\nواختياري <o:p></o:p></span></p>\n\n<p class="MsoBlockText" dir="RTL" style="margin-right:0cm;text-align:justify;\nline-height:150%"><span lang="AR-SA" style="font-size:18.0pt;mso-ansi-font-size:\n10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">حرر و نظم في مدينة\nعمان - الاردن<o:p></o:p></span></p>\n\n<p class="MsoBlockText" align="center" dir="RTL" style="margin-right:0cm;text-align:\ncenter;line-height:150%"><b><span lang="AR-SA" style="font-size:18.0pt;\nmso-ansi-font-size:10.0pt;line-height:150%;font-family:&quot;Traditional Arabic&quot;,serif;\nmso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">"والله\nخير الشاهدين"<o:p></o:p></span></b></p>\n\n<p class="MsoBlockText" dir="RTL" style="margin-right:0cm;text-align:justify"><span lang="AR-SA" style="font-size:18.0pt;mso-ansi-font-size:10.0pt;font-family:&quot;Traditional Arabic&quot;,serif;\nmso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">وعليه\nأوقع بتاريخ&nbsp;09-08-2026<o:p></o:p></span></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-align:justify;\ntext-justify:kashida;text-kashida:0%"><span lang="AR-SA" style="font-size:18.0pt;\nmso-ansi-font-size:10.0pt;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">&nbsp;</span></p>\n\n<p class="MsoNormal" dir="RTL" style="text-align:justify;text-justify:kashida;\ntext-kashida:0%"><b><span lang="AR-SA" style="font-size:18.0pt;mso-ansi-font-size:\n10.0pt;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-hansi-font-family:&quot;Times New Roman&quot;">شاهد&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; شاهد&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; المقر بما فيه<o:p></o:p></span></b></p>\n\n<p class="MsoNormal" dir="RTL" style="margin-right:36.0pt;text-align:justify;\ntext-justify:kashida;text-kashida:0%"><span lang="AR-SA" style="font-size:18.0pt;\nmso-ansi-font-size:10.0pt;font-family:&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; الاسم:<o:p></o:p></span></p>\n\n<p class="MsoNormal" dir="RTL"><span lang="AR-SA" style="font-family:&quot;Traditional Arabic&quot;,serif;\nmso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang="AR-SA" style="font-size:18.0pt;font-family:&quot;Traditional Arabic&quot;,serif;\nmso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp; التوقيع:<o:p></o:p></span></p>\n\n<p class="MsoNormal" dir="RTL"><span lang="AR-SA" style="font-size:18.0pt;font-family:\n&quot;Traditional Arabic&quot;,serif;mso-ascii-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:\n&quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; التاريخ:<o:p></o:p></span></p>			f	445bc65d-256f-48d3-9367-464a408e657b	2026-08-09 08:42:50.893001+00	2026-08-09 08:42:50.893001+00
3b8c6c05-971f-44f7-8206-5d0ea7ff5c6f	10	مؤسسة الحياة العلمية الطبية الكيماوية	الدكتور محمد عقاب الجوابرة	2026-08-08	طلب استقالة الموظف محمود كمال جميل سمحة	templates	<p class="MsoNormal" align="center" dir="RTL" style="text-align:center"><u><span lang="AR-JO" style=""><font size="5">استقالة</font></span></u></p><p class="MsoNormal" align="center" dir="RTL" style="text-align:center"><u><span lang="AR-JO" style=""><font size="5"><br></font></span></u></p>\n\n<p class="MsoNormal" dir="RTL" style="line-height:200%"><span lang="AR-JO" style="line-height: 200%;"><font size="5">انا الموقع ادناه / محمود كمال جميل سمحة&nbsp;</font></span><span style="font-size: x-large;">ارجو التكرم بقبول استقالتي من مؤسستكم&nbsp;</span><span style="font-size: x-large;">ابتداءا من تاريخ / &nbsp;08-08-2026&nbsp;</span><span style="font-size: x-large;">وذلك لظروف شخصية وذلك بناءا على طلبي الخاص .</span></p>\n\n<p class="MsoNormal" dir="RTL"><span lang="AR-SA" style=""><font size="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;وعليه</font></span><span lang="AR-SA" style=""><font size="5"> اوقع </font><span style="font-size: 22pt;"><o:p></o:p></span></span></p>\n\n<p class="MsoNormal" dir="RTL"><br></p>\n\n<p class="MsoNormal" dir="RTL"><u><span lang="AR-SA" style="font-size:20.0pt">التوقيع\n</span></u><span lang="AR-SA" style="font-size:20.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>الموافقة</u></span><span lang="EN-US" dir="LTR" style="font-size:20.0pt"><o:p></o:p></span></p>\n\n<p class="MsoNormal" dir="RTL"><span lang="EN-US" dir="LTR"><o:p>&nbsp;</o:p></span></p>			t	445bc65d-256f-48d3-9367-464a408e657b	2026-08-09 08:38:57.155383+00	2026-08-09 08:38:57.155383+00
5de71db4-14dd-47c5-9599-ffefb7244479	12	شركة أورنج الأردن المحترمين	لمن يهمه الأمر	2026-08-10	تفويض	other	<p style="text-align: center;"><strong><font size="4">تفويض<br></font></strong></p><p style="text-align: right;">أنا الموقع أدناه <strong>محمد عقاب الجوابرة</strong>، بصفتي <strong>صاحب مؤسسة الحياة العلمية الطبية الكيماوية</strong>، أفوض بموجب هذا الكتاب السيد <strong>أسامة طه العلاوي</strong>، لمراجعة شركة <strong>أورنج الأردن</strong> بالنيابة عني وعن المؤسسة، والقيام بكافة الإجراءات والمعاملات المتعلقة بالاشتراكات والخدمات الخاصة بالمؤسسة.</p><p>ويشمل هذا التفويض حقه في <strong>التوقيع على الطلبات والنماذج والمستندات اللازمة، وإجراء أي تعديلات على الاشتراكات أو الخدمات، وتعديل بياناتها، وطلب إلغاء أو إنهاء أي اشتراكات أو خدمات، واستكمال كافة الإجراءات المتعلقة بها لدى شركة أورنج الأردن</strong>.</p><p>وقد أعطي هذا التفويض له لهذه الغاية، وله صلاحية التوقيع نيابةً عني وعن المؤسسة على ما يلزم لإتمام هذه الإجراءات.</p><p>وتفضلوا بقبول الاحترام،،،</p><p><strong>المفوِّض:</strong> محمد عقاب الجوابرة<br><strong>الصفة:</strong> صاحب مؤسسة الحياة العلمية الطبية الكيماوية<br><strong>الرقم الوطني:</strong> ____________________<br><strong>التوقيع:</strong> ____________________&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>الختم&nbsp;</b><br><strong>التاريخ:</strong> ____ / ____ / ______</p><p><br></p>			f	ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-10 07:44:45.702707+00	2026-08-10 07:44:45.702707+00
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
88855acc-3a73-450b-9d5c-ac2d2093970d	c1e9dc76-fb59-4f58-884c-a7fbec058895	0	Safety Chemical Cabinet 12L	\N	EACH	1.000	385.000	385.000	CHINA	PROMPT	\N	16.00
00051fa0-6495-44cf-b35a-7939650f17cd	c1e9dc76-fb59-4f58-884c-a7fbec058895	1	Chemical Spill Kit	\N	kit	1.000	145.000	145.000	CHINA	PROMPT	\N	16.00
74c2d912-412a-4c7c-abfe-ed903f85209e	c1e9dc76-fb59-4f58-884c-a7fbec058895	2	Biological Spill Kit	\N	kit	1.000	85.000	85.000	CHINA	PROMPT	\N	16.00
a404094e-3a51-41c1-9ea7-576c48047b64	c1e9dc76-fb59-4f58-884c-a7fbec058895	3	حاويات نفايات طبية مغلقة في اماكن العمل	\N	EACH	5.000	20.000	100.000	CHINA	PROMPT	\N	16.00
eb24a680-ecc7-4ed3-8fc7-b421af84df91	c1e9dc76-fb59-4f58-884c-a7fbec058895	4	حاويات نفايات طبية مغلقة للدم 5لتر	\N	EACH	5.000	4.500	22.500	CHINA	PROMPT	\N	16.00
23757637-6287-4a91-8ace-55362ec52c8c	e725580d-7baa-4570-b54d-9be667098b94	0	PH meter Digital Pen Type superior qulaity With Calibration Solution	\N	EACH	2.000	35.000	70.000	CHINA	PROMPT	\N	0.00
c8809a7c-e5ea-46d2-99ef-1eafbc032272	2922ef79-9ee2-42bb-80d2-b071f515335c	0	أقلام بورد ومساحة	\N	طقم	5.000	1.500	7.500	CHINA	PROMPT	\N	16.00
993e6b9a-ebbd-43a2-91e9-d51be4af2138	2922ef79-9ee2-42bb-80d2-b071f515335c	1	الوان خشبية وزيتية ومائية	\N	علبة 	5.000	4.000	20.000	CHINA	PROMPT	\N	16.00
85928e53-345f-4679-a4d3-ede0d1f8ac01	2922ef79-9ee2-42bb-80d2-b071f515335c	2	فراشي الوان متنوعة القياس	\N	EACH	5.000	2.000	10.000	CHINA	PROMPT	\N	16.00
ab03040a-398a-41ff-bb2d-23ef2e44f579	2922ef79-9ee2-42bb-80d2-b071f515335c	3	الوان امنة للرسم على الوجوه	\N	EACH	5.000	3.000	15.000	CHINA	PROMPT	\N	16.00
93688630-985c-473f-b541-6947e31bd81d	2922ef79-9ee2-42bb-80d2-b071f515335c	4	صوف	\N	EACH	5.000	1.500	7.500	CHINA	PROMPT	\N	16.00
ae925f92-32ed-483c-a33e-dd4dc8bbea53	2922ef79-9ee2-42bb-80d2-b071f515335c	5	طعام اطفال 0-1.1-2.2-6	\N	EACH	1.000	0.000	0.000	CHINA	PROMPT	\N	16.00
3c849b6a-80f3-443e-a784-a427e54bd73e	2922ef79-9ee2-42bb-80d2-b071f515335c	6	ادوات النظافة الشخصية شامبو ليفة  نكاشات اذن كريم	\N	مجموعة 	1.000	5.000	5.000	CHINA	PROMPT	\N	16.00
d7fd1466-52e1-4bd4-8fd7-43244b124734	2922ef79-9ee2-42bb-80d2-b071f515335c	7	حفاضات مختلفة القياس 0-2 سنة	\N	EACH	1.000	5.000	5.000	CHINA	PROMPT	\N	16.00
c291620a-21d3-4c0f-b792-eef3875107cf	2922ef79-9ee2-42bb-80d2-b071f515335c	8	فوط قماشية للطعام	\N	EACH	1.000	2.000	2.000	CHINA	PROMPT	\N	16.00
ee86f69b-163d-4ff5-b2a5-8681fbade863	2922ef79-9ee2-42bb-80d2-b071f515335c	9	فرشاة اسنان خاصة بالطفل	\N	EACH	5.000	1.250	6.250	CHINA	PROMPT	\N	16.00
e86ebef6-4cff-4e73-9457-f6885dd4a0a4	2922ef79-9ee2-42bb-80d2-b071f515335c	10	معجون اسنان خاص بالطفل	\N	EACH	5.000	1.500	7.500	CHINA	PROMPT	\N	16.00
58699aa4-c42a-43a6-a897-55bb90cf68f6	2922ef79-9ee2-42bb-80d2-b071f515335c	11	صافرة	\N	EACH	5.000	1.000	5.000	CHINA	PROMPT	\N	16.00
6fa0bf01-2e7f-4c95-a7a4-71abe14bf9b3	2922ef79-9ee2-42bb-80d2-b071f515335c	12	فرشاة خاصة لتنظيف زجاجات الرضاعة	\N	EACH	5.000	1.250	6.250	CHINA	PROMPT	\N	16.00
efcdd7b3-664e-424b-b85a-daf650dde282	2922ef79-9ee2-42bb-80d2-b071f515335c	13	فرشاة خاصة لتنظيف حلمة الإرضاع	\N	EACH	5.000	1.250	6.250	CHINA	PROMPT	\N	16.00
e6960c94-0555-40dc-a478-8929182ea901	2922ef79-9ee2-42bb-80d2-b071f515335c	14	دبابيس امان	\N	EACH	5.000	0.250	1.250	CHINA	PROMPT	\N	16.00
0a100da0-0676-496e-b984-521237d34405	2922ef79-9ee2-42bb-80d2-b071f515335c	15	مريول بلاستيكي	\N	EACH	10.000	0.500	5.000	CHINA	PROMPT	\N	16.00
77106efe-6b1b-49a7-8ddf-e94ce68e1482	2922ef79-9ee2-42bb-80d2-b071f515335c	16	فرشاة تنظيف الخضار	\N	EACH	5.000	2.000	10.000	CHINA	PROMPT	\N	16.00
997bb1c2-9c61-4f68-be10-440ac0a4c16a	2922ef79-9ee2-42bb-80d2-b071f515335c	17	غطاء طاولة بلاستيكي	\N	EACH	1.000	1.500	1.500	CHINA	PROMPT	\N	16.00
409f55dd-fd8f-499f-b1a4-44a9e02c3bdb	2922ef79-9ee2-42bb-80d2-b071f515335c	18	بشكير او منشفة	\N	EACH	51.000	2.000	102.000	CHINA	PROMPT	\N	16.00
af641ed0-bd30-42fc-b792-1b8f0bc8f768	2922ef79-9ee2-42bb-80d2-b071f515335c	19	قرطاسية (اوراق - كراتين - اقلام - لاسق - غراء - صمغ )	\N	EACH	1.000	10.000	10.000	CHINA	PROMPT	\N	16.00
95f58cac-25a2-4973-a7f9-46599f359788	2922ef79-9ee2-42bb-80d2-b071f515335c	20	ابر خياطة	\N	EACH	5.000	0.500	2.500	CHINA	PROMPT	\N	16.00
c7bf0a0d-2848-4439-b3d7-8691124bb2be	2922ef79-9ee2-42bb-80d2-b071f515335c	21	ماسورة خياطة مختلفة الألوان	\N	EACH	5.000	2.000	10.000	CHINA	PROMPT	\N	16.00
dce854fd-77ed-457a-9805-aad2c2343035	2922ef79-9ee2-42bb-80d2-b071f515335c	22	فاين للغرف والحمامات والمطبخ - وفاين مبلل	\N	EACH	1.000	7.000	7.000	CHINA	PROMPT	\N	16.00
e608d4f4-bba6-4910-ae8c-04731c22ebf3	2922ef79-9ee2-42bb-80d2-b071f515335c	23	معقم هايجين	\N	EACH	5.000	3.500	17.500	CHINA	PROMPT	\N	16.00
841b8cc1-8618-48e5-b107-04e8961a6aa1	2922ef79-9ee2-42bb-80d2-b071f515335c	24	كمامات	\N	EACH	1.000	1.000	1.000	CHINA	PROMPT	\N	16.00
17d2197d-ea63-4083-9ad1-c49a9cc75087	2922ef79-9ee2-42bb-80d2-b071f515335c	25	قفازات	\N	EACH	1.000	3.000	3.000	CHINA	PROMPT	\N	16.00
c7935758-b215-4663-980c-403225214496	2922ef79-9ee2-42bb-80d2-b071f515335c	26	سحابات مختلفة القياسات	\N	EACH	1.000	3.000	3.000	CHINA	PROMPT	\N	16.00
b549d9ab-52f2-46e3-8883-93d49c75eee8	2922ef79-9ee2-42bb-80d2-b071f515335c	27	ازرار مختلفة الأحجام	\N	EACH	1.000	4.000	4.000	CHINA	PROMPT	\N	16.00
1e6674c1-1416-4661-a4ca-311534f6e8bc	2922ef79-9ee2-42bb-80d2-b071f515335c	28	مماسح وفوط	\N	EACH	1.000	5.000	5.000	CHINA	PROMPT	\N	16.00
8ffc5fb8-adbd-4686-a082-0f153911808a	2922ef79-9ee2-42bb-80d2-b071f515335c	29	ادوات تنظيف وتعقيم (شامبو -كريم - زيت اطفال - فاين مبلل )	\N	EACH	1.000	8.000	8.000	CHINA	PROMPT	\N	16.00
894296d1-f141-4d57-91c0-547f93786bc1	2922ef79-9ee2-42bb-80d2-b071f515335c	30	حذاء + رباط احذية	\N	EACH	5.000	3.000	15.000	CHINA	PROMPT	\N	16.00
f24ffc60-0238-4a7b-94d4-5befde906337	2922ef79-9ee2-42bb-80d2-b071f515335c	31	ادوات مطبخ (تبرويرات - صحون اطفال- ملاعق اطفال )	\N	EACH	1.000	5.000	5.000	CHINA	PROMPT	\N	16.00
f74b5705-8a3f-4478-9268-b43314bddf0f	2922ef79-9ee2-42bb-80d2-b071f515335c	32	محضرة طعام	\N	EACH	1.000	25.000	25.000	CHINA	PROMPT	\N	16.00
cb35fa02-366c-4c06-bf33-3bb4b5fd92e0	2922ef79-9ee2-42bb-80d2-b071f515335c	33	سخان لغلي الماء	\N	EACH	1.000	15.000	15.000	CHINA	PROMPT	\N	16.00
bb896b6d-028a-47db-ba8e-de45b845f599	2922ef79-9ee2-42bb-80d2-b071f515335c	34	غطاء سرير اطفال	\N	EACH	1.000	8.000	8.000	CHINA	PROMPT	\N	16.00
9d88c9ee-63a7-4d48-9284-50712958c426	2922ef79-9ee2-42bb-80d2-b071f515335c	35	مخدة اطفال	\N	EACH	1.000	7.000	7.000	CHINA	PROMPT	\N	16.00
61171583-79f2-46db-93bc-5f46e121e9ff	2922ef79-9ee2-42bb-80d2-b071f515335c	36	رشق سريراطفال	\N	EACH	1.000	10.000	10.000	CHINA	PROMPT	\N	16.00
9e3f9c97-4278-4784-90a3-d34da3da6553	2922ef79-9ee2-42bb-80d2-b071f515335c	37	افرهول من (0 -3 )اشهر	\N	EACH	1.000	3.000	3.000	CHINA	PROMPT	\N	16.00
8b6f2c48-66f4-40ff-82de-74f8b91d14a3	8e65e9ab-30fd-4907-957d-5517ff7603a4	0	دمية بحجم طفل سنتين	\N	EACH	1.000	95.000	95.000	CHINA	PROMPT	\N	16.00
6ea28a80-f733-4e7c-a0c1-e923517adb5c	8e65e9ab-30fd-4907-957d-5517ff7603a4	1	ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale	\N	EACH	1.000	195.000	195.000	CHINA	PROMPT	\N	16.00
608fc14d-45c7-4b22-a4b2-bb6d0e9af12b	8e65e9ab-30fd-4907-957d-5517ff7603a4	2	صندوق اسعافات اولية	\N	EACH	1.000	25.000	25.000	CHINA	PROMPT	\N	16.00
5c768deb-1955-4837-a40f-9878ef507498	8e65e9ab-30fd-4907-957d-5517ff7603a4	3	دمية بحجم طفل رضيع	\N	EACH	1.000	59.000	59.000	CHINA	PROMPT	\N	16.00
62d193cf-990b-4a82-9561-1bd836697546	8e65e9ab-30fd-4907-957d-5517ff7603a4	4	خزانة تخزين خشبية	\N	EACH	1.000	250.000	250.000	CHINA	PROMPT	\N	16.00
4cd0fe5c-859e-4c11-9023-e9369d30ae65	8e65e9ab-30fd-4907-957d-5517ff7603a4	5	خزانة لحفظ الالعاب رفوف مفتوحة	\N	EACH	1.000	100.000	100.000	CHINA	PROMPT	\N	16.00
c85006aa-1d27-42f7-8072-dde4633d1be3	8e65e9ab-30fd-4907-957d-5517ff7603a4	6	سرير وفرشة بيبي 0-3 سنوات	\N	EACH	1.000	90.000	90.000	CHINA	PROMPT	\N	16.00
9e38d2e4-e366-4008-94e3-c27eb582fc87	8e65e9ab-30fd-4907-957d-5517ff7603a4	7	اكسيليفون موسيقى	\N	EACH	1.000	30.000	30.000	CHINA	PROMPT	\N	16.00
1375a4d9-4713-43c5-8a5c-d46af52d7daa	8e65e9ab-30fd-4907-957d-5517ff7603a4	8	الة مثلث موسيقي	\N	EACH	1.000	22.000	22.000	CHINA	PROMPT	\N	16.00
a53c8feb-de4d-4a30-9ace-aa74a073254f	8e65e9ab-30fd-4907-957d-5517ff7603a4	9	دف	\N	EACH	1.000	25.000	25.000	CHINA	PROMPT	\N	16.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, number, quotation_id, quotation_number, customer_name, currency, total_amount, status, notes, expected_delivery, actual_delivery, created_by, archived, archived_at, created_at, updated_at, archive_note, prepared_by, delivered_by, customer_ref, po_number, deleted_at, deleted_by, delete_reason) FROM stdin;
823b33c4-edc2-4922-96e3-ea790aaadc1d	ORD-2026-007	ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	شركة الحياة للصناعات الدوائية	JOD	6248.572	delivered	\N	2026-08-02	\N	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 10:14:02.883+00	2026-08-01 12:02:12.266131+00	2026-08-08 10:14:03.278409+00	تم تسليم الطلبية كاملة بموجب فاتورة	عبد الحكيم صمادي 	عبد الصمد 	\N	\N	\N	\N	\N
e725580d-7baa-4570-b54d-9be667098b94	ORD-2026-013	0a15f774-f2b6-4308-9887-8530a3ccfc5e	QT-2026-0008	الشركة النوعية للكرتون	JOD	70.000	pending	\N	\N	\N	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-08-08 11:43:28.439829+00	2026-08-08 11:43:28.439829+00	\N	\N	\N	\N	\N	\N	\N	\N
c1e9dc76-fb59-4f58-884c-a7fbec058895	ORD-2026-012	c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	شركة زعفران لتجارة المواد الطبية والجراحية	JOD	855.500	confirmed	\N	2026-08-06	\N	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 14:23:57.025+00	2026-08-06 09:07:03.304139+00	2026-08-08 14:23:57.635807+00	تم اصدار فاتورة مفوترة وتنفيذ الطلب	احمد تنيرة	احمد تنيرة	\N	\N	\N	\N	\N
2922ef79-9ee2-42bb-80d2-b071f515335c	ORD-2026-014	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	QT-2026-0048	مدرسة عجلون الثانوية	JOD	443.120	pending	\N	\N	\N	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-10 23:13:41.335723+00	2026-08-10 23:13:41.335723+00	\N	\N	\N	\N	\N	\N	\N	\N
8e65e9ab-30fd-4907-957d-5517ff7603a4	ORD-2026-015	d9cf0468-761e-426f-bd09-2d4d10c36f8a	QT-2026-0047	مدرسة عجلون الثانوية	JOD	1033.560	pending	\N	\N	\N	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-10 23:16:02.559503+00	2026-08-10 23:16:02.559503+00	\N	\N	\N	\N	\N	\N	\N	\N
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
65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	ahmad	Dr. Ahmad tannerah	hmest1969@gmail.com	\N	employee	t	\N	2026-07-23 13:35:58.415005+00	2026-08-11 16:02:30.447622+00	{"hr_access": false, "orders_edit": false, "catalog_edit": false, "orders_access": true, "orders_create": true, "orders_delete": false, "quotes_create": true, "quotes_delete": false, "archive_access": false, "catalog_access": true, "catalog_delete": false, "customers_edit": true, "letters_access": true, "letters_manage": false, "suppliers_edit": false, "activity_access": false, "payments_delete": false, "quotes_edit_all": true, "quotes_view_all": true, "customers_access": true, "customers_create": true, "customers_delete": false, "suppliers_access": false, "suppliers_create": false, "suppliers_delete": false, "quotes_view_issuer": false, "deleted_quotes_access": false, "quotes_validity_override": false, "supplier_invoices_create": false, "supplier_payments_create": false}
6f484e98-e110-4ceb-8070-e61810c5f108	ahlam	Eng. Ahlam Alyamani	hmest121981@gmail.com	\N	admin	t	\N	2026-07-23 13:50:50.459273+00	2026-07-23 13:50:50.948839+00	{}
445bc65d-256f-48d3-9367-464a408e657b	hmest	Dr. Mohammad U Jawabreh	hmest19811@gmail.com	0798807000	admin	t	\N	2026-05-14 13:37:47.517893+00	2026-07-26 07:24:16.140958+00	{}
ee095348-a2de-4906-a078-0e8a3f3560a9	osama	Eng. Osama Alawy	o.alawy.oa@gmail.com	\N	admin	t	\N	2026-05-14 13:37:47.517893+00	2026-08-01 11:51:51.467388+00	{}
\.


--
-- Data for Name: prospects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prospects (id, name, phone, source, interest_level, notes, assigned_to, created_by, created_at, converted, customer_id) FROM stdin;
\.


--
-- Data for Name: purchase_order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_order_items (id, po_id, item_name, description, unit, quantity, unit_price, tax_pct, total, sort_order) FROM stdin;
1ab071ea-2ebd-4db6-84e2-740e64c3cf58	8812d31e-9d77-416e-b36f-c7997754ca92	test	\N	EACH	20.000	20.000	16.00	400.000	0
\.


--
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_orders (id, number, supplier_id, supplier_name, date, expected_delivery, status, currency, subtotal, tax_pct, tax_amt, total, notes, created_by, created_at) FROM stdin;
8812d31e-9d77-416e-b36f-c7997754ca92	PO-0001	5ed75765-cf5c-4e80-9932-79ce699edb30	مورد للتجربة	2026-08-06	2026-08-07	draft	JOD	400.000	0.00	64.000	464.000	\N	\N	2026-08-06 09:03:26.989423+00
\.


--
-- Data for Name: quotation_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotation_items (id, quotation_id, sort_order, item_name, description, unit, quantity, unit_price, origin, delivery, notes, created_at, tax_pct, option_group) FROM stdin;
688adffe-16fb-4198-b318-06868583475e	219269a5-5fdf-4a4a-ad24-5551d478bc55	0	YSB-R10V Pregnancy Testing Device with convex probe and micro-convex probe - (Ysenmed)		EACH	1.000	3440.000	CHINA	4-6 WEEKS		2026-08-08 14:28:04.427989+00	16.00	\N
2c1aab88-467a-4027-aa72-525d08657a5a	df81a005-5d86-4bd2-a92e-555c33891d12	0	كرسي اسنان Keju Chair 		EACH	1.000	2625.000	CHINA	PROMPT		2026-08-08 11:49:02.163508+00	16.00	\N
09c8e3f4-6a27-4172-87b2-81aeecebfcf5	c22be163-9877-485c-8053-e3dfbf094862	0	1\tHeating Incubator Digital Control 20liter		EACH	1.000	235.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
1d119759-8df6-403c-81a2-4ddd39557967	c22be163-9877-485c-8053-e3dfbf094862	1	3\t Analytical Balance, 4 Digits Up to 120gm		EACH	1.000	455.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
96f1ae1d-6ebf-4645-96ec-d0c9560fa2e2	c22be163-9877-485c-8053-e3dfbf094862	2	3\t Analytical Balance, 3 Digits Up to 220gm		EACH	1.000	355.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
152fd349-5d42-48e4-83ae-5d3a907f87fb	c22be163-9877-485c-8053-e3dfbf094862	3	 Hot Plate with stirrer Manual Control Up to 180C		EACH	1.000	165.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
9b2ca220-3585-4f4f-80f6-e9b5ff61e953	c22be163-9877-485c-8053-e3dfbf094862	4	7\tWater Bath with gable cover 7liter		EACH	1.000	110.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
9565e7e3-1c31-43aa-9279-1575734d78a0	c22be163-9877-485c-8053-e3dfbf094862	5	8\tBenchtop pH Meter		EACH	1.000	165.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
9da04dee-1c71-4610-8cf4-33c918ecfcab	c22be163-9877-485c-8053-e3dfbf094862	6	9\tDigital Microscope with LCD screen		EACH	1.000	685.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
8dc4b0d2-c982-4023-89cc-852af4dd8fd9	c22be163-9877-485c-8053-e3dfbf094862	7	Visible Spectrophotometer		EACH	1.000	850.000	CHINA	PROMPT		2026-06-24 10:07:31.965709+00	16.00	\N
c20886fe-7bf6-4c49-ba81-f9a6bc1f3886	db3a3d6c-b5a0-455d-a33e-1d6222455860	0	Medical Trolley, 2 shelves, one drawer		EACH	1.000	73.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
ae45c788-79dc-4d5a-a98a-5d4beb58dc9e	db3a3d6c-b5a0-455d-a33e-1d6222455860	1	Medical Examination Couch		EACH	1.000	86.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
50d3e53e-3030-47dd-a0c7-9a265d05a022	a3215728-2478-4155-b0a2-d4342a61e744	0	Disposable Plastic Scoops 25ml		EACH	200.000	0.790	EUROPE	8-12 WEEKS		2026-07-18 17:18:57.120347+00	16.00	\N
22efcdb5-6db1-4dc0-b3c1-2114dd66a40b	db3a3d6c-b5a0-455d-a33e-1d6222455860	2	IV stand , S.S		EACH	1.000	30.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
62dee6a7-fc40-43c5-9f91-c274b8f100a7	c93f894e-3ecb-40d4-a5f8-6bbfbe2f205d	0	Hydrodistillation ( clevenger apparatus with heating mantle and its accessories) 500ml		EACH	2.000	387.931	CHINA	PROMPT		2026-07-22 10:03:52.100395+00	16.00	\N
4fc664aa-7a81-44a0-aa86-3a62d6358510	7f415e1f-baf2-412b-b49d-7437453aeb95	0	Hydrodistillation (clevenger apparatus with heating mantle and its accessories) 500ml		EACH	1.000	388.000	CHINA	PROMPT		2026-07-22 10:13:33.634196+00	16.00	\N
1c0ba79a-9741-42a0-ac89-5ecbeee70e5f	9ac83342-e490-4896-93fb-04fc3f70b0cb	0	1\tHeating Incubator Digital Control 20liter		EACH	1.000	240.000	CHINA	PROMPT		2026-08-04 09:25:45.72137+00	16.00	\N
68e0654e-3b80-42cf-97b3-2b6d505caef7	db3a3d6c-b5a0-455d-a33e-1d6222455860	3	Otoscope		EACH	1.000	58.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
dfaf5f9b-9f9c-439b-ac83-031db7b49b44	db3a3d6c-b5a0-455d-a33e-1d6222455860	4	CONTEC CMS8000 Multi-Parameter Patient Monitor - without stand		EACH	1.000	754.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
26399d30-6c49-4927-b878-862b9d128347	db3a3d6c-b5a0-455d-a33e-1d6222455860	5	CONTEC CMS5100 Patient Monitor - without stand		EACH	1.000	504.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
5efe2ebd-292e-4dd1-9d91-0f4509cabe94	db3a3d6c-b5a0-455d-a33e-1d6222455860	6	DW-F3 Trolley Color Ultrasonic\nDiagnostic Apparatus : with convex probe and linear probe		EACH	1.000	5600.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
e04c993c-21cf-4129-bc08-0344ab7d560f	db3a3d6c-b5a0-455d-a33e-1d6222455860	7	Trans Vaginal probe (optional)		EACH	1.000	750.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
1766072c-9318-4665-8faf-114e06329191	db3a3d6c-b5a0-455d-a33e-1d6222455860	8	Phased array probe (cardiac probe) (optional)		EACH	1.000	970.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
1182831d-3999-4360-8059-6996cbf3f637	db3a3d6c-b5a0-455d-a33e-1d6222455860	9	Trans-rectal probe (optional)		EACH	1.000	970.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
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
25870c00-7079-45a3-b8fd-68c28d9551d6	219269a5-5fdf-4a4a-ad24-5551d478bc55	1	Slite Veterinary Ultrasound Diagnostic System with convex probe and micro-convex probe - (Dawei)		EACH	1.000	1470.000	CHINA	4-6 WEEKS		2026-08-08 14:28:04.427989+00	16.00	\N
cd2e9eb1-9e83-48a9-9ec1-b3f1fe3a953e	219269a5-5fdf-4a4a-ad24-5551d478bc55	2	YSMJ-DGT-N23 Class N Instrument sterilizer - (Ysenmed)		EACH	2.000	690.000	CHINA	8-12 WEEKS		2026-08-08 14:28:04.427989+00	16.00	\N
455631c5-dbf3-49ca-ac5c-1688ada69aed	5a276011-0db0-40c1-ad6d-4f9971aea927	12	عنصر حديد		100GM	1.000	2.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
4fe23229-35d8-4c8a-811a-084bcffa885c	5a276011-0db0-40c1-ad6d-4f9971aea927	13	عنصر المنيوم 		50غم	1.000	5.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
f41db472-a25d-43ac-bce6-276da71d3bdc	5a276011-0db0-40c1-ad6d-4f9971aea927	14	عنصر صوديوم 		25غم	1.000	22.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
f6de1b81-7962-4b45-9d2c-ed2e889a7bb4	5a276011-0db0-40c1-ad6d-4f9971aea927	15	عنصر اليود 		25غم	1.000	10.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
cf0538a0-84b8-4736-8591-d5814c4ef9ef	5a276011-0db0-40c1-ad6d-4f9971aea927	16	اقطاب جرافيت 		EACH	2.000	2.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
c224b216-d1b3-46cb-8a56-9f13b735e71c	5a276011-0db0-40c1-ad6d-4f9971aea927	17	هيدروكسيد الصوديوم		250غم	1.000	5.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
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
4581c5b1-5755-47aa-8ef0-b893ab71c874	ab3be0df-3b5d-4283-bab0-631e54cc76cd	7	Nitrile Gloves Disposable Blue color Small size HAYAT brand		PK/100	30.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
6468e87a-a2c2-4a45-ac98-e2cea66dfd82	ab3be0df-3b5d-4283-bab0-631e54cc76cd	8	Nitrile Gloves Disposable Blue color Medium size HAYAT brand		PK/100	60.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
60fd27a3-7561-4ac5-970c-908e749b2add	ab3be0df-3b5d-4283-bab0-631e54cc76cd	9	Nitrile Gloves Disposable Blue color Large size HAYAT brand		PK/100	50.000	2.660	THAILAND	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
30c09130-910d-49a6-9ee9-fc82e5d34c37	ab3be0df-3b5d-4283-bab0-631e54cc76cd	10	Disposable Shoes Cover CPE 3.8gm heavy duty		PK/100	30.000	2.650	CHINA	PROMPT		2026-08-01 11:58:42.072717+00	16.00	\N
559a4f8c-94f7-43c5-8fc6-047cd180a160	65badfea-3e6c-48ed-82d0-890b09317b59	0	Electrode For PH meter BNC type		EACH	9.000	47.000	CHINA	PROMPT		2026-07-23 11:42:57.707417+00	16.00	\N
ffe7beea-415f-4345-986b-df52c3bf2532	18aa97f7-211d-484d-b844-76a42a4e742e	0	Heating Mantle 1000ml digital display		EACH	1.000	165.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
c7b468a0-d576-4c13-a07b-281b5e456f14	18aa97f7-211d-484d-b844-76a42a4e742e	1	Ultrasonic bath 2lit		EACH	1.000	118.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
f5fcaa15-e50c-4989-8f59-83dfdc230374	18aa97f7-211d-484d-b844-76a42a4e742e	2	Hot plate with magnatic stirror		EACH	1.000	165.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
bc1bfddb-3a80-4be8-a57d-fa22100a7a4d	18aa97f7-211d-484d-b844-76a42a4e742e	3	Analytical balance 4 digits		EACH	1.000	460.000	CHINA	PROMPT		2026-07-27 07:33:24.427001+00	16.00	\N
1a6dfdfd-401a-47d8-afdb-ebe3cda4df0f	4f367a05-a990-4efe-967b-bebf1407c4e8	0	جهاز الرطوبة والحرارة 		EACH	1.000	18.000	CHINA	PROMPT		2026-08-08 17:18:48.449388+00	16.00	gmskmq8ybkkll
872f504c-9274-4fae-9489-6ca18f923022	4f367a05-a990-4efe-967b-bebf1407c4e8	1	جهاز قياس اللزوجة Viscometer Digital 		EACH	1.000	1100.000	CHINA	PROMPT		2026-08-08 17:18:48.449388+00	16.00	gmskmq8ybkkll
38705b1f-ac0c-4bd0-b67a-af925f6718fb	4f367a05-a990-4efe-967b-bebf1407c4e8	2	Micrometer Digital		EACH	1.000	65.000	CHINA	PROMPT		2026-08-08 17:18:48.449388+00	16.00	\N
322607fb-91f9-4762-b151-9826bf0a585a	4f367a05-a990-4efe-967b-bebf1407c4e8	3	ميزان حرارة حساس مع مجس  -50-300c		EACH	1.000	25.000	CHINA	PROMPT		2026-08-08 17:18:48.449388+00	16.00	\N
a1d2131a-7e88-463f-82e2-730f17419cbd	4f367a05-a990-4efe-967b-bebf1407c4e8	4	جهاز قياس الرطوبة رقمي 		EACH	1.000	18.000	CHINA	PROMPT		2026-08-08 17:18:48.449388+00	16.00	\N
f47d5445-b525-4d51-acc2-086d37377589	5a276011-0db0-40c1-ad6d-4f9971aea927	18	ورق تباع الشمس الاحمر والازرق 		باكيت	2.000	1.500	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
03279457-5cbc-485b-995d-8e5e6c4baa8f	5a276011-0db0-40c1-ad6d-4f9971aea927	19	شرائح مجهرية جاهزة 		EACH	10.000	1.500	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
ff847f2f-7b4c-430e-9406-e1bcafb77931	198b8bc1-3ab8-4330-883b-79bb6f577b37	0	Latex Gloves Disposable White Medium Size HAYAT Brand		PK/100	1.000	2.660	THAILAND	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
c795c106-ff75-477a-b500-e6f5168a6e48	198b8bc1-3ab8-4330-883b-79bb6f577b37	1	Disposable Arm Sleeve		PK/100	1.000	12.070	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
403c70d4-1f1a-4ba0-9cac-9acf6c3051a1	198b8bc1-3ab8-4330-883b-79bb6f577b37	2	Disposable Face Mask		pk/50	1.000	1.150	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
90b08b4a-f6c1-4d0d-8659-41f3eabe60ef	198b8bc1-3ab8-4330-883b-79bb6f577b37	3	Disposables Coat  Non-Woven		EACH	1.000	0.650	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
454d03b0-355f-4b40-88b7-409b63fa1dc7	198b8bc1-3ab8-4330-883b-79bb6f577b37	4	Disposables Coat Nylon		EACH	1.000	0.070	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
4a58adbf-04a5-41ff-947a-c4432a625cf0	198b8bc1-3ab8-4330-883b-79bb6f577b37	5	Disposable Head Cover		PK/100	1.000	1.250	CHINA	PROMPT		2026-08-04 11:08:38.069312+00	16.00	\N
aaf3d47f-8ea4-470f-8e8c-20b33ba39869	5a276011-0db0-40c1-ad6d-4f9971aea927	20	كاس زجاجي مدرج 100مل		EACH	2.000	1.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
e01c829a-3fca-45d5-9b95-7201ced3dcb0	5a276011-0db0-40c1-ad6d-4f9971aea927	21	كاس زجاجي مدرج 250مل		EACH	2.000	1.650	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
311e43f0-a177-49b9-8a7e-e12c2ea8502c	5a276011-0db0-40c1-ad6d-4f9971aea927	22	كرة ارضية 		EACH	1.000	20.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
a7dbe466-7440-49ef-a3d6-96f69f0ceabb	5a276011-0db0-40c1-ad6d-4f9971aea927	23	قضيب تحريك زجاجي		EACH	2.000	1.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
0c3ade1c-a1cd-492f-b397-a42f9646f84c	5a276011-0db0-40c1-ad6d-4f9971aea927	24	لزقات جروح 		باكيت	1.000	1.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
31874c82-a04c-408a-b98b-04127976576a	5a276011-0db0-40c1-ad6d-4f9971aea927	25	باندج مع شاش 		مجموعة	1.000	2.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
7b8aabc3-4f4f-42b5-a2b8-939c9972f2c8	89b49bc4-0135-43a2-a74b-3861ed5d8430	0	علب صابون معلقة بالحائط	\N	EACH	8.000	18.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
24db3fc4-8509-43a9-922c-9b2341680e46	89b49bc4-0135-43a2-a74b-3861ed5d8430	1	جهاز سحب الفاين كهربائيا بدون اللمس	\N	EACH	8.000	39.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
69da195a-16a6-4841-aa45-cedb2f9a1833	89b49bc4-0135-43a2-a74b-3861ed5d8430	2	معقم ايدي   hand sanitizer	\N	LITER	8.000	8.600	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
f6071ce1-a496-4f8c-98ca-a64be78c0e26	89b49bc4-0135-43a2-a74b-3861ed5d8430	3	معقم ( خاص بالغسول الجراحي) غسول CHLORHEXIDINE	\N	LITER	8.000	8.900	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
aba35bb0-fd27-49c4-a618-e82e1c595c66	89b49bc4-0135-43a2-a74b-3861ed5d8430	4	معقم اسطح ترالين جالون 5 لتر	\N	5LIT	1.000	33.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
e8373e01-1ade-4bf4-8b6f-b5db1d9ec589	89b49bc4-0135-43a2-a74b-3861ed5d8430	5	SURGICAL BRUSH	\N	EACH	6.000	1.350	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
a629e465-7de5-459a-9f42-c3fcbde2a8ef	89b49bc4-0135-43a2-a74b-3861ed5d8430	6	غطاء الرأس عادي	\N	PK/100	50.000	1.850	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
f27d3b5b-b42b-4f08-99a1-f4d7e568bf0b	89b49bc4-0135-43a2-a74b-3861ed5d8430	7	غطاء رأس جراحي	\N	PK/100	20.000	2.350	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
24a96a0e-4c1c-46b5-8685-e26873770583	89b49bc4-0135-43a2-a74b-3861ed5d8430	8	مريول جراحي قماش	\N	PK/10	3.000	9.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
8926cb45-92a6-4b54-b666-e1a185ab967c	db3a3d6c-b5a0-455d-a33e-1d6222455860	10	Micro convex array probe (optional)		EACH	1.000	6100.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
3427a407-8375-4651-88c1-3fe7808ab71d	db3a3d6c-b5a0-455d-a33e-1d6222455860	11	Thermal printer (optional)		EACH	1.000	980.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
51289c10-6acc-401f-9b2a-ea1dc7262a3a	7a84e616-f098-46ab-8b3a-0fffad9b86d4	0	صنف للتجربة		EACH	1.000	0.000	CHINA	PROMPT		2026-08-06 13:33:14.351704+00	16.00	\N
1dac9f19-2516-47b3-9860-e15e46d8069a	db3a3d6c-b5a0-455d-a33e-1d6222455860	12	RD-500A Portable Digital X-ray Radiography System - wired FPD and manual bucky		EACH	1.000	12600.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
9f8a2325-ab7c-4a44-9d8c-7ca9cd2f2f5c	db3a3d6c-b5a0-455d-a33e-1d6222455860	13	RD-550C Portable Digital X-ray Radiography System, wireless FPD and All-in-One Trolley/case		EACH	1.000	18000.000	CHINA	4-6 WEEKS		2026-08-08 14:26:00.927851+00	16.00	\N
ec38026f-4999-45cc-8c5e-24568ba674fb	db3a3d6c-b5a0-455d-a33e-1d6222455860	14	Medical Curtains, 4 folds		EACH	1.000	56.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
4bb7388d-66e5-4d4c-8e00-06c7d7b7be52	db3a3d6c-b5a0-455d-a33e-1d6222455860	15	Examination light		EACH	1.000	142.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
17d5472e-3a80-4f3c-9eef-a9df1b408b8a	db3a3d6c-b5a0-455d-a33e-1d6222455860	16	CONTEC Portable Medical Phlegm Suction Unit		EACH	1.000	56.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
c3805d46-a82f-460c-9247-afecb5eb02dd	db3a3d6c-b5a0-455d-a33e-1d6222455860	17	Non-contact medical infrared thermometer with LCD display		EACH	1.000	13.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
de5ba18f-220c-4179-92d6-310191d86ad1	db3a3d6c-b5a0-455d-a33e-1d6222455860	18	Compressor Nebulizer		EACH	1.000	24.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
d2eb6f53-6169-40bb-ab14-695baa75a169	db3a3d6c-b5a0-455d-a33e-1d6222455860	19	Precision Digital White Bathroom Scale		EACH	1.000	13.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
8e4d3d82-e87e-445e-aa5d-2d8fcda8c810	db3a3d6c-b5a0-455d-a33e-1d6222455860	20	Accu-Chek Instant Blood Glucose Meter 		EACH	1.000	15.000	USA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
17aff5fe-5156-4c61-b494-073d580322a7	db3a3d6c-b5a0-455d-a33e-1d6222455860	21	Accu-chek test strips  (pk/50)		EACH	1.000	15.000	USA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
867b47f2-cdbd-4358-967b-f92d7d56f1b8	db3a3d6c-b5a0-455d-a33e-1d6222455860	22	Backless Adjustable Lab Chair		EACH	1.000	16.000	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
080d0c96-12b7-4f0b-9890-6b0e2ca6861b	db3a3d6c-b5a0-455d-a33e-1d6222455860	23	Fire Blanket 100x100cm		EACH	1.000	15.500	CHINA	PROMPT		2026-08-08 14:26:00.927851+00	16.00	\N
83371850-5eb3-4285-bc17-1adfc6444c9d	ec6f990e-5f00-4426-af28-f533ae5796be	0	Amber Glass Vials Screw Top 2ml		PK/100	50.000	14.000	FISHER - EUROPE	PROMPT		2026-08-08 14:27:19.494344+00	16.00	\N
6f5a119e-05a0-4b4b-8167-addf29e13a14	ec6f990e-5f00-4426-af28-f533ae5796be	1	Glass Vials Screw Top 2ml		PK/100	100.000	11.000	FISHER - EUROPE	PROMPT		2026-08-08 14:27:19.494344+00	16.00	\N
2b6cb6b8-c542-4e4d-99ab-d4093318f8a4	ec6f990e-5f00-4426-af28-f533ae5796be	2	Nylon Disposable Filter syringe Sterile 0.45um		PK/50	10.000	28.000	CHINA	PROMPT		2026-08-08 14:27:19.494344+00	16.00	\N
8277d492-9d17-48f2-8313-bea034c5de40	ec6f990e-5f00-4426-af28-f533ae5796be	3	Nylon Disposable Filter syringe Sterile 0.22um		PK/50	10.000	28.000	CHINA	PROMPT		2026-08-08 14:27:19.494344+00	16.00	\N
3b38a10e-a6ff-4139-b6f8-3fabc91d3fb2	ec6f990e-5f00-4426-af28-f533ae5796be	4	Sterile Centerfuge Tube 15ml		PK/100	10.000	29.000	FISHER - EUROPE	PROMPT		2026-08-08 14:27:19.494344+00	16.00	\N
40399271-0483-4342-96bf-cdc68311fc19	c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1	0	مجهر بيولوجي عينيتين واربع شيئيات مع كامل اكسسواراته وصندوق خشبي 		جهاز 	1.000	210.000	CHINA	PROMPT		2026-08-08 11:49:44.586629+00	16.00	\N
9c07d240-c9e1-4233-b2c8-0eec40254df7	e35fadc5-6138-42a1-84b2-9b2063825ee7	0	Ammonium Ferrous Sulfate		500gm	1.000	12.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
1b3b2d30-c489-4875-aef8-84cf52e810d2	e35fadc5-6138-42a1-84b2-9b2063825ee7	1	potassium Dichromate		500gm	1.000	18.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
35bb93c7-29c8-45dc-8777-952da0478303	e35fadc5-6138-42a1-84b2-9b2063825ee7	2	Mercuric Sulfate		100gm	1.000	25.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
bc2b6bcf-043a-43e0-bc6b-b8442094937d	e35fadc5-6138-42a1-84b2-9b2063825ee7	3	Silver Sulfate		25gm	1.000	35.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
6017ac18-6e3f-49bc-81bf-e0381a141a8e	95edd244-8e7a-47ce-9210-d8d3595a72fb	0	Patient Gown, elastic, 30gsm, dark blue, XL (length 130 cm, width 150cm)		EACH	50000.000	0.440	JORDAN	3-4 weeks		2026-08-01 11:56:52.283043+00	0.00	\N
ed25fef2-6f4d-41aa-b575-7f2cafcebbf2	e35fadc5-6138-42a1-84b2-9b2063825ee7	4	-1,10Phene throline Monohydrate		150gm	1.000	0.000	N.A	غير متوفر 		2026-08-08 11:52:19.641686+00	16.00	gmsel9hbm2st7
bd5a0726-4e0f-479f-9258-e29cc69d64ed	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	0	Vertical Electric Heating Air Blast Drying Oven 20Lit Model WGL-20BE		EACH	1.000	250.000	CHINA	PROMPT		2026-08-04 11:09:52.325033+00	16.00	\N
f241a4fe-141c-491a-ad12-84a2a75520ea	5f8785a4-1258-4ca3-ac8e-91a692e48ba5	1	Biological Microscope BIO-001		EACH	1.000	245.690	CHINA	PROMPT		2026-08-04 11:09:52.325033+00	16.00	\N
3b92fbc6-c5be-440e-995b-5ad9c990ac21	0460215c-ff4b-486f-b4b8-d780c6931ef2	0	Nuclear Radiation Detector HFS-10 		EACH	1.000	465.000	CHINA	PROMPT		2026-08-04 11:10:23.463736+00	16.00	\N
fa439fef-fccc-4819-a0ea-0f67b250a78f	0460215c-ff4b-486f-b4b8-d780c6931ef2	1	Electromagnetic Radiation Tester		EACH	1.000	265.000	CHINA	PROMPT		2026-08-04 11:10:23.463736+00	16.00	\N
b800c509-cf42-4f36-b98c-f1e152776d56	e35fadc5-6138-42a1-84b2-9b2063825ee7	5	Ferrous Sulfate Heptahydrate		250gm	1.000	15.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	gmsel9hbm2st7
cae0f75f-a7b3-418d-a012-0b2387a7d814	e35fadc5-6138-42a1-84b2-9b2063825ee7	6	Total Organic Carbon		500ml	1.000	0.000	N.A	غير متوفر		2026-08-08 11:52:19.641686+00	16.00	gmsel9hbm2st7
0d1f1768-c770-48a7-9a18-b11341a409d7	e35fadc5-6138-42a1-84b2-9b2063825ee7	7	Sulfuric Acid		litre	10.000	5.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	gmsel9hbm2st7
7219d672-af6f-4cd6-b982-975a141e30d7	e35fadc5-6138-42a1-84b2-9b2063825ee7	8	Dipotassium Hydrogen Phosphate		250gm	1.000	20.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
ad4e3cae-dd8f-4661-b86c-29d0e6ee1bf5	e35fadc5-6138-42a1-84b2-9b2063825ee7	9	Potassium diHydrogen Phosphate		250gm	1.000	32.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
c93894f6-edfa-4aad-8542-4a6c38f45fc6	e35fadc5-6138-42a1-84b2-9b2063825ee7	10	Disodium Hydrogen Phosphate		500gm	1.000	28.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
28611c45-0ad5-4050-998f-9910133733fc	e35fadc5-6138-42a1-84b2-9b2063825ee7	11	Ammonium Chloride		150gm	1.000	12.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
0b55700a-e449-4580-a80b-3acada7a1636	e35fadc5-6138-42a1-84b2-9b2063825ee7	12	Magnesium Sulfate		150gm	1.000	10.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
c0cbfcf0-fb13-4e4f-96f0-6c210eb8e1ca	e35fadc5-6138-42a1-84b2-9b2063825ee7	13	Calcium Chloride		150gm	1.000	10.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
fc810550-ac1b-4cc6-a1da-cd2200e9a292	e35fadc5-6138-42a1-84b2-9b2063825ee7	14	Ferric Chloride		150gm	1.000	13.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
65a2537d-71a1-4986-bba4-09476ee5745d	e35fadc5-6138-42a1-84b2-9b2063825ee7	15	SodiumHydroxide		kg	2.000	7.500	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
7d1b3b0b-aca2-4f22-b660-4624f0c6d0b4	e35fadc5-6138-42a1-84b2-9b2063825ee7	16	Sodium Azide		100gm	12.000	40.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
a96b0370-5ec5-4b81-aca5-985bd59a3339	e35fadc5-6138-42a1-84b2-9b2063825ee7	17	Sodium Iodide		500gm	1.000	25.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
358436e0-01a2-4c0b-bd27-b91cd2322ff3	e35fadc5-6138-42a1-84b2-9b2063825ee7	18	Manganese Sulfate		250gm	2.000	28.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
ad7de7a7-cf39-47d2-ad43-4fc6cbd79fb1	e35fadc5-6138-42a1-84b2-9b2063825ee7	19	Potassium Iodide		500gm	1.000	75.000	INDIA	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
d2a87464-bd59-44e5-a01b-3dbd9d178cf4	e35fadc5-6138-42a1-84b2-9b2063825ee7	20	Sodium Thiosulfate		500gm	1.000	32.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
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
1f415dc0-f4a8-44f5-bd6f-7e61c520dd9a	e35fadc5-6138-42a1-84b2-9b2063825ee7	21	Potassium Hydrogen di Iodate		150gm	1.000	0.000	N.A	غير متوفر 		2026-08-08 11:52:19.641686+00	16.00	\N
a06bcd82-de10-40ac-9a8e-6160a2fac93b	e35fadc5-6138-42a1-84b2-9b2063825ee7	22	Starch Soluble		250gm	1.000	8.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
800d3b8c-e94a-47b4-be87-7c4c21638e21	e35fadc5-6138-42a1-84b2-9b2063825ee7	23	Salysalic Acid		150gm	1.000	12.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
9cbfd93e-b4f3-48af-bf11-0af4c484951c	e35fadc5-6138-42a1-84b2-9b2063825ee7	24	Glucose		150gm	1.000	6.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
092a2f08-9be1-451d-bb24-9a32c2aabf50	e35fadc5-6138-42a1-84b2-9b2063825ee7	25	Glutamic Acid		150gm	1.000	18.000	HAYAT™	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
c2b7948c-fb85-4f98-8805-f3618186710d	e35fadc5-6138-42a1-84b2-9b2063825ee7	26	Celite 545		500gm	1.000	0.000	N.A	غير متوفر 		2026-08-08 11:52:19.641686+00	16.00	\N
160e94b5-b890-4720-962f-9c5b1f8a8cb9	e35fadc5-6138-42a1-84b2-9b2063825ee7	27	Sodium Chloride		250gm	1.000	6.000	INDIA	PROMPT		2026-08-08 11:52:19.641686+00	16.00	\N
c18fb0b1-3dc2-4afa-9580-32965b2d491d	e35fadc5-6138-42a1-84b2-9b2063825ee7	28	Formazin Turbidity Standard (4000 NTU)		250GM	1.000	0.000	N.A	غير متوفر 		2026-08-08 11:52:19.641686+00	16.00	gmsfyms8390kw
5378d86a-fb03-4c2f-837a-7c4aaa9a7b35	ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	0	Van de Graff generater		EACH	1.000	205.000	CHINA	PROMPT		2026-08-08 11:50:44.282509+00	16.00	\N
449e8790-acf5-4286-b2ce-f9c7bd4f73b4	75bb058a-1ceb-4c1e-b843-c5006a930fd6	7	مصابيح صغيرة 		علبة 	1.000	5.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
7adc2e0c-c58e-4639-bfd1-c30c5cdafd4a	75bb058a-1ceb-4c1e-b843-c5006a930fd6	8	أسلاك فم التمساح 		مجموعة/10	1.000	4.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
a313ab04-ba14-450b-9665-7fe4e6955b2b	75bb058a-1ceb-4c1e-b843-c5006a930fd6	9	انابيب اختبار 		EACH	10.000	0.300	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
c807b372-462b-467a-a7db-8537c194e42a	75bb058a-1ceb-4c1e-b843-c5006a930fd6	10	حاما انابيب 		EACH	1.000	5.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
7651b934-4c3e-489a-98ac-7d487b99d60a	c02833fb-95b8-4e6b-af6d-2104455d0623	0	Safety Chemical Cabinet 12L		EACH	1.000	385.000	CHINA	PROMPT		2026-08-06 07:18:23.378891+00	16.00	\N
ee8e9871-fc6e-45b7-bedf-027b16eddb5a	505e698c-09ce-4610-8d79-772e36f62ec1	0	Digital Heating Mantle (1 Liter)		EACH	1.000	165.000	CHINA	PROMPT		2026-08-03 14:14:21.642604+00	16.00	\N
4f49fef2-cb72-40a1-841c-cad16418208e	c02833fb-95b8-4e6b-af6d-2104455d0623	1	Chemical Spill Kit		kit	1.000	145.000	CHINA	PROMPT		2026-08-06 07:18:23.378891+00	16.00	\N
6e2e08ad-9f45-42a8-812d-5897f9d146cf	75bb058a-1ceb-4c1e-b843-c5006a930fd6	11	ورق تباع الشمس الاحمر والازرق 		باكيت 	2.000	1.500	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
6a32ca0c-63c9-4390-acd3-9926a0d454af	75bb058a-1ceb-4c1e-b843-c5006a930fd6	12	قفازات لاتكس		باكيت	1.000	3.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
5d9d81ac-8c61-4dc4-b758-62103f56d75a	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	0	Capillary Tube For TLC 1-5 ul		PK/100	2.000	14.000	EUROPE	PROMPT		2026-08-02 06:27:24.91528+00	16.00	\N
0546ebbc-7372-47dc-a6ec-b0d26de0c0c7	8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	1	Capillary Tube For TLC 10-50 ul		PK/100	2.000	14.000	EUROPE	PROMPT		2026-08-02 06:27:24.91528+00	16.00	\N
c2e9eeb4-af0f-48a1-89d6-3c0ef085cea5	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	0	Amber Vials Glass Screw Top 2ml		PK/100	100.000	14.000	FISHER - EUROPE	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
520b269c-7f61-4263-89c1-aad07d00cc50	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	1	Clear Vials Glass Screw Top 2ml		PK/100	100.000	11.000	FISHER - EUROPE	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
f98fe0a2-7ab0-4ad2-9f9f-ccdf36e02787	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	2	Parafilm 100 Feet Not 50 Feet		EACH	20.000	24.000	USA	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
e8aa084c-d4b3-42c9-a253-7028e1134085	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	3	Plastic Dropper Graduated 3ml		PK/100	30.000	8.750	CHINA	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
6320ddd4-b4e4-4f6e-b2d1-c55aef9cafa5	4e71dbec-a2b7-4edc-8a71-b5a850689dfe	4	Vials  Rack		EACH	10.000	8.750	CHINA	PROMPT		2026-08-02 06:33:16.157176+00	16.00	\N
013e9a72-a64b-4dc1-8222-0450009b41b5	0877fc34-9ecb-4956-9fbe-8818861c219c	0	 Nylon Disposable filter Syringe 0.45ul Non Sterile 		PK/100	5.000	28.000	CHINA	PROMPT		2026-08-02 06:38:13.860324+00	16.00	\N
d73308eb-41be-4a36-8edc-c0580b707205	0877fc34-9ecb-4956-9fbe-8818861c219c	1	 Nylon Disposable filter Syringe 0.45ul Sterile 		PK/50	5.000	28.000	CHINA	PROMPT		2026-08-02 06:38:13.860324+00	16.00	\N
ef362acc-c102-4370-b7fd-42784318a410	89b49bc4-0135-43a2-a74b-3861ed5d8430	9	غطاء للقدم  cover shoes	\N	PK/100	50.000	2.650	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
018a22cc-1083-4ddd-bfec-aac86e5e4355	89b49bc4-0135-43a2-a74b-3861ed5d8430	10	قفازات جراحية معقمة 6.5	\N	PAIR	100.000	0.220	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
ed7a627e-93bd-432a-b3c8-2fd6053df356	89b49bc4-0135-43a2-a74b-3861ed5d8430	11	قفازات جراحية معقمة 7.5	\N	P	100.000	0.220	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
1335bb45-886e-4af0-aaf3-761526d0d619	89b49bc4-0135-43a2-a74b-3861ed5d8430	12	قفازات جراحية معقمة 8.0	\N	P	100.000	0.220	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
85540b85-a5e6-4142-8725-6115be8b8ed2	89b49bc4-0135-43a2-a74b-3861ed5d8430	13	وعاء استحمام ( للماء والصابون )	\N	EACH	3.000	11.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
6c81784e-2b90-4c1f-b929-b2c52e35d1f6	89b49bc4-0135-43a2-a74b-3861ed5d8430	14	كاسات معدنية للاستحمام	\N	EACH	3.000	2.150	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
3f73ef01-2bbb-49fb-aa8f-ac79b6a5a4c9	89b49bc4-0135-43a2-a74b-3861ed5d8430	15	ميزان حرارة الكتروني عن بعد ( الجبين )	\N	EACH	2.000	9.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
055a1947-8148-409d-b54b-248cbee4f5d1	89b49bc4-0135-43a2-a74b-3861ed5d8430	16	ميزان حرارة الكتروني  حساس مع غطاء	\N	EACH	2.000	9.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
3692319b-c05e-4969-995a-1bc325dc5927	89b49bc4-0135-43a2-a74b-3861ed5d8430	17	مسحة طبية  swap culture	\N	EACH	50.000	0.110	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
b94391c7-8c9e-45be-8ee0-54089a09a2a1	89b49bc4-0135-43a2-a74b-3861ed5d8430	18	علبة عينة بول	\N	EACH	10.000	0.110	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
8ed109bf-c24a-4f83-ab25-56320678e6f5	89b49bc4-0135-43a2-a74b-3861ed5d8430	19	علبة عينة براز	\N	EACH	10.000	0.110	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
97816b85-7137-4f8e-ab1d-7d821d927c3b	89b49bc4-0135-43a2-a74b-3861ed5d8430	20	دواء على شكل شراب	\N	EACH	2.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
c7661cd7-15ab-4a68-9ce9-3fb7454bcca5	89b49bc4-0135-43a2-a74b-3861ed5d8430	21	دواء على شكل حبوب	\N	EACH	2.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
c6e4593c-e6db-4d1c-8e9f-d9ba2c9003a7	89b49bc4-0135-43a2-a74b-3861ed5d8430	22	دواء على شكل كبسولات	\N	EACH	2.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
4ef704b2-aef6-47a4-9126-5b520c8a35d7	89b49bc4-0135-43a2-a74b-3861ed5d8430	23	دواء على شكل كريم	\N	EACH	2.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
1054e686-69c1-4d05-8fa5-4b51393574f4	89b49bc4-0135-43a2-a74b-3861ed5d8430	24	دواء على شكل امبولة	\N	EACH	10.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
89ce572e-fd4f-4e0b-8c56-78955d380d12	89b49bc4-0135-43a2-a74b-3861ed5d8430	25	دواء على شكل فايال	\N	EACH	5.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
c8dee8e8-489a-4a08-9d43-0c9256c054c0	89b49bc4-0135-43a2-a74b-3861ed5d8430	26	تحاميل اطفال وبالغين	\N	EACH	10.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
545bc365-320b-4599-887e-bde32839f8af	79f9499f-31c6-4226-91d4-6c05ba279ab8	0	Potometer		EACH	2.000	25.000	CHINA	PROMPT		2026-08-02 06:47:12.99672+00	16.00	\N
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
09c90e34-cf92-46a5-b366-3de1187e5550	c02833fb-95b8-4e6b-af6d-2104455d0623	2	Biological Spill Kit		kit	1.000	85.000	CHINA	PROMPT		2026-08-06 07:18:23.378891+00	16.00	\N
ebe0a21a-b5d7-464b-89e3-2e4edbd43415	c02833fb-95b8-4e6b-af6d-2104455d0623	3	حاويات نفايات طبية مغلقة في اماكن العمل 		EACH	5.000	20.000	CHINA	PROMPT		2026-08-06 07:18:23.378891+00	16.00	\N
f4ff6610-1930-4cfb-8699-3807c33e4276	c02833fb-95b8-4e6b-af6d-2104455d0623	4	حاويات نفايات طبية مغلقة للدم 5لتر 		EACH	5.000	4.500	CHINA	PROMPT		2026-08-06 07:18:23.378891+00	16.00	\N
c7379eb5-5322-4e72-8e23-a947687b0f15	6aa4a2de-104e-4303-9638-0f23d2348d0b	0	3\t Analytical Balance, 3 Digits Up to 220gm		EACH	1.000	355.000	CHINA	PROMPT		2026-08-06 10:21:48.473357+00	16.00	\N
767abba5-6dc4-447b-81fe-fff5ae6bea7e	e35fadc5-6138-42a1-84b2-9b2063825ee7	29	Glass Microfiber Filters		pk	50.000	0.000	N.A	غير متوفر		2026-08-08 11:52:19.641686+00	16.00	gmsfyms8390kw
814eff32-5a35-4f6d-80ab-29b977b7f7b4	75bb058a-1ceb-4c1e-b843-c5006a930fd6	13	نظارات واقية 		EACH	1.000	1.500	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
b7d32664-a4c9-4813-8e69-13040fc0dbb9	75bb058a-1ceb-4c1e-b843-c5006a930fd6	14	كمامات 		باكيت	1.000	1.500	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
9bb41609-cfd9-47db-9665-e6da3e3c1589	75bb058a-1ceb-4c1e-b843-c5006a930fd6	15	معطف ابيض 		EACH	1.000	8.500	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
767478f5-c84f-4e67-84b7-5279afd131b5	75bb058a-1ceb-4c1e-b843-c5006a930fd6	16	طقم صخور متنوعة 		طقم	1.000	20.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
38ce25d1-85fa-4a7f-804e-341b883e8f82	75bb058a-1ceb-4c1e-b843-c5006a930fd6	17	لوحة السلامة العامة في المختبرات 		EACH	1.000	10.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
0f9caba5-4965-4f00-a12f-fe592178c1ad	89b49bc4-0135-43a2-a74b-3861ed5d8430	27	ادوية للتبخيرة  Pulmicort , Combivent	\N	EACH	10.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
33b76afe-351c-454f-b8e5-054d2f373423	89b49bc4-0135-43a2-a74b-3861ed5d8430	28	حقنة شرجية  rectal enema	\N	EACH	2.000	3.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
170a01f1-5f58-46ad-bc34-0bd9b73094aa	89b49bc4-0135-43a2-a74b-3861ed5d8430	29	قطرة العين	\N	EACH	3.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
65c7220a-82fe-4d92-ab5a-135d984bbffa	89b49bc4-0135-43a2-a74b-3861ed5d8430	30	مرهم للعين	\N	EACH	5.000	2.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
b96828f5-d63b-48c2-852f-79c5a0a99196	89b49bc4-0135-43a2-a74b-3861ed5d8430	31	بلاستر طبي	\N	EACH	10.000	1.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
799651c7-7174-46d8-afba-272341dd02b6	89b49bc4-0135-43a2-a74b-3861ed5d8430	32	يود طبي 5 %	\N	LITER	10.000	6.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
2f650c0f-0b9b-4771-9eae-981474b4bd7c	89b49bc4-0135-43a2-a74b-3861ed5d8430	33	سرنجات انسولين   1ml	\N	PK/100	1.000	6.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
80271fad-f1f9-4e87-a070-e6c000904f8f	89b49bc4-0135-43a2-a74b-3861ed5d8430	34	فيوسيدين كريم للحروق	\N	EACH	2.000	3.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
0bb652dc-7ee6-41a5-9c87-f86d92ce5f92	6aa4a2de-104e-4303-9638-0f23d2348d0b	1	Digital Balance 0.01-620gm with adaptor		EACH	1.000	0.000	CHINA	PROMPT		2026-08-06 10:21:48.473357+00	16.00	\N
1a26c3cd-c519-4ff8-bf85-02d15f0144b7	873a3454-5c39-4fcb-8304-349c14e2bab3	0	1\tHeating Incubator Digital Control 20liter		EACH	1.000	240.000	CHINA	PROMPT		2026-08-06 10:23:48.544684+00	16.00	\N
7f557f6f-2a74-494b-a9f2-dfff64066c62	873a3454-5c39-4fcb-8304-349c14e2bab3	1	3\t Analytical Balance, 3 Digits Up to 220gm		EACH	1.000	355.000	CHINA	PROMPT		2026-08-06 10:23:48.544684+00	16.00	\N
1bacefa3-71f2-4a54-baea-cf2621104a2e	89b49bc4-0135-43a2-a74b-3861ed5d8430	35	لاصقات طبية للغيار على الحروق والجروح  مختلف الاحجام	\N	EACH	20.000	1.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
5fb217eb-09e0-4afc-8e7f-b0a82a5371b3	89b49bc4-0135-43a2-a74b-3861ed5d8430	36	Paraffin gauze dressing	\N	PK/10	5.000	2.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
b343aa2a-c3f5-415e-8d27-e0821b3678d3	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	0	جهاز ضغط رقمي  beurer 		EACH	1.000	34.000	GERMANY	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
1878e908-9af5-406c-93f0-7170f64e448f	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	1	جهاز قياس الحرارة بالأذن 		EACH	1.000	75.000	GERMANY	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
67d643df-96d2-4ff6-bc6f-d3dea77bc76f	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	2	جهاز قياس الاكسجين		EACH	1.000	20.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
4749c4f8-8fe8-421e-b0f0-64a7c6ddfc43	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	3	جهاز قياس السكر Glucolab 		EACH	1.000	15.000	KOREA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
de013560-f702-4b5e-9490-640aab67e1e1	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	4	سرير طبي 		EACH	1.000	110.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
28b57e39-6824-49d0-af06-8568977acdee	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	5	درج سرير 		EACH	1.000	18.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
f70ecaa6-16cc-44ff-9d34-a076e2ce74a4	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	6	ستارة طبية 		EACH	1.000	65.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
158b4f9c-591d-4a05-ad1c-803ea5a47817	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	7	ميزان قياس الوزن والطول  عادي 		EACH	1.000	165.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
c8b46850-d9d9-4b5f-af8b-5e2b0116e90e	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	8	ميزان حرارة رقمي Digital Thermometer for materials		EACH	1.000	195.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
a09b690c-5b83-4176-98e9-f0912a52b8c6	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	9	اسطوانة اكسجين مع منظم 		EACH	1.000	145.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
106ccef8-9c67-4405-83fd-bbcc95263fcd	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	10	سماعة طبية  وجهين 		EACH	1.000	18.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
f9fcb4fb-b2a0-4510-8573-58cfe62284d8	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	11	صندوق اسعافات اولية 		EACH	3.000	25.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
f5cd2857-e078-4005-b7f0-1eb02149c198	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	12	Trolly stanless steel 		EACH	1.000	95.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
a121a7cc-fb37-483a-9349-f6cce2fac63c	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	13	Ice Box		EACH	1.000	23.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
5b6b2714-8113-422c-87e8-d40a807be1eb	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	14	جهاز تبخيره 		EACH	1.000	32.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
1fb6e176-c436-4b9a-af77-85ca04d31d4d	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	15	حرام 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
304e3b2a-57b7-4ccd-8b6e-32e69f364550	3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	16	Tourch		EACH	1.000	16.000	CHINA	PROMPT		2026-08-09 11:38:06.202974+00	16.00	\N
ba4aee31-acbd-496e-a4fb-b35d0fc03e97	89b49bc4-0135-43a2-a74b-3861ed5d8430	37	مشد طبي  crepe pandage\r\n(small - Medium - Large )	\N	PK/12	12.000	4.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
13c07c37-c6d5-404a-bafa-045e13d70fa8	89b49bc4-0135-43a2-a74b-3861ed5d8430	38	ضمادات soft bandage\r\n(Small - Medium - Large)	\N	PK/12	12.000	3.550	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
72a5d51a-0fb2-4781-8f4a-9d2e39185840	89b49bc4-0135-43a2-a74b-3861ed5d8430	39	انبوب معدي بقياساتNasogastric tube \r\nSize 10 - 12 - 18 - 20	\N	EACH	23.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
68a6a8a9-af53-40c9-a3cd-7ee8c16f9cd8	89b49bc4-0135-43a2-a74b-3861ed5d8430	40	بربيش بول \r\nSize 18 - 12 - 8	\N	EACH	6.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
bfe717d9-91b6-4a5d-bff4-0b490e7dd3be	89b49bc4-0135-43a2-a74b-3861ed5d8430	41	Folys catheter 3 way size 18 - 20	\N	EACH	4.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
6dd3be16-3934-4cf5-8314-a41486283a55	89b49bc4-0135-43a2-a74b-3861ed5d8430	42	كيس بول	\N	EACH	10.000	0.550	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7abb93e4-acf0-4579-8f30-08352a09d8df	89b49bc4-0135-43a2-a74b-3861ed5d8430	43	كوندوم كاثيتير للبولflash catheter(انثوي , ذكري ) Medium	\N	EACH	10.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
3b9a2ebe-1724-4a2b-9820-4a37d1e3ca45	89b49bc4-0135-43a2-a74b-3861ed5d8430	44	محلول ملحي  ringer lactate	\N	EACH	5.000	2.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
c640d9e9-2bd0-498f-ade0-bee7da15db79	89b49bc4-0135-43a2-a74b-3861ed5d8430	45	Normal saline 0.9 %	\N	EACH	5.000	1.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
1c41810e-624c-4690-8b0b-a71a387898ac	7d636c37-c439-4ec6-9020-5e11691791b2	0	Aluminium Dishes		EACH	100.000	0.100	CHINA	PROMPT		2026-08-08 14:24:27.47628+00	16.00	\N
23996e86-c916-4d30-b104-fa93f1b44037	7d636c37-c439-4ec6-9020-5e11691791b2	1	Cylinder glass 100ml		500gm	6.000	3.000	CHINA	PROMPT		2026-08-08 14:24:27.47628+00	16.00	\N
27eb85b3-5d58-4088-b049-91b2e7f472a7	7d636c37-c439-4ec6-9020-5e11691791b2	2	Ammonium Sulfate		EACH	3.000	18.000	CHINA	PROMPT		2026-08-08 14:24:27.47628+00	16.00	\N
8da29d02-6faf-47fc-834a-c7e6bba2d4e7	f4484ac3-fe41-4a73-8379-80a9257a185e	0	Low Temperature Circulator RECL30-5		EACH	1.000	2284.000	CHINA	4-8 weeks		2026-08-08 14:25:18.276568+00	16.00	\N
7488c54b-0146-4e32-abf6-1aa033d95d23	89b49bc4-0135-43a2-a74b-3861ed5d8430	46	Glucose saline	\N	EACH	5.000	1.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
e6052349-f594-43f6-9ab1-632d28c97338	89b49bc4-0135-43a2-a74b-3861ed5d8430	47	اسوارة تعريفيه للمريض	\N	EACH	10.000	0.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
4794cdf2-05ce-4623-b895-d7b36d3ff666	89b49bc4-0135-43a2-a74b-3861ed5d8430	48	تيوبات فحص الدم حمراء	\N	EACH	10.000	0.100	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
6b18304f-854c-40be-9978-f4ae93db438d	89b49bc4-0135-43a2-a74b-3861ed5d8430	49	تيوبات فحص الدم بنفسجي	\N	EACH	10.000	0.150	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
88aa85e5-35c7-48a7-887e-cf43860539b1	89b49bc4-0135-43a2-a74b-3861ed5d8430	50	تيوبات فحص الدم زرقاء	\N	EACH	10.000	0.150	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
65876982-089f-4546-a866-fe7d7718ea86	89b49bc4-0135-43a2-a74b-3861ed5d8430	51	تيوبات فحص الدم خضراء	\N	EACH	10.000	0.220	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
9a8e458c-e9db-4db1-97cf-8c41508e3716	89b49bc4-0135-43a2-a74b-3861ed5d8430	52	تيوبات فحص الدم صفراء	\N	EACH	10.000	0.290	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7f5c1b66-dedd-4aa1-bab2-a51fb48f834e	89b49bc4-0135-43a2-a74b-3861ed5d8430	53	شاش طبي معقم  4*4	\N	PK/100	1.000	9.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
9648e1f6-10db-49e4-a3fa-de0f19615020	89b49bc4-0135-43a2-a74b-3861ed5d8430	54	شاش 2*2 صغير جاهز للسكري	\N	PK/100	10.000	1.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
8fd46e7c-8afd-4e53-8aa5-48e70381266b	89b49bc4-0135-43a2-a74b-3861ed5d8430	55	قطن طبي رول	\N	500GM	5.000	3.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7f36f720-3653-49a2-be00-05e24e1a6aa2	89b49bc4-0135-43a2-a74b-3861ed5d8430	56	100 yard gauze رول	\N	EACH	5.000	15.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
4ae2d9d2-8df9-4fd4-af6f-6e3ac305a731	89b49bc4-0135-43a2-a74b-3861ed5d8430	57	Canula \r\nBlue 22 - 50 pcs\r\nPink 20 - 50pcs\r\nGreen 18 - 20 pcs\r\nYellow - 20pcs	\N	EACH	140.000	0.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7e7d340b-a72a-4e99-94f4-9e3be2e4ef73	89b49bc4-0135-43a2-a74b-3861ed5d8430	58	Salem syringe	\N	EACH	25.000	1.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
08f10acd-615b-4434-9e71-85bb43b126cd	89b49bc4-0135-43a2-a74b-3861ed5d8430	59	IV GIVING SET	\N	EACH	20.000	0.550	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
35fc425c-11c7-4a5d-a6f7-21ab5e17dac1	89b49bc4-0135-43a2-a74b-3861ed5d8430	60	MICRO DRIP	\N	EACH	15.000	2.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
696a64db-5791-46dd-9932-02abc12f7090	89b49bc4-0135-43a2-a74b-3861ed5d8430	61	EXTENTION TUEB	\N	EACH	5.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
84bc8d86-dbef-4297-920a-54c6b9691408	89b49bc4-0135-43a2-a74b-3861ed5d8430	62	INFUSION PUMP (SYRING PUMPE) جهاز	\N	EACH	1.000	365.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
18e96abf-564c-4cb1-a34b-ce64c92e5956	89b49bc4-0135-43a2-a74b-3861ed5d8430	63	ASENA  جهاز	\N	EACH	2.000	32.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
ffe91309-781d-4657-9b1b-ac6b29a2ccf7	89b49bc4-0135-43a2-a74b-3861ed5d8430	64	Disposable Syringes 3ML	\N	EACH	100.000	0.050	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
24533c0f-8cc0-4d26-bf7b-d9ec39665516	89b49bc4-0135-43a2-a74b-3861ed5d8430	65	Disposable Syringes 5ML	\N	EACH	100.000	0.050	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
60498b91-be13-4453-8588-6b936abf76d9	89b49bc4-0135-43a2-a74b-3861ed5d8430	66	Disposable Syringes 10ML	\N	EACH	100.000	0.100	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
c55ccc3b-59af-44da-ba2a-fecf7d4af4b2	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	23	طبلة		EACH	1.000	25.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
623bd96f-634d-470e-beab-1e26c2f9fc76	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	24	دف		EACH	1.000	20.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
c9a17709-ae69-45a3-a0d8-1e856fe1ad2c	5a276011-0db0-40c1-ad6d-4f9971aea927	0	عدسات محدبة ومقعرة 		EACH	4.000	1.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
4f750d7c-17be-46b2-8349-ec4d8ff98791	5a276011-0db0-40c1-ad6d-4f9971aea927	1	مغانط اشكال متنوعة 		طقم/4	2.000	12.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
d85b399d-e508-4c7f-bd37-3a9d68afe8ab	5a276011-0db0-40c1-ad6d-4f9971aea927	2	برادة حديد 		100GM	1.000	2.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
2a14f92c-934a-434e-9617-7a884747e3cd	5a276011-0db0-40c1-ad6d-4f9971aea927	3	شمع 		باكيت	1.000	0.500	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
0abd9535-c859-4e8c-abce-54a5ab2bbda6	5a276011-0db0-40c1-ad6d-4f9971aea927	4	ورق ترشيح 		باكيت	1.000	3.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
a4ef0286-009b-48e0-8aed-e0c5f6ae7610	5a276011-0db0-40c1-ad6d-4f9971aea927	5	قفازات لاتكس		باكيت	2.000	3.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
a9c1eb84-336c-42f7-abc0-b8a211c1a0e5	5a276011-0db0-40c1-ad6d-4f9971aea927	6	بطاريات انواع محتلفة 		مجموعة	1.000	10.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
8d2e0e85-5f23-4124-bc1f-b1da6868843a	5a276011-0db0-40c1-ad6d-4f9971aea927	7	فازلين طبي		250غم	1.000	4.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
e8dfea89-3d19-445a-aa3f-4ab6d3431a56	5a276011-0db0-40c1-ad6d-4f9971aea927	8	كمامات 		باكيت	2.000	1.500	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
fa37fba3-18a0-47b0-9c4f-65e8e51ee3d4	5a276011-0db0-40c1-ad6d-4f9971aea927	9	قطارات بلاستيكية 		مجموعة	2.000	2.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
fb80ad50-875e-4626-bb3e-771409d45987	95434668-ce79-4841-8844-ec778967671e	0	ميزان حرارة رقمي طبي Digital Medical Thermometer	\N	EACH	2.000	9.150	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
ee98b66f-47bf-485e-a8a7-5e480d9efcb1	95434668-ce79-4841-8844-ec778967671e	1	ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale	\N	EACH	1.000	195.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
ae354572-69e6-46cf-b918-cd303669bf7a	95434668-ce79-4841-8844-ec778967671e	2	جهاز فحص الضغط اليدوي Manual Pressure Test Device	\N	EACH	1.000	15.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
948f83f5-555a-41b8-8d1d-0c6767b0e10a	95434668-ce79-4841-8844-ec778967671e	3	جهاز ضغط الرقمي digital sphygmomanometer	\N	EACH	1.000	19.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
bbf60be4-e28c-4eab-a629-c972842496f4	95434668-ce79-4841-8844-ec778967671e	4	جهاز قياس مستوى سكر الدم (Blood Glucose Meter)	\N	EACH	2.000	15.000	KOREA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
5e4ca206-3397-4490-83b2-8c20e72bca08	95434668-ce79-4841-8844-ec778967671e	5	جهاز قياس الأكسجين Pulse oximetry	\N	EACH	2.000	15.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
290a4c9a-75ca-46d5-8e9a-ab1a32762160	95434668-ce79-4841-8844-ec778967671e	6	جهاز تبخيرة Medical Nebulizer	\N	EACH	2.000	29.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
8af26aa0-6f42-4d0a-b2f5-232f067776d7	95434668-ce79-4841-8844-ec778967671e	7	نموذج الهيكل العظمي	\N	EACH	1.000	35.000	CHINA	PROMPT	85 cm	2026-08-08 10:17:17.586024+00	16.00	\N
e9333b0f-d9d4-472b-819f-6e0b407b67c2	95434668-ce79-4841-8844-ec778967671e	8	نموذج تشريح ذو أعضاء قابلة للفك والتركيب	\N	EACH	1.000	110.000	INDIA	PROMPT	85 cm	2026-08-08 10:17:17.586024+00	16.00	\N
a9929957-e188-4cba-9f8e-0450954caea6	95434668-ce79-4841-8844-ec778967671e	9	دمية لتطبيق الإسعاف الأولي الرئوي	\N	EACH	1.000	690.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
03c1b80b-3eb1-4653-a554-387faf50832e	95434668-ce79-4841-8844-ec778967671e	10	عربة حمل الأدوات والتجهيزات الطبية Medical trolley	\N	EACH	2.000	90.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
c2b0c26c-aa54-4e65-981d-620ee92a1c50	95434668-ce79-4841-8844-ec778967671e	11	(ميزان حرارة رقمي) Digital Thermometer	\N	EACH	2.000	9.150	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
b68be174-cd18-498d-bc57-07105af08bc1	95434668-ce79-4841-8844-ec778967671e	12	نموذج الفك والأسنان	\N	EACH	2.000	29.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
351365f2-fd3e-484e-816e-03288f503619	95434668-ce79-4841-8844-ec778967671e	13	جهاز قياس قوة التدفق الزفيري	\N	EACH	2.000	9.500	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
1f65fea0-1697-4161-9d57-5d35c90cbfe1	95434668-ce79-4841-8844-ec778967671e	14	صندوق التخلص من الأدوات الحادة Sharps Disposal Container	\N	EACH	1.000	3.250	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
63368a74-cb58-469c-9e1b-49ac52afafab	95434668-ce79-4841-8844-ec778967671e	15	صندوق فرز النفايات الطبية Medical WasteBox	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
6a7d310f-70a4-47a3-9ebe-a191dfb73b58	95434668-ce79-4841-8844-ec778967671e	16	سرير فحص طبي يدوي Manual Medical Examination Bed	\N	EACH	2.000	80.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
52cdc94e-3f2a-47a8-81bc-a6b15be27695	95434668-ce79-4841-8844-ec778967671e	17	شرشف سرير Bed Sheet	\N	EACH	2.000	9.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
33110244-5be4-4d2a-96f6-cfe48930a83c	95434668-ce79-4841-8844-ec778967671e	18	حرام سرير Bed Blanket	\N	EACH	2.000	11.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
a561bfe2-7aa6-4133-9970-f428a7924569	95434668-ce79-4841-8844-ec778967671e	19	مخدة طبية مع غطاء medical pillow with Cover	\N	EACH	2.000	9.250	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
531d3be4-4c6c-4bfa-8582-f4e303b34234	95434668-ce79-4841-8844-ec778967671e	20	ستارة	\N	EACH	2.000	65.000	CHINA	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
f48f0ea1-08a6-4b44-88d1-0e218f5edf31	95434668-ce79-4841-8844-ec778967671e	21	اكسيليفون موسيقي	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
0b56afc6-a47f-46eb-840c-a2bb993d7050	95434668-ce79-4841-8844-ec778967671e	22	آلة المثلث الموسيقي	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
b09b098d-85b7-49fc-a4d4-8a2cfe92edb7	95434668-ce79-4841-8844-ec778967671e	23	طبلة	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
6a6ad624-3ddd-4aa8-b2f5-30673a5b9306	95434668-ce79-4841-8844-ec778967671e	24	دف	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-08 10:17:17.586024+00	16.00	\N
15c79984-b7aa-4521-ba15-6160f0e729c9	f61ede0a-f287-4823-9f93-08362eae21f2	0	Latex Gloves 5.3gm white HAYAT brand		pk/100	2000.000	2.390	THAILAND	PROMPT		2026-08-08 14:24:55.14815+00	16.00	\N
d0995be5-7b02-4b5c-a0ab-f21028478e0f	c54c7220-b131-41cb-a654-d9fca2056792	0	كرسي اسنان  Ziann Jumbo 		EACH	1.000	5000.000	CHINA	PROMPT		2026-08-08 11:46:25.655426+00	16.00	\N
2c52a0d5-d7ea-4a29-87e1-b8ed4f87b20c	1032638a-9a54-49ef-bf84-0adb4862a10d	0	كرسي اسنان Ziann Cart		EACH	1.000	5875.000	CHINA	PROMPT		2026-08-08 11:47:14.613201+00	16.00	\N
ccab60e5-a083-4efd-a2b7-37b58f26f958	25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	0	كرسي اسنان Ziann Chair  		EACH	1.000	5250.000	CHINA	PROMPT		2026-08-08 11:48:09.325601+00	16.00	\N
3f3fb748-3556-4edb-9363-422e66804c17	75bb058a-1ceb-4c1e-b843-c5006a930fd6	0	مجهر بيولوجي عينية واربع شيئيات مع حقيبة وكامل ملحقاته		جهاز	1.000	110.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
ec071c68-0d4a-4f20-a1ad-ef9e11ae391c	75bb058a-1ceb-4c1e-b843-c5006a930fd6	1	عدسات محدبة ومقعرة 		EACH	6.000	1.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
1100acf8-358a-407d-ad94-01b7a140e346	75bb058a-1ceb-4c1e-b843-c5006a930fd6	2	مرايا محدبة ومقعرة ومستوية 		EACH	6.000	1.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
32ac6f1f-4b7f-49e7-ac96-d183b57991c9	75bb058a-1ceb-4c1e-b843-c5006a930fd6	3	حامل عدسات 		EACH	3.000	1.250	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
edb673d5-ad38-479f-aee6-b8205b0fb8c8	75bb058a-1ceb-4c1e-b843-c5006a930fd6	4	ضوء ليزر		EACH	1.000	5.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
cda3db6a-cd53-4eee-acf4-7cf146377a54	75bb058a-1ceb-4c1e-b843-c5006a930fd6	5	جهاز الناقوس والجرس كامل 		EACH	1.000	38.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
8d50629f-c2be-40b5-a56c-ab8fd24286a9	75bb058a-1ceb-4c1e-b843-c5006a930fd6	6	بطاريات متنوعة 		مجموعة 	1.000	8.000	CHINA	PROMPT		2026-08-08 14:26:21.940263+00	16.00	\N
f2445830-a75f-4d05-9f68-6b8189ecd8a3	5a276011-0db0-40c1-ad6d-4f9971aea927	10	سلايدات زجاجية 		باكيت	1.000	1.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
09699ac4-024b-434d-b5f0-2535bde4b8f2	5a276011-0db0-40c1-ad6d-4f9971aea927	11	عنصر النحاس		50غم	1.000	5.000	CHINA	PROMPT		2026-08-09 08:32:54.969166+00	16.00	\N
0f9aedbd-386c-461f-8b88-c560b0ed761b	89b49bc4-0135-43a2-a74b-3861ed5d8430	67	Disposable Syringes 20ML	\N	EACH	100.000	0.220	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
71e4041a-50c8-432a-beed-a8da950731e4	89b49bc4-0135-43a2-a74b-3861ed5d8430	68	اكياس نفايات اصفر طبي تشريحية طبية	\N	EACH	20.000	1.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
d3ec2e8c-d58e-4d9e-a56a-a7f4b8aa68be	89b49bc4-0135-43a2-a74b-3861ed5d8430	69	اكياس نفايات اسود طبية غير خطرة	\N	EACH	50.000	1.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
49d4280b-c736-427e-b962-e26256ccdb26	89b49bc4-0135-43a2-a74b-3861ed5d8430	70	اكياس نفايات ازرق نفايات سامة	\N	EACH	8.000	1.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
ef327294-8c2b-4761-994d-1d8876f9ad7b	89b49bc4-0135-43a2-a74b-3861ed5d8430	71	اكياس نفايات احمر شديد عدوى	\N	EACH	8.000	1.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
64db0719-737e-4344-a886-4b1350196bfc	89b49bc4-0135-43a2-a74b-3861ed5d8430	72	اكياس نفايات البني كيماوية	\N	EACH	8.000	1.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
1434cb8e-c5e9-4780-ab02-5b8f7ba451fb	89b49bc4-0135-43a2-a74b-3861ed5d8430	73	BLOOD CULTURE BOTTLE	\N	EACH	8.000	3.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
ba084ddd-3b20-4737-a228-e2f6b9cf649d	89b49bc4-0135-43a2-a74b-3861ed5d8430	74	TEGADERM	\N	EACH	50.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
73dc8718-11a5-4a7d-a557-5406edd99b2b	89b49bc4-0135-43a2-a74b-3861ed5d8430	75	COLOSTOMY BAG & BASE	\N	EACH	10.000	6.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
03767c3e-d68e-48ee-acbb-133fb51c715e	89b49bc4-0135-43a2-a74b-3861ed5d8430	76	ILEOSTOMY BAG& BASE	\N	EACH	10.000	6.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
52d97a27-a466-4c01-8a3f-1743c8c31c66	89b49bc4-0135-43a2-a74b-3861ed5d8430	77	ANIOS	\N	EACH	10.000	3.150	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
ff690295-db7e-44d7-bf83-9e5e2a7b6a32	89b49bc4-0135-43a2-a74b-3861ed5d8430	78	CUTASEPT	\N	EACH	3.000	6.150	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7b130c5b-2b62-4d5e-8af9-275e5e98d395	89b49bc4-0135-43a2-a74b-3861ed5d8430	79	CHEST TEUB	\N	EACH	2.000	3.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
bd73be33-2f44-44fb-9ed8-7322f329a1a3	89b49bc4-0135-43a2-a74b-3861ed5d8430	80	CHEST BOTTEL	\N	EACH	2.000	6.650	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
b2c531ab-e845-4b26-bc0c-bbe91fa8c7a7	89b49bc4-0135-43a2-a74b-3861ed5d8430	81	CYCTO CATH	\N	EACH	2.000	9.150	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
273e2ccf-90a4-42fa-b6b5-58beea2a63f3	89b49bc4-0135-43a2-a74b-3861ed5d8430	82	STICH	\N	EACH	1.000	85.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
dc1db36c-1d79-47ca-b5bc-cfd71a854180	89b49bc4-0135-43a2-a74b-3861ed5d8430	83	NYLON 0.0	\N	PK/12	1.000	10.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7744f969-981a-4cf4-a8cd-c4852ac8ed97	89b49bc4-0135-43a2-a74b-3861ed5d8430	84	SILK 0.0	\N	PK/12	1.000	10.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
c8d2b448-a538-41ee-9e86-3030cd0545c4	89b49bc4-0135-43a2-a74b-3861ed5d8430	85	VICRYL 0.0	\N	PK/12	1.000	14.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
a46e8d93-286b-449a-883d-12eba9342e03	89b49bc4-0135-43a2-a74b-3861ed5d8430	86	SUCTION CONECTION TEUBE	\N	EACH	2.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
bd19ba3b-ea36-4435-9eea-7380893619f1	89b49bc4-0135-43a2-a74b-3861ed5d8430	87	SUCTION TEUBE size 16 - 8	\N	EACH	8.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
bab0f206-dffd-44ec-95db-15c472fb3f4e	89b49bc4-0135-43a2-a74b-3861ed5d8430	88	AIRWAY YELLOW	\N	EACH	3.000	3.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
9a1511bb-c0f2-4c0e-8b6c-9b1ebe3c2cb6	89b49bc4-0135-43a2-a74b-3861ed5d8430	89	AIRWAY RED	\N	EACH	3.000	3.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
00e0f694-1347-4074-bfcc-3535d848c3c5	89b49bc4-0135-43a2-a74b-3861ed5d8430	90	AIRWAY .WHITE	\N	EACH	2.000	3.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
2222ef96-58cd-430c-ab4b-5b29e104c73a	89b49bc4-0135-43a2-a74b-3861ed5d8430	91	BUTTER FLY	\N	EACH	25.000	1.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
0e290360-dec3-491e-9136-120f8de52399	89b49bc4-0135-43a2-a74b-3861ed5d8430	92	VETURE MASK ADULT	\N	EACH	2.000	3.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
d8f1048c-9d64-49a2-85dc-13cd22ed44ae	89b49bc4-0135-43a2-a74b-3861ed5d8430	93	VETURE MASK PEDIATRIC	\N	EACH	2.000	3.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
c88a95fe-78c0-4352-a8ed-5bc47de8122e	89b49bc4-0135-43a2-a74b-3861ed5d8430	94	NASAL CANULA  ADULT	\N	EACH	2.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
1ac02731-8008-447e-83ed-67de02a8a80b	89b49bc4-0135-43a2-a74b-3861ed5d8430	95	NASAL CANULA  PEDIATRIC	\N	EACH	2.000	2.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
58dc4f48-8a09-41a8-a592-932c14cb55fd	89b49bc4-0135-43a2-a74b-3861ed5d8430	96	NON-REBREATHING MASK  ADULT	\N	EACH	2.000	6.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
21a5bac5-2a46-413e-9bdd-be953de17cbb	89b49bc4-0135-43a2-a74b-3861ed5d8430	97	NON-REBREATHING MASK  PEDIATRIC	\N	EACH	2.000	6.250	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
2f005105-762f-4695-b6a1-9fc57a182b19	89b49bc4-0135-43a2-a74b-3861ed5d8430	98	REBREATHING MASK  ADULT	\N	EACH	2.000	6.300	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
acb27e06-184c-4e0b-97d7-745c03cffeee	89b49bc4-0135-43a2-a74b-3861ed5d8430	99	REBREATHING MASK  PEDIATRIC	\N	EACH	2.000	6.300	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
91921f1c-e93e-4193-b9d9-afb2e7b8207f	89b49bc4-0135-43a2-a74b-3861ed5d8430	100	ورق تغليف للتعقيم  REEL 30	\N	EACH	1.000	11.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
8715821e-3486-41ed-885f-0887e0671cac	89b49bc4-0135-43a2-a74b-3861ed5d8430	101	ورق تغليف للتعقيم  15	\N	EACH	1.000	11.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
2390deef-ea7f-438b-8c15-47d807778b17	89b49bc4-0135-43a2-a74b-3861ed5d8430	102	ورق تغليف للتعقيم  SHEET	\N	EACH	1.000	11.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
ec83eaea-cf0f-448d-9ff3-f4fc56a54560	89b49bc4-0135-43a2-a74b-3861ed5d8430	103	PLATER AUTOCLAVE	\N	EACH	1.000	65.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7e9ecb0e-5c49-4129-b55b-da311adc9ff2	89b49bc4-0135-43a2-a74b-3861ed5d8430	104	مقص جراحي	\N	EACH	1.000	2.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
1558fa21-e72c-4f43-8c9a-cbf1d6b3be93	89b49bc4-0135-43a2-a74b-3861ed5d8430	105	Artery Forceps	\N	EACH	1.000	2.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
dfe61a98-c3e5-4a11-8d9c-85a168127402	89b49bc4-0135-43a2-a74b-3861ed5d8430	106	Dressing forceps	\N	EACH	2.000	3.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
3c7cc12d-f1dd-4f00-9c21-4ff698def48e	89b49bc4-0135-43a2-a74b-3861ed5d8430	107	Allis forceps	\N	EACH	1.000	3.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
4889cc3b-b170-44a7-82d2-5339503ff5b7	89b49bc4-0135-43a2-a74b-3861ed5d8430	108	Kidney dish	\N	EACH	2.000	6.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
2f7dfc90-8c0e-4c9d-9ae0-967fe55e7914	89b49bc4-0135-43a2-a74b-3861ed5d8430	109	Needell holder	\N	EACH	4.000	5.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
46e86907-2544-40d2-abd1-619e10e33632	89b49bc4-0135-43a2-a74b-3861ed5d8430	110	Thoth forceps	\N	EACH	4.000	2.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
5dfc0e9a-e068-4a9b-8ccb-55b7509790e6	89b49bc4-0135-43a2-a74b-3861ed5d8430	111	Surgical bladesشفرات جراحية  10	\N	PK/100	1.000	6.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
1cd42c6a-5b5f-4b46-ba5f-e5e4fb111a90	89b49bc4-0135-43a2-a74b-3861ed5d8430	112	Surgical bladesشفرات جراحية 20	\N	PK/100	1.000	6.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
7dc0a3a9-6d3b-479b-b58e-a974d23d6083	89b49bc4-0135-43a2-a74b-3861ed5d8430	113	Surgical bladesشفرات جراحية 11	\N	PK/100	1.000	6.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
006f8f81-f86e-4c97-9455-80f482042a99	89b49bc4-0135-43a2-a74b-3861ed5d8430	114	Skin traction set	\N	EACH	2.000	11.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
0d51a947-6357-4716-8ade-ac8cb05952de	89b49bc4-0135-43a2-a74b-3861ed5d8430	115	ECG electrode	\N	EACH	100.000	1.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
8124e41d-9eb2-4ecd-9de5-0feaea4ebcf7	89b49bc4-0135-43a2-a74b-3861ed5d8430	116	Tracheostomy set	\N	EACH	2.000	65.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
d9e19dac-792e-4eb1-9259-2b5179898a34	89b49bc4-0135-43a2-a74b-3861ed5d8430	117	Adult Ambu bag	\N	EACH	2.000	85.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
f3d5b26d-80a2-4a1b-a063-89faf8698be7	89b49bc4-0135-43a2-a74b-3861ed5d8430	118	Pediatric Ambu bag	\N	EACH	2.000	85.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
fdd299bd-c938-4d81-be50-39a3239c5b2c	89b49bc4-0135-43a2-a74b-3861ed5d8430	119	Rubber Tourniquet	\N	EACH	16.000	2.500	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
66f10bea-262d-4450-88d8-355ebb27be24	89b49bc4-0135-43a2-a74b-3861ed5d8430	120	نموذج حاضنة خداج	\N	EACH	1.000	950.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
dea1c2ac-8997-42dc-a771-935897c46682	89b49bc4-0135-43a2-a74b-3861ed5d8430	121	عربة علاجاات	\N	EACH	4.000	100.000	CHINA	PROMPT		2026-08-09 11:58:22.072678+00	16.00	\N
fa52ef40-2ae7-4e05-a1ab-6c5af23d29a5	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	20	ابر خياطة		EACH	5.000	0.500	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
7fd6cc8e-7718-4bbd-92d4-500ac8642bc4	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	21	ماسورة خياطة مختلفة الألوان		EACH	5.000	2.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
2a4761b1-07c6-45fb-89e6-e8026993675f	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	22	فاين للغرف والحمامات والمطبخ - وفاين مبلل		EACH	1.000	7.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
031cc9f9-4cd1-496d-903a-e392aa32e22c	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	23	معقم هايجين		EACH	5.000	3.500	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
83903ffe-9f74-4777-b33d-c97ee974462b	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	24	كمامات		EACH	1.000	1.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
7ff016b3-8b47-42b1-aefb-7494d8597385	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	25	قفازات		EACH	1.000	3.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
26faddf6-a32f-4e58-9e49-e4954b125a39	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	26	سحابات مختلفة القياسات		EACH	1.000	3.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
c17fd2e7-ca25-4a18-b0ec-9838b1aba738	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	27	ازرار مختلفة الأحجام		EACH	1.000	4.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
d37f7dd5-5a28-444f-9521-d3867f94f800	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	28	مماسح وفوط		EACH	1.000	5.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
a0310643-5f48-435b-85fc-ac09b3fdf10d	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	29	ادوات تنظيف وتعقيم (شامبو -كريم - زيت اطفال - فاين مبلل )		EACH	1.000	8.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
2065bf5f-58d4-4fe5-a2d5-771815b983dc	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	30	حذاء + رباط احذية 		EACH	5.000	3.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
8b6a0f69-dd9e-410f-add8-d1197ac1b53f	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	31	ادوات مطبخ (تبرويرات - صحون اطفال- ملاعق اطفال )		EACH	1.000	5.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
54d74d37-53fc-4471-9f24-9df3cdd873c6	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	32	محضرة طعام 		EACH	1.000	25.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
d085c43e-2583-4698-820b-93939fe18c8f	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	33	سخان لغلي الماء 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
c3e1735e-53df-4322-8598-0bdc81439599	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	34	غطاء سرير اطفال		EACH	1.000	8.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
a18d975d-3ce2-4819-8494-b00049e37756	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	35	مخدة اطفال		EACH	1.000	7.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
1f6025d3-ec96-42e6-8188-83499452cf5b	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	36	رشق سريراطفال		EACH	1.000	10.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
9930a4ba-4f3a-40d7-aa22-88a8a7d72fa0	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	37	افرهول من (0 -3 )اشهر		EACH	1.000	3.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
c6630593-eb58-48a9-9d46-b6aa76617b36	d9cf0468-761e-426f-bd09-2d4d10c36f8a	1	ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale		EACH	1.000	195.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
78632f9b-9048-45af-969a-99f968bd60c7	d9cf0468-761e-426f-bd09-2d4d10c36f8a	2	صندوق اسعافات اولية 		EACH	1.000	25.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
7e7e21d6-843d-472f-b389-f7d776df41d4	d9cf0468-761e-426f-bd09-2d4d10c36f8a	3	دمية بحجم طفل رضيع 		EACH	1.000	59.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
49c96511-6073-4f6b-becf-194440016720	d9cf0468-761e-426f-bd09-2d4d10c36f8a	4	خزانة تخزين خشبية 		EACH	1.000	260.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
54971136-f9a4-41a7-b3ec-6e9f0ae679aa	d9cf0468-761e-426f-bd09-2d4d10c36f8a	5	خزانة لحفظ الالعاب رفوف مفتوحة 		EACH	1.000	110.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
719c0cd5-47b6-4bbf-91d6-26f78b8db5e7	d9cf0468-761e-426f-bd09-2d4d10c36f8a	6	سرير وفرشة بيبي 0-3 سنوات 		EACH	1.000	90.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
9229790e-8aac-4cf6-bfa6-5581c14a97ea	d9cf0468-761e-426f-bd09-2d4d10c36f8a	7	اكسيليفون موسيقى		EACH	1.000	30.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
cd60e116-9bc6-492f-a2da-44511017b443	d9cf0468-761e-426f-bd09-2d4d10c36f8a	8	الة مثلث موسيقي		EACH	1.000	22.100	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
98d15acb-c999-43e7-8f76-9af97d04547d	d9cf0468-761e-426f-bd09-2d4d10c36f8a	9	دف		EACH	1.000	25.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
0141109f-452d-4861-803f-9b46f98470fa	94435f61-38f3-40e5-88a2-be37057a238b	0	1\tHeating Incubator Digital Control 20liter		EACH	1.000	240.000	CHINA	PROMPT		2026-08-11 14:49:51.776739+00	16.00	\N
ef63fcd5-ea31-4ee5-9e5f-0206d8d275bd	a5a1c783-79f6-41b7-9eed-498bfb502031	8	فوط قماشية للطعام 		EACH	1.000	2.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
4e09bbf3-5bcb-4243-941e-f1a400e84547	a5a1c783-79f6-41b7-9eed-498bfb502031	9	فرشاة اسنان خاصة بالطفل		EACH	5.000	1.250	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
d3c69b46-274e-4744-8543-e3cb40326054	a5a1c783-79f6-41b7-9eed-498bfb502031	10	معجون اسنان خاص بالطفل		EACH	5.000	1.500	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
fe71d6f4-e201-4fb8-9242-7660b4e7f4ff	a5a1c783-79f6-41b7-9eed-498bfb502031	11	صافرة		EACH	5.000	1.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
264cea54-bf86-474a-941f-3d1d370a86a9	a5a1c783-79f6-41b7-9eed-498bfb502031	12	فرشاة خاصة لتنظيف زجاجات الرضاعة		EACH	5.000	1.250	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
bf6c1612-f3f7-4072-a4a3-6d8874f47055	a5a1c783-79f6-41b7-9eed-498bfb502031	13	فرشاة خاصة لتنظيف حلمة الإرضاع		EACH	5.000	1.250	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
3b8a537c-2e77-4dcc-b567-df07eade3c40	a5a1c783-79f6-41b7-9eed-498bfb502031	14	دبابيس امان		EACH	5.000	0.250	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
4605e591-e2ff-4992-a5ce-8577ebe7b1c8	a5a1c783-79f6-41b7-9eed-498bfb502031	15	مريول بلاستيكي		EACH	10.000	0.500	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
98e66a15-4003-477e-be91-414fbf6b2626	a5a1c783-79f6-41b7-9eed-498bfb502031	16	فرشاة تنظيف الخضار		EACH	5.000	2.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
0dde86e6-3e49-4319-ae08-48a8edefa2a1	a5a1c783-79f6-41b7-9eed-498bfb502031	17	غطاء طاولة بلاستيكي		EACH	1.000	1.500	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
c154eb9d-1c49-4906-8f59-37aeb522b1c7	a5a1c783-79f6-41b7-9eed-498bfb502031	18	بشكير او منشفة		EACH	51.000	2.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
ddd56fc4-89ff-44a5-8197-1f64f9ad0bd2	a5a1c783-79f6-41b7-9eed-498bfb502031	19	قرطاسية (اوراق - كراتين - اقلام - لاسق - غراء - صمغ )		EACH	1.000	10.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
dcb2b571-5a08-47f3-9d13-6f5a5f46e3a4	a5a1c783-79f6-41b7-9eed-498bfb502031	20	ابر خياطة		EACH	5.000	0.500	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
ede8362b-a1f4-4de3-bd88-7290e4b1ed11	a5a1c783-79f6-41b7-9eed-498bfb502031	21	ماسورة خياطة مختلفة الألوان		EACH	5.000	2.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
f259ef08-d668-4bbd-837d-52ae131a95e4	6cbd075c-65c8-4703-9c35-9b28f5017259	0	ادوات النظافة الشخصية  معقمات ومعطرات 		مجموعة 	1.000	15.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
86d9432b-f3c9-4511-9699-0c4f9a46b781	6cbd075c-65c8-4703-9c35-9b28f5017259	1	لوحة توضح مفهوم المخاطر 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
cfe9f1cb-05ae-44ac-b259-35932a02ab78	6cbd075c-65c8-4703-9c35-9b28f5017259	2	منشورات عن الادوية والمواد الكيميائية 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
16ef908f-9234-4490-b84e-663dbf92e56a	6cbd075c-65c8-4703-9c35-9b28f5017259	3	نموذج علامات تحذيرية 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
d89f5596-8b64-4931-9a34-0f794dd4027b	6cbd075c-65c8-4703-9c35-9b28f5017259	4	تقرير الحوادث والاصابات 		EACH	1.000	5.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
3426ff7d-46b3-4b1f-80bf-7f2610c8149a	6cbd075c-65c8-4703-9c35-9b28f5017259	5	ادوات تعقيم الادوات الطبية 		EACH	1.000	10.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
9d321f4a-9cae-409a-af5b-e4bd03a69935	6cbd075c-65c8-4703-9c35-9b28f5017259	6	قفازات طبية 		EACH	1.000	3.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
b3c852f8-6de7-4a30-a1da-1a2ced23c135	6cbd075c-65c8-4703-9c35-9b28f5017259	7	سي دي تعليمي		EACH	1.000	5.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
d782ecd5-294b-4c5a-8248-5e03561035c6	6cbd075c-65c8-4703-9c35-9b28f5017259	8	كتب عن الثقافة 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
acb33118-ff9a-4ee0-a238-7c56d7fab7d3	6cbd075c-65c8-4703-9c35-9b28f5017259	9	ادوات رسم 		EACH	1.000	20.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
9dcc8599-3023-4466-ac17-aaa27f284c4f	6cbd075c-65c8-4703-9c35-9b28f5017259	10	ادوات حرف يدوية 		EACH	1.000	20.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
3ace2e92-6cc4-493c-8282-78974003770f	6cbd075c-65c8-4703-9c35-9b28f5017259	11	ادوات بستنة 		EACH	1.000	35.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
bc5b452d-f73c-4707-a81e-edc1aa0ed328	6cbd075c-65c8-4703-9c35-9b28f5017259	12	العاب التفكير مثل الشطرنج 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
e1fcea59-3ba2-4b90-8a23-e627f1d67e64	6cbd075c-65c8-4703-9c35-9b28f5017259	13	لوحة توضح انواع المواد الغذائية 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
c1a33d49-9f7b-487c-a0da-cb2f37b29c0d	6cbd075c-65c8-4703-9c35-9b28f5017259	14	علب حليب اطفال 		EACH	1.000	10.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
f1671815-0d54-47a8-a642-81f5b44dda37	6cbd075c-65c8-4703-9c35-9b28f5017259	15	زجاجات رضاعة 		EACH	1.000	10.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
95fe91bc-07a1-4952-96bd-2848b87609cf	6cbd075c-65c8-4703-9c35-9b28f5017259	16	لوحات ارشادية 		EACH	1.000	13.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
1b30e09f-01ee-4f95-b3dd-8a67ceae26a9	6cbd075c-65c8-4703-9c35-9b28f5017259	17	تطبيقات حاسوبية 		EACH	1.000	0.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
3770f33b-3e05-4152-b5c8-bb55288cc7be	6cbd075c-65c8-4703-9c35-9b28f5017259	18	ادوات مطبخ 		EACH	1.000	35.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
771e1015-6ffe-4954-adca-3cc28558160b	6cbd075c-65c8-4703-9c35-9b28f5017259	19	كمامات 		EACH	1.000	3.000	CHINA	PROMPT		2026-08-11 11:43:30.943276+00	16.00	\N
97c20eb3-4294-4ae0-966f-75ae61d13422	da22b830-27c5-425d-bbc9-17f0ab63a83c	0	1\tHeating Incubator Digital Control 20liter		EACH	1.000	240.000	CHINA	PROMPT		2026-08-11 12:07:40.217216+00	16.00	\N
37dd7a08-37c9-4a80-8f8d-6145ce2950db	a5a1c783-79f6-41b7-9eed-498bfb502031	0	أقلام بورد ومساحة 		طقم	5.000	1.500	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
6b984f8e-5ac0-4300-aa8f-6b813688d71e	a5a1c783-79f6-41b7-9eed-498bfb502031	1	الوان خشبية وزيتية ومائية 		علبة 	5.000	4.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
614b8c14-5aac-4da3-9007-5272a3222d0e	a5a1c783-79f6-41b7-9eed-498bfb502031	2	فراشي الوان متنوعة القياس		EACH	5.000	2.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
21ec5dac-e220-48d3-9fca-ea772e21c606	a5a1c783-79f6-41b7-9eed-498bfb502031	3	الوان امنة للرسم على الوجوه		EACH	5.000	3.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
e34238e3-8577-4fcd-8b55-8b06cd4b36ee	a5a1c783-79f6-41b7-9eed-498bfb502031	4	صوف		EACH	5.000	1.500	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
8b20a455-f5c1-451e-be09-12b84769a045	a5a1c783-79f6-41b7-9eed-498bfb502031	5	طعام اطفال 0-1.1-2.2-6		EACH	1.000	0.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
9451c3c9-e5b9-4fa5-a15e-444b2379e55a	a5a1c783-79f6-41b7-9eed-498bfb502031	6	ادوات النظافة الشخصية شامبو ليفة  نكاشات اذن كريم 		مجموعة 	1.000	5.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
51dd2da4-483b-4280-9c17-39145bbfcf23	a5a1c783-79f6-41b7-9eed-498bfb502031	7	حفاضات مختلفة القياس 0-2 سنة 		EACH	1.000	5.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
4210d680-0f08-4dbd-9189-2209c16fb0f3	d9cf0468-761e-426f-bd09-2d4d10c36f8a	0	دمية بحجم طفل سنتين 		EACH	1.000	95.000	CHINA	PROMPT		2026-08-11 11:50:45.420864+00	16.00	\N
e78b079f-5661-42fa-9cf5-da736555e4f6	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	0	ميزان حرارة رقمي طبي Digital Medical Thermometer	\N	EACH	2.000	9.150	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
cb09e3c6-f132-4cfb-90b4-fcc5ece1e685	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	1	ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale	\N	EACH	1.000	195.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
daee2a18-22a7-45c0-97a2-8cc97eeaf8e3	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	2	جهاز فحص الضغط اليدوي Manual Pressure Test Device	\N	EACH	1.000	15.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
fc66460b-9db6-418c-b19d-f9f18afb32f6	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	3	جهاز ضغط الرقمي digital sphygmomanometer	\N	EACH	1.000	19.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
7322cf05-53d8-4a38-8fc7-f03a6ce39070	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	4	جهاز قياس مستوى سكر الدم (Blood Glucose Meter)	\N	EACH	2.000	15.000	KOREA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
b470a8a1-da1d-4c06-9af5-8af5b3bf9486	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	5	جهاز قياس الأكسجين Pulse oximetry	\N	EACH	2.000	15.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
fd186723-93a9-4efc-8a72-5a282c95fed0	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	6	جهاز تبخيرة Medical Nebulizer	\N	EACH	2.000	29.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
81e08e4a-9d85-4e9e-a772-bca52f741e95	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	7	نموذج الهيكل العظمي	\N	EACH	1.000	35.000	CHINA	PROMPT	85 cm	2026-08-09 17:57:37.985619+00	16.00	\N
9c667b9d-afb1-4a0d-aeb0-22ccbc29aecd	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	8	نموذج تشريح ذو أعضاء قابلة للفك والتركيب	\N	EACH	1.000	110.000	INDIA	PROMPT	85 cm	2026-08-09 17:57:37.985619+00	16.00	\N
9dfeefa8-bcb0-46c9-a4cd-26a63cc5802b	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	9	دمية لتطبيق الإسعاف الأولي الرئوي	\N	EACH	1.000	690.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
574ad6e8-9fce-45f0-85cd-3ce769e6241f	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	10	عربة حمل الأدوات والتجهيزات الطبية Medical trolley	\N	EACH	2.000	90.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
64cf978e-27ae-43ab-abae-aece97e94b87	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	11	(ميزان حرارة رقمي) Digital Thermometer	\N	EACH	2.000	9.150	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
28f5e5a1-c301-4acc-9226-c4be5750fb6e	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	12	نموذج الفك والأسنان	\N	EACH	2.000	29.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
3c13ceed-8e38-4911-9c60-90c120643a23	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	13	جهاز قياس قوة التدفق الزفيري	\N	EACH	2.000	9.500	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
ff57a123-753d-4fd4-97ab-f5f469038cf9	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	14	صندوق التخلص من الأدوات الحادة Sharps Disposal Container	\N	EACH	1.000	3.250	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
542d1b58-169f-4305-8605-3e325a66e348	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	15	صندوق فرز النفايات الطبية Medical WasteBox	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
271b1f06-a861-4638-89e3-2c278688dd04	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	16	سرير فحص طبي يدوي Manual Medical Examination Bed	\N	EACH	2.000	80.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
d3403c5d-aa1a-4866-9c32-a66690d7738b	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	17	شرشف سرير Bed Sheet	\N	EACH	2.000	9.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
257c9896-1f09-4630-9216-280bac72ad3e	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	18	حرام سرير Bed Blanket	\N	EACH	2.000	11.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
1a4a335f-16c4-4f1c-b223-0d7caa4448c4	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	19	مخدة طبية مع غطاء medical pillow with Cover	\N	EACH	2.000	9.250	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
25f1607d-7923-42da-b68c-30537ab84ea4	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	20	ستارة	\N	EACH	2.000	65.000	CHINA	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
1d1a6a25-0116-46e1-bd46-6f9e36115bd5	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	21	اكسيليفون موسيقي	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
d5755d27-28e6-4a9b-be17-769bf359af27	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	22	آلة المثلث الموسيقي	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
14cd3e1e-74c9-4f23-a5ab-ddc377c5f6ed	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	23	طبلة	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
c9201879-7617-413e-acd1-981f59cb98f3	1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	24	دف	\N	EACH	1.000	0.000	XX	PROMPT		2026-08-09 17:57:37.985619+00	16.00	\N
69e65943-f0ab-4951-9ccb-7e1700593359	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	0	أقلام بورد ومساحة 		طقم	5.000	1.500	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
8bad638e-83ea-4aea-b361-aa7d1a640f1a	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	1	الوان خشبية وزيتية ومائية 		علبة 	5.000	4.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
b2372107-428c-47e3-8f2d-e5bc0b3b2db9	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	2	فراشي الوان متنوعة القياس		EACH	5.000	2.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
52e7d6e9-2182-4692-b463-ab2f2139ca52	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	3	الوان امنة للرسم على الوجوه		EACH	5.000	3.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
978632b2-d884-446a-93e3-94b177baf6f3	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	4	صوف		EACH	5.000	1.500	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
ed13c691-28fa-41dc-8a6a-3575d913d053	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	5	طعام اطفال 0-1.1-2.2-6		EACH	1.000	0.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
59d30568-4503-481e-8ab3-c041db0d6d70	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	6	ادوات النظافة الشخصية شامبو ليفة  نكاشات اذن كريم 		مجموعة 	1.000	5.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
54924ea8-da75-4c9f-a9b0-62d7343ec103	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	7	حفاضات مختلفة القياس 0-2 سنة 		EACH	1.000	5.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
ae888180-d6b8-416b-82f7-cb82496f2ef5	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	8	فوط قماشية للطعام 		EACH	1.000	2.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
675dc9ce-dfce-48ee-9e51-622a53bae743	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	9	فرشاة اسنان خاصة بالطفل		EACH	5.000	1.250	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
bdda3021-6382-4792-939e-400e8c2f2123	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	10	معجون اسنان خاص بالطفل		EACH	5.000	1.500	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
556867d2-bf3d-4fe1-9827-01bb9c732b2f	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	11	صافرة		EACH	5.000	1.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
5242c130-e0c8-42e5-970f-15339a2bf08b	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	12	فرشاة خاصة لتنظيف زجاجات الرضاعة		EACH	5.000	1.250	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
2e3dfc24-0414-49d1-a259-97502cb65692	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	13	فرشاة خاصة لتنظيف حلمة الإرضاع		EACH	5.000	1.250	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
568e47c1-4afa-45d9-ae20-872db0ed8535	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	14	دبابيس امان		EACH	5.000	0.250	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
7b5b9444-d379-473b-9188-b74dad4b8925	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	15	مريول بلاستيكي		EACH	10.000	0.500	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
e35f9e01-c94c-45b3-850c-ed646485c83d	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	16	فرشاة تنظيف الخضار		EACH	5.000	2.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
0c6273bd-7161-4512-b964-6f9452a12f2a	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	17	غطاء طاولة بلاستيكي		EACH	1.000	1.500	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
3cede99d-f697-4adc-8432-652d4bf00e18	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	18	بشكير او منشفة		EACH	51.000	2.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
5d79ec23-7597-4c90-a754-c22673e11f30	26b0da4a-95b8-4436-bfee-cd8acaaa6e62	19	قرطاسية (اوراق - كراتين - اقلام - لاسق - غراء - صمغ )		EACH	1.000	10.000	CHINA	PROMPT		2026-08-10 22:52:31.177081+00	16.00	\N
ec79bb32-1e8e-4901-baf1-798fd0c01def	a5a1c783-79f6-41b7-9eed-498bfb502031	22	فاين للغرف والحمامات والمطبخ - وفاين مبلل		EACH	1.000	7.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
ff76960d-d6fa-4f56-b367-3587ca85f270	a5a1c783-79f6-41b7-9eed-498bfb502031	23	معقم هايجين		EACH	5.000	3.500	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
a60b2a9b-29e2-4ffe-b765-b9b0100b4298	a5a1c783-79f6-41b7-9eed-498bfb502031	24	كمامات		EACH	1.000	1.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
f3957163-f88c-40c6-b164-967329142303	a5a1c783-79f6-41b7-9eed-498bfb502031	25	قفازات		EACH	1.000	3.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
6ef5ca3b-40e9-4d78-aadc-dba729a1bf3c	a5a1c783-79f6-41b7-9eed-498bfb502031	26	سحابات مختلفة القياسات		EACH	1.000	3.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
59ecb82e-bddc-44a8-9cf3-44d1915649c8	a5a1c783-79f6-41b7-9eed-498bfb502031	27	ازرار مختلفة الأحجام		EACH	1.000	4.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
3fcc4797-e53c-44f5-b3fb-92bc890cbcff	a5a1c783-79f6-41b7-9eed-498bfb502031	28	مماسح وفوط		EACH	1.000	5.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
41e60500-d6f9-4f55-98ad-30538f7a7134	a5a1c783-79f6-41b7-9eed-498bfb502031	29	ادوات تنظيف وتعقيم (شامبو -كريم - زيت اطفال - فاين مبلل )		EACH	1.000	8.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
f43cc5d0-eb10-49e2-b47b-5a8f748ff9aa	a5a1c783-79f6-41b7-9eed-498bfb502031	30	حذاء + رباط احذية 		EACH	5.000	3.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
f3161cd0-c066-4bf5-8125-771651497652	a5a1c783-79f6-41b7-9eed-498bfb502031	31	ادوات مطبخ (تبرويرات - صحون اطفال- ملاعق اطفال )		EACH	1.000	5.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
e37d2dfb-d05e-409d-bca2-b29bd4ab4de2	a5a1c783-79f6-41b7-9eed-498bfb502031	32	محضرة طعام 		EACH	1.000	25.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
850e60a4-edef-4581-963d-99ced959c86a	a5a1c783-79f6-41b7-9eed-498bfb502031	33	سخان لغلي الماء 		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
f3476f80-612e-44ee-8531-5eb8127e3438	a5a1c783-79f6-41b7-9eed-498bfb502031	34	غطاء سرير اطفال		EACH	1.000	8.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
9efc279c-0f12-41f8-826d-b17ce89c1e56	a5a1c783-79f6-41b7-9eed-498bfb502031	35	مخدة اطفال		EACH	1.000	7.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
86cfe97d-fae6-4e71-9ae1-25f02fcd92cd	a5a1c783-79f6-41b7-9eed-498bfb502031	36	رشق سريراطفال		EACH	1.000	10.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
e8b87f66-1631-4387-aca9-1f35705a95ed	a5a1c783-79f6-41b7-9eed-498bfb502031	37	افرهول من (0 -3 )اشهر		EACH	1.000	3.000	CHINA	PROMPT		2026-08-11 14:59:34.788473+00	16.00	\N
10a1a53f-63fe-49c2-9263-020526851b84	7b053b6e-5c57-4498-930d-0869cfcab2fa	0	Spare Parts for Rotary Evaporator		EACH	2.000	84.000	CHINA	PROMPT		2026-08-11 15:25:11.277085+00	16.00	\N
815f2a5d-3301-4f43-914c-a1ef208e04d2	3e155eba-5c80-4fef-b02f-97d65d0e3628	0	ميزان حرارة رقمي طبي Medical Digital Thermometer Gun type slim	\N	Each	2.000	9.000	China	PROMPT	high accuracy	2026-08-11 15:59:08.061421+00	16.00	\N
7660b238-1186-474c-8795-b79a5a8b10d9	3e155eba-5c80-4fef-b02f-97d65d0e3628	1	ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale	\N	Each	1.000	195.000	China	PROMPT		2026-08-11 15:59:08.061421+00	16.00	\N
c989466e-8f4e-4979-aa8e-6ae1797fafcb	3e155eba-5c80-4fef-b02f-97d65d0e3628	2	جهاز فحص الضغط اليدوي Manual Pressure Test Device	\N	Each	1.000	15.000	China	PROMPT	aneroid	2026-08-11 15:59:08.061421+00	16.00	\N
02fdacd8-d6f1-442c-8453-0b4691ab9234	3e155eba-5c80-4fef-b02f-97d65d0e3628	3	جهاز ضغط الرقمي Digital sphygmomanometer Wrist type	\N	Each	1.000	19.000	China	PROMPT	wrist system	2026-08-11 15:59:08.061421+00	16.00	\N
e28c00b9-c797-4082-9b90-42e610a5e6a1	3e155eba-5c80-4fef-b02f-97d65d0e3628	4	جهاز قياس مستوى سكر الدم Blood Glucose Meter with 25 test strips	\N	Each	2.000	15.000	Korea	PROMPT	high accuracy	2026-08-11 15:59:08.061421+00	16.00	\N
a1e9668f-31bd-48f0-9a77-e5a311d7b011	3e155eba-5c80-4fef-b02f-97d65d0e3628	5	جهاز قياس الأكسجين Pulse oximetry superior type JIKIZ	\N	Each	2.000	15.000	China	PROMPT		2026-08-11 15:59:08.061421+00	16.00	\N
83812e21-75fd-47d3-926a-83d422059bbe	3e155eba-5c80-4fef-b02f-97d65d0e3628	6	جهاز تبخيرة Medical Nebulizer high effective	\N	Each	2.000	29.000	China	PROMPT	F-PUFF	2026-08-11 15:59:08.061421+00	16.00	\N
419870af-6649-4a64-a514-bb6190b58e53	3e155eba-5c80-4fef-b02f-97d65d0e3628	7	نموذج الهيكل العظمي 85cm on stand	\N	Each	1.000	34.000	China	PROMPT	85 cm	2026-08-11 15:59:08.061421+00	16.00	\N
6895821a-0083-42db-ab71-5e70f6d23969	3e155eba-5c80-4fef-b02f-97d65d0e3628	8	نموذج تشريح ذو أعضاء قابلة للفك والتركيب 85cm anatomical	\N	Each	1.000	115.000	India	PROMPT	85 cm	2026-08-11 15:59:08.061421+00	16.00	\N
da8bf2b0-7b8f-4da3-b9f6-b511229674fe	3e155eba-5c80-4fef-b02f-97d65d0e3628	9	دمية لتطبيق الإسعاف الأولي الرئوي Electronic Half body Tupe	\N	Each	1.000	690.000	China	PROMPT	anatomical	2026-08-11 15:59:08.061421+00	16.00	gmsotyjc0ma3m
fdca8974-f675-4a1d-8cfb-dce1032985c6	3e155eba-5c80-4fef-b02f-97d65d0e3628	10	دمية لتطبيق الإسعاف الأولي الرئوي Basic Type	\N	Each	1.000	490.000	CHINA	PROMPT		2026-08-11 15:59:08.061421+00	16.00	gmsotyjc0ma3m
a014242a-2e00-4b10-ac16-c6a5d5371fdc	3e155eba-5c80-4fef-b02f-97d65d0e3628	11	دمية لتطبيق الإسعاف الأولي الرئوي Regular Type Without Press	\N	Each	1.000	390.000	CHINA	PROMPT		2026-08-11 15:59:08.061421+00	16.00	gmsotyjc0ma3m
48af94c8-89f3-4ae0-a0d5-ba696a5c4459	3e155eba-5c80-4fef-b02f-97d65d0e3628	12	عربة حمل الأدوات والتجهيزات الطبية Medical trolley stainless steel	\N	Each	2.000	90.000	China	PROMPT	SS-415	2026-08-11 15:59:08.061421+00	16.00	\N
5271b617-56f1-4b96-b027-2da49889a40d	3e155eba-5c80-4fef-b02f-97d65d0e3628	13	ميزان حرارة رقمي Digital Thermometer for materials	\N	Each	2.000	9.000	China	PROMPT	SS-318	2026-08-11 15:59:08.061421+00	16.00	\N
40c52244-4f04-44fa-b1bb-7eecaaabd391	3e155eba-5c80-4fef-b02f-97d65d0e3628	14	نموذج الفك والأسنان Movable	\N	Each	2.000	29.000	China	PROMPT	anatomical	2026-08-11 15:59:08.061421+00	16.00	\N
ac79836f-ad7e-4d67-9595-6c23114be43b	3e155eba-5c80-4fef-b02f-97d65d0e3628	15	جهاز قياس قوة التدفق الزفيري	\N	Each	2.000	9.500	China	PROMPT	high accuracy	2026-08-11 15:59:08.061421+00	16.00	\N
4d096a1b-924b-4b05-805e-254d6cd38ae0	3e155eba-5c80-4fef-b02f-97d65d0e3628	16	صندوق التخلص من الأدوات الحادة Sharps Disposal Container	\N	Each	1.000	3.000	China	PROMPT		2026-08-11 15:59:08.061421+00	16.00	\N
50f7856d-d264-4ac1-8c00-2b36032dd5ce	3e155eba-5c80-4fef-b02f-97d65d0e3628	17	صندوق فرز النفايات الطبية Medical WasteBox	\N	Set	1.000	45.000	China	PROMPT	3PCS	2026-08-11 15:59:08.061421+00	16.00	\N
f4d76539-ab68-4584-aaf8-170caef5e8ae	3e155eba-5c80-4fef-b02f-97d65d0e3628	18	سرير فحص طبي يدوي Manual Medical Examination Bed	\N	Each	2.000	80.000	China	PROMPT	Medical	2026-08-11 15:59:08.061421+00	16.00	\N
aae6b2d3-e610-44b3-87af-4188a9da190e	3e155eba-5c80-4fef-b02f-97d65d0e3628	19	شرشف سرير Bed Sheet	\N	Each	2.000	9.000	China	PROMPT	hypoallergic	2026-08-11 15:59:08.061421+00	16.00	\N
79e63654-905b-4ad1-9fe7-a0ad1a01eba4	3e155eba-5c80-4fef-b02f-97d65d0e3628	20	حرام سرير Bed Blanket	\N	Each	2.000	11.000	China	PROMPT	hypoallergic	2026-08-11 15:59:08.061421+00	16.00	\N
648ba748-5e20-4d6c-a205-dcd2ef726b9c	3e155eba-5c80-4fef-b02f-97d65d0e3628	21	مخدة طبية مع غطاء Medical pillow with Cover	\N	Each	2.000	9.000	China	PROMPT	hypoallergic	2026-08-11 15:59:08.061421+00	16.00	\N
edc52657-a6ee-4de7-ad0a-9673f36a5ebc	3e155eba-5c80-4fef-b02f-97d65d0e3628	22	ستارة 4 Folded with Blue screen	\N	Each	2.000	65.000	China	PROMPT	Medical	2026-08-11 15:59:08.061421+00	16.00	\N
2b5f17d6-b018-42da-85b9-6f6517411e12	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	0	ميزان حرارة رقمي طبي Digital Medical Thermometer		EACH	2.000	12.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
e94aa3a5-88a7-4d35-8311-089855c78ae0	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	1	ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale		EACH	1.000	195.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
e5d52038-c192-448b-a6ac-37b7368f407c	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	2	جهاز فحص الضغط اليدوي Manual Pressure Test Device		EACH	1.000	15.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
64c9ebff-4cc8-496d-adb8-14d48c9a9520	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	3	جهاز ضغط الرقمي digital sphygmomanometer		EACH	1.000	25.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
49859fe7-d016-4ab5-8a39-e66c94ee0b73	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	4	جهاز قياس مستوى سكر الدم (Blood Glucose Meter)		EACH	2.000	15.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
23fad1fd-5409-406b-9fdf-b84199d23103	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	5	جهاز قياس الأكسجين Pulse oximetry		EACH	2.000	14.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
0646ecd3-fe8d-4b18-883f-72397aed2b62	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	6	جهاز تبخيرة Medical Nebulizer		EACH	2.000	29.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
a645abdc-3dd4-42d5-ac7c-83e71b114bd2	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	7	نموذج الهيكل العظمي		EACH	1.000	40.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
c221d09e-32ce-4867-b705-32e6573d4769	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	8	نموذج تشريح ذو أعضاء قابلة للفك والتركيب		EACH	1.000	115.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
48ad93ae-dea0-4c4c-9e7d-979c3666e3cd	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	9	دمية لتطبيق الإسعاف الأولي الرئوي		EACH	1.000	690.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
1d06af12-534d-4ef7-b595-63da25a240b2	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	10	عربة حمل الأدوات والتجهيزات الطبية Medical trolley		EACH	2.000	90.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
1e8a79b8-5558-47ff-a3d1-0ca6198c12ef	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	11	(ميزان حرارة رقمي) Digital Thermometer		EACH	2.000	15.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
fa21cb4f-4ca7-4e7a-bc75-8a6996781362	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	12	نموذج الفك والأسنان		EACH	2.000	29.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
08571480-d952-4a4e-b633-c67d4f9d8dda	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	13	جهاز قياس قوة التدفق الزفيري		EACH	2.000	9.500	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
72fbc9f6-cac6-4598-828b-d94c3da25133	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	14	صندوق التخلص من الأدوات الحادة Sharps Disposal Container		EACH	1.000	3.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
af9b84f3-d991-4023-92e4-909e90a7f2f8	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	15	صندوق فرز النفايات الطبية Medical WasteBox		EACH	1.000	45.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
8ab5ec23-0001-4f8c-b016-4aef9ba693fd	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	16	سرير فحص طبي يدوي Manual Medical Examination Bed		EACH	2.000	80.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
250d46da-23f5-451a-ac50-260e645abd7b	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	17	شرشف سرير Bed Sheet		EACH	2.000	9.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
e3e3fade-8fb6-42ee-a5ea-eea154ebe236	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	18	حرام سرير Bed Blanket		EACH	2.000	11.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
3398f824-031c-4b56-8b2a-2e428868f1da	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	19	مخدة طبية مع غطاء medical pillow with Cover		EACH	2.000	9.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
263208e8-91dc-4581-aa58-369ee2f26b8c	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	20	ستارة 		EACH	2.000	65.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
6f4b51cc-4f29-4339-bdec-6077f4eb333f	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	21	اكسيليفون موسيقى		EACH	1.000	30.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
d94a6255-00df-4dd8-8674-8b5e08df2693	9ee4cd10-89fc-40d7-8ee2-b5c998fad274	22	الة مثلث موسيقي		EACH	1.000	22.000	CHINA	PROMPT		2026-08-11 16:10:23.515402+00	0.00	\N
2bb9d60b-da6a-422b-a43e-e26e5b2915a1	e5a5e969-c9f3-4764-bf44-58a3b10a8818	0	ميزان حرارة رقمي طبي Digital Medical Thermometer		EACH	2.000	7.759	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
f397e16c-0958-41d7-9819-ef2d006aca35	e5a5e969-c9f3-4764-bf44-58a3b10a8818	1	ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale		EACH	1.000	168.103	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
79719768-7675-4e45-9d3e-1eaa32c16502	e5a5e969-c9f3-4764-bf44-58a3b10a8818	2	جهاز فحص الضغط اليدوي Manual Pressure Test Device		EACH	1.000	25.862	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
74b1eec3-b458-4568-b721-6650d05f9ef3	e5a5e969-c9f3-4764-bf44-58a3b10a8818	3	جهاز ضغط الرقمي digital sphygmomanometer		EACH	1.000	25.862	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
92a1adcb-dc19-4a0a-b530-d7c3b6a147b4	e5a5e969-c9f3-4764-bf44-58a3b10a8818	4	جهاز قياس مستوى سكر الدم (Blood Glucose Meter)		EACH	2.000	12.931	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
00485a3a-4009-4aea-a28e-a03d02ea5657	e5a5e969-c9f3-4764-bf44-58a3b10a8818	5	جهاز قياس الأكسجين Pulse oximetry		EACH	2.000	17.241	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
1c0c29bf-1424-424f-9620-4024d87d8ce3	e5a5e969-c9f3-4764-bf44-58a3b10a8818	6	جهاز تبخيرة Medical Nebulizer		EACH	2.000	3.172	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
21861846-275d-4300-880b-6e7a9912430e	e5a5e969-c9f3-4764-bf44-58a3b10a8818	7	نموذج الهيكل العظمي		EACH	1.000	34.483	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
2de3f3b0-5117-42ed-8e2b-e7c53847925a	e5a5e969-c9f3-4764-bf44-58a3b10a8818	8	نموذج تشريح ذو أعضاء قابلة للفك والتركيب		EACH	1.000	99.138	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
3dd771ad-3969-401d-8219-ad86cb2c4228	e5a5e969-c9f3-4764-bf44-58a3b10a8818	9	دمية لتطبيق الإسعاف الأولي الرئوي		EACH	1.000	387.931	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
01660742-50b2-4d88-a885-3e8399aa7e2b	e5a5e969-c9f3-4764-bf44-58a3b10a8818	10	عربة حمل الأدوات والتجهيزات الطبية Medical trolley		EACH	2.000	107.759	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
015e6d9b-4bfb-4cd7-aa98-219ec4a1aa00	e5a5e969-c9f3-4764-bf44-58a3b10a8818	11	(ميزان حرارة رقمي) Digital Thermometer		EACH	2.000	21.552	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
2bac3246-a356-402e-b70a-866090e4f88c	e5a5e969-c9f3-4764-bf44-58a3b10a8818	12	نموذج الفك والأسنان		EACH	2.000	30.172	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
5a13a1c1-9cc5-4b52-adb4-076a18ac4959	e5a5e969-c9f3-4764-bf44-58a3b10a8818	13	جهاز قياس قوة التدفق الزفيري		EACH	2.000	8.190	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
d97a766e-2102-4e47-8e75-081f7b80ba22	e5a5e969-c9f3-4764-bf44-58a3b10a8818	14	صندوق التخلص من الأدوات الحادة Sharps Disposal Container		EACH	1.000	2.586	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
d81b9f35-c537-4cd3-8e56-fed61422fbec	e5a5e969-c9f3-4764-bf44-58a3b10a8818	15	صندوق فرز النفايات الطبية Medical WasteBox		EACH	1.000	38.793	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
85fc461b-ed11-42b5-9ecf-d7ef8ac3598f	e5a5e969-c9f3-4764-bf44-58a3b10a8818	16	سرير فحص طبي يدوي Manual Medical Examination Bed		EACH	2.000	85.345	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
7623b0de-3237-482a-ad72-1ea5c03a2249	e5a5e969-c9f3-4764-bf44-58a3b10a8818	17	شرشف سرير Bed Sheet		EACH	2.000	7.759	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
c301da25-3b52-47e4-947c-4c152ddf4d2d	e5a5e969-c9f3-4764-bf44-58a3b10a8818	18	حرام سرير Bed Blanket		EACH	2.000	15.517	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
8ec7ff59-e6e0-4efa-b189-5c9ccbac46ad	e5a5e969-c9f3-4764-bf44-58a3b10a8818	19	مخدة طبية مع غطاء medical pillow with Cover		EACH	2.000	7.759	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
9a863864-f17c-4c1c-9601-3ace8694efce	e5a5e969-c9f3-4764-bf44-58a3b10a8818	20	ستارة 		EACH	2.000	64.655	CHINA	PROMPT		2026-08-11 21:32:50.506418+00	16.00	\N
\.


--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotations (id, number, customer_name, attention, phone, address, date, reference, currency, delivery, subtotal, discount_pct, discount_amt, grand_total, tax_pct, tax_amt, nett_price, notes, terms, prepared_by, status, created_by, archived, archived_at, created_at, updated_at, customer_id, valid_until, discount_type, discount_fixed, deleted_at, deleted_by, delete_reason, quote_type, detailed_layout, archive_note, quote_lang, requester_name, requester_phone, requester_phone2) FROM stdin;
0a15f774-f2b6-4308-9887-8530a3ccfc5e	QT-2026-0008	الشركة النوعية للكرتون	قسم المشتريات المحترمين	0797311208		2026-07-21	REQ20260939 - Micrometer	JOD	PROMPT	230.000	0.00	0.000	0.000	16.00	36.800	266.800			\N	converted	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 11:43:58.222+00	2026-07-21 07:41:42.683116+00	2026-08-08 11:43:58.682123+00	a75c3c0c-7657-4be5-9db9-8879815e77ff	2026-08-30	pct	0	\N	\N	\N	quote	t	تم اصدار فاتورة فوترة وارسال الطلبية مع النقل	ar	\N	\N	\N
c2ece74c-a5df-4ea3-9907-e54b2e5567ad	QT-2026-0001	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين 	064162607		2026-05-21	Disposable Syringes 10ml	JOD	PROMPT	265.000	0.00	0.000	0.000	16.00	42.400	307.400			\N	rejected	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 06:53:45.923+00	2026-05-21 14:42:33.327369+00	2026-08-03 06:53:46.500058+00	\N	2026-07-01	pct	0	\N	\N	\N	quote	t	تم الشراء من جهة اخرى بسبب السعر	ar	\N	\N	\N
c22be163-9877-485c-8053-e3dfbf094862	QT-2026-0004	مؤسسة الموارد للتجهيزات الطبية	قسم المشتريات المحترمين	\N		2026-06-07	Lab Equipments	JOD	PROMPT	3020.000	0.00	0.000	0.000	16.00	483.200	3503.200	\N		\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:54:45.979+00	2026-06-07 10:47:13.820927+00	2026-08-03 06:54:46.830964+00	c188bbff-81c5-4dfb-a0ad-7e985f6c8d6a	2026-08-30	pct	0	\N	\N	\N	quote	t	تم تقديم العرض لجهة وسيطة ولم يتم احالة العرض	ar	\N	\N	\N
4dd56fea-27bc-4a5a-931c-d09c9f6b73c2	QT-2026-0007	مدارس اكاديمية الاتفاق الدولية	قسم المشتريات المحترمين			2026-07-20	عرض النادي الصيفي	JOD	PROMPT	156.000	0.00	0.000	0.000	16.00	24.960	180.960	للاستفسار والتواصل مع الدكتور احمد تنيرة على موبايل 0798802031		\N	approved	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:55:04.193+00	2026-07-20 08:40:04.187543+00	2026-08-03 06:55:04.982939+00	9b8362b9-9253-4971-b79f-be458d346b26	2026-09-30	pct	0	\N	\N	\N	quote	t	تمت احالة كامل الطلبية على المؤسسة ولله الحمد	ar	\N	\N	\N
c54c7220-b131-41cb-a654-d9fca2056792	QT-2026-0012	جمعية خليل الرحمن /النزهة 	مدير المشتريات			2026-07-21	كرسي اسنان Zinna	JOD	PROMPT	5000.000	0.00	0.000	0.000	16.00	800.000	5800.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره\n		\N	cancelled	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 11:46:44.231+00	2026-07-21 09:48:34.463945+00	2026-08-08 11:46:44.696566+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	ar	\N	\N	\N
19276c37-9a91-48b0-af67-f9f8a99e8795	QT-2026-0002	شركة الحياة للصناعات الدوائية	قسم المشتريات	064162607		2026-05-21	Disposable Coats	JOD	PROMPT	195.000	0.00	0.000	0.000	16.00	31.200	226.200			\N	cancelled	ee095348-a2de-4906-a078-0e8a3f3560a9	t	2026-08-03 13:45:29.243+00	2026-05-21 15:29:54.721504+00	2026-08-03 13:45:30.223546+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-07-30	pct	0	\N	\N	\N	quote	t	تم تحويله الى طلب اخر من المؤسسة بموجب عرض سعر رقم 22/2026	ar	\N	\N	\N
5f8785a4-1258-4ca3-ac8e-91a692e48ba5	QT-2026-0033	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	قسم المشتريات المحترمين	00962790117273		2026-08-03	Microscope -Drying Oven	JOD	PROMPT	495.690	0.00	0.000	0.000	16.00	79.310	575.000			\N	sent	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-03 07:46:50.672363+00	2026-08-04 11:09:51.702105+00	cd40c449-f543-4142-8804-dcc8838ac95e	2026-09-02	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc	QT-2026-0013	جمعية خليل الرحمن /النزهة 	إدارة المشتريات			2026-07-21	كرسي اسنان Zinna	JOD	PROMPT	5250.000	0.00	0.000	0.000	16.00	840.000	6090.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره		\N	cancelled	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 11:48:26.014+00	2026-07-21 09:55:52.297358+00	2026-08-08 11:48:26.480757+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	ar	\N	\N	\N
a3215728-2478-4155-b0a2-d4342a61e744	QT-2026-0006	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-18	Scoops 25ml	JOD	PROMPT	158.000	0.00	0.000	0.000	16.00	25.280	183.280	From ISO LAB		\N	approved	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-18 17:18:56.640512+00	2026-08-04 12:51:05.305563+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	t	تم اعتماد الطلب	ar	\N	\N	\N
df81a005-5d86-4bd2-a92e-555c33891d12	QT-2026-0014	جمعية خليل الرحمن /النزهه 	إدارة المشتريات	0795845888		2026-07-21	كرسي اسنان Keju Chair 	JOD	PROMPT	2625.000	0.00	0.000	0.000	16.00	420.000	3045.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره 		\N	cancelled	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 11:49:15.075+00	2026-07-21 09:59:16.931125+00	2026-08-08 11:49:15.537917+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	ar	\N	\N	\N
c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1	QT-2026-0009	مدارس جمعية خليل الرحمن /العقبة 	إدارة المشتريات	0795845888		2026-07-21	مجهر بيولوجي	JOD	PROMPT	210.000	0.00	0.000	0.000	0.00	33.600	243.600	لاي استفسار الاتصال على 0798802031  د. احمد تنيرة 		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 08:38:56.027224+00	2026-08-08 11:49:43.986967+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b	QT-2026-0021	مدارس جمعية خليل الرحمن /العقبة	مدير المشتريات			2026-07-27	Van de Graff generater	JOD	PROMPT	205.000	0.00	0.000	0.000	0.00	32.800	237.800	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-07-27 06:09:30.914774+00	2026-08-08 11:50:43.679429+00	\N	2026-08-27	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
7d636c37-c439-4ec6-9020-5e11691791b2	QT-2026-0018	مصنع الخميرة 	إدارة المشتريات	0792221816		2026-07-22	مواد مخبرية	JOD	PROMPT	82.000	0.00	0.000	0.000	16.00	13.120	95.120	لاي استفسار الرجاء الاتصال على 0798802031 		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-22 12:53:23.593863+00	2026-08-08 14:24:26.856362+00	\N	2026-08-22	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
f61ede0a-f287-4823-9f93-08362eae21f2	QT-2026-0011	شركة دار الدواء	قسم المشتريات المحترمين			2026-07-21	Latex Gloves	JOD	PROMPT	4780.000	0.00	0.000	0.000	16.00	764.800	5544.800			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-21 09:38:35.574845+00	2026-08-08 14:24:54.543293+00	2d8619b2-afd9-4a41-a81c-3eefc0f15722	2026-08-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
c9e4f3b0-9a34-44b9-8526-de6755caff8a	QT-2026-0017	جامعة العلوم التطبيقية الخاصة	قسم المشتريات المحترمين			2026-07-22	RFQ-ASU-58	JOD	PROMPT	2247.110	0.00	0.000	0.000	16.00	359.538	2606.648			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-22 10:55:19.069966+00	2026-07-22 11:11:33.26947+00	\N	2026-08-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
c93f894e-3ecb-40d4-a5f8-6bbfbe2f205d	QT-2026-0015	الجامعة الأردنية	قسم المشتريات المحترمين			2026-07-22	مخصصات رقم 262324 حاجة د. راميا بقاعين	JOD	PROMPT	775.862	0.00	0.000	0.000	16.00	124.138	900.000			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-22 10:01:23.782863+00	2026-07-22 10:03:51.511449+00	8b9b4c0a-eede-4acb-9e59-8eefab8e4375	2026-08-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
65badfea-3e6c-48ed-82d0-890b09317b59	QT-2026-0020	جامعة الشرق الاوسط 	قسم المشتريات المحترمين			2026-07-23	PH electrode	JOD	PROMPT	423.000	0.00	0.000	0.000	16.00	67.680	490.680			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-23 11:41:08.138111+00	2026-07-23 11:42:57.079923+00	75cd4de7-e08c-430e-8291-6226da18a49a	2026-08-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
18aa97f7-211d-484d-b844-76a42a4e742e	QT-2026-0019	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-23	Lab Equipments - Mantle	JOD	PROMPT	908.000	0.00	0.000	0.000	16.00	145.280	1053.280	المواد متوفر للمعاينة حالا في حال رغبتكم 		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-07-23 06:51:15.445682+00	2026-07-27 07:33:23.752566+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
e7dec721-47fa-4b65-9d98-6519600bc45d	QT-2026-0037	شركة روابي الاردن للمستلزمات و الاجهزة الطبية	قسم المشتريات المحترمين			2026-08-04		JOD		17346.000	0.00	0.000	0.000	16.00	2775.360	20121.360			\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-08-04 11:16:02.05324+00	2026-08-05 08:00:52.376986+00	\N	2026-09-03	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
95edd244-8e7a-47ce-9210-d8d3595a72fb	QT-2026-0026	مديرية الخدمات الطبية الملكية 				2026-07-29	Patient Gown	JOD	3-4 weeks	22000.000	0.00	0.000	0.000	0.00	0.000	22000.000	* السعر أعلاه للكمية المذكورة تحديدا\n* مدة صلاحية العرض 30 يوم\n* مدة التسليم خلال 3 الى 4 أسابيع\n* الأسعار بالدينار الأردني غير شامل الضريبة العامة على المبيعات واصل مستودعاتكم		\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-07-29 10:01:03.423827+00	2026-08-01 11:56:51.693217+00	\N	2026-08-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
198b8bc1-3ab8-4330-883b-79bb6f577b37	QT-2026-0035	شركة سحاب لمواد التجميل 	قسم المشتريات المحترمين	00962778760786		2026-08-03	 Disposables	JOD	PROMPT	17.850	0.00	0.000	0.000	16.00	2.856	20.706			\N	sent	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-03 13:12:28.072125+00	2026-08-06 07:59:22.62327+00	739a0229-8e24-4988-9731-58c9c8cd56b6	2026-09-02	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
c02833fb-95b8-4e6b-af6d-2104455d0623	QT-2026-0034	شركة زعفران لتجارة المواد الطبية والجراحية 	قسم المشتريات المحترمين	0785699076		2026-08-03		JOD	PROMPT	737.500	0.00	0.000	0.000	16.00	118.000	855.500	لاي استفسار الاتصال على 0798802031 احمد تنيره		\N	converted	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-06 09:07:38.95+00	2026-08-03 12:42:10.558812+00	2026-08-06 09:07:39.901878+00	\N	2026-09-02	pct	0	\N	\N	\N	quote	t	تم اصدار فاتورة رقم 476	ar	\N	\N	\N
0877fc34-9ecb-4956-9fbe-8818861c219c	QT-2026-0031	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-02	Filter Syringes 0.45	JOD	PROMPT	280.000	0.00	0.000	0.000	16.00	44.800	324.800			\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 13:08:23.765+00	2026-08-02 06:38:13.498991+00	2026-08-02 13:08:23.502204+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	التاخر في ارسال عرض السعر للعميل وتم الشراء من مصدر اخر	ar	\N	\N	\N
4e71dbec-a2b7-4edc-8a71-b5a850689dfe	QT-2026-0030	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-02	Vials - Parafilm	JOD	PROMPT	3330.000	0.00	0.000	0.000	16.00	532.800	3862.800			\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-02 13:08:55.19+00	2026-08-02 06:33:15.804239+00	2026-08-02 13:08:55.074315+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	التاخر في ارسال عرض السعر للعميل وتم الطلب من مصدر اخر	ar	\N	\N	\N
50143d1a-360b-484f-8d5a-23172401aa7d	QT-2026-0032	شركة الكهرباء الوطنية 	قسم المشتريات المحترمين	0787356764		2026-08-03		JOD	PROMPT	690.000	0.00	0.000	0.000	16.00	110.400	800.400	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة 		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-03 06:12:56.613452+00	2026-08-03 06:15:05.563682+00	\N	2026-09-02	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
deb11bf4-fad8-4379-a302-25be8454c7b3	QT-2026-0003	الشركة النوعية للكرتون	قسم المشتريات المحترمين			2026-06-06	Micrometer - Balance	JOD	PROMPT	320.000	0.00	0.000	0.000	0.00	0.000	320.000	الشركة النوعية للكرتون معفاة من الضريبة العامة للمبيعات بموجب كتاب رئاسة الوزراء		\N	partial_referral	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 06:54:13.176+00	2026-06-06 14:41:19.289009+00	2026-08-03 06:54:13.766419+00	\N	2026-07-01	pct	0	\N	\N	\N	quote	t	تمت احالة جزئية للعرض والغاء باقي البنود	ar	\N	\N	\N
e35fadc5-6138-42a1-84b2-9b2063825ee7	QT-2026-0040	شركة مياهنا /مادبا 	السيد رمزي فراج 	0772467253		2026-08-04	كيماويات	JOD	PROMPT	998.000	0.00	0.000	0.000	16.00	159.680	1157.680	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيره		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-04 12:32:45.484673+00	2026-08-08 11:52:19.00718+00	\N	2026-09-03	pct	0	\N	\N	\N	quote	f	\N	ar	\N	\N	\N
db3a3d6c-b5a0-455d-a33e-1d6222455860	QT-2026-0023	جمعية مؤسسة الزكاة الأمريكية	قسم المشتريات المحترمين			2026-07-27	عطاء رقم 301/2026 : شراء وتوريد معدات طبية لصالح العيادة  في مخيم غزة	JOD		47840.500	0.00	0.000	0.000	16.00	7654.480	55494.980	الدفع 50% عند توقيع الاتفاقية ، 25% عند الاستلام ، 25% بعد انتهاء المشروع\nالدفع عن طريق حوالة بنكية أو شيك بنكي		\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-07-27 14:42:00.930163+00	2026-08-08 14:26:00.318024+00	\N	2026-10-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
75bb058a-1ceb-4c1e-b843-c5006a930fd6	QT-2026-0024	مدارس عمان الاهلية	إدارة المشتريات	0797901489		2026-07-28	مواد تعليمية	JOD	PROMPT	241.250	0.00	0.000	0.000	16.00	38.600	279.850	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة 		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-07-28 09:32:31.784458+00	2026-08-08 14:26:21.336925+00	cf5c4b24-cf21-4602-b569-5f069d914ee5	2026-08-28	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
8fcbdf26-1fa2-49da-8ff1-0b6a919afbb9	QT-2026-0029	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-02	Capillary Tube	JOD	PROMPT	56.000	0.00	0.000	0.000	16.00	8.960	64.960			\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 13:41:56.707+00	2026-08-02 06:27:24.548531+00	2026-08-11 12:10:14.942349+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	الادعاء من العميل بان العينات المرسلة غير مطابقة حيث تم طلب ان تكون مدرجة ومفتوحة من الطرفين	ar	\N	\N	\N
219269a5-5fdf-4a4a-ad24-5551d478bc55	QT-2026-0025	جمعية هيلفيتاس السويسرية HELVETAS	قسم المشتريات المحترمين			2026-07-28	RFQ  11-26	JOD	4-6 WEEKS	6290.000	0.00	0.000	0.000	16.00	1006.400	7296.400			\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-07-28 14:07:05.648253+00	2026-08-08 14:28:03.848669+00	\N	2026-09-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
7f415e1f-baf2-412b-b49d-7437453aeb95	QT-2026-0016	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-22		JOD	PROMPT	388.000	0.00	0.000	0.000	16.00	62.080	450.080			\N	rejected	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 13:40:59.069+00	2026-07-22 10:13:33.294016+00	2026-08-11 12:10:22.861419+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	t	الادعاء من المصنع بان المطلوب ليس نفس العينة المرسلة علما انه تم ارسال العينة الى مالك الخوالدة لكن تم رفضه من المختبرات	ar	\N	\N	\N
505e698c-09ce-4610-8d79-772e36f62ec1	QT-2026-0036	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-03	Heating Mantle	JOD	PROMPT	165.000	0.00	0.000	0.000	16.00	26.400	191.400			\N	sent	6f484e98-e110-4ceb-8070-e61810c5f108	f	\N	2026-08-03 13:41:03.938552+00	2026-08-04 11:19:03.431152+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-09-02	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
ab3be0df-3b5d-4283-bab0-631e54cc76cd	QT-2026-0022	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-07-27	Disposables - Gloves	JOD	PROMPT	5386.700	0.00	0.000	0.000	16.00	861.872	6248.572			\N	converted	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-03 14:16:52.43+00	2026-07-27 07:46:47.894622+00	2026-08-03 14:16:53.483704+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-08-30	pct	0	\N	\N	\N	quote	f	تم احالة الطلبية بشكل كلي على المؤسسة ولله الحمد	ar	\N	\N	\N
0460215c-ff4b-486f-b4b8-d780c6931ef2	QT-2026-0028	شركة المناصير لتكنولوجيا المعلومات	قسم المشتريات المحترمين	0096265813700		2026-08-01	Radiation Detector 	JOD	PROMPT	730.000	0.00	0.000	0.000	16.00	116.800	846.800			\N	sent	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-01 15:50:36.892492+00	2026-08-04 11:10:22.862846+00	98c85065-5320-477e-b78c-83ad9270728a	2026-09-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
9ac83342-e490-4896-93fb-04fc3f70b0cb	2026D-001	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	قسم المشتريات المحترمين	00962790117273		2026-08-04	-	JOD	PROMPT	240.000	0.00	0.000	0.000	16.00	38.400	278.400			\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-04 09:25:45.361952+00	2026-08-04 12:54:04.179841+00	cd40c449-f543-4142-8804-dcc8838ac95e	2026-09-03	pct	0	2026-08-04 12:54:03.084+00	445bc65d-256f-48d3-9367-464a408e657b	فقط للتجربة	quote	t	\N	ar	\N	\N	\N
1032638a-9a54-49ef-bf84-0adb4862a10d	QT-2026-0010	 جمعية خليل الرحمن /النزهة 	إدارة المشتريات	0795845888		2026-07-21	كرسي اسنان	JOD	PROMPT	5875.000	0.00	0.000	0.000	16.00	940.000	6815.000	لاي استفسار الرجاء الاتصال على 0798802031 د.احمد تنيره		\N	cancelled	445bc65d-256f-48d3-9367-464a408e657b	t	2026-08-08 11:47:32.063+00	2026-07-21 09:18:30.544996+00	2026-08-08 11:47:32.524116+00	\N	2026-09-21	pct	0	\N	\N	\N	quote	t	سوء فهم مع العميل حيث المطلوب هو كرسي مكتب عادي	ar	\N	\N	\N
7a84e616-f098-46ab-8b3a-0fffad9b86d4	2026D-005	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-06		JOD	PROMPT	0.000	0.00	0.000	0.000	16.00	0.000	0.000			\N	draft	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-08-06 13:33:13.989757+00	2026-08-06 13:33:49.224707+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-09-05	pct	0	2026-08-06 13:33:48.034+00	445bc65d-256f-48d3-9367-464a408e657b	تجربة	quote	f	\N	ar	\N	\N	\N
6aa4a2de-104e-4303-9638-0f23d2348d0b	2026D-004	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-06	-	JOD	PROMPT	355.000	0.00	0.000	0.000	16.00	56.800	411.800			\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-06 10:16:41.391576+00	2026-08-08 10:06:15.171906+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-09-05	pct	0	2026-08-08 10:06:14.773+00	445bc65d-256f-48d3-9367-464a408e657b	للتجربة	quote	f	\N	en	\N	\N	\N
873a3454-5c39-4fcb-8304-349c14e2bab3	2026D-003	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-06	-	JOD	PROMPT	595.000	0.00	0.000	0.000	16.00	95.200	690.200			\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-06 10:13:21.576724+00	2026-08-08 10:06:22.424375+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-09-05	pct	0	2026-08-08 10:06:22.032+00	445bc65d-256f-48d3-9367-464a408e657b	للتجربة	quote	t	\N	ar	\N	\N	\N
79f9499f-31c6-4226-91d4-6c05ba279ab8	QT-2026-0027	جامعة جرش الاهلية	قسم المشتريات المحترمين	0778450550		2026-07-29		JOD	PROMPT	50.000	0.00	0.000	0.000	16.00	8.000	58.000	لاي استفسار الرجاء الاتصال على 0798802031		\N	rejected	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	t	2026-08-08 11:51:41.246+00	2026-07-29 11:01:48.503883+00	2026-08-08 11:51:41.705764+00	\N	2026-08-29	pct	0	\N	\N	\N	quote	t	تم الشراء من جهة اخرى بسبب التاخر في ارسال عرض السعر	ar	\N	\N	\N
95434668-ce79-4841-8844-ec778967671e	2026D-007			\N	\N	2026-08-08		JOD	PROMPT	1827.350	0.00	0.000	0.000	0.00	0.000	1827.350	مستورد من Excel — بانتظار المراجعة	\N	\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-08 10:17:17.219272+00	2026-08-08 11:52:56.103829+00	\N	2026-09-07	pct	0	2026-08-08 11:52:55.61+00	445bc65d-256f-48d3-9367-464a408e657b	تم اعتماده	quote	f	\N	ar	\N	\N	\N
8d865c1b-7081-4faf-b0c6-2b4877aaadb4	QT-2026-0039	المدارس الاردنية الدولية 	قسم المشتريات المحترمين	0796972176		2026-08-05		JOD	2-4 WEEKS	1015.200	0.00	0.000	0.000	16.00	162.432	1177.632	لاي استفسار الرجاء الاتصال على 0798802031 احمد تنيرة 		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-05 09:57:41.476817+00	2026-08-08 11:37:40.822282+00	\N	2026-09-04	pct	0	\N	\N	\N	quote	f	\N	ar	\N	\N	\N
f4484ac3-fe41-4a73-8379-80a9257a185e	QT-2026-0005	الجامعة الأردنية	دائرة اللوازم المركزية - شعبة تأمين مستلزمات البحث العلمي			2026-06-30	مناقصة طلب شراء رقم (262202)  بحث د. يحيى طبازه - كلية الصيدلة	JOD	4-8 weeks	2284.000	0.00	0.000	0.000	16.00	365.440	2649.440	الدفع خلال (60) يوم من تاريخ التوريد		\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-06-30 10:19:20.795436+00	2026-08-08 14:25:17.591711+00	8b9b4c0a-eede-4acb-9e59-8eefab8e4375	2026-08-30	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
3e155eba-5c80-4fef-b02f-97d65d0e3628	QT-2026-0042	عرض سعر مخصص للمدارس	قسم الرعاية الصحية	0796799511	\N	2026-08-08	قسم الرعاية الصحية	JOD	PROMPT	1875.000	0.00	0.000	1872.350	0.00	0.000	1875.000	الأسعار شاملة الضريبة العامة على المبيعات	\N	\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-08-08 09:54:40.114269+00	2026-08-11 15:59:07.455823+00	\N	2026-09-07	pct	0	\N	\N	\N	quote	f	\N	ar	0000000000	00000000000000	\N
ec6f990e-5f00-4426-af28-f533ae5796be	QT-2026-0041	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-06	CON-00363	JOD	PROMPT	2650.000	0.00	0.000	0.000	16.00	424.000	3074.000			\N	sent	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-08-06 10:28:49.716686+00	2026-08-08 14:27:18.862334+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-09-05	pct	0	\N	\N	\N	quote	f	\N	ar	\N	\N	\N
4f367a05-a990-4efe-967b-bebf1407c4e8	QT-2026-0043	شركة القيمة المتميزة للصناعات الغذائية 	قسم المشتريات المحترمين	0799300301		2026-08-08	تجهيز مختبر مصنع	JOD	PROMPT	1208.000	0.00	0.000	0.000	16.00	193.280	1401.280	لاي استفسار الرجاء الاتصال على 079+8802031 احمد تنيره		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-08 17:18:47.870414+00	2026-08-08 17:18:47.870414+00	\N	2026-09-07	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
5a276011-0db0-40c1-ad6d-4f9971aea927	QT-2026-0044	مدارس المشاهير 	قسم المشتريات المحترمين	0782966860		2026-08-08	مواد مختبر العلوم	JOD	PROMPT	162.800	0.00	0.000	0.000	16.00	26.048	188.848			\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-08 17:44:07.090891+00	2026-08-09 08:32:54.275867+00	\N	2026-09-07	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
3f64dbea-7e03-4be7-96f6-a8c2d7792fd6	QT-2026-0045	مدارس ميار الدولية الثانية 	قسم المشتريات المحترمين	0780985646		2026-08-09	تجهيز العيادة 	JOD	PROMPT	1116.000	0.00	0.000	0.000	16.00	178.560	1294.560			\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-09 11:38:05.77469+00	2026-08-09 11:38:05.77469+00	\N	2026-09-08	pct	0	\N	\N	\N	quote	t	\N	ar	\N	\N	\N
89b49bc4-0135-43a2-a74b-3861ed5d8430	QT-2026-0046	جامعة العقبة للعلوم الطبية	قسم المشتريات المحترمين	\N	\N	2026-08-09	مواد كلية التمريض	JOD	PROMPT	5190.700	0.00	0.000	0.000	0.00	0.000	5190.700	السعر واصل الى الجامعة في العقبة / ضريبة المبيعات معفاة \nالتواصل مع السيد نضال المجالي 0795180100 لاية استفسارات	\N	\N	sent	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-09 11:54:05.357159+00	2026-08-09 11:58:21.414371+00	\N	2026-09-08	pct	0	\N	\N	\N	quote	f	\N	ar	\N	\N	\N
1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b	2026D-009			\N	\N	2026-08-09		JOD	PROMPT	1827.350	0.00	0.000	0.000	0.00	0.000	1827.350	مستورد من Excel — بانتظار المراجعة	\N	\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-09 17:57:37.508604+00	2026-08-10 07:27:24.282421+00	\N	2026-09-08	pct	0	2026-08-10 07:27:23.473+00	445bc65d-256f-48d3-9367-464a408e657b	تجربة	quote	f	\N	ar	\N	\N	\N
26b0da4a-95b8-4436-bfee-cd8acaaa6e62	QT-2026-0048	مدرسة عجلون الثانوية 	قسم المشتريات المحترمين			2026-08-10	قائمة المستهلكات -طفولة مبكرة 	JOD	PROMPT	382.000	0.00	0.000	0.000	16.00	61.120	443.120			\N	converted	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-10 22:52:30.757354+00	2026-08-10 23:13:42.127896+00	\N	2026-09-09	pct	0	\N	\N	\N	quote	t	\N	ar	احمد تنيره	0798802031	
d9cf0468-761e-426f-bd09-2d4d10c36f8a	QT-2026-0047	مدرسة عجلون الثانوية 	قسم المشتريات المحترمين			2026-08-10	طفولة مبكرة 	JOD	PROMPT	911.100	0.00	0.000	0.000	16.00	145.776	1056.876			\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-10 22:15:56.233883+00	2026-08-11 11:50:44.62038+00	\N	2026-09-09	pct	0	\N	\N	\N	quote	t	\N	ar	احمد تنيره	0798802031	
7b053b6e-5c57-4498-930d-0869cfcab2fa	QT-2026-0050	الشركة الاردنية لانتاج الادوية 	قسم المشتريات المحترمين			2026-08-11	Rotary Evaporator	JOD	PROMPT	168.000	0.00	0.000	0.000	16.00	26.880	194.880	لاي استفسار الرجاء الاتصال على 079+8802031 احمد تنيره		\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-11 08:45:48.047967+00	2026-08-11 15:25:10.627175+00	\N	2026-09-10	pct	0	\N	\N	\N	quote	t	\N	ar	0000000000000	0000000000000000	
e5a5e969-c9f3-4764-bf44-58a3b10a8818	QT-2026-0049	مدرسة عجلون الثانوية 	قسم المشتريات المحترمين			2026-08-11	تخصص الرعاية الصحية 	JOD	PROMPT	1562.380	0.00	0.000	0.000	16.00	249.981	1812.361			\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-11 06:06:45.260964+00	2026-08-11 21:32:49.364496+00	\N	2026-09-10	pct	0	\N	\N	\N	quote	t	\N	ar	احمد تنيرة 	0798802031	
6cbd075c-65c8-4703-9c35-9b28f5017259	QT-2026-0051	مدرسة عجلون الثانوية 	قسم المشتريات المحترمين			2026-08-08	الرعاية الصحية - المستهلكات 	JOD	PROMPT	274.000	0.00	0.000	0.000	16.00	43.840	317.840			\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-11 06:18:39.189003+00	2026-08-11 11:43:30.121934+00	\N	2026-09-07	pct	0	\N	\N	\N	quote	t	\N	ar	احمد تنيره	0798802031	
da22b830-27c5-425d-bbc9-17f0ab63a83c	2026D-011	شركة الحياة للصناعات الدوائية	قسم المشتريات المحترمين	064162607		2026-08-11	chemicals	JOD	PROMPT	240.000	0.00	0.000	0.000	16.00	38.400	278.400			\N	draft	445bc65d-256f-48d3-9367-464a408e657b	f	\N	2026-08-11 12:07:39.844551+00	2026-08-11 12:11:36.307089+00	30c5f5ec-0d68-46fe-a969-36926ac21235	2026-09-10	pct	0	2026-08-11 12:11:35.072+00	445bc65d-256f-48d3-9367-464a408e657b	تجربة	quote	f	\N	ar	01111	111111111111111111111	
94435f61-38f3-40e5-88a2-be37057a238b	2026D-012	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	قسم المشتريات المحترمين	00962790117273		2026-08-11	--	JOD	PROMPT	240.000	0.00	0.000	0.000	16.00	38.400	278.400			\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-11 14:49:51.425357+00	2026-08-11 14:50:02.505136+00	cd40c449-f543-4142-8804-dcc8838ac95e	2026-09-10	pct	0	2026-08-11 14:50:02.426+00	ee095348-a2de-4906-a078-0e8a3f3560a9	تجربة	quote	f	\N	ar	اس	123123123	
a5a1c783-79f6-41b7-9eed-498bfb502031	2026D-013	الثلاثية المتخصصة لتجهيزات المنشئات والمحلات	قسم المشتريات المحترمين	00962790117273		2026-08-11	11	JOD	PROMPT	382.000	0.00	0.000	0.000	16.00	61.120	443.120			\N	draft	ee095348-a2de-4906-a078-0e8a3f3560a9	f	\N	2026-08-11 14:59:34.424947+00	2026-08-11 15:00:07.347087+00	cd40c449-f543-4142-8804-dcc8838ac95e	2026-09-10	pct	0	2026-08-11 15:00:07.226+00	ee095348-a2de-4906-a078-0e8a3f3560a9	تجربة	quote	t	\N	ar	الا	123123123123	
9ee4cd10-89fc-40d7-8ee2-b5c998fad274	QT-2026-0052	مدرسة هالة بنت خويلد 	قسم المشتريات المحترمين	0795744934		2026-08-11	بيتك- الرعاية الصحية 	JOD	PROMPT	2000.000	0.00	0.000	0.000	0.00	0.000	2000.000			\N	sent	65ce1c8f-6151-402a-8bcd-4270b3cf6d0a	f	\N	2026-08-11 16:10:22.912928+00	2026-08-11 16:10:22.912928+00	99256d7a-4d68-4685-851c-49565f38e8a7	2026-09-10	pct	0	\N	\N	\N	quote	t	\N	ar	مديرة المدرسة 	0795744934	
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
cfecd000-aa7f-49ce-b0c7-e52a4ff1c643	65badfea-3e6c-48ed-82d0-890b09317b59	قام ابو ابراهيم الجيوسي بالاتصال مع العميل وقال ان الملف تم تحويله الى المشتريات لغايات الاعتماد	445bc65d-256f-48d3-9367-464a408e657b	2026-08-08 12:04:12.806694+00
\.


--
-- Data for Name: supplier_invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier_invoices (id, number, supplier_invoice_no, supplier_id, supplier_name, po_id, po_number, date, due_date, status, currency, total, paid_amount, notes, created_by, created_at) FROM stdin;
cbaa33a7-c1df-46c3-8693-df59f2a40367	\N	114741	5ed75765-cf5c-4e80-9932-79ce699edb30	مورد للتجربة	8812d31e-9d77-416e-b36f-c7997754ca92	PO-0001	2026-08-06	2026-08-13	partial	JOD	464.000	64.000	\N	\N	2026-08-06 09:04:04.015054+00
\.


--
-- Data for Name: supplier_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier_payments (id, supplier_id, invoice_id, date, amount, method, reference, notes, created_by, created_at) FROM stdin;
9afda0d1-093d-443b-877f-2ef766ac00e8	5ed75765-cf5c-4e80-9932-79ce699edb30	cbaa33a7-c1df-46c3-8693-df59f2a40367	2026-08-06	64.000	check	1123132123	\N	\N	2026-08-06 09:04:28.573391+00
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, code, name, phone, email, address, city, country, contact_name, contact_phone, payment_terms, notes, is_active, created_by, created_at) FROM stdin;
5ed75765-cf5c-4e80-9932-79ce699edb30	SUP-0001	مورد للتجربة	011233	test@test.com	\N	amman	الأردن	ahmad	0783323123	30	\N	t	\N	2026-08-06 09:02:39.278938+00
\.


--
-- Data for Name: vouchers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vouchers (id, type, number, date, amount, currency, party, description, payment_method, reference, prepared_by, approved_by, notes, created_by, created_at, updated_at, archived, archive_reason) FROM stdin;
aa677c1d-62ae-494f-966a-e079d4a6dc0f	payment	SP-0001	2026-08-06	500.000	JOD	اسامة	دفعة تجريبية 	نقداً		Eng. Osama Alawy	اسامة 		ee095348-a2de-4906-a078-0e8a3f3560a9	2026-08-06 14:39:17.822866+00	2026-08-06 14:39:17.822866+00	f	\N
\.


--
-- Data for Name: messages_2026_08_08; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_08 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_09; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_09 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_10; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_10 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_11; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_11 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_12; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_12 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_13; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_13 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
\.


--
-- Data for Name: messages_2026_08_14; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages_2026_08_14 (topic, extension, payload, event, private, updated_at, inserted_at, id, binary_payload) FROM stdin;
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

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 727, true);


--
-- Name: custom_origins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_origins_id_seq', 74, true);


--
-- Name: custom_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_units_id_seq', 95, true);


--
-- Name: po_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.po_number_seq', 1, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 3581, true);


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
-- Name: item_name_history item_name_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_name_history
    ADD CONSTRAINT item_name_history_pkey PRIMARY KEY (name);


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
-- Name: prospects prospects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospects
    ADD CONSTRAINT prospects_pkey PRIMARY KEY (id);


--
-- Name: purchase_order_items purchase_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders purchase_orders_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_number_key UNIQUE (number);


--
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


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
-- Name: supplier_invoices supplier_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_invoices
    ADD CONSTRAINT supplier_invoices_pkey PRIMARY KEY (id);


--
-- Name: supplier_payments supplier_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_payments
    ADD CONSTRAINT supplier_payments_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_code_key UNIQUE (code);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: vouchers vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_08 messages_2026_08_08_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_08
    ADD CONSTRAINT messages_2026_08_08_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_09 messages_2026_08_09_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_09
    ADD CONSTRAINT messages_2026_08_09_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_10 messages_2026_08_10_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_10
    ADD CONSTRAINT messages_2026_08_10_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_11 messages_2026_08_11_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_11
    ADD CONSTRAINT messages_2026_08_11_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_12 messages_2026_08_12_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_12
    ADD CONSTRAINT messages_2026_08_12_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_13 messages_2026_08_13_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_13
    ADD CONSTRAINT messages_2026_08_13_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_08_14 messages_2026_08_14_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages_2026_08_14
    ADD CONSTRAINT messages_2026_08_14_pkey PRIMARY KEY (id, inserted_at);


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
-- Name: vouchers_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vouchers_type_idx ON public.vouchers USING btree (type);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_08_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_08_inserted_at_topic_idx ON realtime.messages_2026_08_08 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_09_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_09_inserted_at_topic_idx ON realtime.messages_2026_08_09 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_10_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_10_inserted_at_topic_idx ON realtime.messages_2026_08_10 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_11_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_11_inserted_at_topic_idx ON realtime.messages_2026_08_11 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_12_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_12_inserted_at_topic_idx ON realtime.messages_2026_08_12 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_13_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_13_inserted_at_topic_idx ON realtime.messages_2026_08_13 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_08_14_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_2026_08_14_inserted_at_topic_idx ON realtime.messages_2026_08_14 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


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
-- Name: messages_2026_08_08_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_08_inserted_at_topic_idx;


--
-- Name: messages_2026_08_08_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_08_pkey;


--
-- Name: messages_2026_08_09_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_09_inserted_at_topic_idx;


--
-- Name: messages_2026_08_09_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_09_pkey;


--
-- Name: messages_2026_08_10_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_10_inserted_at_topic_idx;


--
-- Name: messages_2026_08_10_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_10_pkey;


--
-- Name: messages_2026_08_11_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_11_inserted_at_topic_idx;


--
-- Name: messages_2026_08_11_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_11_pkey;


--
-- Name: messages_2026_08_12_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_12_inserted_at_topic_idx;


--
-- Name: messages_2026_08_12_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_12_pkey;


--
-- Name: messages_2026_08_13_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_13_inserted_at_topic_idx;


--
-- Name: messages_2026_08_13_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_13_pkey;


--
-- Name: messages_2026_08_14_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_08_14_inserted_at_topic_idx;


--
-- Name: messages_2026_08_14_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_08_14_pkey;


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
-- Name: purchase_orders trg_po_number; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_po_number BEFORE INSERT ON public.purchase_orders FOR EACH ROW EXECUTE FUNCTION public.set_po_number();


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
-- Name: vouchers trg_vouchers_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_vouchers_updated_at BEFORE UPDATE ON public.vouchers FOR EACH ROW EXECUTE FUNCTION public.update_vouchers_updated_at();


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
-- Name: orders orders_deleted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_deleted_by_fkey FOREIGN KEY (deleted_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


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
-- Name: prospects prospects_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospects
    ADD CONSTRAINT prospects_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.profiles(id);


--
-- Name: prospects prospects_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospects
    ADD CONSTRAINT prospects_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: prospects prospects_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospects
    ADD CONSTRAINT prospects_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: purchase_order_items purchase_order_items_po_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_po_id_fkey FOREIGN KEY (po_id) REFERENCES public.purchase_orders(id) ON DELETE CASCADE;


--
-- Name: purchase_orders purchase_orders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: purchase_orders purchase_orders_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


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
-- Name: supplier_invoices supplier_invoices_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_invoices
    ADD CONSTRAINT supplier_invoices_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: supplier_invoices supplier_invoices_po_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_invoices
    ADD CONSTRAINT supplier_invoices_po_id_fkey FOREIGN KEY (po_id) REFERENCES public.purchase_orders(id);


--
-- Name: supplier_invoices supplier_invoices_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_invoices
    ADD CONSTRAINT supplier_invoices_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: supplier_payments supplier_payments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_payments
    ADD CONSTRAINT supplier_payments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: supplier_payments supplier_payments_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_payments
    ADD CONSTRAINT supplier_payments_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.supplier_invoices(id);


--
-- Name: supplier_payments supplier_payments_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier_payments
    ADD CONSTRAINT supplier_payments_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: suppliers suppliers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: vouchers vouchers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE SET NULL;


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
-- Name: prospects auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY auth ON public.prospects TO authenticated USING (true) WITH CHECK (true);


--
-- Name: purchase_order_items auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY auth ON public.purchase_order_items TO authenticated USING (true) WITH CHECK (true);


--
-- Name: purchase_orders auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY auth ON public.purchase_orders TO authenticated USING (true) WITH CHECK (true);


--
-- Name: supplier_invoices auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY auth ON public.supplier_invoices TO authenticated USING (true) WITH CHECK (true);


--
-- Name: supplier_payments auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY auth ON public.supplier_payments TO authenticated USING (true) WITH CHECK (true);


--
-- Name: suppliers auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY auth ON public.suppliers TO authenticated USING (true) WITH CHECK (true);


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
-- Name: item_name_history authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated users" ON public.item_name_history TO authenticated USING (true) WITH CHECK (true);


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
-- Name: item_name_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.item_name_history ENABLE ROW LEVEL SECURITY;

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
-- Name: prospects; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.prospects ENABLE ROW LEVEL SECURITY;

--
-- Name: purchase_order_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase_order_items ENABLE ROW LEVEL SECURITY;

--
-- Name: purchase_orders; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase_orders ENABLE ROW LEVEL SECURITY;

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
-- Name: supplier_invoices; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.supplier_invoices ENABLE ROW LEVEL SECURITY;

--
-- Name: supplier_payments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.supplier_payments ENABLE ROW LEVEL SECURITY;

--
-- Name: suppliers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;

--
-- Name: quote_followups users can manage followups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "users can manage followups" ON public.quote_followups USING (true) WITH CHECK (true);


--
-- Name: vouchers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.vouchers ENABLE ROW LEVEL SECURITY;

--
-- Name: vouchers vouchers_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY vouchers_all ON public.vouchers USING ((auth.uid() IS NOT NULL));


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
-- Name: FUNCTION next_po_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.next_po_number() TO anon;
GRANT ALL ON FUNCTION public.next_po_number() TO authenticated;
GRANT ALL ON FUNCTION public.next_po_number() TO service_role;


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
-- Name: FUNCTION set_po_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_po_number() TO anon;
GRANT ALL ON FUNCTION public.set_po_number() TO authenticated;
GRANT ALL ON FUNCTION public.set_po_number() TO service_role;


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
-- Name: FUNCTION update_vouchers_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_vouchers_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_vouchers_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_vouchers_updated_at() TO service_role;


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
-- Name: TABLE item_name_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.item_name_history TO anon;
GRANT ALL ON TABLE public.item_name_history TO authenticated;
GRANT ALL ON TABLE public.item_name_history TO service_role;


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
-- Name: SEQUENCE po_number_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.po_number_seq TO anon;
GRANT ALL ON SEQUENCE public.po_number_seq TO authenticated;
GRANT ALL ON SEQUENCE public.po_number_seq TO service_role;


--
-- Name: TABLE prospects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.prospects TO anon;
GRANT ALL ON TABLE public.prospects TO authenticated;
GRANT ALL ON TABLE public.prospects TO service_role;


--
-- Name: TABLE purchase_order_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.purchase_order_items TO anon;
GRANT ALL ON TABLE public.purchase_order_items TO authenticated;
GRANT ALL ON TABLE public.purchase_order_items TO service_role;


--
-- Name: TABLE purchase_orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.purchase_orders TO anon;
GRANT ALL ON TABLE public.purchase_orders TO authenticated;
GRANT ALL ON TABLE public.purchase_orders TO service_role;


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
-- Name: TABLE supplier_invoices; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.supplier_invoices TO anon;
GRANT ALL ON TABLE public.supplier_invoices TO authenticated;
GRANT ALL ON TABLE public.supplier_invoices TO service_role;


--
-- Name: TABLE supplier_payments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.supplier_payments TO anon;
GRANT ALL ON TABLE public.supplier_payments TO authenticated;
GRANT ALL ON TABLE public.supplier_payments TO service_role;


--
-- Name: TABLE suppliers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suppliers TO anon;
GRANT ALL ON TABLE public.suppliers TO authenticated;
GRANT ALL ON TABLE public.suppliers TO service_role;


--
-- Name: TABLE vouchers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vouchers TO anon;
GRANT ALL ON TABLE public.vouchers TO authenticated;
GRANT ALL ON TABLE public.vouchers TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2026_08_08; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_08 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_08 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_09; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_09 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_09 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_10; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_10 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_10 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_11; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_11 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_11 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_12; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_12 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_12 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_13; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_13 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_13 TO dashboard_user;


--
-- Name: TABLE messages_2026_08_14; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages_2026_08_14 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_08_14 TO dashboard_user;


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

\unrestrict ETZNTyuDlZ8KeJEQYQ1iEud3iNvbsWsCcp0oc3JBqLYqkThrwvEjRAQxyZzFgrk

