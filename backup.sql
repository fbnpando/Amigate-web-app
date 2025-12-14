--
-- PostgreSQL database dump
--

\restrict ylgdAnhpcFrg7soLk3pfW2flmbaQOi4XRTbjCAR2FRuVJtnRyH0dRYcZXhPknqH

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: roderich
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO roderich;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: roderich
--

COMMENT ON SCHEMA public IS '';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO roderich;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO roderich;

--
-- Name: categorias; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.categorias (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(100) NOT NULL,
    icono character varying(50),
    color character varying(7),
    descripcion text,
    activo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categorias OWNER TO roderich;

--
-- Name: configuracion_notificaciones_usuario; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.configuracion_notificaciones_usuario (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    usuario_id uuid NOT NULL,
    push_activo boolean DEFAULT true NOT NULL,
    email_activo boolean DEFAULT true NOT NULL,
    sms_activo boolean DEFAULT false NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone
);


ALTER TABLE public.configuracion_notificaciones_usuario OWNER TO roderich;

--
-- Name: configuracion_sistema; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.configuracion_sistema (
    clave character varying(100) NOT NULL,
    valor text NOT NULL,
    descripcion text,
    tipo character varying(20) DEFAULT 'string'::character varying NOT NULL,
    updated_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    CONSTRAINT check_tipo CHECK (((tipo)::text = ANY ((ARRAY['string'::character varying, 'number'::character varying, 'boolean'::character varying, 'json'::character varying])::text[])))
);


ALTER TABLE public.configuracion_sistema OWNER TO roderich;

--
-- Name: cuadrante_barrios; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.cuadrante_barrios (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    cuadrante_id uuid NOT NULL,
    nombre_barrio character varying(200) NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.cuadrante_barrios OWNER TO roderich;

--
-- Name: cuadrantes; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.cuadrantes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    codigo character varying(20) NOT NULL,
    fila character varying(5) NOT NULL,
    columna integer NOT NULL,
    nombre character varying(100),
    lat_min numeric(10,8) NOT NULL,
    lat_max numeric(10,8) NOT NULL,
    lng_min numeric(11,8) NOT NULL,
    lng_max numeric(11,8) NOT NULL,
    centro_lat numeric(10,8),
    centro_lng numeric(11,8),
    ciudad character varying(100) NOT NULL,
    zona character varying(100),
    activo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.cuadrantes OWNER TO roderich;

--
-- Name: expansiones_reporte; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.expansiones_reporte (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reporte_id uuid NOT NULL,
    cuadrante_expandido_id uuid NOT NULL,
    nivel integer NOT NULL,
    fecha_expansion timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.expansiones_reporte OWNER TO roderich;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO roderich;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: roderich
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO roderich;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: roderich
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: grupo_miembros; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.grupo_miembros (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    grupo_id uuid NOT NULL,
    usuario_id uuid NOT NULL,
    rol character varying(20) DEFAULT 'miembro'::character varying NOT NULL,
    notificaciones_activas boolean DEFAULT true NOT NULL,
    joined_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    CONSTRAINT check_rol CHECK (((rol)::text = ANY ((ARRAY['miembro'::character varying, 'moderador'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.grupo_miembros OWNER TO roderich;

--
-- Name: grupos; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.grupos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    cuadrante_id uuid NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion text,
    imagen_url text,
    publico boolean DEFAULT true NOT NULL,
    requiere_aprobacion boolean DEFAULT false NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone
);


ALTER TABLE public.grupos OWNER TO roderich;

--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO roderich;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO roderich;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: roderich
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO roderich;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: roderich
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO roderich;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: roderich
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO roderich;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: roderich
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id character varying(255) NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO roderich;

--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id character varying(255) NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO roderich;

--
-- Name: notificacion_datos; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.notificacion_datos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    notificacion_id uuid NOT NULL,
    clave character varying(100) NOT NULL,
    valor text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notificacion_datos OWNER TO roderich;

--
-- Name: notificaciones; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.notificaciones (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    usuario_id uuid NOT NULL,
    tipo character varying(50) NOT NULL,
    titulo character varying(200) NOT NULL,
    mensaje text NOT NULL,
    leida boolean DEFAULT false NOT NULL,
    enviada_push boolean DEFAULT false NOT NULL,
    enviada_email boolean DEFAULT false NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notificaciones OWNER TO roderich;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO roderich;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO roderich;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: roderich
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO roderich;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: roderich
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: reporte_caracteristicas; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.reporte_caracteristicas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reporte_id uuid NOT NULL,
    clave character varying(100) NOT NULL,
    valor text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reporte_caracteristicas OWNER TO roderich;

--
-- Name: reporte_imagenes; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.reporte_imagenes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reporte_id uuid NOT NULL,
    url text NOT NULL,
    orden integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reporte_imagenes OWNER TO roderich;

--
-- Name: reporte_videos; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.reporte_videos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reporte_id uuid NOT NULL,
    url text NOT NULL,
    orden integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reporte_videos OWNER TO roderich;

--
-- Name: reportes; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.reportes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    usuario_id uuid NOT NULL,
    categoria_id uuid NOT NULL,
    cuadrante_id uuid NOT NULL,
    tipo_reporte character varying(20) NOT NULL,
    titulo character varying(200) NOT NULL,
    descripcion text NOT NULL,
    ubicacion_exacta_lat numeric(10,8),
    ubicacion_exacta_lng numeric(11,8),
    direccion_referencia text,
    fecha_perdida timestamp(0) with time zone,
    fecha_reporte timestamp(0) with time zone DEFAULT now() NOT NULL,
    estado character varying(20) DEFAULT 'activo'::character varying NOT NULL,
    prioridad character varying(20) DEFAULT 'normal'::character varying NOT NULL,
    nivel_expansion integer DEFAULT 1 NOT NULL,
    max_expansion integer DEFAULT 3 NOT NULL,
    proxima_expansion timestamp(0) with time zone,
    contacto_publico boolean DEFAULT true NOT NULL,
    telefono_contacto character varying(20),
    email_contacto character varying(255),
    recompensa numeric(10,2),
    vistas integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone,
    CONSTRAINT check_estado CHECK (((estado)::text = ANY ((ARRAY['activo'::character varying, 'resuelto'::character varying, 'inactivo'::character varying, 'spam'::character varying])::text[]))),
    CONSTRAINT check_prioridad CHECK (((prioridad)::text = ANY ((ARRAY['baja'::character varying, 'normal'::character varying, 'alta'::character varying, 'urgente'::character varying])::text[]))),
    CONSTRAINT check_tipo_reporte CHECK (((tipo_reporte)::text = ANY ((ARRAY['perdido'::character varying, 'encontrado'::character varying])::text[])))
);


ALTER TABLE public.reportes OWNER TO roderich;

--
-- Name: respuesta_imagenes; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.respuesta_imagenes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    respuesta_id uuid NOT NULL,
    url text NOT NULL,
    orden integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.respuesta_imagenes OWNER TO roderich;

--
-- Name: respuesta_videos; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.respuesta_videos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    respuesta_id uuid NOT NULL,
    url text NOT NULL,
    orden integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.respuesta_videos OWNER TO roderich;

--
-- Name: respuestas; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.respuestas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reporte_id uuid NOT NULL,
    usuario_id uuid NOT NULL,
    tipo_respuesta character varying(20) NOT NULL,
    mensaje text NOT NULL,
    ubicacion_lat numeric(10,8),
    ubicacion_lng numeric(11,8),
    direccion_referencia text,
    verificada boolean DEFAULT false NOT NULL,
    util boolean,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    CONSTRAINT check_tipo_respuesta CHECK (((tipo_respuesta)::text = ANY ((ARRAY['avistamiento'::character varying, 'encontrado'::character varying, 'informacion'::character varying, 'pregunta'::character varying])::text[])))
);


ALTER TABLE public.respuestas OWNER TO roderich;

--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO roderich;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO roderich;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: roderich
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO roderich;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: roderich
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO roderich;

--
-- Name: users; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO roderich;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: roderich
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO roderich;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: roderich
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: roderich
--

CREATE TABLE public.usuarios (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    telefono character varying(20),
    avatar_url text,
    puntos_ayuda integer DEFAULT 0 NOT NULL,
    fecha_registro timestamp(0) with time zone DEFAULT now() NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    ubicacion_actual_lat numeric(10,8),
    ubicacion_actual_lng numeric(11,8),
    rol character varying(20) DEFAULT 'cliente'::character varying NOT NULL,
    contrasena text DEFAULT ''::text NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone,
    CONSTRAINT check_rol CHECK (((rol)::text = ANY ((ARRAY['cliente'::character varying, 'moderador'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO roderich;

--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.categorias (id, nombre, icono, color, descripcion, activo, created_at) FROM stdin;
6002c2e2-6a0e-4370-9c11-42c10edf15ef	Personas	person	#FF6B6B	Personas perdidas o desaparecidas	t	2025-12-13 21:53:23-04
ea31ca99-64ca-4ff6-996d-6b431c289018	Mascotas	pets	#4ECDC4	Perros, gatos y otras mascotas	t	2025-12-13 21:53:23-04
2123b794-d024-4f9d-9169-4f5794e380da	Documentos	description	#45B7D1	Identificaciones, pasaportes, licencias	t	2025-12-13 21:53:23-04
d67582ae-b982-454d-a55b-df43873fa7d9	Electrónicos	smartphone	#96CEB4	Teléfonos, laptops, tablets, etc.	t	2025-12-13 21:53:23-04
129497e4-b602-47b4-9b90-a15cd3e1f440	Vehículos	directions_car	#FFEAA7	Autos, motos, bicicletas	t	2025-12-13 21:53:23-04
71c1c42d-f3f0-4225-941a-046765941691	Ropa/Accesorios	checkroom	#DDA0DD	Ropa, bolsas, joyas, etc.	t	2025-12-13 21:53:23-04
ffefcfd5-0fb9-4e3f-933f-026c71069f11	Llaves	vpn_key	#F39C12	Llaves de casa, auto, oficina	t	2025-12-13 21:53:23-04
bd7be892-a767-4ef1-b89f-dbd7a00df01a	Otros	category	#95A5A6	Otros objetos no categorizados	t	2025-12-13 21:53:23-04
\.


--
-- Data for Name: configuracion_notificaciones_usuario; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.configuracion_notificaciones_usuario (id, usuario_id, push_activo, email_activo, sms_activo, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: configuracion_sistema; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.configuracion_sistema (clave, valor, descripcion, tipo, updated_at) FROM stdin;
tiempo_expansion_horas	0.083	Horas antes de expandir a cuadrantes adyacentes	number	2025-12-13 21:53:24-04
max_nivel_expansion	3	Máximo nivel de expansión permitido	number	2025-12-13 21:53:24-04
radio_cuadrante_km	2	Radio en kilómetros de cada cuadrante	number	2025-12-13 21:53:24-04
\.


--
-- Data for Name: cuadrante_barrios; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.cuadrante_barrios (id, cuadrante_id, nombre_barrio, created_at) FROM stdin;
\.


--
-- Data for Name: cuadrantes; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.cuadrantes (id, codigo, fila, columna, nombre, lat_min, lat_max, lng_min, lng_max, centro_lat, centro_lng, ciudad, zona, activo, created_at) FROM stdin;
\.


--
-- Data for Name: expansiones_reporte; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.expansiones_reporte (id, reporte_id, cuadrante_expandido_id, nivel, fecha_expansion) FROM stdin;
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: grupo_miembros; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.grupo_miembros (id, grupo_id, usuario_id, rol, notificaciones_activas, joined_at) FROM stdin;
\.


--
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.grupos (id, cuadrante_id, nombre, descripcion, imagen_url, publico, requiere_aprobacion, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2024_01_01_000000_create_permission_tables	1
5	2024_01_01_100000_create_usuarios_table	1
6	2024_01_01_100001_create_configuracion_notificaciones_usuario_table	1
7	2024_01_01_100002_create_cuadrantes_table	1
8	2024_01_01_100003_create_cuadrante_barrios_table	1
9	2024_01_01_100004_create_categorias_table	1
10	2024_01_01_100005_create_reportes_table	1
11	2024_01_01_100006_create_reporte_caracteristicas_table	1
12	2024_01_01_100007_create_reporte_imagenes_table	1
13	2024_01_01_100008_create_reporte_videos_table	1
14	2024_01_01_100009_create_respuestas_table	1
15	2024_01_01_100010_create_respuesta_imagenes_table	1
16	2024_01_01_100011_create_respuesta_videos_table	1
17	2024_01_01_100012_create_grupos_table	1
18	2024_01_01_100013_create_grupo_miembros_table	1
19	2024_01_01_100014_create_expansiones_reporte_table	1
20	2024_01_01_100015_create_notificaciones_table	1
21	2024_01_01_100016_create_notificacion_datos_table	1
22	2024_01_01_100017_create_configuracion_sistema_table	1
23	2024_01_01_100018_create_indexes_for_tables	1
24	2025_12_11_005646_modify_model_has_roles_for_uuid_support	1
\.


--
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;

\.


--
-- Data for Name: notificacion_datos; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.notificacion_datos (id, notificacion_id, clave, valor, created_at) FROM stdin;
\.


--
-- Data for Name: notificaciones; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.notificaciones (id, usuario_id, tipo, titulo, mensaje, leida, enviada_push, enviada_email, created_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.permissions (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reporte_caracteristicas; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.reporte_caracteristicas (id, reporte_id, clave, valor, created_at) FROM stdin;
\.


--
-- Data for Name: reporte_imagenes; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.reporte_imagenes (id, reporte_id, url, orden, created_at) FROM stdin;
\.


--
-- Data for Name: reporte_videos; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.reporte_videos (id, reporte_id, url, orden, created_at) FROM stdin;
\.


--
-- Data for Name: reportes; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.reportes (id, usuario_id, categoria_id, cuadrante_id, tipo_reporte, titulo, descripcion, ubicacion_exacta_lat, ubicacion_exacta_lng, direccion_referencia, fecha_perdida, fecha_reporte, estado, prioridad, nivel_expansion, max_expansion, proxima_expansion, contacto_publico, telefono_contacto, email_contacto, recompensa, vistas, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: respuesta_imagenes; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.respuesta_imagenes (id, respuesta_id, url, orden, created_at) FROM stdin;
\.


--
-- Data for Name: respuesta_videos; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.respuesta_videos (id, respuesta_id, url, orden, created_at) FROM stdin;
\.


--
-- Data for Name: respuestas; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.respuestas (id, reporte_id, usuario_id, tipo_respuesta, mensaje, ubicacion_lat, ubicacion_lng, direccion_referencia, verificada, util, created_at) FROM stdin;
\.


--
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: roderich
--

COPY public.usuarios (id, nombre, email, telefono, avatar_url, puntos_ayuda, fecha_registro, activo, ubicacion_actual_lat, ubicacion_actual_lng, rol, contrasena, created_at, updated_at) FROM stdin;
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: roderich
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: roderich
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: roderich
--

SELECT pg_catalog.setval('public.migrations_id_seq', 24, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: roderich
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: roderich
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: roderich
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: categorias categorias_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_unique UNIQUE (nombre);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: configuracion_notificaciones_usuario configuracion_notificaciones_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.configuracion_notificaciones_usuario
    ADD CONSTRAINT configuracion_notificaciones_usuario_pkey PRIMARY KEY (id);


--
-- Name: configuracion_notificaciones_usuario configuracion_notificaciones_usuario_usuario_id_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.configuracion_notificaciones_usuario
    ADD CONSTRAINT configuracion_notificaciones_usuario_usuario_id_unique UNIQUE (usuario_id);


--
-- Name: configuracion_sistema configuracion_sistema_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.configuracion_sistema
    ADD CONSTRAINT configuracion_sistema_pkey PRIMARY KEY (clave);


--
-- Name: cuadrante_barrios cuadrante_barrios_cuadrante_id_nombre_barrio_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cuadrante_barrios
    ADD CONSTRAINT cuadrante_barrios_cuadrante_id_nombre_barrio_unique UNIQUE (cuadrante_id, nombre_barrio);


--
-- Name: cuadrante_barrios cuadrante_barrios_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cuadrante_barrios
    ADD CONSTRAINT cuadrante_barrios_pkey PRIMARY KEY (id);


--
-- Name: cuadrantes cuadrantes_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cuadrantes
    ADD CONSTRAINT cuadrantes_codigo_unique UNIQUE (codigo);


--
-- Name: cuadrantes cuadrantes_fila_columna_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cuadrantes
    ADD CONSTRAINT cuadrantes_fila_columna_unique UNIQUE (fila, columna);


--
-- Name: cuadrantes cuadrantes_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cuadrantes
    ADD CONSTRAINT cuadrantes_pkey PRIMARY KEY (id);


--
-- Name: expansiones_reporte expansiones_reporte_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.expansiones_reporte
    ADD CONSTRAINT expansiones_reporte_pkey PRIMARY KEY (id);


--
-- Name: expansiones_reporte expansiones_reporte_reporte_id_cuadrante_expandido_id_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.expansiones_reporte
    ADD CONSTRAINT expansiones_reporte_reporte_id_cuadrante_expandido_id_unique UNIQUE (reporte_id, cuadrante_expandido_id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: grupo_miembros grupo_miembros_grupo_id_usuario_id_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.grupo_miembros
    ADD CONSTRAINT grupo_miembros_grupo_id_usuario_id_unique UNIQUE (grupo_id, usuario_id);


--
-- Name: grupo_miembros grupo_miembros_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.grupo_miembros
    ADD CONSTRAINT grupo_miembros_pkey PRIMARY KEY (id);


--
-- Name: grupos grupos_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: notificacion_datos notificacion_datos_notificacion_id_clave_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.notificacion_datos
    ADD CONSTRAINT notificacion_datos_notificacion_id_clave_unique UNIQUE (notificacion_id, clave);


--
-- Name: notificacion_datos notificacion_datos_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.notificacion_datos
    ADD CONSTRAINT notificacion_datos_pkey PRIMARY KEY (id);


--
-- Name: notificaciones notificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: reporte_caracteristicas reporte_caracteristicas_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reporte_caracteristicas
    ADD CONSTRAINT reporte_caracteristicas_pkey PRIMARY KEY (id);


--
-- Name: reporte_caracteristicas reporte_caracteristicas_reporte_id_clave_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reporte_caracteristicas
    ADD CONSTRAINT reporte_caracteristicas_reporte_id_clave_unique UNIQUE (reporte_id, clave);


--
-- Name: reporte_imagenes reporte_imagenes_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reporte_imagenes
    ADD CONSTRAINT reporte_imagenes_pkey PRIMARY KEY (id);


--
-- Name: reporte_videos reporte_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reporte_videos
    ADD CONSTRAINT reporte_videos_pkey PRIMARY KEY (id);


--
-- Name: reportes reportes_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_pkey PRIMARY KEY (id);


--
-- Name: respuesta_imagenes respuesta_imagenes_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.respuesta_imagenes
    ADD CONSTRAINT respuesta_imagenes_pkey PRIMARY KEY (id);


--
-- Name: respuesta_videos respuesta_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.respuesta_videos
    ADD CONSTRAINT respuesta_videos_pkey PRIMARY KEY (id);


--
-- Name: respuestas respuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_pkey PRIMARY KEY (id);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_unique; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_unique UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: idx_cuadrante_barrios_cuadrante; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_cuadrante_barrios_cuadrante ON public.cuadrante_barrios USING btree (cuadrante_id);


--
-- Name: idx_expansiones_reporte; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_expansiones_reporte ON public.expansiones_reporte USING btree (reporte_id);


--
-- Name: idx_notificacion_datos_notificacion; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_notificacion_datos_notificacion ON public.notificacion_datos USING btree (notificacion_id);


--
-- Name: idx_reporte_caracteristicas_reporte; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_reporte_caracteristicas_reporte ON public.reporte_caracteristicas USING btree (reporte_id);


--
-- Name: idx_reporte_imagenes_reporte; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_reporte_imagenes_reporte ON public.reporte_imagenes USING btree (reporte_id);


--
-- Name: idx_reporte_videos_reporte; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_reporte_videos_reporte ON public.reporte_videos USING btree (reporte_id);


--
-- Name: idx_respuesta_imagenes_respuesta; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_respuesta_imagenes_respuesta ON public.respuesta_imagenes USING btree (respuesta_id);


--
-- Name: idx_respuesta_videos_respuesta; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_respuesta_videos_respuesta ON public.respuesta_videos USING btree (respuesta_id);


--
-- Name: idx_respuestas_reporte; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX idx_respuestas_reporte ON public.respuestas USING btree (reporte_id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: roderich
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: configuracion_notificaciones_usuario configuracion_notificaciones_usuario_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.configuracion_notificaciones_usuario
    ADD CONSTRAINT configuracion_notificaciones_usuario_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: cuadrante_barrios cuadrante_barrios_cuadrante_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.cuadrante_barrios
    ADD CONSTRAINT cuadrante_barrios_cuadrante_id_foreign FOREIGN KEY (cuadrante_id) REFERENCES public.cuadrantes(id) ON DELETE CASCADE;


--
-- Name: expansiones_reporte expansiones_reporte_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.expansiones_reporte
    ADD CONSTRAINT expansiones_reporte_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: grupo_miembros grupo_miembros_grupo_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.grupo_miembros
    ADD CONSTRAINT grupo_miembros_grupo_id_foreign FOREIGN KEY (grupo_id) REFERENCES public.grupos(id) ON DELETE CASCADE;


--
-- Name: grupo_miembros grupo_miembros_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.grupo_miembros
    ADD CONSTRAINT grupo_miembros_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: grupos grupos_cuadrante_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_cuadrante_id_foreign FOREIGN KEY (cuadrante_id) REFERENCES public.cuadrantes(id);


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: notificacion_datos notificacion_datos_notificacion_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.notificacion_datos
    ADD CONSTRAINT notificacion_datos_notificacion_id_foreign FOREIGN KEY (notificacion_id) REFERENCES public.notificaciones(id) ON DELETE CASCADE;


--
-- Name: notificaciones notificaciones_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: reporte_caracteristicas reporte_caracteristicas_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reporte_caracteristicas
    ADD CONSTRAINT reporte_caracteristicas_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: reporte_imagenes reporte_imagenes_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reporte_imagenes
    ADD CONSTRAINT reporte_imagenes_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: reporte_videos reporte_videos_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reporte_videos
    ADD CONSTRAINT reporte_videos_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: reportes reportes_categoria_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_categoria_id_foreign FOREIGN KEY (categoria_id) REFERENCES public.categorias(id);


--
-- Name: reportes reportes_cuadrante_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_cuadrante_id_foreign FOREIGN KEY (cuadrante_id) REFERENCES public.cuadrantes(id);


--
-- Name: reportes reportes_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: respuesta_imagenes respuesta_imagenes_respuesta_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.respuesta_imagenes
    ADD CONSTRAINT respuesta_imagenes_respuesta_id_foreign FOREIGN KEY (respuesta_id) REFERENCES public.respuestas(id) ON DELETE CASCADE;


--
-- Name: respuesta_videos respuesta_videos_respuesta_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.respuesta_videos
    ADD CONSTRAINT respuesta_videos_respuesta_id_foreign FOREIGN KEY (respuesta_id) REFERENCES public.respuestas(id) ON DELETE CASCADE;


--
-- Name: respuestas respuestas_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: respuestas respuestas_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: roderich
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: roderich
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;

--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
1	usuario	web	2025-12-13 17:28:48	2025-12-13 17:28:48
3	administrador	web	2025-12-13 17:40:16	2025-12-13 17:40:16
4	editor	web	2025-12-13 18:49:42	2025-12-13 18:49:42
\.


--
-- PostgreSQL database dump complete
--

\unrestrict ylgdAnhpcFrg7soLk3pfW2flmbaQOi4XRTbjCAR2FRuVJtnRyH0dRYcZXhPknqH

