--
-- MedQuote Pro - Consolidated schema (public tables + functions + policies)
-- Regenerated from live DB backup (backup_2026-08-19.sql) on 2026-08-20
-- DO NOT edit manually - regenerate from a fresh pg_dump when schema changes.
--

SET check_function_bodies = false;

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
-- Name: change_request_replies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.change_request_replies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    request_id uuid NOT NULL,
    user_id uuid NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.change_request_replies OWNER TO postgres;


--
-- Name: change_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.change_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    body text DEFAULT ''::text NOT NULL,
    status text DEFAULT 'open'::text NOT NULL,
    priority text DEFAULT 'medium'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.change_requests OWNER TO postgres;


--
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    edited boolean DEFAULT false
);

ALTER TABLE ONLY public.chat_messages REPLICA IDENTITY FULL;


ALTER TABLE public.chat_messages OWNER TO postgres;


--
-- Name: chat_reactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_reactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    message_id uuid NOT NULL,
    user_id uuid NOT NULL,
    emoji text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

ALTER TABLE ONLY public.chat_reactions REPLICA IDENTITY FULL;


ALTER TABLE public.chat_reactions OWNER TO postgres;


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
-- Name: customer_name_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_name_history (
    name text NOT NULL,
    last_used_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.customer_name_history OWNER TO postgres;


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
-- Name: inbox_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbox_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    from_company text NOT NULL,
    type text DEFAULT 'other'::text NOT NULL,
    title text NOT NULL,
    reference text,
    received_at date DEFAULT CURRENT_DATE NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    assigned_to uuid,
    status text DEFAULT 'new'::text NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.inbox_items OWNER TO postgres;


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
    reference text,
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
-- Name: quote_discussions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quote_discussions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    quotation_id uuid NOT NULL,
    user_id uuid NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

ALTER TABLE ONLY public.quote_discussions REPLICA IDENTITY FULL;


ALTER TABLE public.quote_discussions OWNER TO postgres;


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
-- Name: reference_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reference_history (
    name text NOT NULL,
    last_used_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.reference_history OWNER TO postgres;


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
-- Name: task_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    task_id uuid NOT NULL,
    user_id uuid NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

ALTER TABLE ONLY public.task_comments REPLICA IDENTITY FULL;


ALTER TABLE public.task_comments OWNER TO postgres;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_by uuid NOT NULL,
    assigned_to uuid,
    title text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    status text DEFAULT 'todo'::text NOT NULL,
    priority text DEFAULT 'medium'::text NOT NULL,
    due_date date,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

ALTER TABLE ONLY public.tasks REPLICA IDENTITY FULL;


ALTER TABLE public.tasks OWNER TO postgres;


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
-- Name: custom_origins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_origins ALTER COLUMN id SET DEFAULT nextval('public.custom_origins_id_seq'::regclass);



--
-- Name: custom_units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_units ALTER COLUMN id SET DEFAULT nextval('public.custom_units_id_seq'::regclass);



--
-- Name: custom_origins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_origins_id_seq', 1484, true);



--
-- Name: custom_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custom_units_id_seq', 203, true);



--
-- Name: po_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.po_number_seq', 1, true);



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
-- Name: change_request_replies change_request_replies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_request_replies
    ADD CONSTRAINT change_request_replies_pkey PRIMARY KEY (id);



--
-- Name: change_requests change_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT change_requests_pkey PRIMARY KEY (id);



--
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);



--
-- Name: chat_reactions chat_reactions_message_id_user_id_emoji_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_reactions
    ADD CONSTRAINT chat_reactions_message_id_user_id_emoji_key UNIQUE (message_id, user_id, emoji);



--
-- Name: chat_reactions chat_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_reactions
    ADD CONSTRAINT chat_reactions_pkey PRIMARY KEY (id);



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
-- Name: customer_name_history customer_name_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_name_history
    ADD CONSTRAINT customer_name_history_pkey PRIMARY KEY (name);



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
-- Name: inbox_items inbox_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbox_items
    ADD CONSTRAINT inbox_items_pkey PRIMARY KEY (id);



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
-- Name: quote_discussions quote_discussions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote_discussions
    ADD CONSTRAINT quote_discussions_pkey PRIMARY KEY (id);



--
-- Name: quote_followups quote_followups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote_followups
    ADD CONSTRAINT quote_followups_pkey PRIMARY KEY (id);



--
-- Name: reference_history reference_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reference_history
    ADD CONSTRAINT reference_history_pkey PRIMARY KEY (name);



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
-- Name: task_comments task_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_comments
    ADD CONSTRAINT task_comments_pkey PRIMARY KEY (id);



--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);



--
-- Name: vouchers vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_pkey PRIMARY KEY (id);



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
-- Name: change_request_replies change_request_replies_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_request_replies
    ADD CONSTRAINT change_request_replies_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.change_requests(id) ON DELETE CASCADE;



--
-- Name: change_request_replies change_request_replies_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_request_replies
    ADD CONSTRAINT change_request_replies_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;



--
-- Name: change_requests change_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT change_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;



--
-- Name: chat_messages chat_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;



--
-- Name: chat_reactions chat_reactions_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_reactions
    ADD CONSTRAINT chat_reactions_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.chat_messages(id) ON DELETE CASCADE;



--
-- Name: chat_reactions chat_reactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_reactions
    ADD CONSTRAINT chat_reactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;



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
-- Name: inbox_items inbox_items_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbox_items
    ADD CONSTRAINT inbox_items_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES auth.users(id) ON DELETE SET NULL;



--
-- Name: inbox_items inbox_items_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbox_items
    ADD CONSTRAINT inbox_items_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;



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
-- Name: quote_discussions quote_discussions_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote_discussions
    ADD CONSTRAINT quote_discussions_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(id) ON DELETE CASCADE;



--
-- Name: quote_discussions quote_discussions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quote_discussions
    ADD CONSTRAINT quote_discussions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;



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
-- Name: task_comments task_comments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_comments
    ADD CONSTRAINT task_comments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;



--
-- Name: task_comments task_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_comments
    ADD CONSTRAINT task_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;



--
-- Name: tasks tasks_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES auth.users(id) ON DELETE SET NULL;



--
-- Name: tasks tasks_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE CASCADE;



--
-- Name: vouchers vouchers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE SET NULL;



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
-- Name: change_request_replies; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.change_request_replies ENABLE ROW LEVEL SECURITY;


--
-- Name: change_requests; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.change_requests ENABLE ROW LEVEL SECURITY;


--
-- Name: chat_messages chat_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY chat_del ON public.chat_messages FOR DELETE USING ((auth.uid() = user_id));



--
-- Name: chat_messages chat_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY chat_ins ON public.chat_messages FOR INSERT WITH CHECK ((auth.uid() = user_id));



--
-- Name: chat_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_messages ENABLE ROW LEVEL SECURITY;


--
-- Name: chat_reactions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.chat_reactions ENABLE ROW LEVEL SECURITY;


--
-- Name: chat_messages chat_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY chat_sel ON public.chat_messages FOR SELECT USING ((auth.role() = 'authenticated'::text));



--
-- Name: chat_messages chat_upd; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY chat_upd ON public.chat_messages FOR UPDATE USING ((auth.uid() = user_id));



--
-- Name: change_requests cr_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cr_del ON public.change_requests FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));



--
-- Name: change_requests cr_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cr_ins ON public.change_requests FOR INSERT WITH CHECK ((auth.uid() = user_id));



--
-- Name: change_requests cr_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cr_sel ON public.change_requests FOR SELECT USING ((auth.role() = 'authenticated'::text));



--
-- Name: change_requests cr_upd; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY cr_upd ON public.change_requests FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));



--
-- Name: change_request_replies crr_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY crr_del ON public.change_request_replies FOR DELETE USING ((auth.uid() = user_id));



--
-- Name: change_request_replies crr_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY crr_ins ON public.change_request_replies FOR INSERT WITH CHECK ((auth.uid() = user_id));



--
-- Name: change_request_replies crr_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY crr_sel ON public.change_request_replies FOR SELECT USING ((auth.role() = 'authenticated'::text));



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
-- Name: customer_name_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_name_history ENABLE ROW LEVEL SECURITY;


--
-- Name: customer_name_history customer_name_history_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customer_name_history_all ON public.customer_name_history USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));



--
-- Name: customers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;


--
-- Name: customers customers_all_auth; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_all_auth ON public.customers USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));



--
-- Name: quote_discussions disc_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY disc_del ON public.quote_discussions FOR DELETE USING ((auth.uid() = user_id));



--
-- Name: quote_discussions disc_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY disc_ins ON public.quote_discussions FOR INSERT WITH CHECK ((auth.uid() = user_id));



--
-- Name: quote_discussions disc_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY disc_sel ON public.quote_discussions FOR SELECT USING ((auth.role() = 'authenticated'::text));



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
-- Name: inbox_items inbox_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY inbox_del ON public.inbox_items FOR DELETE USING (((auth.uid() = user_id) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text))))));



--
-- Name: inbox_items inbox_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY inbox_ins ON public.inbox_items FOR INSERT WITH CHECK ((auth.uid() = user_id));



--
-- Name: inbox_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.inbox_items ENABLE ROW LEVEL SECURITY;


--
-- Name: inbox_items inbox_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY inbox_sel ON public.inbox_items FOR SELECT USING ((auth.role() = 'authenticated'::text));



--
-- Name: inbox_items inbox_upd; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY inbox_upd ON public.inbox_items FOR UPDATE USING (((auth.uid() = user_id) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text))))));



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
-- Name: quote_discussions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.quote_discussions ENABLE ROW LEVEL SECURITY;


--
-- Name: quote_followups; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.quote_followups ENABLE ROW LEVEL SECURITY;


--
-- Name: chat_reactions react_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY react_del ON public.chat_reactions FOR DELETE USING ((auth.uid() = user_id));



--
-- Name: chat_reactions react_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY react_ins ON public.chat_reactions FOR INSERT WITH CHECK ((auth.uid() = user_id));



--
-- Name: chat_reactions react_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY react_sel ON public.chat_reactions FOR SELECT USING ((auth.role() = 'authenticated'::text));



--
-- Name: reference_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reference_history ENABLE ROW LEVEL SECURITY;


--
-- Name: reference_history reference_history_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reference_history_all ON public.reference_history USING ((auth.uid() IS NOT NULL)) WITH CHECK ((auth.uid() IS NOT NULL));



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
-- Name: task_comments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.task_comments ENABLE ROW LEVEL SECURITY;


--
-- Name: tasks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;


--
-- Name: tasks tasks_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tasks_del ON public.tasks FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['admin'::text, 'manager'::text]))))));



--
-- Name: tasks tasks_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tasks_ins ON public.tasks FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['admin'::text, 'manager'::text]))))));



--
-- Name: tasks tasks_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tasks_sel ON public.tasks FOR SELECT USING ((auth.role() = 'authenticated'::text));



--
-- Name: tasks tasks_upd; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tasks_upd ON public.tasks FOR UPDATE USING (((auth.uid() = assigned_to) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['admin'::text, 'manager'::text])))))));



--
-- Name: task_comments tc_del; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tc_del ON public.task_comments FOR DELETE USING (((auth.uid() = user_id) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = ANY (ARRAY['admin'::text, 'manager'::text])))))));



--
-- Name: task_comments tc_ins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tc_ins ON public.task_comments FOR INSERT WITH CHECK ((auth.uid() = user_id));



--
-- Name: task_comments tc_sel; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tc_sel ON public.task_comments FOR SELECT USING ((auth.role() = 'authenticated'::text));



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
-- Name: supabase_realtime chat_messages; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.chat_messages;



--
-- Name: supabase_realtime chat_reactions; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.chat_reactions;



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
-- Name: supabase_realtime quote_discussions; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.quote_discussions;



--
-- Name: supabase_realtime task_comments; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.task_comments;



--
-- Name: supabase_realtime tasks; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.tasks;



--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;



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
-- Name: TABLE change_request_replies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.change_request_replies TO anon;
GRANT ALL ON TABLE public.change_request_replies TO authenticated;
GRANT ALL ON TABLE public.change_request_replies TO service_role;



--
-- Name: TABLE change_requests; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.change_requests TO anon;
GRANT ALL ON TABLE public.change_requests TO authenticated;
GRANT ALL ON TABLE public.change_requests TO service_role;



--
-- Name: TABLE chat_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.chat_messages TO anon;
GRANT ALL ON TABLE public.chat_messages TO authenticated;
GRANT ALL ON TABLE public.chat_messages TO service_role;



--
-- Name: TABLE chat_reactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.chat_reactions TO anon;
GRANT ALL ON TABLE public.chat_reactions TO authenticated;
GRANT ALL ON TABLE public.chat_reactions TO service_role;



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
-- Name: TABLE customer_name_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customer_name_history TO anon;
GRANT ALL ON TABLE public.customer_name_history TO authenticated;
GRANT ALL ON TABLE public.customer_name_history TO service_role;



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
-- Name: TABLE inbox_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.inbox_items TO anon;
GRANT ALL ON TABLE public.inbox_items TO authenticated;
GRANT ALL ON TABLE public.inbox_items TO service_role;



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
-- Name: TABLE quote_discussions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.quote_discussions TO anon;
GRANT ALL ON TABLE public.quote_discussions TO authenticated;
GRANT ALL ON TABLE public.quote_discussions TO service_role;



--
-- Name: TABLE quote_followups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.quote_followups TO anon;
GRANT ALL ON TABLE public.quote_followups TO authenticated;
GRANT ALL ON TABLE public.quote_followups TO service_role;



--
-- Name: TABLE reference_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reference_history TO anon;
GRANT ALL ON TABLE public.reference_history TO authenticated;
GRANT ALL ON TABLE public.reference_history TO service_role;



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
-- Name: TABLE task_comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.task_comments TO anon;
GRANT ALL ON TABLE public.task_comments TO authenticated;
GRANT ALL ON TABLE public.task_comments TO service_role;



--
-- Name: TABLE tasks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tasks TO anon;
GRANT ALL ON TABLE public.tasks TO authenticated;
GRANT ALL ON TABLE public.tasks TO service_role;



--
-- Name: TABLE vouchers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vouchers TO anon;
GRANT ALL ON TABLE public.vouchers TO authenticated;
GRANT ALL ON TABLE public.vouchers TO service_role;



