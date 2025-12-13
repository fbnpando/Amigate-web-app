--
-- PostgreSQL database dump
--

\restrict 0fRJbDA0rczuovACNVOie1QiJeDDAaSAM6uJKygx727RP0GCCe2kgLqg8g4aEta

-- Dumped from database version 16.11
-- Dumped by pg_dump version 16.11

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

SET default_table_access_method = heap;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id uuid NOT NULL,
    nombre character varying(255) NOT NULL,
    icono character varying(255),
    color character varying(255),
    descripcion character varying(255),
    activo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: configuracion_sistema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configuracion_sistema (
    clave character varying(255) NOT NULL,
    valor text,
    descripcion character varying(255),
    tipo character varying(255) DEFAULT 'string'::character varying NOT NULL,
    updated_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.configuracion_sistema OWNER TO postgres;

--
-- Name: cuadrante_barrios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuadrante_barrios (
    id uuid NOT NULL,
    cuadrante_id uuid NOT NULL,
    nombre_barrio character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cuadrante_barrios OWNER TO postgres;

--
-- Name: cuadrantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuadrantes (
    id uuid NOT NULL,
    codigo character varying(255) NOT NULL,
    fila character varying(255) NOT NULL,
    columna integer NOT NULL,
    nombre character varying(255),
    geometria text,
    centro text,
    lat_min numeric(10,8) NOT NULL,
    lat_max numeric(10,8) NOT NULL,
    lng_min numeric(11,8) NOT NULL,
    lng_max numeric(11,8) NOT NULL,
    ciudad character varying(255),
    zona character varying(255),
    barrios json,
    activo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    centro_lat numeric(10,8),
    centro_lng numeric(11,8)
);


ALTER TABLE public.cuadrantes OWNER TO postgres;

--
-- Name: expansiones_reporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expansiones_reporte (
    id uuid NOT NULL,
    reporte_id uuid NOT NULL,
    cuadrante_original_id uuid NOT NULL,
    cuadrante_expandido_id uuid NOT NULL,
    nivel integer NOT NULL,
    fecha_expansion timestamp(0) without time zone,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.expansiones_reporte OWNER TO postgres;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: grupo_miembros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo_miembros (
    id uuid NOT NULL,
    grupo_id uuid NOT NULL,
    usuario_id uuid NOT NULL,
    rol character varying(255) DEFAULT 'miembro'::character varying NOT NULL,
    notificaciones_activas boolean DEFAULT true NOT NULL,
    joined_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.grupo_miembros OWNER TO postgres;

--
-- Name: grupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupos (
    id uuid NOT NULL,
    cuadrante_id uuid NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text,
    imagen_url character varying(255),
    publico boolean DEFAULT true NOT NULL,
    requiere_aprobacion boolean DEFAULT false NOT NULL,
    miembros_count integer DEFAULT 0 NOT NULL,
    reportes_activos_count integer DEFAULT 0 NOT NULL,
    reportes_resueltos_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.grupos OWNER TO postgres;

--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id character varying(255) NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO postgres;

--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id character varying(255) NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO postgres;

--
-- Name: notificaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificaciones (
    id uuid NOT NULL,
    usuario_id uuid NOT NULL,
    tipo character varying(255) NOT NULL,
    titulo character varying(255) NOT NULL,
    mensaje text,
    datos json,
    leida boolean DEFAULT false NOT NULL,
    enviada_push boolean DEFAULT false NOT NULL,
    enviada_email boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notificaciones OWNER TO postgres;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: reporte_imagenes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reporte_imagenes (
    id bigint NOT NULL,
    reporte_id uuid NOT NULL,
    ruta character varying(255) NOT NULL,
    tipo character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.reporte_imagenes OWNER TO postgres;

--
-- Name: reporte_imagenes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reporte_imagenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reporte_imagenes_id_seq OWNER TO postgres;

--
-- Name: reporte_imagenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reporte_imagenes_id_seq OWNED BY public.reporte_imagenes.id;


--
-- Name: reportes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reportes (
    id uuid NOT NULL,
    usuario_id uuid NOT NULL,
    categoria_id uuid NOT NULL,
    cuadrante_id uuid NOT NULL,
    tipo_reporte character varying(255) NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    ubicacion_exacta_lat numeric(10,8),
    ubicacion_exacta_lng numeric(11,8),
    direccion_referencia character varying(255),
    fecha_perdida timestamp(0) without time zone,
    fecha_reporte timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estado character varying(255) DEFAULT 'activo'::character varying NOT NULL,
    prioridad character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    nivel_expansion integer DEFAULT 1 NOT NULL,
    max_expansion integer DEFAULT 3 NOT NULL,
    proxima_expansion timestamp(0) without time zone,
    contacto_publico boolean DEFAULT true NOT NULL,
    telefono_contacto character varying(255),
    email_contacto character varying(255),
    recompensa numeric(10,2),
    vistas integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.reportes OWNER TO postgres;

--
-- Name: respuestas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuestas (
    id uuid NOT NULL,
    reporte_id uuid NOT NULL,
    usuario_id uuid NOT NULL,
    tipo_respuesta character varying(255),
    mensaje text,
    ubicacion character varying(255),
    direccion_referencia character varying(255),
    imagenes json,
    videos json,
    verificada boolean DEFAULT false NOT NULL,
    util boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.respuestas OWNER TO postgres;

--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id character varying(255),
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id uuid NOT NULL,
    nombre character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    telefono character varying(255),
    avatar_url character varying(255),
    puntos_ayuda integer DEFAULT 0 NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    fecha_registro timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ubicacion_actual_lat numeric(10,8),
    ubicacion_actual_lng numeric(11,8),
    rol character varying(255),
    contrasena character varying(255)
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: reporte_imagenes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reporte_imagenes ALTER COLUMN id SET DEFAULT nextval('public.reporte_imagenes_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
spatie.permission.cache	a:3:{s:5:"alias";a:0:{}s:11:"permissions";a:0:{}s:5:"roles";a:0:{}}	1765740573
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nombre, icono, color, descripcion, activo, created_at) FROM stdin;
f098a0e3-07aa-46bf-8bd1-46f460cb54a6	Personas	person	#FF6B6B	Personas perdidas o desaparecidas	t	2025-11-28 15:38:42
2e623894-ecf5-4d93-a0a0-2e03265ded4c	Mascotas	pets	#4ECDC4	Perros, gatos y otras mascotas	t	2025-11-28 15:38:42
\.


--
-- Data for Name: configuracion_sistema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuracion_sistema (clave, valor, descripcion, tipo, updated_at, created_at) FROM stdin;
\.


--
-- Data for Name: cuadrante_barrios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuadrante_barrios (id, cuadrante_id, nombre_barrio, created_at) FROM stdin;
019ad11f-967f-70d9-b79f-485fd9eab259	019ad11f-93c9-7099-9542-88e8e959b99d	Cristo Redentor A1	2025-11-29 19:38:19
019ad11f-98cf-7339-a42a-f8c13c1f6997	019ad11f-93c9-7099-9542-88e8e959b99d	Oeste A1	2025-11-29 19:38:20
019ad11f-9aac-7322-9bab-29436c9fc928	019ad11f-93c9-7099-9542-88e8e959b99d	Centro A1	2025-11-29 19:38:20
019ad11f-a0bc-73e9-a048-ed247439b002	019ad11f-9edc-71c7-9d9b-8da1371ca5e0	Norte A2	2025-11-29 19:38:22
019ad11f-a2f6-7229-a853-a07069c8031e	019ad11f-9edc-71c7-9d9b-8da1371ca5e0	Equipetrol A2	2025-11-29 19:38:22
019ad11f-a541-7042-8ca1-ff4cbfda4f4d	019ad11f-9edc-71c7-9d9b-8da1371ca5e0	Hamacas A2	2025-11-29 19:38:23
019ad11f-ab41-725c-961e-e96ed3918cb8	019ad11f-a8e7-72bf-9c65-32ab9bb6d571	Las Palmas A3	2025-11-29 19:38:24
019ad11f-ad1e-7193-bb44-c99f56075fcb	019ad11f-a8e7-72bf-9c65-32ab9bb6d571	SatÃ©lite Norte A3	2025-11-29 19:38:25
019ad11f-af0d-7197-9d4c-fb7b388b9f02	019ad11f-a8e7-72bf-9c65-32ab9bb6d571	UrbarÃ­ A3	2025-11-29 19:38:25
019ad11f-b1f3-7161-9346-869013e88731	019ad11f-a8e7-72bf-9c65-32ab9bb6d571	Los Pozos A3	2025-11-29 19:38:26
019ad11f-b888-7194-b397-211557a0374d	019ad11f-b649-7172-afe8-bef6f2865a80	Palmasola A4	2025-11-29 19:38:28
019ad11f-ba66-70ab-81ae-6e1b8333334b	019ad11f-b649-7172-afe8-bef6f2865a80	Centro A4	2025-11-29 19:38:28
019ad11f-bca5-7139-a366-53c944d4bfb4	019ad11f-b649-7172-afe8-bef6f2865a80	Plan 3000 A4	2025-11-29 19:38:29
019ad11f-c350-72a3-a488-0790cb01263f	019ad11f-c0db-72b1-804d-1df0b91e01a0	Palmasola A5	2025-11-29 19:38:31
019ad11f-c533-709d-89fc-d0f1df803c16	019ad11f-c0db-72b1-804d-1df0b91e01a0	Oeste A5	2025-11-29 19:38:31
019ad11f-ce5f-7134-bbef-91f566f97f8a	019ad11f-cc1d-73b3-8864-9c9ea2d7299b	Oeste A6	2025-11-29 19:38:33
019ad11f-d03c-736f-8084-cfd857474853	019ad11f-cc1d-73b3-8864-9c9ea2d7299b	Centro A6	2025-11-29 19:38:34
019ad11f-d234-7334-99c4-5bb12d4f6d00	019ad11f-cc1d-73b3-8864-9c9ea2d7299b	UrbanizaciÃ³n A6	2025-11-29 19:38:34
019ad11f-d82e-73b2-8e0a-2bbe1f48ac65	019ad11f-d653-71d2-be73-0a87e453cf87	Oeste A7	2025-11-29 19:38:36
019ad11f-da68-731e-9d68-fe5e86f1265d	019ad11f-d653-71d2-be73-0a87e453cf87	Sur A7	2025-11-29 19:38:37
019ad11f-e08f-7388-a456-0f5dd5305767	019ad11f-de3b-7354-b4cd-58f5f42ea670	Norte A8	2025-11-29 19:38:38
019ad11f-e281-71c5-81c7-d09a84f98f3b	019ad11f-de3b-7354-b4cd-58f5f42ea670	UrbarÃ­ A8	2025-11-29 19:38:39
019ad11f-e4d4-7227-88b4-c48e9250e44e	019ad11f-de3b-7354-b4cd-58f5f42ea670	Villa A8	2025-11-29 19:38:39
019ad11f-eaea-7051-bd0d-abb61408c22b	019ad11f-e910-7015-af14-50722fd9eeeb	SatÃ©lite Norte A9	2025-11-29 19:38:41
019ad11f-ecde-7377-b7e6-59a9707a714f	019ad11f-e910-7015-af14-50722fd9eeeb	Villa A9	2025-11-29 19:38:41
019ad11f-f103-738c-a210-356bff0b7a2b	019ad11f-e910-7015-af14-50722fd9eeeb	Oeste A9	2025-11-29 19:38:42
019ad11f-f784-7346-997d-5226c11f33e8	019ad11f-f536-7145-b0cf-778bcebcbfdf	UrbanizaciÃ³n A10	2025-11-29 19:38:44
019ad11f-f9c1-73b1-a7fc-9f122bab21e9	019ad11f-f536-7145-b0cf-778bcebcbfdf	Equipetrol A10	2025-11-29 19:38:45
019ad11f-fba6-7130-b378-d725719945d0	019ad11f-f536-7145-b0cf-778bcebcbfdf	UrbarÃ­ A10	2025-11-29 19:38:45
019ad11f-fd9b-72b5-9610-3f46830c778b	019ad11f-f536-7145-b0cf-778bcebcbfdf	Palmasola A10	2025-11-29 19:38:46
019ad120-043a-7149-bb59-62fcc64819c9	019ad120-01ee-71a8-b7bd-fdee54895cad	SatÃ©lite Norte A11	2025-11-29 19:38:47
019ad120-062f-727a-8ae7-4977ef1ef3d0	019ad120-01ee-71a8-b7bd-fdee54895cad	UrbarÃ­ A11	2025-11-29 19:38:48
019ad120-0869-7277-a1cb-62e185dc699d	019ad120-01ee-71a8-b7bd-fdee54895cad	Hamacas A11	2025-11-29 19:38:48
019ad120-11b6-73fc-bdd4-e8838faf8a46	019ad120-0fb1-7167-be1f-77d3a197244b	UrbanizaciÃ³n A12	2025-11-29 19:38:51
019ad120-13ff-7195-ad86-49a8d51c14ad	019ad120-0fb1-7167-be1f-77d3a197244b	Palmasola A12	2025-11-29 19:38:51
019ad120-15d6-7280-8f83-0fd3637e41cc	019ad120-0fb1-7167-be1f-77d3a197244b	Centro A12	2025-11-29 19:38:52
019ad120-1de2-73e9-8807-cf2f375728f8	019ad120-1bdf-7263-abb3-59bb576df920	Este A13	2025-11-29 19:38:54
019ad120-202b-7254-aa25-8fa394c02f50	019ad120-1bdf-7263-abb3-59bb576df920	Norte A13	2025-11-29 19:38:54
019ad120-2654-7222-ab33-b77a38cbcc3c	019ad120-23e8-73de-a677-4c5185af27f0	Las Palmas A14	2025-11-29 19:38:56
019ad120-2848-71d8-b554-471bf56b6d44	019ad120-23e8-73de-a677-4c5185af27f0	Este A14	2025-11-29 19:38:56
019ad120-2a8f-7273-aff9-cc0ffe0ea562	019ad120-23e8-73de-a677-4c5185af27f0	Villa A14	2025-11-29 19:38:57
019ad120-2c73-730e-aa2f-bfd9fc278252	019ad120-23e8-73de-a677-4c5185af27f0	UrbarÃ­ A14	2025-11-29 19:38:58
019ad120-32fa-7304-a189-326a249c12f0	019ad120-3110-7345-a11e-ff591319d967	Los Pozos B1	2025-11-29 19:38:59
019ad120-355a-7116-b93c-a332bcddebd5	019ad120-3110-7345-a11e-ff591319d967	Norte B1	2025-11-29 19:39:00
019ad120-3740-70f3-b526-d9f17324bf3b	019ad120-3110-7345-a11e-ff591319d967	Sur B1	2025-11-29 19:39:00
019ad120-3b5a-73af-8500-294dc1a5274c	019ad120-3110-7345-a11e-ff591319d967	UrbanizaciÃ³n B1	2025-11-29 19:39:01
019ad120-4231-7055-afc0-9b8e9981876a	019ad120-3fea-70a3-ac08-471dd0060eaf	Oeste B2	2025-11-29 19:39:03
019ad120-4424-7112-a932-9344929fbd51	019ad120-3fea-70a3-ac08-471dd0060eaf	Villa B2	2025-11-29 19:39:04
019ad120-4688-7392-8396-e81c51c5c7eb	019ad120-3fea-70a3-ac08-471dd0060eaf	Cristo Redentor B2	2025-11-29 19:39:04
019ad120-487d-724b-a83a-78e42f5ec640	019ad120-3fea-70a3-ac08-471dd0060eaf	Centro B2	2025-11-29 19:39:05
019ad120-4ad1-7391-b96e-479535938ea5	019ad120-3fea-70a3-ac08-471dd0060eaf	Este B2	2025-11-29 19:39:05
019ad120-50e7-7142-b805-63e3b5268340	019ad120-4f05-7354-abcf-2e4d969da2ee	Centro B3	2025-11-29 19:39:07
019ad120-52c2-70e4-986f-49b60e52e408	019ad120-4f05-7354-abcf-2e4d969da2ee	Norte B3	2025-11-29 19:39:07
019ad120-54fd-7235-b0bb-e771b49e7c4a	019ad120-4f05-7354-abcf-2e4d969da2ee	SatÃ©lite Norte B3	2025-11-29 19:39:08
019ad120-56d7-7387-824e-11b2940c1fa8	019ad120-4f05-7354-abcf-2e4d969da2ee	Palmasola B3	2025-11-29 19:39:08
019ad120-5db6-739e-86ba-f430628ba863	019ad120-5b6e-7228-845f-00433a02d2d5	Plan 3000 B4	2025-11-29 19:39:10
019ad120-5fa3-737c-be62-0560c57bb6db	019ad120-5b6e-7228-845f-00433a02d2d5	Palmasola B4	2025-11-29 19:39:11
019ad120-65d1-714d-8807-a26fcd101cd0	019ad120-63cd-7181-a99a-aa451f5db3d8	Los Pozos B5	2025-11-29 19:39:12
019ad120-684e-7325-b51c-1525d3fc2b01	019ad120-63cd-7181-a99a-aa451f5db3d8	Centro B5	2025-11-29 19:39:13
019ad120-6aab-703b-a2e5-3d1d232d0912	019ad120-63cd-7181-a99a-aa451f5db3d8	Este B5	2025-11-29 19:39:13
019ad120-6d6c-7107-a9a2-dfde59b7ab54	019ad120-63cd-7181-a99a-aa451f5db3d8	Hamacas B5	2025-11-29 19:39:14
019ad120-6fc9-71ef-84ac-8244648dda4a	019ad120-63cd-7181-a99a-aa451f5db3d8	Villa B5	2025-11-29 19:39:15
019ad120-7672-70af-bb12-9fd0a13ebebc	019ad120-7410-7312-80c5-c5865b70b333	Oeste B6	2025-11-29 19:39:16
019ad120-78b3-7371-a3ae-872ff24d1fc5	019ad120-7410-7312-80c5-c5865b70b333	Norte B6	2025-11-29 19:39:17
019ad120-7a95-706c-9f4e-971e6fdaf88b	019ad120-7410-7312-80c5-c5865b70b333	UrbanizaciÃ³n B6	2025-11-29 19:39:18
019ad120-81b0-7375-931c-dfd477ce466c	019ad120-7f62-70f0-8312-6a6dcf1cfd7b	Equipetrol B7	2025-11-29 19:39:19
019ad120-83a0-7247-9ca8-e525c8ba3ddf	019ad120-7f62-70f0-8312-6a6dcf1cfd7b	Centro B7	2025-11-29 19:39:20
019ad120-85ea-7056-9b4d-cadd4306770c	019ad120-7f62-70f0-8312-6a6dcf1cfd7b	Este B7	2025-11-29 19:39:20
019ad120-87c1-71eb-8548-e09e4de86e86	019ad120-7f62-70f0-8312-6a6dcf1cfd7b	Las Palmas B7	2025-11-29 19:39:21
019ad120-8ed8-70f8-aeba-3d7a41505806	019ad120-8c7d-7244-8899-50f49ae84b12	Centro B8	2025-11-29 19:39:23
019ad120-90c3-707c-b47c-414511fd214d	019ad120-8c7d-7244-8899-50f49ae84b12	Palmasola B8	2025-11-29 19:39:23
019ad120-931d-7359-ac87-2bf768aba264	019ad120-8c7d-7244-8899-50f49ae84b12	UrbanizaciÃ³n B8	2025-11-29 19:39:24
019ad120-94f3-7383-ba63-1fa200ab2e60	019ad120-8c7d-7244-8899-50f49ae84b12	Este B8	2025-11-29 19:39:24
019ad120-9ba4-717f-8549-75c31e7c4a0b	019ad120-994c-71b0-80db-73c31500fb65	Oeste B9	2025-11-29 19:39:26
019ad120-9d9d-728f-876a-1b5c76f78bd8	019ad120-994c-71b0-80db-73c31500fb65	SatÃ©lite Norte B9	2025-11-29 19:39:27
019ad120-9fe0-723e-8598-0cc95cbfaa6d	019ad120-994c-71b0-80db-73c31500fb65	Las Palmas B9	2025-11-29 19:39:27
019ad120-a614-7095-b011-2a3fa4dce398	019ad120-a3c3-71da-9668-07a31c600b03	Los Pozos B10	2025-11-29 19:39:29
019ad120-a80c-7067-82f9-978d71f0fc2d	019ad120-a3c3-71da-9668-07a31c600b03	Este B10	2025-11-29 19:39:29
019ad120-aa7a-7220-91da-244fb712d259	019ad120-a3c3-71da-9668-07a31c600b03	Hamacas B10	2025-11-29 19:39:30
019ad120-ac6e-720b-86d1-e46fb09f490f	019ad120-a3c3-71da-9668-07a31c600b03	Cristo Redentor B10	2025-11-29 19:39:30
019ad120-b30a-71ea-bce9-39278a4929de	019ad120-b0b5-73ef-8328-5bce7948cd19	Este B11	2025-11-29 19:39:32
019ad120-b528-728a-8452-fc760f2a6a8e	019ad120-b0b5-73ef-8328-5bce7948cd19	Palmasola B11	2025-11-29 19:39:33
019ad120-b772-72f4-a775-9e2402865311	019ad120-b0b5-73ef-8328-5bce7948cd19	UrbanizaciÃ³n B11	2025-11-29 19:39:33
019ad120-bdc5-7010-951f-fda1c1c3c938	019ad120-bbd6-72dd-a2c4-ccadb90be88f	SatÃ©lite Norte B12	2025-11-29 19:39:35
019ad120-c010-70ba-a29a-639b31b53e45	019ad120-bbd6-72dd-a2c4-ccadb90be88f	Plan 3000 B12	2025-11-29 19:39:35
019ad120-c1ff-709e-93ef-4ad6524ab791	019ad120-bbd6-72dd-a2c4-ccadb90be88f	Oeste B12	2025-11-29 19:39:36
019ad120-c883-7219-9dd1-d5c6865f924a	019ad120-c642-70ab-a243-63d667c9ccd0	Este B13	2025-11-29 19:39:37
019ad120-ca7a-7114-bef2-3f1aa59ed1f5	019ad120-c642-70ab-a243-63d667c9ccd0	Oeste B13	2025-11-29 19:39:38
019ad120-cc63-70fa-9dab-7ea94dec008e	019ad120-c642-70ab-a243-63d667c9ccd0	Villa B13	2025-11-29 19:39:38
019ad120-cef2-70b0-80b0-74058769930c	019ad120-c642-70ab-a243-63d667c9ccd0	Equipetrol B13	2025-11-29 19:39:39
019ad120-d529-72ef-8d2c-c6a01ef66542	019ad120-d2b1-724a-b4b7-bb8b9492bb3c	UrbanizaciÃ³n B14	2025-11-29 19:39:41
019ad120-d732-7399-a93a-910b536caa76	019ad120-d2b1-724a-b4b7-bb8b9492bb3c	Los Pozos B14	2025-11-29 19:39:41
019ad120-ddd1-734a-9934-c7e577f4a8bb	019ad120-db91-705e-9ffc-0252e97b2bc1	Equipetrol C1	2025-11-29 19:39:43
019ad120-dfbd-7147-a697-f3fa53a787b5	019ad120-db91-705e-9ffc-0252e97b2bc1	UrbarÃ­ C1	2025-11-29 19:39:43
019ad120-e5e0-716c-adde-cc4da9ca06e9	019ad120-e3da-7363-95f9-9a5fc1920ed5	Norte C2	2025-11-29 19:39:45
019ad120-eb59-73e5-b264-b7e12d64bb19	019ad120-e3da-7363-95f9-9a5fc1920ed5	Hamacas C2	2025-11-29 19:39:46
019ad120-eda3-7360-8cc5-df93ce54e8b8	019ad120-e3da-7363-95f9-9a5fc1920ed5	UrbarÃ­ C2	2025-11-29 19:39:47
019ad120-ef93-731f-93f6-9d05f2c35e2b	019ad120-e3da-7363-95f9-9a5fc1920ed5	Los Pozos C2	2025-11-29 19:39:47
019ad120-f58a-72ec-a8b1-241f76da3502	019ad120-f3ad-73a5-9143-ba8f60034202	Sur C3	2025-11-29 19:39:49
019ad120-f7c0-7085-a5a3-eac0f102d820	019ad120-f3ad-73a5-9143-ba8f60034202	Hamacas C3	2025-11-29 19:39:50
019ad120-f992-710c-825a-4f9b71202018	019ad120-f3ad-73a5-9143-ba8f60034202	UrbanizaciÃ³n C3	2025-11-29 19:39:50
019ad120-fbde-7237-86ac-7bceb705b867	019ad120-f3ad-73a5-9143-ba8f60034202	SatÃ©lite Norte C3	2025-11-29 19:39:51
019ad120-fe2e-71a5-9567-e128cee0293b	019ad120-f3ad-73a5-9143-ba8f60034202	Equipetrol C3	2025-11-29 19:39:51
019ad121-0485-7312-b9c4-b3d6a27bb3b9	019ad121-028e-73be-bb89-01679a2aff90	UrbanizaciÃ³n C4	2025-11-29 19:39:53
019ad121-06b8-73e2-a38d-fb31d8f4c09e	019ad121-028e-73be-bb89-01679a2aff90	Los Pozos C4	2025-11-29 19:39:53
019ad121-0a90-71a1-a938-84062d7f113d	019ad121-028e-73be-bb89-01679a2aff90	Oeste C4	2025-11-29 19:39:54
019ad121-115f-7297-bbb3-aa441f1ea900	019ad121-0ef0-7224-9b3e-eb3f7a5eecf1	Este C5	2025-11-29 19:39:56
019ad121-13b4-73b8-98fb-f3ad77074a2d	019ad121-0ef0-7224-9b3e-eb3f7a5eecf1	Equipetrol C5	2025-11-29 19:39:57
019ad121-1628-706d-967c-198152de37d1	019ad121-0ef0-7224-9b3e-eb3f7a5eecf1	Oeste C5	2025-11-29 19:39:57
019ad121-1814-7208-9956-1ae90dda45e2	019ad121-0ef0-7224-9b3e-eb3f7a5eecf1	Villa C5	2025-11-29 19:39:58
019ad121-1e46-72cd-b0ce-8e79a2bfc5c7	019ad121-1c62-7274-8d0d-540878d127f5	UrbarÃ­ C6	2025-11-29 19:39:59
019ad121-2094-7050-87a4-765689a791b9	019ad121-1c62-7274-8d0d-540878d127f5	Centro C6	2025-11-29 19:40:00
019ad121-26de-7054-8638-36c010d5f2a8	019ad121-24fd-731b-b538-e23c7822e1b5	SatÃ©lite Norte C7	2025-11-29 19:40:02
019ad121-2968-702a-8200-ecd5d6ad1323	019ad121-24fd-731b-b538-e23c7822e1b5	Los Pozos C7	2025-11-29 19:40:02
019ad121-2b55-73c6-a803-a825df814b6a	019ad121-24fd-731b-b538-e23c7822e1b5	Cristo Redentor C7	2025-11-29 19:40:03
019ad121-2da7-710c-a903-58628ad625ee	019ad121-24fd-731b-b538-e23c7822e1b5	Norte C7	2025-11-29 19:40:03
019ad121-35dc-721b-a700-71145fb94a92	019ad121-33f4-71e0-9cd5-fccd55a73d43	Centro C8	2025-11-29 19:40:05
019ad121-3a74-7332-a56d-84b6b38d6a1b	019ad121-33f4-71e0-9cd5-fccd55a73d43	Norte C8	2025-11-29 19:40:07
019ad121-3cc5-72dc-9a3b-a3996d88a463	019ad121-33f4-71e0-9cd5-fccd55a73d43	Palmasola C8	2025-11-29 19:40:07
019ad121-42dc-71f2-b381-a5210c81cdaa	019ad121-4096-7359-9d9b-521c6c6889aa	Plan 3000 C9	2025-11-29 19:40:09
019ad121-46ab-7267-b20e-b294588470b3	019ad121-4096-7359-9d9b-521c6c6889aa	Sur C9	2025-11-29 19:40:10
019ad121-4f17-70da-9220-753afd728b97	019ad121-4d2d-7201-937e-0164ae9adde8	Norte C10	2025-11-29 19:40:12
019ad121-533c-70f3-a054-9b2015c29da8	019ad121-4d2d-7201-937e-0164ae9adde8	Oeste C10	2025-11-29 19:40:13
019ad121-5522-73c6-a905-7aa486ec966f	019ad121-4d2d-7201-937e-0164ae9adde8	Palmasola C10	2025-11-29 19:40:13
019ad121-5bb3-7300-b83c-f851f3a32fcd	019ad121-59af-7282-8874-008208d4b228	Las Palmas C11	2025-11-29 19:40:15
019ad121-5e09-7225-96be-767b38224816	019ad121-59af-7282-8874-008208d4b228	Los Pozos C11	2025-11-29 19:40:16
019ad121-5fef-7144-aea5-4f125d633e61	019ad121-59af-7282-8874-008208d4b228	SatÃ©lite Norte C11	2025-11-29 19:40:16
019ad121-61f3-73b7-badd-21fee144d0a7	019ad121-59af-7282-8874-008208d4b228	Sur C11	2025-11-29 19:40:17
019ad121-643f-72a6-8f1f-d492c7207ec9	019ad121-59af-7282-8874-008208d4b228	Cristo Redentor C11	2025-11-29 19:40:17
019ad121-6a87-73b6-8ea8-10b005f360a7	019ad121-689e-736e-8f24-3adac30d5ec6	Este C12	2025-11-29 19:40:19
019ad121-6c6a-7366-8752-44c6398c8a08	019ad121-689e-736e-8f24-3adac30d5ec6	Equipetrol C12	2025-11-29 19:40:19
019ad121-72e0-709f-8041-c56705f8520b	019ad121-70a3-707e-8991-7a00f2401c2f	Este C13	2025-11-29 19:40:21
019ad121-74d4-7294-bba7-2d00577bb8ff	019ad121-70a3-707e-8991-7a00f2401c2f	Centro C13	2025-11-29 19:40:22
019ad121-7751-7270-b3c9-f605beedc0f0	019ad121-70a3-707e-8991-7a00f2401c2f	Palmasola C13	2025-11-29 19:40:22
019ad121-7d5b-71e9-a452-e695b7ffbfda	019ad121-7b14-7129-a192-cfbbd05f9d3f	Norte C14	2025-11-29 19:40:24
019ad121-7f42-71d3-81e6-7dd04d96948e	019ad121-7b14-7129-a192-cfbbd05f9d3f	Villa C14	2025-11-29 19:40:24
019ad121-819d-730f-889e-66cf24c29961	019ad121-7b14-7129-a192-cfbbd05f9d3f	SatÃ©lite Norte C14	2025-11-29 19:40:25
019ad121-87bb-719c-9df7-ad5eabbac69b	019ad121-85cd-7216-bd0a-b89abcecac4d	UrbanizaciÃ³n D1	2025-11-29 19:40:26
019ad121-8a15-733b-91b5-ad86b09e7483	019ad121-85cd-7216-bd0a-b89abcecac4d	Centro D1	2025-11-29 19:40:27
019ad121-8c59-72f9-afef-9590a1e03fd2	019ad121-85cd-7216-bd0a-b89abcecac4d	SatÃ©lite Norte D1	2025-11-29 19:40:28
019ad121-8e4a-73db-9158-3c2f3d583ca9	019ad121-85cd-7216-bd0a-b89abcecac4d	Norte D1	2025-11-29 19:40:28
019ad121-9030-7187-b632-8af6d0beab40	019ad121-85cd-7216-bd0a-b89abcecac4d	Sur D1	2025-11-29 19:40:29
019ad121-974f-700b-958f-ce4a5aea6f37	019ad121-948e-72ba-a607-c447d0f7142c	SatÃ©lite Norte D2	2025-11-29 19:40:30
019ad121-99ea-72ea-add2-e9d0590a1f4b	019ad121-948e-72ba-a607-c447d0f7142c	Centro D2	2025-11-29 19:40:31
019ad121-9be4-729b-85ff-3f46ed6a9e99	019ad121-948e-72ba-a607-c447d0f7142c	Sur D2	2025-11-29 19:40:32
019ad121-a028-72c8-8494-5f56a7dc809e	019ad121-948e-72ba-a607-c447d0f7142c	Este D2	2025-11-29 19:40:33
019ad121-a61d-712a-bf83-dea40727e4b8	019ad121-a42b-734e-8a92-5c60486b1443	Este D3	2025-11-29 19:40:34
019ad121-aaaf-7041-bf46-b86973221d23	019ad121-a42b-734e-8a92-5c60486b1443	Cristo Redentor D3	2025-11-29 19:40:35
019ad121-b17c-7106-a709-6ef594b24471	019ad121-af1c-7119-a214-86de277bcffe	Plan 3000 D4	2025-11-29 19:40:37
019ad121-b36b-701d-9592-d99631abe025	019ad121-af1c-7119-a214-86de277bcffe	Cristo Redentor D4	2025-11-29 19:40:38
019ad121-ba30-718e-b90a-218b9a5d8357	019ad121-b7d1-7159-aadb-4708fabc0883	Equipetrol D5	2025-11-29 19:40:39
019ad121-bc31-7186-9979-52ed9aa38271	019ad121-b7d1-7159-aadb-4708fabc0883	SatÃ©lite Norte D5	2025-11-29 19:40:40
019ad121-be9f-722f-a391-a56d854cb563	019ad121-b7d1-7159-aadb-4708fabc0883	UrbarÃ­ D5	2025-11-29 19:40:40
019ad121-c08c-7140-a91b-a2fe509cd876	019ad121-b7d1-7159-aadb-4708fabc0883	Palmasola D5	2025-11-29 19:40:41
019ad121-c2e5-730b-95cd-9a810323e9bb	019ad121-b7d1-7159-aadb-4708fabc0883	Hamacas D5	2025-11-29 19:40:42
019ad121-c903-7194-8867-6dc3a49e30b7	019ad121-c71c-7160-8f1f-76bb7be2493f	Oeste D6	2025-11-29 19:40:43
019ad121-cafd-7108-ba56-498d3929e3c6	019ad121-c71c-7160-8f1f-76bb7be2493f	Plan 3000 D6	2025-11-29 19:40:44
019ad121-cd57-714b-9d4c-a91d4cae37d7	019ad121-c71c-7160-8f1f-76bb7be2493f	SatÃ©lite Norte D6	2025-11-29 19:40:44
019ad121-cf4b-72f3-8526-17bab9442a3a	019ad121-c71c-7160-8f1f-76bb7be2493f	Norte D6	2025-11-29 19:40:45
019ad121-d186-7307-92b2-15a634f89deb	019ad121-c71c-7160-8f1f-76bb7be2493f	UrbarÃ­ D6	2025-11-29 19:40:45
019ad121-d7fa-70b4-8cff-60dc83e24b4e	019ad121-d5f5-73bf-9102-8c3ea8bf7f7d	Cristo Redentor D7	2025-11-29 19:40:47
019ad121-da40-7235-97d7-1257fe1cddfc	019ad121-d5f5-73bf-9102-8c3ea8bf7f7d	Centro D7	2025-11-29 19:40:48
019ad121-dc23-7018-a4eb-f30187ecbf01	019ad121-d5f5-73bf-9102-8c3ea8bf7f7d	Los Pozos D7	2025-11-29 19:40:48
019ad121-de00-720f-9e96-983bf73b84ce	019ad121-d5f5-73bf-9102-8c3ea8bf7f7d	Norte D7	2025-11-29 19:40:49
019ad121-e40b-7336-a991-6e2b7dcc9cf5	019ad121-e23b-7008-82e9-9c5a6dc48c65	Centro D8	2025-11-29 19:40:50
019ad121-e652-71e8-a83b-83fbdb740234	019ad121-e23b-7008-82e9-9c5a6dc48c65	Equipetrol D8	2025-11-29 19:40:51
019ad121-e823-7350-8c9c-15b025b3490a	019ad121-e23b-7008-82e9-9c5a6dc48c65	Este D8	2025-11-29 19:40:51
019ad121-ef4e-7058-9808-9a8549cd4e1d	019ad121-ecf8-739c-97c0-49a1e1a0dd5e	Villa D9	2025-11-29 19:40:53
019ad121-f19a-71f5-902b-eb031a69c46d	019ad121-ecf8-739c-97c0-49a1e1a0dd5e	Norte D9	2025-11-29 19:40:54
019ad121-f7cd-7320-b8f4-5267868da15c	019ad121-f56d-7311-bb95-5f8314c30d02	Los Pozos D10	2025-11-29 19:40:55
019ad121-f9b8-7190-9a0a-906952aab846	019ad121-f56d-7311-bb95-5f8314c30d02	UrbanizaciÃ³n D10	2025-11-29 19:40:56
019ad121-fc26-7249-806a-4212c11cb624	019ad121-f56d-7311-bb95-5f8314c30d02	Centro D10	2025-11-29 19:40:56
019ad121-fe1a-708f-ab65-6781cebe6149	019ad121-f56d-7311-bb95-5f8314c30d02	Villa D10	2025-11-29 19:40:57
019ad122-04ae-703c-91aa-9b9fbca7b9dd	019ad122-025d-71d3-badd-2acc9285dd06	UrbanizaciÃ³n D11	2025-11-29 19:40:58
019ad122-068f-725f-82d0-c021ffd2d7ed	019ad122-025d-71d3-badd-2acc9285dd06	Sur D11	2025-11-29 19:40:59
019ad122-0873-713f-ab7a-167c1546e737	019ad122-025d-71d3-badd-2acc9285dd06	Equipetrol D11	2025-11-29 19:40:59
019ad122-0f76-73ce-9926-8e99206a1b31	019ad122-0d0d-7200-94cc-b2cc9068f0e2	Palmasola D12	2025-11-29 19:41:01
019ad122-1162-7249-a877-c317d9939da2	019ad122-0d0d-7200-94cc-b2cc9068f0e2	Centro D12	2025-11-29 19:41:02
019ad122-1447-7092-b4bd-cd1a719c3d22	019ad122-0d0d-7200-94cc-b2cc9068f0e2	Cristo Redentor D12	2025-11-29 19:41:02
019ad122-16b7-70e8-ad23-d6feeebbf867	019ad122-0d0d-7200-94cc-b2cc9068f0e2	Plan 3000 D12	2025-11-29 19:41:03
019ad122-1f8b-7119-8cf1-f580b6967d46	019ad122-1cc5-726f-89d2-bcbf49aee788	Este D13	2025-11-29 19:41:05
019ad122-2246-72e3-ad5c-0a42bf1648be	019ad122-1cc5-726f-89d2-bcbf49aee788	Palmasola D13	2025-11-29 19:41:06
019ad122-24a2-7378-beca-38662d36a507	019ad122-1cc5-726f-89d2-bcbf49aee788	Villa D13	2025-11-29 19:41:07
019ad122-2906-7298-9f5b-f1bb4cc1f526	019ad122-1cc5-726f-89d2-bcbf49aee788	Los Pozos D13	2025-11-29 19:41:08
019ad122-2f58-7080-ace5-8fabc749d756	019ad122-2d6e-739a-95ed-d091372687c9	Cristo Redentor D14	2025-11-29 19:41:09
019ad122-319f-722f-8098-df1c849f27cf	019ad122-2d6e-739a-95ed-d091372687c9	SatÃ©lite Norte D14	2025-11-29 19:41:10
019ad122-3393-731f-8d5e-dcba39ae6288	019ad122-2d6e-739a-95ed-d091372687c9	Plan 3000 D14	2025-11-29 19:41:10
019ad122-359e-737f-b3b4-b4f99e072e49	019ad122-2d6e-739a-95ed-d091372687c9	Norte D14	2025-11-29 19:41:11
019ad122-3cc7-71c6-923d-aae8f19d823f	019ad122-39eb-72af-a1e1-d81066fe703f	Sur E1	2025-11-29 19:41:13
019ad122-3f1e-707d-8691-5d2ef3b101cc	019ad122-39eb-72af-a1e1-d81066fe703f	Oeste E1	2025-11-29 19:41:13
019ad122-410a-7274-b84e-607c7a704197	019ad122-39eb-72af-a1e1-d81066fe703f	Plan 3000 E1	2025-11-29 19:41:14
019ad122-4365-73cc-835d-cbe51a03ca59	019ad122-39eb-72af-a1e1-d81066fe703f	Equipetrol E1	2025-11-29 19:41:14
019ad122-4994-7304-9829-83140d7a1bb6	019ad122-4798-7081-b1d4-5b66fc5d9f70	UrbarÃ­ E2	2025-11-29 19:41:16
019ad122-4bd8-727d-a6a4-f17fe3d8c86c	019ad122-4798-7081-b1d4-5b66fc5d9f70	Centro E2	2025-11-29 19:41:17
019ad122-4dc9-70dd-80fd-9333b364d455	019ad122-4798-7081-b1d4-5b66fc5d9f70	Equipetrol E2	2025-11-29 19:41:17
019ad122-5012-73cc-ac86-d830f7b55437	019ad122-4798-7081-b1d4-5b66fc5d9f70	UrbanizaciÃ³n E2	2025-11-29 19:41:18
019ad122-5695-7312-b31d-d243a21c37e7	019ad122-544b-7212-850f-1196c2092b30	Equipetrol E3	2025-11-29 19:41:19
019ad122-588f-708d-923a-1ab17dea7300	019ad122-544b-7212-850f-1196c2092b30	Palmasola E3	2025-11-29 19:41:20
019ad122-5aea-70fd-a62b-748f47459066	019ad122-544b-7212-850f-1196c2092b30	Oeste E3	2025-11-29 19:41:21
019ad122-5ead-7119-98dc-75ff8a8c876a	019ad122-544b-7212-850f-1196c2092b30	Norte E3	2025-11-29 19:41:21
019ad122-64d0-72e7-9078-025f4042b5c6	019ad122-62de-705f-ae1e-93d0b9a0dfff	Oeste E4	2025-11-29 19:41:23
019ad122-670a-7069-aeb0-5332418a249f	019ad122-62de-705f-ae1e-93d0b9a0dfff	Equipetrol E4	2025-11-29 19:41:24
019ad122-68eb-72a1-a29b-2ac23052920c	019ad122-62de-705f-ae1e-93d0b9a0dfff	Centro E4	2025-11-29 19:41:24
019ad122-6abf-73d2-b653-8f1c100e8acf	019ad122-62de-705f-ae1e-93d0b9a0dfff	Plan 3000 E4	2025-11-29 19:41:25
019ad122-714a-73ba-8a6c-b51c1d05b63d	019ad122-6efc-70cb-b36b-31828140b288	Palmasola E5	2025-11-29 19:41:26
019ad122-7314-73c5-b39a-13fbc65fc41a	019ad122-6efc-70cb-b36b-31828140b288	Hamacas E5	2025-11-29 19:41:27
019ad122-7953-7076-aed2-dbfe41e3773c	019ad122-7774-71e3-8e5a-8aeb8771701b	UrbarÃ­ E6	2025-11-29 19:41:28
019ad122-7ba8-7250-871a-f86707a7894e	019ad122-7774-71e3-8e5a-8aeb8771701b	Este E6	2025-11-29 19:41:29
019ad122-7f61-71d5-a7d2-3b74262a9103	019ad122-7774-71e3-8e5a-8aeb8771701b	Equipetrol E6	2025-11-29 19:41:30
019ad122-8632-7157-98c1-7e0a5be22ff1	019ad122-83ec-72d8-9871-897d12966042	Cristo Redentor E7	2025-11-29 19:41:32
019ad122-8820-7052-84c6-8a0c70cf1e12	019ad122-83ec-72d8-9871-897d12966042	UrbarÃ­ E7	2025-11-29 19:41:32
019ad122-8a6e-7064-a0fd-6fd246abf823	019ad122-83ec-72d8-9871-897d12966042	Hamacas E7	2025-11-29 19:41:33
019ad122-9184-731b-a497-e9f893fe53fa	019ad122-8f2d-73b3-b91e-11848d9794f8	Equipetrol E8	2025-11-29 19:41:34
019ad122-9362-722a-8652-c86b6f0b81da	019ad122-8f2d-73b3-b91e-11848d9794f8	Oeste E8	2025-11-29 19:41:35
019ad122-9a3c-7068-8042-7c65e14dbdbf	019ad122-97cb-71fa-8f99-336ee2270965	UrbanizaciÃ³n E9	2025-11-29 19:41:37
019ad122-9c2a-7382-8e0e-23e2d7db9a48	019ad122-97cb-71fa-8f99-336ee2270965	Equipetrol E9	2025-11-29 19:41:37
019ad122-9e93-7093-be57-f638c6fce517	019ad122-97cb-71fa-8f99-336ee2270965	Centro E9	2025-11-29 19:41:38
019ad122-a4ca-7141-b4fe-e207029b82b0	019ad122-a2d7-7356-92ca-880c8cec5874	Plan 3000 E10	2025-11-29 19:41:39
019ad122-a716-73fb-ad37-635e8643c634	019ad122-a2d7-7356-92ca-880c8cec5874	Cristo Redentor E10	2025-11-29 19:41:40
019ad122-a8f9-729b-ba3d-c3194f24438f	019ad122-a2d7-7356-92ca-880c8cec5874	Las Palmas E10	2025-11-29 19:41:40
019ad122-af50-721a-a6bd-1fef9b919d25	019ad122-ad53-733c-a6a2-8baedaff8058	Sur E11	2025-11-29 19:41:42
019ad122-b1cc-70b3-8142-e13db3539fc3	019ad122-ad53-733c-a6a2-8baedaff8058	Hamacas E11	2025-11-29 19:41:43
019ad122-b80c-724d-86aa-7aac9eafaab3	019ad122-b61d-7395-9159-42319dd91914	Norte E12	2025-11-29 19:41:44
019ad122-ba5a-72fc-ae0d-1507410349a7	019ad122-b61d-7395-9159-42319dd91914	Equipetrol E12	2025-11-29 19:41:45
019ad122-bec3-71c7-9a2b-7b2e7e679974	019ad122-b61d-7395-9159-42319dd91914	UrbarÃ­ E12	2025-11-29 19:41:46
019ad122-c0ab-7361-8bfb-2e887625be11	019ad122-b61d-7395-9159-42319dd91914	Palmasola E12	2025-11-29 19:41:47
019ad122-c78d-73ed-9b85-6f20b0e1e19c	019ad122-c529-7348-ac7e-459398a558c4	UrbanizaciÃ³n E13	2025-11-29 19:41:48
019ad122-c96f-71b0-aa3e-0cf48e6d8fbf	019ad122-c529-7348-ac7e-459398a558c4	Oeste E13	2025-11-29 19:41:49
019ad122-cb5a-71d4-8553-07d9950c42f0	019ad122-c529-7348-ac7e-459398a558c4	SatÃ©lite Norte E13	2025-11-29 19:41:49
019ad122-d1fd-7399-97b3-8c7e0eda7fee	019ad122-cf98-7071-ad9f-63c6316044cf	Plan 3000 E14	2025-11-29 19:41:51
019ad122-d3f4-7198-9e89-78ed12441b85	019ad122-cf98-7071-ad9f-63c6316044cf	Las Palmas E14	2025-11-29 19:41:51
019ad122-d658-72ea-9491-a9d8f9add435	019ad122-cf98-7071-ad9f-63c6316044cf	UrbanizaciÃ³n E14	2025-11-29 19:41:52
019ad122-d851-72e4-8215-61cfa464748c	019ad122-cf98-7071-ad9f-63c6316044cf	SatÃ©lite Norte E14	2025-11-29 19:41:53
019ad122-dacf-7382-86a8-8017242cafcd	019ad122-cf98-7071-ad9f-63c6316044cf	Equipetrol E14	2025-11-29 19:41:53
019ad122-e105-70eb-8204-e233ef7012bf	019ad122-df13-708e-a597-989a222f1789	Oeste F1	2025-11-29 19:41:55
019ad122-e305-706c-9e38-bcdf0b8991ff	019ad122-df13-708e-a597-989a222f1789	SatÃ©lite Norte F1	2025-11-29 19:41:55
019ad122-e55b-72c5-893e-fff499c08e86	019ad122-df13-708e-a597-989a222f1789	Las Palmas F1	2025-11-29 19:41:56
019ad122-e74f-71e2-af61-7e6c92585814	019ad122-df13-708e-a597-989a222f1789	Este F1	2025-11-29 19:41:56
019ad122-eeab-7069-8a01-4a0013e7a2b7	019ad122-ec50-7164-84ad-eea8c619e7cd	Equipetrol F2	2025-11-29 19:41:58
019ad122-f092-71da-9dac-a030ea154ece	019ad122-ec50-7164-84ad-eea8c619e7cd	Plan 3000 F2	2025-11-29 19:41:59
019ad122-f30f-7359-874d-24540a7a7208	019ad122-ec50-7164-84ad-eea8c619e7cd	Sur F2	2025-11-29 19:41:59
019ad122-f502-7202-ac93-ba6f5e4b3a1f	019ad122-ec50-7164-84ad-eea8c619e7cd	Centro F2	2025-11-29 19:42:00
019ad122-fb9b-713a-ac06-064eec5311bb	019ad122-f935-70a4-84e7-af226d0d011d	Centro F3	2025-11-29 19:42:02
019ad122-fe12-73a3-9757-4c95c1518233	019ad122-f935-70a4-84e7-af226d0d011d	Las Palmas F3	2025-11-29 19:42:02
019ad123-049f-7346-afa7-865451ac3ced	019ad123-02a9-73fd-8c4a-16d9996b4e0a	Centro F4	2025-11-29 19:42:04
019ad123-0684-71d5-b2c9-65057c8f9f63	019ad123-02a9-73fd-8c4a-16d9996b4e0a	Sur F4	2025-11-29 19:42:04
019ad123-08ec-722c-afa0-7c8dfe2d58a9	019ad123-02a9-73fd-8c4a-16d9996b4e0a	Los Pozos F4	2025-11-29 19:42:05
019ad123-0ad9-71fa-ad11-561778598a3e	019ad123-02a9-73fd-8c4a-16d9996b4e0a	Villa F4	2025-11-29 19:42:06
019ad123-11c1-72cd-a437-61b8f2b2bb06	019ad123-0f6f-7111-a995-5864a15b3e8e	UrbarÃ­ F5	2025-11-29 19:42:07
019ad123-13b8-70f2-ad45-547b7f612f5d	019ad123-0f6f-7111-a995-5864a15b3e8e	Hamacas F5	2025-11-29 19:42:08
019ad123-1863-715a-8ec0-9eedd698ccff	019ad123-0f6f-7111-a995-5864a15b3e8e	SatÃ©lite Norte F5	2025-11-29 19:42:09
019ad123-1ab4-724a-8743-554fbf4fcf3a	019ad123-0f6f-7111-a995-5864a15b3e8e	Palmasola F5	2025-11-29 19:42:10
019ad123-20e7-72f6-a193-588890cb0da6	019ad123-1ef7-731b-aa46-df35ec9345e7	Villa F6	2025-11-29 19:42:11
019ad123-22da-72ed-aec4-f614e877936d	019ad123-1ef7-731b-aa46-df35ec9345e7	Centro F6	2025-11-29 19:42:12
019ad123-2531-73c2-b1e8-1e10de301700	019ad123-1ef7-731b-aa46-df35ec9345e7	Cristo Redentor F6	2025-11-29 19:42:12
019ad123-28f6-7166-be05-f5310d1d0fb5	019ad123-1ef7-731b-aa46-df35ec9345e7	Norte F6	2025-11-29 19:42:13
019ad123-2f9a-7326-aa0c-63c590599452	019ad123-2d2b-730d-8a58-389ce9aaea6d	Los Pozos F7	2025-11-29 19:42:15
019ad123-3176-72e6-9320-dcd05061e5e6	019ad123-2d2b-730d-8a58-389ce9aaea6d	Cristo Redentor F7	2025-11-29 19:42:15
019ad123-37dc-7003-967c-ca85ffa026f6	019ad123-35df-718c-8488-aa0f1202135d	Norte F8	2025-11-29 19:42:17
019ad123-3a29-7259-b61e-698678b25501	019ad123-35df-718c-8488-aa0f1202135d	Cristo Redentor F8	2025-11-29 19:42:18
019ad123-3c28-72a5-b1d1-3adffa649103	019ad123-35df-718c-8488-aa0f1202135d	Villa F8	2025-11-29 19:42:18
019ad123-451c-7016-96cb-48496e169aac	019ad123-42c1-7367-b965-906b77867688	Norte F9	2025-11-29 19:42:20
019ad123-4715-723b-abf9-317e1b22ff2d	019ad123-42c1-7367-b965-906b77867688	UrbanizaciÃ³n F9	2025-11-29 19:42:21
019ad123-497f-7197-bd13-201e289e759f	019ad123-42c1-7367-b965-906b77867688	UrbarÃ­ F9	2025-11-29 19:42:22
019ad123-501d-713b-9304-a8a07b0b71ca	019ad123-4dcf-70fe-9706-42ce093c7ef9	UrbarÃ­ F10	2025-11-29 19:42:23
019ad123-52a3-7216-aac4-cbf912c6ebeb	019ad123-4dcf-70fe-9706-42ce093c7ef9	Los Pozos F10	2025-11-29 19:42:24
019ad123-58ca-7011-929a-276fc5182bb7	019ad123-56d5-7181-8d3e-e2c32ee2f9a9	UrbarÃ­ F11	2025-11-29 19:42:25
019ad123-5b28-73bf-a70d-20e81abe07c1	019ad123-56d5-7181-8d3e-e2c32ee2f9a9	Cristo Redentor F11	2025-11-29 19:42:26
019ad123-5d70-710d-b6b1-009ebb0d0020	019ad123-56d5-7181-8d3e-e2c32ee2f9a9	Los Pozos F11	2025-11-29 19:42:27
019ad123-660b-7124-96ca-0f244a65913a	019ad123-63aa-725b-9413-b8608fda48ee	Sur F12	2025-11-29 19:42:29
019ad123-6801-728a-bbcd-1cc69e1e25c3	019ad123-63aa-725b-9413-b8608fda48ee	Palmasola F12	2025-11-29 19:42:29
019ad123-6a58-7124-9a1d-265d02a0ee9d	019ad123-63aa-725b-9413-b8608fda48ee	Hamacas F12	2025-11-29 19:42:30
019ad123-6c47-7091-ba9c-329ceec0147a	019ad123-63aa-725b-9413-b8608fda48ee	Los Pozos F12	2025-11-29 19:42:30
019ad123-728c-704a-8b2d-a40940b28a1b	019ad123-7081-73a1-a438-df0f6b141b82	UrbanizaciÃ³n F13	2025-11-29 19:42:32
019ad123-74e6-7372-bd71-507a7dbdd1a3	019ad123-7081-73a1-a438-df0f6b141b82	Palmasola F13	2025-11-29 19:42:33
019ad123-76dc-70f5-9031-70974ef56183	019ad123-7081-73a1-a438-df0f6b141b82	Villa F13	2025-11-29 19:42:33
019ad123-7dd9-7390-b5bc-89ec7527e3b0	019ad123-7be2-7029-8bba-1546a2e45a47	Palmasola F14	2025-11-29 19:42:35
019ad123-7fca-70db-8271-7ca5d5fac789	019ad123-7be2-7029-8bba-1546a2e45a47	SatÃ©lite Norte F14	2025-11-29 19:42:35
019ad123-868d-72cf-9aad-c7806e40b48f	019ad123-8441-7396-a494-e0532fc4052f	SatÃ©lite Norte G1	2025-11-29 19:42:37
019ad123-887d-720c-a1e9-1e0c148870af	019ad123-8441-7396-a494-e0532fc4052f	Palmasola G1	2025-11-29 19:42:38
019ad123-8a8a-72fd-a215-dfa0d50675b3	019ad123-8441-7396-a494-e0532fc4052f	Los Pozos G1	2025-11-29 19:42:38
019ad123-9143-73e2-b77c-6b799aa9a8a0	019ad123-8f5a-72a9-8c50-2ac8b07599bc	Los Pozos G2	2025-11-29 19:42:40
019ad123-9415-73a1-9f2c-dfb88384ed27	019ad123-8f5a-72a9-8c50-2ac8b07599bc	UrbarÃ­ G2	2025-11-29 19:42:41
019ad123-9666-7233-922e-6de87d2ce286	019ad123-8f5a-72a9-8c50-2ac8b07599bc	Villa G2	2025-11-29 19:42:41
019ad123-9859-7385-b5d7-eeb51f430d1c	019ad123-8f5a-72a9-8c50-2ac8b07599bc	Centro G2	2025-11-29 19:42:42
019ad123-9aa8-7194-b211-13449eb76a04	019ad123-8f5a-72a9-8c50-2ac8b07599bc	Hamacas G2	2025-11-29 19:42:42
019ad123-a0cf-72d3-b173-7c842fd4d749	019ad123-9e73-706a-b979-d2352e7d107a	Villa G3	2025-11-29 19:42:44
019ad123-a2ac-72eb-a642-848ef47acc4a	019ad123-9e73-706a-b979-d2352e7d107a	UrbanizaciÃ³n G3	2025-11-29 19:42:44
019ad123-a478-72b0-805d-6ffcd264612c	019ad123-9e73-706a-b979-d2352e7d107a	Este G3	2025-11-29 19:42:45
019ad123-aae7-71bc-9446-70760e6eab2a	019ad123-a8a1-70a7-ba89-379e6b7a285b	Equipetrol G4	2025-11-29 19:42:47
019ad123-aefd-72ec-bdac-1556edc76be5	019ad123-a8a1-70a7-ba89-379e6b7a285b	SatÃ©lite Norte G4	2025-11-29 19:42:48
019ad123-b0f2-71aa-8c0b-b892f593c605	019ad123-a8a1-70a7-ba89-379e6b7a285b	Villa G4	2025-11-29 19:42:48
019ad123-b6f6-7042-a377-e12d7b30681e	019ad123-b516-727a-bfa8-d8b1bccfd009	Equipetrol G5	2025-11-29 19:42:50
019ad123-b932-71ff-8f6c-2beaf1c2e95b	019ad123-b516-727a-bfa8-d8b1bccfd009	Oeste G5	2025-11-29 19:42:50
019ad123-bb7f-711e-9ca0-a8af588d1923	019ad123-b516-727a-bfa8-d8b1bccfd009	Este G5	2025-11-29 19:42:51
019ad123-bd65-72d7-a645-c1794bc3800a	019ad123-b516-727a-bfa8-d8b1bccfd009	Sur G5	2025-11-29 19:42:51
019ad123-c463-7354-9805-4656b1feaaca	019ad123-c214-71a9-a6fd-28bf2b7c981f	Centro G6	2025-11-29 19:42:53
019ad123-c649-72a2-89f7-8686f37c8ba3	019ad123-c214-71a9-a6fd-28bf2b7c981f	UrbarÃ­ G6	2025-11-29 19:42:54
019ad123-cc57-7169-a765-f347e793af08	019ad123-ca79-7377-9b89-7b3eadc8f974	Centro G7	2025-11-29 19:42:55
019ad123-ce4d-73ea-8188-66eb8f3f7fc2	019ad123-ca79-7377-9b89-7b3eadc8f974	Palmasola G7	2025-11-29 19:42:56
019ad123-d0dc-71cf-bdbf-88a581158837	019ad123-ca79-7377-9b89-7b3eadc8f974	Plan 3000 G7	2025-11-29 19:42:56
019ad123-d4ea-7361-85f2-42c86c77c814	019ad123-ca79-7377-9b89-7b3eadc8f974	Equipetrol G7	2025-11-29 19:42:57
019ad123-db0a-736f-b640-93e99fa73f7f	019ad123-d923-7209-868b-884d794bd927	Sur G8	2025-11-29 19:42:59
019ad123-df28-72f3-802e-7be3e28571d0	019ad123-d923-7209-868b-884d794bd927	Este G8	2025-11-29 19:43:00
019ad123-e116-707d-b396-bc92e33c8e54	019ad123-d923-7209-868b-884d794bd927	Palmasola G8	2025-11-29 19:43:00
019ad123-ea75-71a5-9024-ee2a226e1926	019ad123-e835-7366-ae21-d54021259015	Este G9	2025-11-29 19:43:03
019ad123-ec60-70f2-b8f3-c1dfa0ac887e	019ad123-e835-7366-ae21-d54021259015	Villa G9	2025-11-29 19:43:03
019ad123-f08c-717f-b318-59f3cedd65b9	019ad123-e835-7366-ae21-d54021259015	Los Pozos G9	2025-11-29 19:43:04
019ad123-f282-72e1-8d29-437e948acde1	019ad123-e835-7366-ae21-d54021259015	Centro G9	2025-11-29 19:43:05
019ad123-f911-71aa-bcf2-ae302bbae71c	019ad123-f6c0-7057-9954-782bf5e37746	UrbarÃ­ G10	2025-11-29 19:43:07
019ad123-fb03-70db-82ab-f013fb40aaed	019ad123-f6c0-7057-9954-782bf5e37746	Este G10	2025-11-29 19:43:07
019ad123-fd08-73ca-b8d1-3c55d039df10	019ad123-f6c0-7057-9954-782bf5e37746	UrbanizaciÃ³n G10	2025-11-29 19:43:08
019ad123-ffea-70b3-9c3e-06c322ced7fe	019ad123-f6c0-7057-9954-782bf5e37746	Centro G10	2025-11-29 19:43:08
019ad124-0704-7384-bfe7-59f7bad49a33	019ad124-04ad-71bc-926b-b85ec1dd015f	Oeste G11	2025-11-29 19:43:10
019ad124-08e8-71a8-9a4c-691c0b137797	019ad124-04ad-71bc-926b-b85ec1dd015f	Palmasola G11	2025-11-29 19:43:11
019ad124-0add-714a-b659-f58a56149dcd	019ad124-04ad-71bc-926b-b85ec1dd015f	SatÃ©lite Norte G11	2025-11-29 19:43:11
019ad124-0d2a-73d8-a5b3-7800da577619	019ad124-04ad-71bc-926b-b85ec1dd015f	Villa G11	2025-11-29 19:43:12
019ad124-1522-7363-b050-fc4fbaf428a8	019ad124-1338-72aa-8a04-c68c8743c41b	Este G12	2025-11-29 19:43:14
019ad124-17c8-7179-b5b2-c3d8fa3e58f5	019ad124-1338-72aa-8a04-c68c8743c41b	Las Palmas G12	2025-11-29 19:43:14
019ad124-19f9-7039-8bb9-92a53c23b930	019ad124-1338-72aa-8a04-c68c8743c41b	Centro G12	2025-11-29 19:43:15
019ad124-1bd1-729f-a6a4-004f53ad8ac0	019ad124-1338-72aa-8a04-c68c8743c41b	Los Pozos G12	2025-11-29 19:43:15
019ad124-1dc8-70fc-ba89-451445211f55	019ad124-1338-72aa-8a04-c68c8743c41b	Hamacas G12	2025-11-29 19:43:16
019ad124-244c-72df-991f-5d042b127a4f	019ad124-21ff-7310-a1a7-4770f85e9ed2	Plan 3000 G13	2025-11-29 19:43:18
019ad124-2624-7145-a337-e5fe8da9a927	019ad124-21ff-7310-a1a7-4770f85e9ed2	Cristo Redentor G13	2025-11-29 19:43:18
019ad124-283b-72e0-b902-c7e2ed87d656	019ad124-21ff-7310-a1a7-4770f85e9ed2	UrbarÃ­ G13	2025-11-29 19:43:19
019ad124-2a83-71ab-9f58-7033196ab3f6	019ad124-21ff-7310-a1a7-4770f85e9ed2	Equipetrol G13	2025-11-29 19:43:19
019ad124-3084-7394-9b25-d6690a446e9a	019ad124-2e38-718a-8d42-9c91ac03eb73	Norte G14	2025-11-29 19:43:21
019ad124-325b-7271-bbc3-277cd274b89e	019ad124-2e38-718a-8d42-9c91ac03eb73	Las Palmas G14	2025-11-29 19:43:21
019ad124-3432-7303-95aa-46d92c45ed53	019ad124-2e38-718a-8d42-9c91ac03eb73	Cristo Redentor G14	2025-11-29 19:43:22
019ad124-3a43-7317-a4f0-e4dda87eb7be	019ad124-3866-7353-996f-04876d745709	Los Pozos H1	2025-11-29 19:43:23
019ad124-3c81-7250-91b1-4ce31947ff9e	019ad124-3866-7353-996f-04876d745709	UrbanizaciÃ³n H1	2025-11-29 19:43:24
019ad124-42f6-71f7-9fdc-34855d1673b5	019ad124-4119-72c4-892f-b195145ede0c	UrbarÃ­ H2	2025-11-29 19:43:25
019ad124-44ec-707d-9c05-a3c10cc96aea	019ad124-4119-72c4-892f-b195145ede0c	Hamacas H2	2025-11-29 19:43:26
019ad124-4af1-713b-b2ef-f562a453a370	019ad124-4909-70e5-87da-201d1f7cd740	Equipetrol H3	2025-11-29 19:43:27
019ad124-4d2d-7333-b2fc-48d18cbaf619	019ad124-4909-70e5-87da-201d1f7cd740	UrbarÃ­ H3	2025-11-29 19:43:28
019ad124-4f88-715b-8023-4f42df5f29e4	019ad124-4909-70e5-87da-201d1f7cd740	Plan 3000 H3	2025-11-29 19:43:29
019ad124-522b-7082-88f9-e4b8bb964877	019ad124-4909-70e5-87da-201d1f7cd740	Cristo Redentor H3	2025-11-29 19:43:29
019ad124-5867-73d0-a4a0-4c75734de44d	019ad124-567f-71e1-b2ea-5a0bcf65f900	Oeste H4	2025-11-29 19:43:31
019ad124-5aa5-70ba-96f3-b07e643d7c76	019ad124-567f-71e1-b2ea-5a0bcf65f900	Este H4	2025-11-29 19:43:32
019ad124-60ea-715a-b10d-2cf0240f4346	019ad124-5e99-7251-9324-86f698d3bc5e	SatÃ©lite Norte H5	2025-11-29 19:43:33
019ad124-62de-7335-842a-b5411c79848e	019ad124-5e99-7251-9324-86f698d3bc5e	Villa H5	2025-11-29 19:43:34
019ad124-6bdb-7173-ac09-42f75bc0c83e	019ad124-69eb-71ab-b429-dd9e887c6b6b	Palmasola H6	2025-11-29 19:43:36
019ad124-6e20-7079-8da7-c3e344f141e7	019ad124-69eb-71ab-b429-dd9e887c6b6b	Hamacas H6	2025-11-29 19:43:36
019ad124-705a-71aa-b4a7-7ab6481ec21d	019ad124-69eb-71ab-b429-dd9e887c6b6b	Sur H6	2025-11-29 19:43:37
019ad124-7241-72ea-8cb0-cae481b90c18	019ad124-69eb-71ab-b429-dd9e887c6b6b	SatÃ©lite Norte H6	2025-11-29 19:43:38
019ad124-7aba-7261-9aa9-e6a4f3b45768	019ad124-786e-73e7-9a9b-acb07ee80fe4	Las Palmas H7	2025-11-29 19:43:40
019ad124-7d02-72d4-8c18-5e5c1e4c2041	019ad124-786e-73e7-9a9b-acb07ee80fe4	Centro H7	2025-11-29 19:43:40
019ad124-7ed9-72c7-b362-7fe84edbb924	019ad124-786e-73e7-9a9b-acb07ee80fe4	SatÃ©lite Norte H7	2025-11-29 19:43:41
019ad124-8380-7385-9c93-647e4a93d87d	019ad124-786e-73e7-9a9b-acb07ee80fe4	Equipetrol H7	2025-11-29 19:43:42
019ad124-8989-7208-80ed-2ac48d9cede3	019ad124-87ac-707c-b150-a1796a67b3c4	SatÃ©lite Norte H8	2025-11-29 19:43:44
019ad124-8b6c-71c5-b670-4bb48ccf0277	019ad124-87ac-707c-b150-a1796a67b3c4	Sur H8	2025-11-29 19:43:44
019ad124-924d-71a0-b1fd-5f68eebec309	019ad124-9004-72e8-8469-dca2061f4500	UrbanizaciÃ³n H9	2025-11-29 19:43:46
019ad124-9436-7114-893c-ef6c962ab23e	019ad124-9004-72e8-8469-dca2061f4500	Centro H9	2025-11-29 19:43:46
019ad124-9677-72d9-8c68-04ca93bbb7b3	019ad124-9004-72e8-8469-dca2061f4500	Sur H9	2025-11-29 19:43:47
019ad124-9857-70f0-b8fd-665702eae68f	019ad124-9004-72e8-8469-dca2061f4500	UrbarÃ­ H9	2025-11-29 19:43:47
019ad124-9e7c-71a9-9318-bee8cfe35b00	019ad124-9ca8-71f2-8c8a-69dbf1980700	Villa H10	2025-11-29 19:43:49
019ad124-a6f5-7129-8ff7-0b088a625486	019ad124-a497-715c-b0b0-c17c50c4b2d3	Cristo Redentor H11	2025-11-29 19:43:51
019ad124-a8dd-73c6-beac-094bf053f08f	019ad124-a497-715c-b0b0-c17c50c4b2d3	Palmasola H11	2025-11-29 19:43:52
019ad124-aad0-7271-8d59-1a67789d1bc8	019ad124-a497-715c-b0b0-c17c50c4b2d3	Las Palmas H11	2025-11-29 19:43:52
019ad124-ad1b-70b6-b960-d3ea977a999d	019ad124-a497-715c-b0b0-c17c50c4b2d3	Hamacas H11	2025-11-29 19:43:53
019ad124-b354-70b3-9678-3a30920f738a	019ad124-b170-710f-9a5f-311b4fcb2ce8	Palmasola H12	2025-11-29 19:43:54
019ad124-b5c1-72df-961b-ff3090dba926	019ad124-b170-710f-9a5f-311b4fcb2ce8	Villa H12	2025-11-29 19:43:55
019ad124-b79c-72c6-b0d4-6b38ea440c92	019ad124-b170-710f-9a5f-311b4fcb2ce8	Plan 3000 H12	2025-11-29 19:43:55
019ad124-be2d-7103-afff-bc3e6c2cc3e2	019ad124-bbc9-72a2-9ad4-f17593c94707	Sur H13	2025-11-29 19:43:57
019ad124-c016-7397-981a-5cf9f916ae00	019ad124-bbc9-72a2-9ad4-f17593c94707	Cristo Redentor H13	2025-11-29 19:43:57
019ad124-c634-70d3-869b-40617ba0dbd5	019ad124-c469-7196-8065-a47c1e915776	Villa H14	2025-11-29 19:43:59
019ad124-c9ed-7094-97ab-b5ef43fd8215	019ad124-c469-7196-8065-a47c1e915776	UrbarÃ­ H14	2025-11-29 19:44:00
019ad124-cc4d-73de-b7fb-b3ac5bc3c260	019ad124-c469-7196-8065-a47c1e915776	UrbanizaciÃ³n H14	2025-11-29 19:44:01
019ad124-d280-71dd-9f02-554649fb8ee5	019ad124-d010-7396-bfdb-41d6a29622b1	Hamacas I1	2025-11-29 19:44:02
019ad124-d45e-70e5-a1f8-a7581d64aabf	019ad124-d010-7396-bfdb-41d6a29622b1	Los Pozos I1	2025-11-29 19:44:03
019ad124-e091-7022-93c0-7c512e4a060b	019ad124-dea1-736a-9e00-c8e10e3aa9a8	Las Palmas I2	2025-11-29 19:44:06
019ad124-e984-71a6-94fa-e96b55311f9f	019ad124-e71e-7246-a53e-d95dbfac6ae0	Sur I3	2025-11-29 19:44:08
019ad124-eb56-733c-9c30-57d8e38f6897	019ad124-e71e-7246-a53e-d95dbfac6ae0	UrbarÃ­ I3	2025-11-29 19:44:09
019ad124-ed40-7327-a4a4-13d48ca439bc	019ad124-e71e-7246-a53e-d95dbfac6ae0	Norte I3	2025-11-29 19:44:09
019ad124-efa6-700f-a29e-e69ac48838a6	019ad124-e71e-7246-a53e-d95dbfac6ae0	Villa I3	2025-11-29 19:44:10
019ad124-f17a-70dc-b4da-351f84e93280	019ad124-e71e-7246-a53e-d95dbfac6ae0	SatÃ©lite Norte I3	2025-11-29 19:44:10
019ad124-f868-7371-9c8d-f9f7a4d56dd0	019ad124-f616-71d7-9c57-bbb94fa64ddb	Hamacas I4	2025-11-29 19:44:12
019ad124-fa5f-7084-92b0-a554b9adc143	019ad124-f616-71d7-9c57-bbb94fa64ddb	Oeste I4	2025-11-29 19:44:12
019ad125-00b0-71bf-832b-b3bb26b09a3a	019ad124-fec1-7113-a7bc-f6a6c7ecc270	Hamacas I5	2025-11-29 19:44:14
019ad125-0301-70ba-bcd8-cbeb92d2368f	019ad124-fec1-7113-a7bc-f6a6c7ecc270	Los Pozos I5	2025-11-29 19:44:15
019ad125-04fb-7069-8306-3d28917834b2	019ad124-fec1-7113-a7bc-f6a6c7ecc270	Cristo Redentor I5	2025-11-29 19:44:15
019ad125-0757-70ed-a98a-25fb4462a9fb	019ad124-fec1-7113-a7bc-f6a6c7ecc270	Sur I5	2025-11-29 19:44:16
019ad125-0e3c-70ec-9281-a46b049dbc61	019ad125-0c12-739e-b211-b9596a24ce2f	UrbarÃ­ I6	2025-11-29 19:44:17
019ad125-109f-73af-b2d0-ae87b9af7469	019ad125-0c12-739e-b211-b9596a24ce2f	UrbanizaciÃ³n I6	2025-11-29 19:44:18
019ad125-16b7-713a-9298-93fc1c00da7a	019ad125-14c6-7338-934c-7535e4c89c11	Centro I7	2025-11-29 19:44:20
019ad125-1921-7269-96f2-48bcfbd36c35	019ad125-14c6-7338-934c-7535e4c89c11	Equipetrol I7	2025-11-29 19:44:20
019ad125-1b0a-7230-92a5-4b0ddc66d41f	019ad125-14c6-7338-934c-7535e4c89c11	Sur I7	2025-11-29 19:44:21
019ad125-1d95-73df-9ff1-b3a6d6093124	019ad125-14c6-7338-934c-7535e4c89c11	Oeste I7	2025-11-29 19:44:21
019ad125-1f7b-715f-8284-72d7018a7e3d	019ad125-14c6-7338-934c-7535e4c89c11	Los Pozos I7	2025-11-29 19:44:22
019ad125-2598-729e-830c-33f68b939aab	019ad125-23a9-701e-b4a4-bb765af061f8	Sur I8	2025-11-29 19:44:23
019ad125-27e5-7144-9886-d3a8170a2778	019ad125-23a9-701e-b4a4-bb765af061f8	Palmasola I8	2025-11-29 19:44:24
019ad125-29fe-7081-a865-2f638990e1ab	019ad125-23a9-701e-b4a4-bb765af061f8	Hamacas I8	2025-11-29 19:44:25
019ad125-325f-7260-a919-a2820285ed5d	019ad125-3012-736e-bf47-e257f9b30a60	Sur I9	2025-11-29 19:44:27
019ad125-38f4-736e-b534-c2e131f0b57c	019ad125-3012-736e-bf47-e257f9b30a60	UrbarÃ­ I9	2025-11-29 19:44:28
019ad125-3f9a-703f-9fb6-3276431beb60	019ad125-3d53-728a-86e1-d7e0bc8e56d8	Este I10	2025-11-29 19:44:30
019ad125-419b-732b-a120-ee3431cfa137	019ad125-3d53-728a-86e1-d7e0bc8e56d8	Cristo Redentor I10	2025-11-29 19:44:31
019ad125-43d6-72b4-80a3-e2bc12a72495	019ad125-3d53-728a-86e1-d7e0bc8e56d8	Equipetrol I10	2025-11-29 19:44:31
019ad125-4c8e-7180-a165-764d64e5c01c	019ad125-4a48-7265-b6c7-f9cf8bf4785b	Palmasola I11	2025-11-29 19:44:33
019ad125-4e6d-7128-ae09-1289e86bc6e0	019ad125-4a48-7265-b6c7-f9cf8bf4785b	Oeste I11	2025-11-29 19:44:34
019ad125-5055-73c0-bd80-ec9fd5c973f2	019ad125-4a48-7265-b6c7-f9cf8bf4785b	Villa I11	2025-11-29 19:44:34
019ad125-5290-7186-a2a5-2f5d43c3a277	019ad125-4a48-7265-b6c7-f9cf8bf4785b	Centro I11	2025-11-29 19:44:35
019ad125-5474-72d8-9302-da0980178f7c	019ad125-4a48-7265-b6c7-f9cf8bf4785b	Las Palmas I11	2025-11-29 19:44:35
019ad125-5aba-73f5-b9f6-d6bed4ed85dc	019ad125-58ca-71e8-8218-27edb3fe40c3	Hamacas I12	2025-11-29 19:44:37
019ad125-5d2f-739f-8e47-a9461a24eee8	019ad125-58ca-71e8-8218-27edb3fe40c3	Los Pozos I12	2025-11-29 19:44:38
019ad125-5f12-705c-a3a0-ef5b4b788f6b	019ad125-58ca-71e8-8218-27edb3fe40c3	Centro I12	2025-11-29 19:44:38
019ad125-6163-70c4-83af-216c33605748	019ad125-58ca-71e8-8218-27edb3fe40c3	Cristo Redentor I12	2025-11-29 19:44:39
019ad125-67b3-72c8-b557-5d73ab77e2cd	019ad125-65de-7204-9d4e-92a721ab1d94	Las Palmas I13	2025-11-29 19:44:40
019ad125-6998-719b-bd54-861a66934ec7	019ad125-65de-7204-9d4e-92a721ab1d94	Los Pozos I13	2025-11-29 19:44:41
019ad125-7033-7363-8ddc-37c77ddf4a7a	019ad125-6de0-720b-9b8f-95b438003aec	Equipetrol I14	2025-11-29 19:44:43
019ad125-7295-704d-abff-d9d83da1b8ce	019ad125-6de0-720b-9b8f-95b438003aec	UrbarÃ­ I14	2025-11-29 19:44:43
019ad125-790e-732b-a7cd-849d840b3344	019ad125-76bb-7167-b726-a19f97fa4a2e	Este J1	2025-11-29 19:44:45
019ad125-7b19-7040-be78-029721650776	019ad125-76bb-7167-b726-a19f97fa4a2e	Hamacas J1	2025-11-29 19:44:45
019ad125-7d24-703a-b525-47c17781525e	019ad125-76bb-7167-b726-a19f97fa4a2e	Villa J1	2025-11-29 19:44:46
019ad125-83b0-7100-80c1-5881ae79e38b	019ad125-8173-7097-b706-38868e3b80a1	Sur J2	2025-11-29 19:44:48
019ad125-85a9-7328-b06c-9f6190049697	019ad125-8173-7097-b706-38868e3b80a1	Plan 3000 J2	2025-11-29 19:44:48
019ad125-8c31-72ba-8b72-f6e12b8575c9	019ad125-89cf-73f7-951f-8305fdd9dde0	UrbanizaciÃ³n J3	2025-11-29 19:44:50
019ad125-8f00-7237-b7f5-51a9ae6e1105	019ad125-89cf-73f7-951f-8305fdd9dde0	Villa J3	2025-11-29 19:44:50
019ad125-9143-73b5-bd08-e2e609df98e9	019ad125-89cf-73f7-951f-8305fdd9dde0	Palmasola J3	2025-11-29 19:44:51
019ad125-9772-72d4-ae5b-c99aaed8b97d	019ad125-951a-72d2-846b-ecc35575a4de	UrbarÃ­ J4	2025-11-29 19:44:53
019ad125-995f-73a7-b72c-5f52674fbdd7	019ad125-951a-72d2-846b-ecc35575a4de	Plan 3000 J4	2025-11-29 19:44:53
019ad125-9d94-7100-b4ef-55d5e2140689	019ad125-951a-72d2-846b-ecc35575a4de	Cristo Redentor J4	2025-11-29 19:44:54
019ad125-a59a-718e-a062-215d43f70ba8	019ad125-a3b0-73df-a6a3-89df080f1bec	Oeste J5	2025-11-29 19:44:56
019ad125-a7ed-7354-8f4d-3219039fa2c2	019ad125-a3b0-73df-a6a3-89df080f1bec	Los Pozos J5	2025-11-29 19:44:57
019ad125-ae67-72b2-a6f8-46cc7a2973eb	019ad125-ac68-7270-83f3-edd7fe7294b8	Los Pozos J6	2025-11-29 19:44:58
019ad125-b0c5-715f-9ef1-39798f53e28f	019ad125-ac68-7270-83f3-edd7fe7294b8	Palmasola J6	2025-11-29 19:44:59
019ad125-b29b-7124-b980-5702bde11404	019ad125-ac68-7270-83f3-edd7fe7294b8	Sur J6	2025-11-29 19:45:00
019ad125-b486-7339-a178-5913b924bf24	019ad125-ac68-7270-83f3-edd7fe7294b8	UrbarÃ­ J6	2025-11-29 19:45:00
019ad125-bbb3-722c-a06b-a7b41767210b	019ad125-b936-732e-9009-da9c77de85b4	UrbanizaciÃ³n J7	2025-11-29 19:45:02
019ad125-bd96-70e1-a319-9676d157690d	019ad125-b936-732e-9009-da9c77de85b4	Oeste J7	2025-11-29 19:45:02
019ad125-c1d9-7153-a133-ac7045fc7dd7	019ad125-b936-732e-9009-da9c77de85b4	Palmasola J7	2025-11-29 19:45:03
019ad125-c86d-719a-acf3-96b1986c5986	019ad125-c61a-7137-9a95-b3a380f11e49	Los Pozos J8	2025-11-29 19:45:05
019ad125-caad-7199-8ce3-226d6654607b	019ad125-c61a-7137-9a95-b3a380f11e49	UrbarÃ­ J8	2025-11-29 19:45:06
019ad125-cc9b-70dd-be25-00956e63d845	019ad125-c61a-7137-9a95-b3a380f11e49	Palmasola J8	2025-11-29 19:45:06
019ad125-d56f-73c4-b6b7-84cfb4345b57	019ad125-d294-7192-9840-f9eeb3086e77	SatÃ©lite Norte J9	2025-11-29 19:45:08
019ad125-d7d3-71da-8b82-0b9e62bff250	019ad125-d294-7192-9840-f9eeb3086e77	Centro J9	2025-11-29 19:45:09
019ad125-d9c6-7028-b6a2-5cddb253634a	019ad125-d294-7192-9840-f9eeb3086e77	Palmasola J9	2025-11-29 19:45:10
019ad125-dc20-7017-870f-3a999b051bd0	019ad125-d294-7192-9840-f9eeb3086e77	UrbanizaciÃ³n J9	2025-11-29 19:45:10
019ad125-de16-715c-9e83-cfdc983f8bfc	019ad125-d294-7192-9840-f9eeb3086e77	Oeste J9	2025-11-29 19:45:11
019ad125-e421-70f3-8e9c-dd3bf5458625	019ad125-e243-7265-a825-5815f4dc4e4d	Centro J10	2025-11-29 19:45:12
019ad125-e614-723e-8557-8aba91391e6e	019ad125-e243-7265-a825-5815f4dc4e4d	Hamacas J10	2025-11-29 19:45:13
019ad125-ecc0-7347-846f-74ce0c4fd3fb	019ad125-ea66-7248-9b22-b5613f692a32	Las Palmas J11	2025-11-29 19:45:14
019ad125-eea8-7104-b659-1fa87e9056dd	019ad125-ea66-7248-9b22-b5613f692a32	Los Pozos J11	2025-11-29 19:45:15
019ad125-f09b-71c8-848a-c86b5e256545	019ad125-ea66-7248-9b22-b5613f692a32	SatÃ©lite Norte J11	2025-11-29 19:45:15
019ad125-f30a-72d7-a9aa-6a60694acf8e	019ad125-ea66-7248-9b22-b5613f692a32	Oeste J11	2025-11-29 19:45:16
019ad125-f4e5-718b-8ce4-6c97f2ae8e56	019ad125-ea66-7248-9b22-b5613f692a32	Centro J11	2025-11-29 19:45:17
019ad125-fbb8-73ee-9548-464540b3789f	019ad125-f950-71ec-97a8-fd867f080025	Sur J12	2025-11-29 19:45:18
019ad125-fda4-7191-84d5-9457636eb503	019ad125-f950-71ec-97a8-fd867f080025	Norte J12	2025-11-29 19:45:19
019ad125-ffea-7016-a55d-27d9fd8a2a65	019ad125-f950-71ec-97a8-fd867f080025	Palmasola J12	2025-11-29 19:45:19
019ad126-01cb-73ec-a7d7-3870a3f7941b	019ad125-f950-71ec-97a8-fd867f080025	Las Palmas J12	2025-11-29 19:45:20
019ad126-086f-7295-95a6-4f2f429201f9	019ad126-0627-7138-a832-c95789db03c6	Hamacas J13	2025-11-29 19:45:22
019ad126-0ac4-7089-a7ba-3fecb9d721c3	019ad126-0627-7138-a832-c95789db03c6	Oeste J13	2025-11-29 19:45:22
019ad126-0cbd-70d6-bc7a-03e65f0721cd	019ad126-0627-7138-a832-c95789db03c6	Villa J13	2025-11-29 19:45:23
019ad126-0f1c-7274-90f9-e26d5937e9de	019ad126-0627-7138-a832-c95789db03c6	Centro J13	2025-11-29 19:45:23
019ad126-10f4-7208-86e4-42b6217e97ce	019ad126-0627-7138-a832-c95789db03c6	Equipetrol J13	2025-11-29 19:45:24
019ad126-171a-70e5-8307-5732e64480cf	019ad126-152b-719e-a225-c1f5d4c7d153	Oeste J14	2025-11-29 19:45:25
019ad126-190b-702c-89be-3a4daaea1780	019ad126-152b-719e-a225-c1f5d4c7d153	Centro J14	2025-11-29 19:45:26
019ad126-1b58-7119-a8a9-7f637428bad5	019ad126-152b-719e-a225-c1f5d4c7d153	Sur J14	2025-11-29 19:45:26
019ad126-1d41-73f3-b302-0b94cbb99bd5	019ad126-152b-719e-a225-c1f5d4c7d153	Cristo Redentor J14	2025-11-29 19:45:27
019ad126-1f2f-73c1-bf13-597d3c2741f6	019ad126-152b-719e-a225-c1f5d4c7d153	UrbarÃ­ J14	2025-11-29 19:45:27
019ad126-25b8-73cb-99a1-df8ebe13828d	019ad126-236c-7011-9337-b8e2ac1a6d77	Cristo Redentor K1	2025-11-29 19:45:29
019ad126-2844-7168-8248-4166a086ec6b	019ad126-236c-7011-9337-b8e2ac1a6d77	Los Pozos K1	2025-11-29 19:45:30
019ad126-2a3d-70ae-a8a0-0ce95f1fa25c	019ad126-236c-7011-9337-b8e2ac1a6d77	UrbanizaciÃ³n K1	2025-11-29 19:45:30
019ad126-313a-70e3-b93f-4e50342daf70	019ad126-2ed8-7153-aa64-5edc41846459	Equipetrol K2	2025-11-29 19:45:32
019ad126-3333-71e6-9dec-8986417615d7	019ad126-2ed8-7153-aa64-5edc41846459	Plan 3000 K2	2025-11-29 19:45:32
019ad126-3588-70ef-b51c-a04000b29c75	019ad126-2ed8-7153-aa64-5edc41846459	UrbanizaciÃ³n K2	2025-11-29 19:45:33
019ad126-3774-71a7-9418-b8bcb6c87014	019ad126-2ed8-7153-aa64-5edc41846459	UrbarÃ­ K2	2025-11-29 19:45:34
019ad126-3e1f-7082-baa7-2e266139bfb9	019ad126-3bbf-717d-91ee-a77f1d17ed77	UrbanizaciÃ³n K3	2025-11-29 19:45:35
019ad126-4031-7307-809f-2e7734c7f446	019ad126-3bbf-717d-91ee-a77f1d17ed77	Centro K3	2025-11-29 19:45:36
019ad126-428e-70cc-93e1-572c0a580bc4	019ad126-3bbf-717d-91ee-a77f1d17ed77	Sur K3	2025-11-29 19:45:36
019ad126-446d-73ce-8593-7d09a19a0c1a	019ad126-3bbf-717d-91ee-a77f1d17ed77	Plan 3000 K3	2025-11-29 19:45:37
019ad126-465c-7198-8bd8-991c9c29c551	019ad126-3bbf-717d-91ee-a77f1d17ed77	Oeste K3	2025-11-29 19:45:37
019ad126-4d4d-7356-b8b9-f37494d9f92a	019ad126-4abd-71ff-9e69-b6a19a9b340d	UrbanizaciÃ³n K4	2025-11-29 19:45:39
019ad126-4f3a-72d2-84fc-f04d03f82ad6	019ad126-4abd-71ff-9e69-b6a19a9b340d	Cristo Redentor K4	2025-11-29 19:45:40
019ad126-5a15-7134-9383-01f6ad249f2f	019ad126-57c4-724f-82c8-e76a6ea85c3b	UrbarÃ­ K5	2025-11-29 19:45:42
019ad126-5c6f-71a4-89b2-c57bf0fc3667	019ad126-57c4-724f-82c8-e76a6ea85c3b	Hamacas K5	2025-11-29 19:45:43
019ad126-5ecc-7042-8d2a-8ed93f5da909	019ad126-57c4-724f-82c8-e76a6ea85c3b	Sur K5	2025-11-29 19:45:44
019ad126-60b1-70bd-b4cb-6da941fc371e	019ad126-57c4-724f-82c8-e76a6ea85c3b	UrbanizaciÃ³n K5	2025-11-29 19:45:44
019ad126-630e-73b8-a476-4873dd68c57b	019ad126-57c4-724f-82c8-e76a6ea85c3b	Equipetrol K5	2025-11-29 19:45:45
019ad126-6960-7301-acf3-f98a0e73a229	019ad126-6769-723c-9c40-447a04bbef8f	Plan 3000 K6	2025-11-29 19:45:46
019ad126-6baa-733b-ab45-71c12bca1ca8	019ad126-6769-723c-9c40-447a04bbef8f	SatÃ©lite Norte K6	2025-11-29 19:45:47
019ad126-71cb-7057-8651-273d81eaab02	019ad126-6f85-70e1-83a7-d986305d8b92	Este K7	2025-11-29 19:45:49
019ad126-73af-7307-aabf-045a38f85e0e	019ad126-6f85-70e1-83a7-d986305d8b92	SatÃ©lite Norte K7	2025-11-29 19:45:49
019ad126-7aa5-73bc-b63c-5cab8c3068e8	019ad126-7804-73e8-b06d-072a734a8d7c	Los Pozos K8	2025-11-29 19:45:51
019ad126-7d5d-7371-980d-84ca45780d90	019ad126-7804-73e8-b06d-072a734a8d7c	Sur K8	2025-11-29 19:45:51
019ad126-819f-708a-803a-e9a3a1832c5c	019ad126-7804-73e8-b06d-072a734a8d7c	Cristo Redentor K8	2025-11-29 19:45:53
019ad126-838b-701c-8696-1c159e7449f9	019ad126-7804-73e8-b06d-072a734a8d7c	Equipetrol K8	2025-11-29 19:45:53
019ad126-8a0d-736a-8f30-49f86ff40cc1	019ad126-87c6-703e-a730-23b301bb1997	UrbanizaciÃ³n K9	2025-11-29 19:45:55
019ad126-8c06-73eb-b93e-e86c5fdedae0	019ad126-87c6-703e-a730-23b301bb1997	Cristo Redentor K9	2025-11-29 19:45:55
019ad126-8de6-73a3-8da2-f32a2a9dfb4f	019ad126-87c6-703e-a730-23b301bb1997	Las Palmas K9	2025-11-29 19:45:56
019ad126-98fe-719c-9479-147c9d6042b6	019ad126-9692-7308-8aec-cc70eaae0eb3	Cristo Redentor K10	2025-11-29 19:45:59
019ad126-9b56-71c3-900b-5679a4d1336f	019ad126-9692-7308-8aec-cc70eaae0eb3	Este K10	2025-11-29 19:45:59
019ad126-a1af-718c-87dd-7811522b8062	019ad126-9fbe-72f6-9f57-b4de32a17a07	Palmasola K11	2025-11-29 19:46:01
019ad126-a3a1-701a-8cd1-2adc83899f33	019ad126-9fbe-72f6-9f57-b4de32a17a07	Equipetrol K11	2025-11-29 19:46:01
019ad126-a617-7118-b958-10ea52f7664a	019ad126-9fbe-72f6-9f57-b4de32a17a07	Los Pozos K11	2025-11-29 19:46:02
019ad126-a7ff-7361-aa2a-e9b46cd30d85	019ad126-9fbe-72f6-9f57-b4de32a17a07	Cristo Redentor K11	2025-11-29 19:46:02
019ad126-b094-7326-9a59-2ec96b8df715	019ad126-aea1-720f-aece-1b621cca7668	Las Palmas K12	2025-11-29 19:46:05
019ad126-b522-7176-a22c-85642aa3d1d8	019ad126-aea1-720f-aece-1b621cca7668	UrbarÃ­ K12	2025-11-29 19:46:06
019ad126-bbc0-714f-ad01-35203ea0e181	019ad126-b967-7357-813f-ad260e2bb656	Cristo Redentor K13	2025-11-29 19:46:07
019ad126-bd9a-71f0-94a8-8003e74ebd46	019ad126-b967-7357-813f-ad260e2bb656	Equipetrol K13	2025-11-29 19:46:08
019ad126-bf76-7060-9f2e-a46f037477b2	019ad126-b967-7357-813f-ad260e2bb656	Villa K13	2025-11-29 19:46:08
019ad126-c1a6-71cc-8b73-5074fb7b6a0b	019ad126-b967-7357-813f-ad260e2bb656	UrbanizaciÃ³n K13	2025-11-29 19:46:09
019ad126-c37a-7324-87a7-55a4564a3d52	019ad126-b967-7357-813f-ad260e2bb656	Sur K13	2025-11-29 19:46:09
019ad126-c9bd-7149-9181-fd3531054c6d	019ad126-c7cb-7331-ba6f-a72c71e8192b	SatÃ©lite Norte K14	2025-11-29 19:46:11
019ad126-cc34-722c-a11d-6c2610082084	019ad126-c7cb-7331-ba6f-a72c71e8192b	Oeste K14	2025-11-29 19:46:12
019ad126-d2e9-7334-b7c2-e9d72b35665d	019ad126-d084-7188-a17f-12cea270d305	Palmasola L1	2025-11-29 19:46:13
019ad126-d54b-73ff-94c6-c566ac67fc15	019ad126-d084-7188-a17f-12cea270d305	Plan 3000 L1	2025-11-29 19:46:14
019ad126-d799-709f-a557-98cc5b69508a	019ad126-d084-7188-a17f-12cea270d305	Equipetrol L1	2025-11-29 19:46:15
019ad126-d9e4-70ff-8029-7e02166cec0d	019ad126-d084-7188-a17f-12cea270d305	Sur L1	2025-11-29 19:46:15
019ad126-e00c-7147-82ce-7134dffc97c5	019ad126-de2b-7189-9f63-8d2aec540598	Villa L2	2025-11-29 19:46:17
019ad126-e1e9-71fe-a10f-9f5de6c352c7	019ad126-de2b-7189-9f63-8d2aec540598	Hamacas L2	2025-11-29 19:46:17
019ad126-e443-70d3-a5fc-87555f7baeae	019ad126-de2b-7189-9f63-8d2aec540598	Los Pozos L2	2025-11-29 19:46:18
019ad126-e616-7008-b0d5-e9931f77bdba	019ad126-de2b-7189-9f63-8d2aec540598	UrbanizaciÃ³n L2	2025-11-29 19:46:18
019ad126-ec1e-7364-97c9-3ffc77269f2c	019ad126-ea1e-7211-8fe0-c80a851736a2	Centro L3	2025-11-29 19:46:20
019ad126-ee97-7390-8824-fd32c4dd6eb6	019ad126-ea1e-7211-8fe0-c80a851736a2	Cristo Redentor L3	2025-11-29 19:46:20
019ad126-f08a-726a-9823-ffc1a6dbad26	019ad126-ea1e-7211-8fe0-c80a851736a2	Oeste L3	2025-11-29 19:46:21
019ad126-f748-7186-a526-9a49dc9a8bed	019ad126-f4df-73b3-8b5c-fb0afe1d9b61	Hamacas L4	2025-11-29 19:46:23
019ad126-f935-7248-b821-89f7ed6ac2e5	019ad126-f4df-73b3-8b5c-fb0afe1d9b61	SatÃ©lite Norte L4	2025-11-29 19:46:23
019ad126-fb9d-710f-a700-2711b7eafa4e	019ad126-f4df-73b3-8b5c-fb0afe1d9b61	Los Pozos L4	2025-11-29 19:46:24
019ad127-0223-7240-b92e-596f7a9a0a43	019ad127-0029-70f8-9613-268b4ce0a5af	Centro L5	2025-11-29 19:46:25
019ad127-04a3-70ca-b499-0f6f9ddf2802	019ad127-0029-70f8-9613-268b4ce0a5af	Equipetrol L5	2025-11-29 19:46:26
019ad127-06a2-71af-ae8e-1a0bf6ebcc7f	019ad127-0029-70f8-9613-268b4ce0a5af	UrbarÃ­ L5	2025-11-29 19:46:27
019ad127-0d65-717e-b2c1-f81263d161d2	019ad127-0af2-71bc-bcd3-8aa01e7156f8	Villa L6	2025-11-29 19:46:28
019ad127-0f62-73a8-b630-3e44533f986c	019ad127-0af2-71bc-bcd3-8aa01e7156f8	Equipetrol L6	2025-11-29 19:46:29
019ad127-1153-7098-990b-5f52dd920c49	019ad127-0af2-71bc-bcd3-8aa01e7156f8	Este L6	2025-11-29 19:46:29
019ad127-13c7-7286-bf25-770a88280f28	019ad127-0af2-71bc-bcd3-8aa01e7156f8	Palmasola L6	2025-11-29 19:46:30
019ad127-1c4b-7320-931f-d331c45b8a5b	019ad127-19f9-7054-8d17-349961227666	Las Palmas L7	2025-11-29 19:46:32
019ad127-1e53-7089-9d59-32514c05ea15	019ad127-19f9-7054-8d17-349961227666	Centro L7	2025-11-29 19:46:33
019ad127-251b-71f5-86a3-0c11c93cc1a6	019ad127-22b3-725b-b6fe-cccfec1539b7	Plan 3000 L8	2025-11-29 19:46:34
019ad127-26fd-71a6-b834-180205da9dde	019ad127-22b3-725b-b6fe-cccfec1539b7	UrbarÃ­ L8	2025-11-29 19:46:35
019ad127-2e02-71f2-8418-01ced24fcda3	019ad127-2b87-700f-9a0f-70cd2dae0cd0	Oeste L9	2025-11-29 19:46:37
019ad127-2fda-709f-936d-da9b44e1961d	019ad127-2b87-700f-9a0f-70cd2dae0cd0	Los Pozos L9	2025-11-29 19:46:37
019ad127-387c-73c5-b1f8-18874ca249f4	019ad127-3622-738d-ab33-86d1e30f5e6b	UrbanizaciÃ³n L10	2025-11-29 19:46:39
019ad127-3a61-7008-b4b6-8485ddec3394	019ad127-3622-738d-ab33-86d1e30f5e6b	Hamacas L10	2025-11-29 19:46:40
019ad127-431d-73f3-85ad-bb66ee69bac5	019ad127-412b-70f3-ba2f-372a51966a28	Equipetrol L11	2025-11-29 19:46:42
019ad127-456d-72d4-8dd2-0895da9e4cac	019ad127-412b-70f3-ba2f-372a51966a28	Los Pozos L11	2025-11-29 19:46:43
019ad127-4768-72b7-9e5b-47820bf1550c	019ad127-412b-70f3-ba2f-372a51966a28	UrbarÃ­ L11	2025-11-29 19:46:43
019ad127-4d9b-72d2-9707-113f703f4898	019ad127-4b8e-701e-81b8-07cff06d06fe	Hamacas L12	2025-11-29 19:46:45
019ad127-5027-72ac-9a5f-acd6c4d3fb93	019ad127-4b8e-701e-81b8-07cff06d06fe	Oeste L12	2025-11-29 19:46:45
019ad127-5705-72a6-817e-9959ecaf0dd2	019ad127-54cc-7222-b609-471036a2c681	Equipetrol L13	2025-11-29 19:46:47
019ad127-58de-7058-b31d-249588e731e5	019ad127-54cc-7222-b609-471036a2c681	UrbarÃ­ L13	2025-11-29 19:46:48
019ad127-5ae7-7104-8ffe-59769ab40573	019ad127-54cc-7222-b609-471036a2c681	Plan 3000 L13	2025-11-29 19:46:48
019ad127-635e-723f-9b02-ff7b25782174	019ad127-6108-71d0-83b1-65c13974fcca	Palmasola L14	2025-11-29 19:46:50
019ad127-653c-716c-8ee8-613f0dd5b038	019ad127-6108-71d0-83b1-65c13974fcca	Oeste L14	2025-11-29 19:46:51
019ad127-671c-71cb-9a0e-7f84e344717a	019ad127-6108-71d0-83b1-65c13974fcca	Norte L14	2025-11-29 19:46:51
019ad127-6961-7106-a291-d357a8599933	019ad127-6108-71d0-83b1-65c13974fcca	Cristo Redentor L14	2025-11-29 19:46:52
019ad127-703e-73e2-aa94-08a41e0177d8	019ad127-6de7-7299-aa3c-6bd685633f5a	Hamacas M1	2025-11-29 19:46:54
019ad127-7298-71a9-917f-44c9f2b5c26e	019ad127-6de7-7299-aa3c-6bd685633f5a	Norte M1	2025-11-29 19:46:54
019ad127-7476-7010-8afb-68ac31e93167	019ad127-6de7-7299-aa3c-6bd685633f5a	Los Pozos M1	2025-11-29 19:46:55
019ad127-7ab0-70b7-a22b-b1f2a05194d8	019ad127-78c1-71a7-84bc-66e18a7750ea	Centro M2	2025-11-29 19:46:56
019ad127-7ca8-72f3-bfec-37b7f5a93344	019ad127-78c1-71a7-84bc-66e18a7750ea	Las Palmas M2	2025-11-29 19:46:57
019ad127-854d-732e-a7bb-2f15f36f0ada	019ad127-82d4-71b5-8c91-b51a39199f3d	Plan 3000 M3	2025-11-29 19:46:59
019ad127-8734-72b9-85be-162acdf9adbb	019ad127-82d4-71b5-8c91-b51a39199f3d	SatÃ©lite Norte M3	2025-11-29 19:47:00
019ad127-8977-7149-973c-c74c08090948	019ad127-82d4-71b5-8c91-b51a39199f3d	Equipetrol M3	2025-11-29 19:47:00
019ad127-8b54-7380-afa4-86d9aa119fd3	019ad127-82d4-71b5-8c91-b51a39199f3d	Sur M3	2025-11-29 19:47:01
019ad127-9159-70b8-92ba-9a9d0cbf07a5	019ad127-8f5f-72b5-b599-1d54a536f699	Este M4	2025-11-29 19:47:02
019ad127-935f-7139-b7b1-ad0d827300d5	019ad127-8f5f-72b5-b599-1d54a536f699	Centro M4	2025-11-29 19:47:03
019ad127-95ae-717b-9ab4-27e9f9b6d778	019ad127-8f5f-72b5-b599-1d54a536f699	Las Palmas M4	2025-11-29 19:47:03
019ad127-9793-73ce-92f3-a56e0675698f	019ad127-8f5f-72b5-b599-1d54a536f699	Norte M4	2025-11-29 19:47:04
019ad127-9979-7083-b2a3-a1115669448d	019ad127-8f5f-72b5-b599-1d54a536f699	Sur M4	2025-11-29 19:47:04
019ad127-9f97-70de-8b85-f093c4ba419c	019ad127-9d96-7375-8987-2d12711a1752	Norte M5	2025-11-29 19:47:06
019ad127-a1fa-7090-aad0-3177b2c2fe91	019ad127-9d96-7375-8987-2d12711a1752	UrbarÃ­ M5	2025-11-29 19:47:06
019ad127-a7ff-737c-9a8a-b7950a4ca8ec	019ad127-a61b-7207-8713-4148a7ce4419	UrbanizaciÃ³n M6	2025-11-29 19:47:08
019ad127-aab6-7156-82f4-f41c35ee6093	019ad127-a61b-7207-8713-4148a7ce4419	Norte M6	2025-11-29 19:47:09
019ad127-ad12-72fb-9037-04ac2c03079f	019ad127-a61b-7207-8713-4148a7ce4419	Plan 3000 M6	2025-11-29 19:47:09
019ad127-b3c2-72c9-8eeb-42765d8b5329	019ad127-b147-71e5-b197-168632fc652a	SatÃ©lite Norte M7	2025-11-29 19:47:11
019ad127-b61a-7168-9e4c-841f40c63867	019ad127-b147-71e5-b197-168632fc652a	Cristo Redentor M7	2025-11-29 19:47:12
019ad127-bc46-72cd-9290-892bb2b6e87b	019ad127-b9d2-7219-ad6f-825e6152c4c0	SatÃ©lite Norte M8	2025-11-29 19:47:13
019ad127-be2b-7097-a977-138ba1f976b7	019ad127-b9d2-7219-ad6f-825e6152c4c0	Este M8	2025-11-29 19:47:14
019ad127-c4dc-7013-9760-4e507dcfc7f4	019ad127-c27d-7056-a7cc-2ff85061792e	UrbarÃ­ M9	2025-11-29 19:47:15
019ad127-c6e3-7140-9ea8-72f8b02b0e89	019ad127-c27d-7056-a7cc-2ff85061792e	Norte M9	2025-11-29 19:47:16
019ad127-c93a-7317-8421-287561f0c1a5	019ad127-c27d-7056-a7cc-2ff85061792e	Hamacas M9	2025-11-29 19:47:16
019ad127-cb25-719b-8bee-c09ea23010b2	019ad127-c27d-7056-a7cc-2ff85061792e	UrbanizaciÃ³n M9	2025-11-29 19:47:17
019ad127-d1c7-7088-a548-cc9d7783f4d2	019ad127-cf5c-7313-8756-90217e0b4a1a	SatÃ©lite Norte M10	2025-11-29 19:47:19
019ad127-d3af-70e9-81c1-b5dce9ebfdff	019ad127-cf5c-7313-8756-90217e0b4a1a	UrbarÃ­ M10	2025-11-29 19:47:19
019ad127-d61b-7310-8a27-73da091ac254	019ad127-cf5c-7313-8756-90217e0b4a1a	Palmasola M10	2025-11-29 19:47:20
019ad127-d808-7356-9722-4e825ec73ff9	019ad127-cf5c-7313-8756-90217e0b4a1a	Equipetrol M10	2025-11-29 19:47:20
019ad127-df12-723d-8d8e-58c0a3a0b9d1	019ad127-dc4d-732f-b867-6e858e9e1be0	Los Pozos M11	2025-11-29 19:47:22
019ad127-e14a-723d-81cd-2ba7126f6b15	019ad127-dc4d-732f-b867-6e858e9e1be0	Plan 3000 M11	2025-11-29 19:47:23
019ad127-e332-73ad-bb7e-30862e05330b	019ad127-dc4d-732f-b867-6e858e9e1be0	Centro M11	2025-11-29 19:47:23
019ad127-e94c-7235-b11a-e92f3cf6bc10	019ad127-e75e-731d-800f-6c5eae82b981	Centro M12	2025-11-29 19:47:25
019ad127-ebaa-7092-a001-702fdec69122	019ad127-e75e-731d-800f-6c5eae82b981	Palmasola M12	2025-11-29 19:47:25
019ad127-edb9-7038-857c-74dd7560d872	019ad127-e75e-731d-800f-6c5eae82b981	Cristo Redentor M12	2025-11-29 19:47:26
019ad127-f026-70ef-89f3-a267be9c0ec0	019ad127-e75e-731d-800f-6c5eae82b981	UrbarÃ­ M12	2025-11-29 19:47:26
019ad127-f6ae-7313-bd84-9f29545fee76	019ad127-f49a-71e9-9f99-3a809484aab9	SatÃ©lite Norte M13	2025-11-29 19:47:28
019ad127-faeb-71ae-9409-d27b99f57547	019ad127-f49a-71e9-9f99-3a809484aab9	Centro M13	2025-11-29 19:47:29
019ad127-fcc9-7274-9091-7fe36b1ef0c8	019ad127-f49a-71e9-9f99-3a809484aab9	Sur M13	2025-11-29 19:47:30
019ad127-ff1b-7220-b348-c78a994f6859	019ad127-f49a-71e9-9f99-3a809484aab9	Hamacas M13	2025-11-29 19:47:30
019ad128-057b-7202-ba5e-b7297a0be71b	019ad128-0381-733e-9738-af129dab192d	Sur M14	2025-11-29 19:47:32
019ad128-07d6-737d-8dbc-4597d4f4f09b	019ad128-0381-733e-9738-af129dab192d	Hamacas M14	2025-11-29 19:47:32
019ad128-0dff-7251-a8bf-6b70c8d7781e	019ad128-0c0e-722b-b97f-7d13f309dcc7	Plan 3000 N1	2025-11-29 19:47:34
019ad128-1066-72bb-ab48-00ec13511f3f	019ad128-0c0e-722b-b97f-7d13f309dcc7	Sur N1	2025-11-29 19:47:35
019ad128-12b3-7185-be98-08adcf66720c	019ad128-0c0e-722b-b97f-7d13f309dcc7	UrbanizaciÃ³n N1	2025-11-29 19:47:35
019ad128-1526-7000-b4a3-f14e8b85135b	019ad128-0c0e-722b-b97f-7d13f309dcc7	UrbarÃ­ N1	2025-11-29 19:47:36
019ad128-1728-7343-9fe0-ed8d605405bf	019ad128-0c0e-722b-b97f-7d13f309dcc7	Villa N1	2025-11-29 19:47:36
019ad128-1d3d-7099-89f0-e100ddba5310	019ad128-1b4c-725e-881d-923320341f05	Sur N2	2025-11-29 19:47:38
019ad128-1f82-71d9-b48a-ffeaa71d38d9	019ad128-1b4c-725e-881d-923320341f05	Centro N2	2025-11-29 19:47:39
019ad128-218e-7055-8f25-5cca05b584f9	019ad128-1b4c-725e-881d-923320341f05	Villa N2	2025-11-29 19:47:39
019ad128-23f2-701a-a8c9-f163a6f26d9e	019ad128-1b4c-725e-881d-923320341f05	Las Palmas N2	2025-11-29 19:47:40
019ad128-25df-7216-9b86-6ccb30dba819	019ad128-1b4c-725e-881d-923320341f05	Plan 3000 N2	2025-11-29 19:47:40
019ad128-2bf0-73d6-bc0a-ca6a52f87770	019ad128-2a0e-7347-aee4-f544c368d00f	Villa N3	2025-11-29 19:47:42
019ad128-2e58-7161-aa25-f0e7c54f8314	019ad128-2a0e-7347-aee4-f544c368d00f	SatÃ©lite Norte N3	2025-11-29 19:47:42
019ad128-302a-7362-833d-b224a4569c13	019ad128-2a0e-7347-aee4-f544c368d00f	Hamacas N3	2025-11-29 19:47:43
019ad128-322e-7138-8b44-5293e7a4bd9e	019ad128-2a0e-7347-aee4-f544c368d00f	Sur N3	2025-11-29 19:47:43
019ad128-3ade-7334-a346-adc5cc493ccb	019ad128-38fb-7270-baf4-a20bb374bcf0	Sur N4	2025-11-29 19:47:46
019ad128-3cca-7248-90ae-bd64c80920af	019ad128-38fb-7270-baf4-a20bb374bcf0	Cristo Redentor N4	2025-11-29 19:47:46
019ad128-3f17-7382-9bff-2ecd1a5d3207	019ad128-38fb-7270-baf4-a20bb374bcf0	Norte N4	2025-11-29 19:47:47
019ad128-4501-73e4-a0a2-e8da0404ea8b	019ad128-432d-70c5-b3c8-566001d0cde8	SatÃ©lite Norte N5	2025-11-29 19:47:48
019ad128-46e2-71a7-8f9b-d2f8fc7af225	019ad128-432d-70c5-b3c8-566001d0cde8	Los Pozos N5	2025-11-29 19:47:49
019ad128-4935-71be-acaa-e8a7fae707e9	019ad128-432d-70c5-b3c8-566001d0cde8	Cristo Redentor N5	2025-11-29 19:47:49
019ad128-4b18-7005-a767-55757e6279bf	019ad128-432d-70c5-b3c8-566001d0cde8	Palmasola N5	2025-11-29 19:47:50
019ad128-51f2-7363-80b3-250ccfde7b7a	019ad128-4f3d-70bc-b4cf-9a034c55e088	Villa N6	2025-11-29 19:47:51
019ad128-5447-7114-bc9e-40d4f515dc66	019ad128-4f3d-70bc-b4cf-9a034c55e088	Los Pozos N6	2025-11-29 19:47:52
019ad128-561b-7203-9954-50b79263036e	019ad128-4f3d-70bc-b4cf-9a034c55e088	UrbarÃ­ N6	2025-11-29 19:47:52
019ad128-5c15-7170-96c9-0ae93cedf6c2	019ad128-5a36-720e-8c4b-524150b38a46	Cristo Redentor N7	2025-11-29 19:47:54
019ad128-5df8-71a2-b67a-ecf67ad6da93	019ad128-5a36-720e-8c4b-524150b38a46	SatÃ©lite Norte N7	2025-11-29 19:47:55
019ad128-6069-7014-9033-c59fb296008d	019ad128-5a36-720e-8c4b-524150b38a46	Villa N7	2025-11-29 19:47:55
019ad128-68d6-7235-9e02-d34182b17030	019ad128-6680-7038-bd60-a2ffd587fc18	Este N8	2025-11-29 19:47:57
019ad128-6aa3-725f-8c51-36391bbf72ea	019ad128-6680-7038-bd60-a2ffd587fc18	Villa N8	2025-11-29 19:47:58
019ad128-6c8b-72d6-a176-0ee66790c6e2	019ad128-6680-7038-bd60-a2ffd587fc18	Centro N8	2025-11-29 19:47:58
019ad128-6ec7-7371-a06d-552f61249368	019ad128-6680-7038-bd60-a2ffd587fc18	UrbanizaciÃ³n N8	2025-11-29 19:47:59
019ad128-74b3-72fb-9db6-4db9181b9552	019ad128-7269-71e1-8265-bbb735ed4dd8	Plan 3000 N9	2025-11-29 19:48:00
019ad128-7848-70d9-8e61-086f2865dba0	019ad128-7269-71e1-8265-bbb735ed4dd8	Centro N9	2025-11-29 19:48:01
019ad128-8143-7115-b4f0-dbdd91d0b754	019ad128-7efd-7162-8457-afc36737c8d9	Cristo Redentor N10	2025-11-29 19:48:04
019ad128-8398-70f4-a076-6a8103c02b9e	019ad128-7efd-7162-8457-afc36737c8d9	Las Palmas N10	2025-11-29 19:48:04
019ad128-85f5-71d5-8675-20a001423fba	019ad128-7efd-7162-8457-afc36737c8d9	UrbarÃ­ N10	2025-11-29 19:48:05
019ad128-8a5d-72b2-b0a7-42af09c7e013	019ad128-7efd-7162-8457-afc36737c8d9	Equipetrol N10	2025-11-29 19:48:06
019ad128-90c7-705c-a59b-231c283033c5	019ad128-8e7d-736a-9ff0-3ba4d2030332	SatÃ©lite Norte N11	2025-11-29 19:48:08
019ad128-930b-721d-a954-0cc6cdd75062	019ad128-8e7d-736a-9ff0-3ba4d2030332	Este N11	2025-11-29 19:48:08
019ad128-9509-71f2-b723-c1d08f14cf63	019ad128-8e7d-736a-9ff0-3ba4d2030332	Palmasola N11	2025-11-29 19:48:09
019ad128-9765-7144-b05f-7e26df11ccb9	019ad128-8e7d-736a-9ff0-3ba4d2030332	Oeste N11	2025-11-29 19:48:09
019ad128-994b-721b-a361-f4099fbc212d	019ad128-8e7d-736a-9ff0-3ba4d2030332	Plan 3000 N11	2025-11-29 19:48:10
019ad128-9f4c-72f0-9016-737b2b049893	019ad128-9d64-7245-9219-ccc45589f4a9	Centro N12	2025-11-29 19:48:11
019ad128-a1ac-7153-9bf0-632f735c9966	019ad128-9d64-7245-9219-ccc45589f4a9	Los Pozos N12	2025-11-29 19:48:12
019ad128-a39f-7010-aacd-16b802b9b866	019ad128-9d64-7245-9219-ccc45589f4a9	UrbanizaciÃ³n N12	2025-11-29 19:48:12
019ad128-a9bb-70b4-9d07-0977acc3db93	019ad128-a7d5-7297-bea2-d2c012972553	Centro N13	2025-11-29 19:48:14
019ad128-adf8-723b-b39e-1b0f5c6373d1	019ad128-a7d5-7297-bea2-d2c012972553	Norte N13	2025-11-29 19:48:15
019ad128-b032-7280-9c4a-7c3f2617077a	019ad128-a7d5-7297-bea2-d2c012972553	Sur N13	2025-11-29 19:48:16
019ad128-b218-7149-990d-3cf397b25ada	019ad128-a7d5-7297-bea2-d2c012972553	UrbarÃ­ N13	2025-11-29 19:48:16
019ad128-b806-72be-ba66-569932f04609	019ad128-b61d-71a6-afee-e6835989c7cf	Los Pozos N14	2025-11-29 19:48:18
019ad128-bc58-72ea-9cc8-3260afbd0e4a	019ad128-b61d-71a6-afee-e6835989c7cf	UrbarÃ­ N14	2025-11-29 19:48:19
019ad128-c27e-736a-950e-48c16599ab1c	019ad128-c09e-7116-9ee9-f32e32efcd84	UrbarÃ­ O1	2025-11-29 19:48:20
019ad128-c4bf-71a1-9f1a-2dca88fd3cbb	019ad128-c09e-7116-9ee9-f32e32efcd84	Plan 3000 O1	2025-11-29 19:48:21
019ad128-c883-7252-be20-7367a914a33b	019ad128-c09e-7116-9ee9-f32e32efcd84	Palmasola O1	2025-11-29 19:48:22
019ad128-d0ff-7264-b3eb-8cb1749ca6d3	019ad128-ce88-72ab-888e-1a400ec9bd84	Este O2	2025-11-29 19:48:24
019ad128-d2f5-70cc-991e-0993559f5375	019ad128-ce88-72ab-888e-1a400ec9bd84	Las Palmas O2	2025-11-29 19:48:24
019ad128-d533-700a-b5df-2ad62e68acf7	019ad128-ce88-72ab-888e-1a400ec9bd84	Villa O2	2025-11-29 19:48:25
019ad128-d704-7236-b5a5-4f2bb19e9e71	019ad128-ce88-72ab-888e-1a400ec9bd84	Plan 3000 O2	2025-11-29 19:48:25
019ad128-d8e5-724b-a184-5d9994a9ec28	019ad128-ce88-72ab-888e-1a400ec9bd84	Equipetrol O2	2025-11-29 19:48:26
019ad128-df4a-7254-a306-cd8444aabe4a	019ad128-dd10-71e9-b4ae-87a99a9f89ab	UrbarÃ­ O3	2025-11-29 19:48:28
019ad128-e133-738e-a879-2f709860d395	019ad128-dd10-71e9-b4ae-87a99a9f89ab	Oeste O3	2025-11-29 19:48:28
019ad128-e37d-70d3-9328-d99724e6f43b	019ad128-dd10-71e9-b4ae-87a99a9f89ab	Palmasola O3	2025-11-29 19:48:29
019ad128-e56f-7250-867b-8ee930524b6a	019ad128-dd10-71e9-b4ae-87a99a9f89ab	Este O3	2025-11-29 19:48:29
019ad128-ee54-725a-8ca4-39a81a619adf	019ad128-ec0d-71f8-8a0d-14257173677c	Equipetrol O4	2025-11-29 19:48:31
019ad128-f1ff-71b9-b5de-494e07409cd4	019ad128-ec0d-71f8-8a0d-14257173677c	Los Pozos O4	2025-11-29 19:48:32
019ad128-f44b-7148-a5a9-0f6413bdbae6	019ad128-ec0d-71f8-8a0d-14257173677c	Norte O4	2025-11-29 19:48:33
019ad128-f62a-7000-a6e8-77d771fa40b5	019ad128-ec0d-71f8-8a0d-14257173677c	Villa O4	2025-11-29 19:48:33
019ad128-fc9a-720b-be98-2e1e424ce203	019ad128-fa5e-73c9-bf99-5410c5119f29	UrbanizaciÃ³n O5	2025-11-29 19:48:35
019ad128-fe89-72f6-94ca-b88a7810aa6d	019ad128-fa5e-73c9-bf99-5410c5119f29	Los Pozos O5	2025-11-29 19:48:36
019ad129-051d-7191-aa36-79606742f579	019ad129-02c8-725f-a0f7-8c8f2141ff3e	Palmasola O6	2025-11-29 19:48:37
019ad129-075e-718f-9a67-28973d4ce281	019ad129-02c8-725f-a0f7-8c8f2141ff3e	Sur O6	2025-11-29 19:48:38
019ad129-0b22-739b-bac4-9021e6c44dae	019ad129-02c8-725f-a0f7-8c8f2141ff3e	Plan 3000 O6	2025-11-29 19:48:39
019ad129-1140-7263-b711-ce35ccf2ea64	019ad129-0f63-7183-9aa7-60ee9f9a64ca	Villa O7	2025-11-29 19:48:40
019ad129-1640-70ec-9582-5bdb570c3886	019ad129-0f63-7183-9aa7-60ee9f9a64ca	Norte O7	2025-11-29 19:48:42
019ad129-1c9f-72a3-b383-4eee19200a2c	019ad129-19f8-70df-ad54-e06628ab0541	Equipetrol O8	2025-11-29 19:48:43
019ad129-1f38-716d-a8ab-2bd34be469c8	019ad129-19f8-70df-ad54-e06628ab0541	Sur O8	2025-11-29 19:48:44
019ad129-27c1-720a-be2d-89fd69d4bf30	019ad129-256a-73ec-964a-dd3e86be121d	Equipetrol O9	2025-11-29 19:48:46
019ad129-299e-731a-ab80-5d68e7f14040	019ad129-256a-73ec-964a-dd3e86be121d	SatÃ©lite Norte O9	2025-11-29 19:48:47
019ad129-2b79-70a4-bdd0-9d91a6a7c9bf	019ad129-256a-73ec-964a-dd3e86be121d	Norte O9	2025-11-29 19:48:47
019ad129-2dcc-7238-ae38-6496b33b8855	019ad129-256a-73ec-964a-dd3e86be121d	UrbanizaciÃ³n O9	2025-11-29 19:48:48
019ad129-3628-72e0-965f-9c71c75a2e8f	019ad129-33e3-70ca-bc69-de05379a3905	Equipetrol O10	2025-11-29 19:48:50
019ad129-381c-70c2-8eb3-973e4558aea8	019ad129-33e3-70ca-bc69-de05379a3905	Los Pozos O10	2025-11-29 19:48:50
019ad129-406c-706b-a5de-cf3c18289252	019ad129-3e95-7305-8a0a-caab679e7401	Los Pozos O11	2025-11-29 19:48:52
019ad129-425d-707f-8064-781813960b33	019ad129-3e95-7305-8a0a-caab679e7401	Sur O11	2025-11-29 19:48:53
019ad129-448e-7258-a2e9-ac73795b3488	019ad129-3e95-7305-8a0a-caab679e7401	Cristo Redentor O11	2025-11-29 19:48:54
019ad129-4669-71e4-aef6-f2cf88aabeab	019ad129-3e95-7305-8a0a-caab679e7401	Hamacas O11	2025-11-29 19:48:54
019ad129-4efe-707d-8846-eb008df343b3	019ad129-4c8b-709b-a27a-790d15a34423	Oeste O12	2025-11-29 19:48:56
019ad129-50f4-7124-afd0-33d2bbee7e70	019ad129-4c8b-709b-a27a-790d15a34423	Cristo Redentor O12	2025-11-29 19:48:57
019ad129-539d-7107-b85b-971de8ce05d8	019ad129-4c8b-709b-a27a-790d15a34423	Palmasola O12	2025-11-29 19:48:57
019ad129-55d8-710f-b3c9-46ed0be40b87	019ad129-4c8b-709b-a27a-790d15a34423	UrbarÃ­ O12	2025-11-29 19:48:58
019ad129-5cf5-73b8-b8d4-8c1a4b54ff8d	019ad129-5aa0-72b7-a209-bb3a6129a7b8	Este O13	2025-11-29 19:49:00
019ad129-5f2e-70b2-aef5-4b72b5344d9c	019ad129-5aa0-72b7-a209-bb3a6129a7b8	Las Palmas O13	2025-11-29 19:49:00
019ad129-6114-713b-9b39-b741b3b5c0da	019ad129-5aa0-72b7-a209-bb3a6129a7b8	UrbarÃ­ O13	2025-11-29 19:49:01
019ad129-62ec-7117-934c-b3509708797e	019ad129-5aa0-72b7-a209-bb3a6129a7b8	Palmasola O13	2025-11-29 19:49:01
019ad129-6982-71ac-9fe4-95ee601e8bd6	019ad129-672b-7343-bc3c-0aaa78b6644c	Este O14	2025-11-29 19:49:03
019ad129-6b4a-73cb-a173-15ef9d466702	019ad129-672b-7343-bc3c-0aaa78b6644c	Oeste O14	2025-11-29 19:49:03
019ad129-6d38-71ac-874e-539eba32ae61	019ad129-672b-7343-bc3c-0aaa78b6644c	Centro O14	2025-11-29 19:49:04
019ad129-6f64-724c-bad7-9b28c2a27f49	019ad129-672b-7343-bc3c-0aaa78b6644c	Plan 3000 O14	2025-11-29 19:49:04
019ad129-757e-7371-8bfc-7cb8c5e026b8	019ad129-7330-70fc-b43a-89ef1b66b9b8	Palmasola P1	2025-11-29 19:49:06
019ad129-7763-714a-a5d8-7aa82de505fd	019ad129-7330-70fc-b43a-89ef1b66b9b8	UrbarÃ­ P1	2025-11-29 19:49:07
019ad129-79bb-7286-8134-fa1b427434b9	019ad129-7330-70fc-b43a-89ef1b66b9b8	Norte P1	2025-11-29 19:49:07
019ad129-7df8-71b0-806b-d4f9423be5ac	019ad129-7330-70fc-b43a-89ef1b66b9b8	Las Palmas P1	2025-11-29 19:49:08
019ad129-83f5-7101-b634-8b7ffd7a6437	019ad129-81b0-736b-85a7-4ae840ca4a81	Este P2	2025-11-29 19:49:10
019ad129-85e4-7141-b87d-3d2227deb77c	019ad129-81b0-736b-85a7-4ae840ca4a81	Oeste P2	2025-11-29 19:49:10
019ad129-87d6-7199-ad2c-94406a3eaa1d	019ad129-81b0-736b-85a7-4ae840ca4a81	SatÃ©lite Norte P2	2025-11-29 19:49:11
019ad129-8c45-7360-b5ab-6cbcb1d36f43	019ad129-81b0-736b-85a7-4ae840ca4a81	Sur P2	2025-11-29 19:49:12
019ad129-9249-71f1-a788-067c12ce7158	019ad129-9064-707c-b5d3-ca7600e3e91c	Sur P3	2025-11-29 19:49:13
019ad129-9485-70c1-a4ed-00f9de9ba9b7	019ad129-9064-707c-b5d3-ca7600e3e91c	UrbarÃ­ P3	2025-11-29 19:49:14
019ad129-9662-7228-bf34-9b992240ae60	019ad129-9064-707c-b5d3-ca7600e3e91c	Villa P3	2025-11-29 19:49:14
019ad129-9842-73e0-a9fb-62d0318c8334	019ad129-9064-707c-b5d3-ca7600e3e91c	Cristo Redentor P3	2025-11-29 19:49:15
019ad129-9aa7-70ff-a5a6-023f8d254d07	019ad129-9064-707c-b5d3-ca7600e3e91c	Plan 3000 P3	2025-11-29 19:49:16
019ad129-a0e5-7239-96e9-4b1e1ec758d4	019ad129-9eff-7381-b73d-7c92c2d22ea2	Palmasola P4	2025-11-29 19:49:17
019ad129-a32f-73f0-892e-7a5a315e9f4f	019ad129-9eff-7381-b73d-7c92c2d22ea2	Villa P4	2025-11-29 19:49:18
019ad129-a961-73f8-8899-e5a4ace66f50	019ad129-a704-728c-912a-e1296785a2a7	Norte P5	2025-11-29 19:49:19
019ad129-ab44-73cd-ada1-f49828f53328	019ad129-a704-728c-912a-e1296785a2a7	Los Pozos P5	2025-11-29 19:49:20
019ad129-b157-719e-8ae4-d099c25164f9	019ad129-af6d-73eb-a201-8fc9587240a7	Plan 3000 P6	2025-11-29 19:49:21
019ad129-b33a-7340-951f-83729ea31e4e	019ad129-af6d-73eb-a201-8fc9587240a7	Cristo Redentor P6	2025-11-29 19:49:22
019ad129-b59a-701e-a946-4e6d27db263b	019ad129-af6d-73eb-a201-8fc9587240a7	Este P6	2025-11-29 19:49:22
019ad129-b76d-731f-8a2b-be3771c7b68c	019ad129-af6d-73eb-a201-8fc9587240a7	Las Palmas P6	2025-11-29 19:49:23
019ad129-bdc3-7117-af7f-f019eaae1a4a	019ad129-bbee-7311-bacf-c9869897b239	Este P7	2025-11-29 19:49:25
019ad129-bfb6-735e-a694-813c43ea751d	019ad129-bbee-7311-bacf-c9869897b239	UrbarÃ­ P7	2025-11-29 19:49:25
019ad129-c1fe-73be-82fa-e96e26cd27a7	019ad129-bbee-7311-bacf-c9869897b239	Las Palmas P7	2025-11-29 19:49:26
019ad129-c3ec-7061-9f20-9237d769cc57	019ad129-bbee-7311-bacf-c9869897b239	SatÃ©lite Norte P7	2025-11-29 19:49:26
019ad129-c9ff-7191-b37f-dc980a00e709	019ad129-c820-70e2-94cc-fca1a84a0f0b	Los Pozos P8	2025-11-29 19:49:28
019ad129-cbe6-70ac-a7ee-b832adca3372	019ad129-c820-70e2-94cc-fca1a84a0f0b	Centro P8	2025-11-29 19:49:28
019ad129-d005-732b-a41c-5b7c1c6f4690	019ad129-c820-70e2-94cc-fca1a84a0f0b	Villa P8	2025-11-29 19:49:29
019ad129-d657-7242-8eef-561d37df25d9	019ad129-d467-70d9-81d4-f6e5af643be8	SatÃ©lite Norte P9	2025-11-29 19:49:31
019ad129-da8c-707d-a6df-8e416b5ccd23	019ad129-d467-70d9-81d4-f6e5af643be8	UrbarÃ­ P9	2025-11-29 19:49:32
019ad129-e100-700d-a065-cd5565a1c666	019ad129-debb-7261-800e-d8334ad7a932	Plan 3000 P10	2025-11-29 19:49:34
019ad129-e333-7156-b4de-084397f03c9f	019ad129-debb-7261-800e-d8334ad7a932	Hamacas P10	2025-11-29 19:49:34
019ad129-e50c-73df-b2fc-9d3fe93706bb	019ad129-debb-7261-800e-d8334ad7a932	UrbarÃ­ P10	2025-11-29 19:49:35
019ad129-e928-7082-a407-40cebf288d45	019ad129-debb-7261-800e-d8334ad7a932	Palmasola P10	2025-11-29 19:49:36
019ad129-ef50-71d6-a039-c08c3768eef8	019ad129-ed02-7238-b88e-c35c305f1138	SatÃ©lite Norte P11	2025-11-29 19:49:37
019ad129-f126-7175-ac23-80d47034a0f8	019ad129-ed02-7238-b88e-c35c305f1138	UrbarÃ­ P11	2025-11-29 19:49:38
019ad129-f808-70a3-8774-200f2764d0ae	019ad129-f5ba-73d0-9fff-c40ae9294f3c	Hamacas P12	2025-11-29 19:49:39
019ad129-f9f3-71e6-af81-29d281ebcd04	019ad129-f5ba-73d0-9fff-c40ae9294f3c	Las Palmas P12	2025-11-29 19:49:40
019ad129-fc37-73e7-97b7-d290266fac4c	019ad129-f5ba-73d0-9fff-c40ae9294f3c	Plan 3000 P12	2025-11-29 19:49:41
019ad129-fe19-701c-95f5-55bc708d6c75	019ad129-f5ba-73d0-9fff-c40ae9294f3c	Palmasola P12	2025-11-29 19:49:41
019ad12a-0059-736c-89b4-093e5497c7b5	019ad129-f5ba-73d0-9fff-c40ae9294f3c	UrbanizaciÃ³n P12	2025-11-29 19:49:42
019ad12a-066c-72a7-a5ae-3bbfec1d7e6e	019ad12a-0489-72f4-a46e-c7ccac08e0da	Cristo Redentor P13	2025-11-29 19:49:43
019ad12a-0852-7277-bc5e-d8bdee2c7edc	019ad12a-0489-72f4-a46e-c7ccac08e0da	Palmasola P13	2025-11-29 19:49:44
019ad12a-0c6e-70fa-b9b1-7b4e2690b046	019ad12a-0489-72f4-a46e-c7ccac08e0da	Los Pozos P13	2025-11-29 19:49:45
019ad12a-1263-7032-be5e-12836f8c2995	019ad12a-1087-70eb-ab1b-b5f01e0084f8	UrbarÃ­ P14	2025-11-29 19:49:46
019ad12a-144c-70cf-944e-9a96c1de030f	019ad12a-1087-70eb-ab1b-b5f01e0084f8	Las Palmas P14	2025-11-29 19:49:47
019ad12a-16a2-70b9-b034-1d988ddd6e6f	019ad12a-1087-70eb-ab1b-b5f01e0084f8	Norte P14	2025-11-29 19:49:47
019ad12a-1d23-7255-bcb4-3ab79d480d86	019ad12a-1a5a-71d2-9512-526ea3c25ebe	Norte Q1	2025-11-29 19:49:49
019ad12a-1f6d-714e-bfb0-13aca2067e84	019ad12a-1a5a-71d2-9512-526ea3c25ebe	Sur Q1	2025-11-29 19:49:50
019ad12a-214f-707e-a847-7ff2aa1102d9	019ad12a-1a5a-71d2-9512-526ea3c25ebe	UrbanizaciÃ³n Q1	2025-11-29 19:49:50
019ad12a-27ef-7207-b022-71ee43fc22eb	019ad12a-259a-70e9-9687-af59d0de33ba	Sur Q2	2025-11-29 19:49:52
019ad12a-29cd-7217-90e5-2b3cec4d1359	019ad12a-259a-70e9-9687-af59d0de33ba	Centro Q2	2025-11-29 19:49:52
019ad12a-2c18-7127-b0e1-7a966c7ee44b	019ad12a-259a-70e9-9687-af59d0de33ba	SatÃ©lite Norte Q2	2025-11-29 19:49:53
019ad12a-2dfa-72c1-bcac-a173749348cc	019ad12a-259a-70e9-9687-af59d0de33ba	Equipetrol Q2	2025-11-29 19:49:53
019ad12a-364d-7032-a220-e035ea52801a	019ad12a-3402-708f-99a5-35228523c459	Sur Q3	2025-11-29 19:49:55
019ad12a-3833-726f-8373-f5e43212217a	019ad12a-3402-708f-99a5-35228523c459	Este Q3	2025-11-29 19:49:56
019ad12a-3e20-7244-ab56-0198a09c370e	019ad12a-3c29-703b-b61c-b96a2892dad8	Equipetrol Q4	2025-11-29 19:49:57
019ad12a-4064-734c-81e5-1496c363ad82	019ad12a-3c29-703b-b61c-b96a2892dad8	Oeste Q4	2025-11-29 19:49:58
019ad12a-423f-73dd-905b-962fe0dcac7e	019ad12a-3c29-703b-b61c-b96a2892dad8	Centro Q4	2025-11-29 19:49:58
019ad12a-4420-71fc-8a67-1fc8516efce6	019ad12a-3c29-703b-b61c-b96a2892dad8	Cristo Redentor Q4	2025-11-29 19:49:59
019ad12a-4aa0-73ed-9e91-dbe8141581fe	019ad12a-485b-701c-9b9c-3fb4e2717798	Palmasola Q5	2025-11-29 19:50:01
019ad12a-4cf4-7305-b82b-3b147fbf96c1	019ad12a-485b-701c-9b9c-3fb4e2717798	Plan 3000 Q5	2025-11-29 19:50:01
019ad12a-4f5f-7211-8f8c-b38d0e596b6d	019ad12a-485b-701c-9b9c-3fb4e2717798	Las Palmas Q5	2025-11-29 19:50:02
019ad12a-55ff-706f-a07f-25e2b65a097b	019ad12a-53bb-7219-bdfc-68945d619b26	Cristo Redentor Q6	2025-11-29 19:50:04
019ad12a-57dd-71db-ba46-e10ce27fe65c	019ad12a-53bb-7219-bdfc-68945d619b26	Centro Q6	2025-11-29 19:50:04
019ad12a-5dff-70d6-85e1-188be81204d4	019ad12a-5c0c-7361-804d-cb3c2033ab37	SatÃ©lite Norte Q7	2025-11-29 19:50:06
019ad12a-6055-70b9-b9bd-34b8a1e0768d	019ad12a-5c0c-7361-804d-cb3c2033ab37	Cristo Redentor Q7	2025-11-29 19:50:06
019ad12a-6410-7376-9543-f95c17676eac	019ad12a-5c0c-7361-804d-cb3c2033ab37	Las Palmas Q7	2025-11-29 19:50:07
019ad12a-69f6-702e-ab3d-7e8299f65e7a	019ad12a-681f-7374-8152-1306f6b2e85b	Plan 3000 Q8	2025-11-29 19:50:09
019ad12a-6c54-703f-8297-b14ac5e344ce	019ad12a-681f-7374-8152-1306f6b2e85b	Este Q8	2025-11-29 19:50:09
019ad12a-729f-710d-89d7-d04e7b1ae8ae	019ad12a-70b3-713d-8e5b-0323c338e2d4	UrbarÃ­ Q9	2025-11-29 19:50:11
019ad12a-74f4-7363-ac4a-128344d12070	019ad12a-70b3-713d-8e5b-0323c338e2d4	UrbanizaciÃ³n Q9	2025-11-29 19:50:11
019ad12a-76cb-72a6-a1a5-a5aafff425e3	019ad12a-70b3-713d-8e5b-0323c338e2d4	Oeste Q9	2025-11-29 19:50:12
019ad12a-7ced-70da-95ba-b93c4aa1aef7	019ad12a-7b07-7261-86b5-b59ff4cbe2fa	Centro Q10	2025-11-29 19:50:13
019ad12a-7ecd-7298-95cc-9f072a87643f	019ad12a-7b07-7261-86b5-b59ff4cbe2fa	Palmasola Q10	2025-11-29 19:50:14
019ad12a-859c-734a-bf24-1a38c53364bf	019ad12a-8364-70c6-b2d5-3ff080252d25	Los Pozos Q11	2025-11-29 19:50:16
019ad12a-8776-736a-b1fb-a55f8820e96e	019ad12a-8364-70c6-b2d5-3ff080252d25	Hamacas Q11	2025-11-29 19:50:16
019ad12a-8e1e-712b-ae4d-cad17030c3e9	019ad12a-8bc5-72d8-8e25-718b740135b1	SatÃ©lite Norte Q12	2025-11-29 19:50:18
019ad12a-9235-7293-b124-f9837ebb5e28	019ad12a-8bc5-72d8-8e25-718b740135b1	Centro Q12	2025-11-29 19:50:19
019ad12a-9480-7112-9b63-67fe3e712934	019ad12a-8bc5-72d8-8e25-718b740135b1	UrbanizaciÃ³n Q12	2025-11-29 19:50:20
019ad12a-96c6-73e8-a6e5-4f58d2a58816	019ad12a-8bc5-72d8-8e25-718b740135b1	Oeste Q12	2025-11-29 19:50:20
019ad12a-9d7a-73fe-a49c-0ec785abcb76	019ad12a-9b1a-7132-a570-b57e3e07a8a8	Hamacas Q13	2025-11-29 19:50:22
019ad12a-9fb6-7360-aba6-a1600dc327ef	019ad12a-9b1a-7132-a570-b57e3e07a8a8	Cristo Redentor Q13	2025-11-29 19:50:22
019ad12a-a1a7-72fa-8b46-4d82d7c0af3f	019ad12a-9b1a-7132-a570-b57e3e07a8a8	Los Pozos Q13	2025-11-29 19:50:23
019ad12a-a38a-73bf-afc1-cf402d59deab	019ad12a-9b1a-7132-a570-b57e3e07a8a8	SatÃ©lite Norte Q13	2025-11-29 19:50:23
019ad12a-aa36-7083-9860-bbf45ff8ca6c	019ad12a-a7d7-73a8-a569-62a2ddd043c1	Cristo Redentor Q14	2025-11-29 19:50:25
019ad12a-ac2a-7330-abfa-24c495bc29a9	019ad12a-a7d7-73a8-a569-62a2ddd043c1	UrbarÃ­ Q14	2025-11-29 19:50:26
019ad12a-b04c-7296-9994-14bc412cfe9d	019ad12a-a7d7-73a8-a569-62a2ddd043c1	UrbanizaciÃ³n Q14	2025-11-29 19:50:27
019ad12a-b228-71c1-a8ff-916d657cf2de	019ad12a-a7d7-73a8-a569-62a2ddd043c1	Equipetrol Q14	2025-11-29 19:50:27
\.


--
-- Data for Name: cuadrantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuadrantes (id, codigo, fila, columna, nombre, geometria, centro, lat_min, lat_max, lng_min, lng_max, ciudad, zona, barrios, activo, created_at, centro_lat, centro_lng) FROM stdin;
019ad11f-93c9-7099-9542-88e8e959b99d	A1	A	1	Cuadrante A1	\N	\N	-17.70900000	-17.70000000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:38:18	-17.70450000	-63.24450000
019ad11f-9edc-71c7-9d9b-8da1371ca5e0	A2	A	2	Cuadrante A2	\N	\N	-17.70900000	-17.70000000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:38:21	-17.70450000	-63.23350000
019ad11f-a8e7-72bf-9c65-32ab9bb6d571	A3	A	3	Cuadrante A3	\N	\N	-17.70900000	-17.70000000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:38:24	-17.70450000	-63.22250000
019ad11f-b649-7172-afe8-bef6f2865a80	A4	A	4	Cuadrante A4	\N	\N	-17.70900000	-17.70000000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:38:27	-17.70450000	-63.21150000
019ad11f-c0db-72b1-804d-1df0b91e01a0	A5	A	5	Cuadrante A5	\N	\N	-17.70900000	-17.70000000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:38:30	-17.70450000	-63.20050000
019ad11f-cc1d-73b3-8864-9c9ea2d7299b	A6	A	6	Cuadrante A6	\N	\N	-17.70900000	-17.70000000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:38:33	-17.70450000	-63.18950000
019ad11f-d653-71d2-be73-0a87e453cf87	A7	A	7	Cuadrante A7	\N	\N	-17.70900000	-17.70000000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:35	-17.70450000	-63.17850000
019ad11f-de3b-7354-b4cd-58f5f42ea670	A8	A	8	Cuadrante A8	\N	\N	-17.70900000	-17.70000000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:38	-17.70450000	-63.16750000
019ad11f-e910-7015-af14-50722fd9eeeb	A9	A	9	Cuadrante A9	\N	\N	-17.70900000	-17.70000000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:40	-17.70450000	-63.15650000
019ad11f-f536-7145-b0cf-778bcebcbfdf	A10	A	10	Cuadrante A10	\N	\N	-17.70900000	-17.70000000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:43	-17.70450000	-63.14550000
019ad120-01ee-71a8-b7bd-fdee54895cad	A11	A	11	Cuadrante A11	\N	\N	-17.70900000	-17.70000000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:47	-17.70450000	-63.13450000
019ad120-0fb1-7167-be1f-77d3a197244b	A12	A	12	Cuadrante A12	\N	\N	-17.70900000	-17.70000000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:50	-17.70450000	-63.12350000
019ad120-1bdf-7263-abb3-59bb576df920	A13	A	13	Cuadrante A13	\N	\N	-17.70900000	-17.70000000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:53	-17.70450000	-63.11250000
019ad120-23e8-73de-a677-4c5185af27f0	A14	A	14	Cuadrante A14	\N	\N	-17.70900000	-17.70000000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:38:55	-17.70450000	-63.10150000
019ad120-3110-7345-a11e-ff591319d967	B1	B	1	Cuadrante B1	\N	\N	-17.71800000	-17.70900000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:38:59	-17.71350000	-63.24450000
019ad120-3fea-70a3-ac08-471dd0060eaf	B2	B	2	Cuadrante B2	\N	\N	-17.71800000	-17.70900000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:03	-17.71350000	-63.23350000
019ad120-4f05-7354-abcf-2e4d969da2ee	B3	B	3	Cuadrante B3	\N	\N	-17.71800000	-17.70900000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:06	-17.71350000	-63.22250000
019ad120-5b6e-7228-845f-00433a02d2d5	B4	B	4	Cuadrante B4	\N	\N	-17.71800000	-17.70900000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:10	-17.71350000	-63.21150000
019ad120-63cd-7181-a99a-aa451f5db3d8	B5	B	5	Cuadrante B5	\N	\N	-17.71800000	-17.70900000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:12	-17.71350000	-63.20050000
019ad120-7410-7312-80c5-c5865b70b333	B6	B	6	Cuadrante B6	\N	\N	-17.71800000	-17.70900000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:16	-17.71350000	-63.18950000
019ad120-7f62-70f0-8312-6a6dcf1cfd7b	B7	B	7	Cuadrante B7	\N	\N	-17.71800000	-17.70900000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:19	-17.71350000	-63.17850000
019ad120-8c7d-7244-8899-50f49ae84b12	B8	B	8	Cuadrante B8	\N	\N	-17.71800000	-17.70900000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:22	-17.71350000	-63.16750000
019ad120-994c-71b0-80db-73c31500fb65	B9	B	9	Cuadrante B9	\N	\N	-17.71800000	-17.70900000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:25	-17.71350000	-63.15650000
019ad120-a3c3-71da-9668-07a31c600b03	B10	B	10	Cuadrante B10	\N	\N	-17.71800000	-17.70900000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:28	-17.71350000	-63.14550000
019ad120-b0b5-73ef-8328-5bce7948cd19	B11	B	11	Cuadrante B11	\N	\N	-17.71800000	-17.70900000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:31	-17.71350000	-63.13450000
019ad120-bbd6-72dd-a2c4-ccadb90be88f	B12	B	12	Cuadrante B12	\N	\N	-17.71800000	-17.70900000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:34	-17.71350000	-63.12350000
019ad120-c642-70ab-a243-63d667c9ccd0	B13	B	13	Cuadrante B13	\N	\N	-17.71800000	-17.70900000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:37	-17.71350000	-63.11250000
019ad120-d2b1-724a-b4b7-bb8b9492bb3c	B14	B	14	Cuadrante B14	\N	\N	-17.71800000	-17.70900000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:39:40	-17.71350000	-63.10150000
019ad120-db91-705e-9ffc-0252e97b2bc1	C1	C	1	Cuadrante C1	\N	\N	-17.72700000	-17.71800000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:42	-17.72250000	-63.24450000
019ad120-e3da-7363-95f9-9a5fc1920ed5	C2	C	2	Cuadrante C2	\N	\N	-17.72700000	-17.71800000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:44	-17.72250000	-63.23350000
019ad120-f3ad-73a5-9143-ba8f60034202	C3	C	3	Cuadrante C3	\N	\N	-17.72700000	-17.71800000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:49	-17.72250000	-63.22250000
019ad121-028e-73be-bb89-01679a2aff90	C4	C	4	Cuadrante C4	\N	\N	-17.72700000	-17.71800000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:52	-17.72250000	-63.21150000
019ad121-0ef0-7224-9b3e-eb3f7a5eecf1	C5	C	5	Cuadrante C5	\N	\N	-17.72700000	-17.71800000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:56	-17.72250000	-63.20050000
019ad121-1c62-7274-8d0d-540878d127f5	C6	C	6	Cuadrante C6	\N	\N	-17.72700000	-17.71800000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:39:59	-17.72250000	-63.18950000
019ad121-24fd-731b-b538-e23c7822e1b5	C7	C	7	Cuadrante C7	\N	\N	-17.72700000	-17.71800000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:01	-17.72250000	-63.17850000
019ad121-33f4-71e0-9cd5-fccd55a73d43	C8	C	8	Cuadrante C8	\N	\N	-17.72700000	-17.71800000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:05	-17.72250000	-63.16750000
019ad121-4096-7359-9d9b-521c6c6889aa	C9	C	9	Cuadrante C9	\N	\N	-17.72700000	-17.71800000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:08	-17.72250000	-63.15650000
019ad121-4d2d-7201-937e-0164ae9adde8	C10	C	10	Cuadrante C10	\N	\N	-17.72700000	-17.71800000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:11	-17.72250000	-63.14550000
019ad121-59af-7282-8874-008208d4b228	C11	C	11	Cuadrante C11	\N	\N	-17.72700000	-17.71800000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:15	-17.72250000	-63.13450000
019ad121-689e-736e-8f24-3adac30d5ec6	C12	C	12	Cuadrante C12	\N	\N	-17.72700000	-17.71800000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:18	-17.72250000	-63.12350000
019ad121-70a3-707e-8991-7a00f2401c2f	C13	C	13	Cuadrante C13	\N	\N	-17.72700000	-17.71800000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:21	-17.72250000	-63.11250000
019ad121-7b14-7129-a192-cfbbd05f9d3f	C14	C	14	Cuadrante C14	\N	\N	-17.72700000	-17.71800000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:23	-17.72250000	-63.10150000
019ad121-85cd-7216-bd0a-b89abcecac4d	D1	D	1	Cuadrante D1	\N	\N	-17.73600000	-17.72700000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:40:26	-17.73150000	-63.24450000
019ad121-948e-72ba-a607-c447d0f7142c	D2	D	2	Cuadrante D2	\N	\N	-17.73600000	-17.72700000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:40:30	-17.73150000	-63.23350000
019ad121-a42b-734e-8a92-5c60486b1443	D3	D	3	Cuadrante D3	\N	\N	-17.73600000	-17.72700000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:40:34	-17.73150000	-63.22250000
019ad121-af1c-7119-a214-86de277bcffe	D4	D	4	Cuadrante D4	\N	\N	-17.73600000	-17.72700000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:40:37	-17.73150000	-63.21150000
019ad121-b7d1-7159-aadb-4708fabc0883	D5	D	5	Cuadrante D5	\N	\N	-17.73600000	-17.72700000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:40:39	-17.73150000	-63.20050000
019ad121-c71c-7160-8f1f-76bb7be2493f	D6	D	6	Cuadrante D6	\N	\N	-17.73600000	-17.72700000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:40:43	-17.73150000	-63.18950000
019ad121-d5f5-73bf-9102-8c3ea8bf7f7d	D7	D	7	Cuadrante D7	\N	\N	-17.73600000	-17.72700000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:46	-17.73150000	-63.17850000
019ad121-e23b-7008-82e9-9c5a6dc48c65	D8	D	8	Cuadrante D8	\N	\N	-17.73600000	-17.72700000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:50	-17.73150000	-63.16750000
019ad121-ecf8-739c-97c0-49a1e1a0dd5e	D9	D	9	Cuadrante D9	\N	\N	-17.73600000	-17.72700000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:52	-17.73150000	-63.15650000
019ad121-f56d-7311-bb95-5f8314c30d02	D10	D	10	Cuadrante D10	\N	\N	-17.73600000	-17.72700000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:55	-17.73150000	-63.14550000
019ad122-025d-71d3-badd-2acc9285dd06	D11	D	11	Cuadrante D11	\N	\N	-17.73600000	-17.72700000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:40:58	-17.73150000	-63.13450000
019ad122-0d0d-7200-94cc-b2cc9068f0e2	D12	D	12	Cuadrante D12	\N	\N	-17.73600000	-17.72700000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:01	-17.73150000	-63.12350000
019ad122-1cc5-726f-89d2-bcbf49aee788	D13	D	13	Cuadrante D13	\N	\N	-17.73600000	-17.72700000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:05	-17.73150000	-63.11250000
019ad122-2d6e-739a-95ed-d091372687c9	D14	D	14	Cuadrante D14	\N	\N	-17.73600000	-17.72700000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:09	-17.73150000	-63.10150000
019ad122-39eb-72af-a1e1-d81066fe703f	E1	E	1	Cuadrante E1	\N	\N	-17.74500000	-17.73600000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:12	-17.74050000	-63.24450000
019ad122-4798-7081-b1d4-5b66fc5d9f70	E2	E	2	Cuadrante E2	\N	\N	-17.74500000	-17.73600000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:16	-17.74050000	-63.23350000
019ad122-544b-7212-850f-1196c2092b30	E3	E	3	Cuadrante E3	\N	\N	-17.74500000	-17.73600000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:19	-17.74050000	-63.22250000
019ad122-62de-705f-ae1e-93d0b9a0dfff	E4	E	4	Cuadrante E4	\N	\N	-17.74500000	-17.73600000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:23	-17.74050000	-63.21150000
019ad122-6efc-70cb-b36b-31828140b288	E5	E	5	Cuadrante E5	\N	\N	-17.74500000	-17.73600000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:26	-17.74050000	-63.20050000
019ad122-7774-71e3-8e5a-8aeb8771701b	E6	E	6	Cuadrante E6	\N	\N	-17.74500000	-17.73600000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:28	-17.74050000	-63.18950000
019ad122-83ec-72d8-9871-897d12966042	E7	E	7	Cuadrante E7	\N	\N	-17.74500000	-17.73600000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:31	-17.74050000	-63.17850000
019ad122-8f2d-73b3-b91e-11848d9794f8	E8	E	8	Cuadrante E8	\N	\N	-17.74500000	-17.73600000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:34	-17.74050000	-63.16750000
019ad122-97cb-71fa-8f99-336ee2270965	E9	E	9	Cuadrante E9	\N	\N	-17.74500000	-17.73600000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:36	-17.74050000	-63.15650000
019ad122-a2d7-7356-92ca-880c8cec5874	E10	E	10	Cuadrante E10	\N	\N	-17.74500000	-17.73600000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:39	-17.74050000	-63.14550000
019ad122-ad53-733c-a6a2-8baedaff8058	E11	E	11	Cuadrante E11	\N	\N	-17.74500000	-17.73600000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:42	-17.74050000	-63.13450000
019ad122-b61d-7395-9159-42319dd91914	E12	E	12	Cuadrante E12	\N	\N	-17.74500000	-17.73600000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:44	-17.74050000	-63.12350000
019ad122-c529-7348-ac7e-459398a558c4	E13	E	13	Cuadrante E13	\N	\N	-17.74500000	-17.73600000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:48	-17.74050000	-63.11250000
019ad122-cf98-7071-ad9f-63c6316044cf	E14	E	14	Cuadrante E14	\N	\N	-17.74500000	-17.73600000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:41:50	-17.74050000	-63.10150000
019ad122-df13-708e-a597-989a222f1789	F1	F	1	Cuadrante F1	\N	\N	-17.75400000	-17.74500000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:54	-17.74950000	-63.24450000
019ad122-ec50-7164-84ad-eea8c619e7cd	F2	F	2	Cuadrante F2	\N	\N	-17.75400000	-17.74500000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:41:58	-17.74950000	-63.23350000
019ad122-f935-70a4-84e7-af226d0d011d	F3	F	3	Cuadrante F3	\N	\N	-17.75400000	-17.74500000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:01	-17.74950000	-63.22250000
019ad123-02a9-73fd-8c4a-16d9996b4e0a	F4	F	4	Cuadrante F4	\N	\N	-17.75400000	-17.74500000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:03	-17.74950000	-63.21150000
019ad123-0f6f-7111-a995-5864a15b3e8e	F5	F	5	Cuadrante F5	\N	\N	-17.75400000	-17.74500000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:07	-17.74950000	-63.20050000
019ad123-1ef7-731b-aa46-df35ec9345e7	F6	F	6	Cuadrante F6	\N	\N	-17.75400000	-17.74500000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:11	-17.74950000	-63.18950000
019ad123-2d2b-730d-8a58-389ce9aaea6d	F7	F	7	Cuadrante F7	\N	\N	-17.75400000	-17.74500000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:14	-17.74950000	-63.17850000
019ad123-35df-718c-8488-aa0f1202135d	F8	F	8	Cuadrante F8	\N	\N	-17.75400000	-17.74500000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:17	-17.74950000	-63.16750000
019ad123-42c1-7367-b965-906b77867688	F9	F	9	Cuadrante F9	\N	\N	-17.75400000	-17.74500000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:20	-17.74950000	-63.15650000
019ad123-4dcf-70fe-9706-42ce093c7ef9	F10	F	10	Cuadrante F10	\N	\N	-17.75400000	-17.74500000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:23	-17.74950000	-63.14550000
019ad123-56d5-7181-8d3e-e2c32ee2f9a9	F11	F	11	Cuadrante F11	\N	\N	-17.75400000	-17.74500000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:25	-17.74950000	-63.13450000
019ad123-63aa-725b-9413-b8608fda48ee	F12	F	12	Cuadrante F12	\N	\N	-17.75400000	-17.74500000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:28	-17.74950000	-63.12350000
019ad123-7081-73a1-a438-df0f6b141b82	F13	F	13	Cuadrante F13	\N	\N	-17.75400000	-17.74500000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:32	-17.74950000	-63.11250000
019ad123-7be2-7029-8bba-1546a2e45a47	F14	F	14	Cuadrante F14	\N	\N	-17.75400000	-17.74500000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:34	-17.74950000	-63.10150000
019ad123-8441-7396-a494-e0532fc4052f	G1	G	1	Cuadrante G1	\N	\N	-17.76300000	-17.75400000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:37	-17.75850000	-63.24450000
019ad123-8f5a-72a9-8c50-2ac8b07599bc	G2	G	2	Cuadrante G2	\N	\N	-17.76300000	-17.75400000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:39	-17.75850000	-63.23350000
019ad123-9e73-706a-b979-d2352e7d107a	G3	G	3	Cuadrante G3	\N	\N	-17.76300000	-17.75400000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:43	-17.75850000	-63.22250000
019ad123-a8a1-70a7-ba89-379e6b7a285b	G4	G	4	Cuadrante G4	\N	\N	-17.76300000	-17.75400000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:46	-17.75850000	-63.21150000
019ad123-b516-727a-bfa8-d8b1bccfd009	G5	G	5	Cuadrante G5	\N	\N	-17.76300000	-17.75400000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:49	-17.75850000	-63.20050000
019ad123-c214-71a9-a6fd-28bf2b7c981f	G6	G	6	Cuadrante G6	\N	\N	-17.76300000	-17.75400000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:42:52	-17.75850000	-63.18950000
019ad123-ca79-7377-9b89-7b3eadc8f974	G7	G	7	Cuadrante G7	\N	\N	-17.76300000	-17.75400000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:55	-17.75850000	-63.17850000
019ad123-d923-7209-868b-884d794bd927	G8	G	8	Cuadrante G8	\N	\N	-17.76300000	-17.75400000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:42:58	-17.75850000	-63.16750000
019ad123-e835-7366-ae21-d54021259015	G9	G	9	Cuadrante G9	\N	\N	-17.76300000	-17.75400000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:02	-17.75850000	-63.15650000
019ad123-f6c0-7057-9954-782bf5e37746	G10	G	10	Cuadrante G10	\N	\N	-17.76300000	-17.75400000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:06	-17.75850000	-63.14550000
019ad124-04ad-71bc-926b-b85ec1dd015f	G11	G	11	Cuadrante G11	\N	\N	-17.76300000	-17.75400000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:09	-17.75850000	-63.13450000
019ad124-1338-72aa-8a04-c68c8743c41b	G12	G	12	Cuadrante G12	\N	\N	-17.76300000	-17.75400000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:13	-17.75850000	-63.12350000
019ad124-21ff-7310-a1a7-4770f85e9ed2	G13	G	13	Cuadrante G13	\N	\N	-17.76300000	-17.75400000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:17	-17.75850000	-63.11250000
019ad124-2e38-718a-8d42-9c91ac03eb73	G14	G	14	Cuadrante G14	\N	\N	-17.76300000	-17.75400000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:20	-17.75850000	-63.10150000
019ad124-3866-7353-996f-04876d745709	H1	H	1	Cuadrante H1	\N	\N	-17.77200000	-17.76300000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:43:23	-17.76750000	-63.24450000
019ad124-4119-72c4-892f-b195145ede0c	H2	H	2	Cuadrante H2	\N	\N	-17.77200000	-17.76300000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:43:25	-17.76750000	-63.23350000
019ad124-4909-70e5-87da-201d1f7cd740	H3	H	3	Cuadrante H3	\N	\N	-17.77200000	-17.76300000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:43:27	-17.76750000	-63.22250000
019ad124-567f-71e1-b2ea-5a0bcf65f900	H4	H	4	Cuadrante H4	\N	\N	-17.77200000	-17.76300000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:43:30	-17.76750000	-63.21150000
019ad124-5e99-7251-9324-86f698d3bc5e	H5	H	5	Cuadrante H5	\N	\N	-17.77200000	-17.76300000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:43:33	-17.76750000	-63.20050000
019ad124-69eb-71ab-b429-dd9e887c6b6b	H6	H	6	Cuadrante H6	\N	\N	-17.77200000	-17.76300000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:43:35	-17.76750000	-63.18950000
019ad124-786e-73e7-9a9b-acb07ee80fe4	H7	H	7	Cuadrante H7	\N	\N	-17.77200000	-17.76300000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:39	-17.76750000	-63.17850000
019ad124-87ac-707c-b150-a1796a67b3c4	H8	H	8	Cuadrante H8	\N	\N	-17.77200000	-17.76300000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:43	-17.76750000	-63.16750000
019ad124-9004-72e8-8469-dca2061f4500	H9	H	9	Cuadrante H9	\N	\N	-17.77200000	-17.76300000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:45	-17.76750000	-63.15650000
019ad124-9ca8-71f2-8c8a-69dbf1980700	H10	H	10	Cuadrante H10	\N	\N	-17.77200000	-17.76300000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:48	-17.76750000	-63.14550000
019ad124-a497-715c-b0b0-c17c50c4b2d3	H11	H	11	Cuadrante H11	\N	\N	-17.77200000	-17.76300000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:50	-17.76750000	-63.13450000
019ad124-b170-710f-9a5f-311b4fcb2ce8	H12	H	12	Cuadrante H12	\N	\N	-17.77200000	-17.76300000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:54	-17.76750000	-63.12350000
019ad124-bbc9-72a2-9ad4-f17593c94707	H13	H	13	Cuadrante H13	\N	\N	-17.77200000	-17.76300000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:56	-17.76750000	-63.11250000
019ad124-c469-7196-8065-a47c1e915776	H14	H	14	Cuadrante H14	\N	\N	-17.77200000	-17.76300000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:43:59	-17.76750000	-63.10150000
019ad124-d010-7396-bfdb-41d6a29622b1	I1	I	1	Cuadrante I1	\N	\N	-17.78100000	-17.77200000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:44:02	-17.77650000	-63.24450000
019ad124-dea1-736a-9e00-c8e10e3aa9a8	I2	I	2	Cuadrante I2	\N	\N	-17.78100000	-17.77200000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:44:05	-17.77650000	-63.23350000
019ad124-e71e-7246-a53e-d95dbfac6ae0	I3	I	3	Cuadrante I3	\N	\N	-17.78100000	-17.77200000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:44:07	-17.77650000	-63.22250000
019ad124-f616-71d7-9c57-bbb94fa64ddb	I4	I	4	Cuadrante I4	\N	\N	-17.78100000	-17.77200000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:44:11	-17.77650000	-63.21150000
019ad124-fec1-7113-a7bc-f6a6c7ecc270	I5	I	5	Cuadrante I5	\N	\N	-17.78100000	-17.77200000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:44:14	-17.77650000	-63.20050000
019ad125-0c12-739e-b211-b9596a24ce2f	I6	I	6	Cuadrante I6	\N	\N	-17.78100000	-17.77200000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Norte	\N	t	2025-11-29 19:44:17	-17.77650000	-63.18950000
019ad125-14c6-7338-934c-7535e4c89c11	I7	I	7	Cuadrante I7	\N	\N	-17.78100000	-17.77200000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:19	-17.77650000	-63.17850000
019ad125-23a9-701e-b4a4-bb765af061f8	I8	I	8	Cuadrante I8	\N	\N	-17.78100000	-17.77200000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:23	-17.77650000	-63.16750000
019ad125-3012-736e-bf47-e257f9b30a60	I9	I	9	Cuadrante I9	\N	\N	-17.78100000	-17.77200000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:26	-17.77650000	-63.15650000
019ad125-3d53-728a-86e1-d7e0bc8e56d8	I10	I	10	Cuadrante I10	\N	\N	-17.78100000	-17.77200000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:30	-17.77650000	-63.14550000
019ad125-4a48-7265-b6c7-f9cf8bf4785b	I11	I	11	Cuadrante I11	\N	\N	-17.78100000	-17.77200000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:33	-17.77650000	-63.13450000
019ad125-58ca-71e8-8218-27edb3fe40c3	I12	I	12	Cuadrante I12	\N	\N	-17.78100000	-17.77200000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:37	-17.77650000	-63.12350000
019ad125-65de-7204-9d4e-92a721ab1d94	I13	I	13	Cuadrante I13	\N	\N	-17.78100000	-17.77200000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:40	-17.77650000	-63.11250000
019ad125-6de0-720b-9b8f-95b438003aec	I14	I	14	Cuadrante I14	\N	\N	-17.78100000	-17.77200000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Noreste	\N	t	2025-11-29 19:44:42	-17.77650000	-63.10150000
019ad125-76bb-7167-b726-a19f97fa4a2e	J1	J	1	Cuadrante J1	\N	\N	-17.79000000	-17.78100000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:44:44	-17.78550000	-63.24450000
019ad125-8173-7097-b706-38868e3b80a1	J2	J	2	Cuadrante J2	\N	\N	-17.79000000	-17.78100000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:44:47	-17.78550000	-63.23350000
019ad125-89cf-73f7-951f-8305fdd9dde0	J3	J	3	Cuadrante J3	\N	\N	-17.79000000	-17.78100000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:44:49	-17.78550000	-63.22250000
019ad125-951a-72d2-846b-ecc35575a4de	J4	J	4	Cuadrante J4	\N	\N	-17.79000000	-17.78100000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:44:52	-17.78550000	-63.21150000
019ad125-a3b0-73df-a6a3-89df080f1bec	J5	J	5	Cuadrante J5	\N	\N	-17.79000000	-17.78100000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:44:56	-17.78550000	-63.20050000
019ad125-ac68-7270-83f3-edd7fe7294b8	J6	J	6	Cuadrante J6	\N	\N	-17.79000000	-17.78100000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:44:58	-17.78550000	-63.18950000
019ad125-b936-732e-9009-da9c77de85b4	J7	J	7	Cuadrante J7	\N	\N	-17.79000000	-17.78100000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:01	-17.78550000	-63.17850000
019ad125-c61a-7137-9a95-b3a380f11e49	J8	J	8	Cuadrante J8	\N	\N	-17.79000000	-17.78100000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:05	-17.78550000	-63.16750000
019ad125-d294-7192-9840-f9eeb3086e77	J9	J	9	Cuadrante J9	\N	\N	-17.79000000	-17.78100000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:08	-17.78550000	-63.15650000
019ad125-e243-7265-a825-5815f4dc4e4d	J10	J	10	Cuadrante J10	\N	\N	-17.79000000	-17.78100000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:12	-17.78550000	-63.14550000
019ad125-ea66-7248-9b22-b5613f692a32	J11	J	11	Cuadrante J11	\N	\N	-17.79000000	-17.78100000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:14	-17.78550000	-63.13450000
019ad125-f950-71ec-97a8-fd867f080025	J12	J	12	Cuadrante J12	\N	\N	-17.79000000	-17.78100000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:18	-17.78550000	-63.12350000
019ad126-0627-7138-a832-c95789db03c6	J13	J	13	Cuadrante J13	\N	\N	-17.79000000	-17.78100000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:21	-17.78550000	-63.11250000
019ad126-152b-719e-a225-c1f5d4c7d153	J14	J	14	Cuadrante J14	\N	\N	-17.79000000	-17.78100000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:25	-17.78550000	-63.10150000
019ad126-236c-7011-9337-b8e2ac1a6d77	K1	K	1	Cuadrante K1	\N	\N	-17.79900000	-17.79000000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:45:28	-17.79450000	-63.24450000
019ad126-2ed8-7153-aa64-5edc41846459	K2	K	2	Cuadrante K2	\N	\N	-17.79900000	-17.79000000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:45:31	-17.79450000	-63.23350000
019ad126-3bbf-717d-91ee-a77f1d17ed77	K3	K	3	Cuadrante K3	\N	\N	-17.79900000	-17.79000000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:45:35	-17.79450000	-63.22250000
019ad126-4abd-71ff-9e69-b6a19a9b340d	K4	K	4	Cuadrante K4	\N	\N	-17.79900000	-17.79000000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:45:39	-17.79450000	-63.21150000
019ad126-57c4-724f-82c8-e76a6ea85c3b	K5	K	5	Cuadrante K5	\N	\N	-17.79900000	-17.79000000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:45:42	-17.79450000	-63.20050000
019ad126-6769-723c-9c40-447a04bbef8f	K6	K	6	Cuadrante K6	\N	\N	-17.79900000	-17.79000000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:45:46	-17.79450000	-63.18950000
019ad126-6f85-70e1-83a7-d986305d8b92	K7	K	7	Cuadrante K7	\N	\N	-17.79900000	-17.79000000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:48	-17.79450000	-63.17850000
019ad126-7804-73e8-b06d-072a734a8d7c	K8	K	8	Cuadrante K8	\N	\N	-17.79900000	-17.79000000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:50	-17.79450000	-63.16750000
019ad126-87c6-703e-a730-23b301bb1997	K9	K	9	Cuadrante K9	\N	\N	-17.79900000	-17.79000000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:54	-17.79450000	-63.15650000
019ad126-9692-7308-8aec-cc70eaae0eb3	K10	K	10	Cuadrante K10	\N	\N	-17.79900000	-17.79000000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:45:58	-17.79450000	-63.14550000
019ad126-9fbe-72f6-9f57-b4de32a17a07	K11	K	11	Cuadrante K11	\N	\N	-17.79900000	-17.79000000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:00	-17.79450000	-63.13450000
019ad126-aea1-720f-aece-1b621cca7668	K12	K	12	Cuadrante K12	\N	\N	-17.79900000	-17.79000000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:04	-17.79450000	-63.12350000
019ad126-b967-7357-813f-ad260e2bb656	K13	K	13	Cuadrante K13	\N	\N	-17.79900000	-17.79000000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:07	-17.79450000	-63.11250000
019ad126-c7cb-7331-ba6f-a72c71e8192b	K14	K	14	Cuadrante K14	\N	\N	-17.79900000	-17.79000000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:11	-17.79450000	-63.10150000
019ad126-d084-7188-a17f-12cea270d305	L1	L	1	Cuadrante L1	\N	\N	-17.80800000	-17.79900000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:13	-17.80350000	-63.24450000
019ad126-de2b-7189-9f63-8d2aec540598	L2	L	2	Cuadrante L2	\N	\N	-17.80800000	-17.79900000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:16	-17.80350000	-63.23350000
019ad126-ea1e-7211-8fe0-c80a851736a2	L3	L	3	Cuadrante L3	\N	\N	-17.80800000	-17.79900000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:19	-17.80350000	-63.22250000
019ad126-f4df-73b3-8b5c-fb0afe1d9b61	L4	L	4	Cuadrante L4	\N	\N	-17.80800000	-17.79900000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:22	-17.80350000	-63.21150000
019ad127-0029-70f8-9613-268b4ce0a5af	L5	L	5	Cuadrante L5	\N	\N	-17.80800000	-17.79900000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:25	-17.80350000	-63.20050000
019ad127-0af2-71bc-bcd3-8aa01e7156f8	L6	L	6	Cuadrante L6	\N	\N	-17.80800000	-17.79900000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:28	-17.80350000	-63.18950000
019ad127-19f9-7054-8d17-349961227666	L7	L	7	Cuadrante L7	\N	\N	-17.80800000	-17.79900000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:32	-17.80350000	-63.17850000
019ad127-22b3-725b-b6fe-cccfec1539b7	L8	L	8	Cuadrante L8	\N	\N	-17.80800000	-17.79900000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:34	-17.80350000	-63.16750000
019ad127-2b87-700f-9a0f-70cd2dae0cd0	L9	L	9	Cuadrante L9	\N	\N	-17.80800000	-17.79900000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:36	-17.80350000	-63.15650000
019ad127-3622-738d-ab33-86d1e30f5e6b	L10	L	10	Cuadrante L10	\N	\N	-17.80800000	-17.79900000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:39	-17.80350000	-63.14550000
019ad127-412b-70f3-ba2f-372a51966a28	L11	L	11	Cuadrante L11	\N	\N	-17.80800000	-17.79900000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:42	-17.80350000	-63.13450000
019ad127-4b8e-701e-81b8-07cff06d06fe	L12	L	12	Cuadrante L12	\N	\N	-17.80800000	-17.79900000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:44	-17.80350000	-63.12350000
019ad127-54cc-7222-b609-471036a2c681	L13	L	13	Cuadrante L13	\N	\N	-17.80800000	-17.79900000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:47	-17.80350000	-63.11250000
019ad127-6108-71d0-83b1-65c13974fcca	L14	L	14	Cuadrante L14	\N	\N	-17.80800000	-17.79900000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:46:50	-17.80350000	-63.10150000
019ad127-6de7-7299-aa3c-6bd685633f5a	M1	M	1	Cuadrante M1	\N	\N	-17.81700000	-17.80800000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:53	-17.81250000	-63.24450000
019ad127-78c1-71a7-84bc-66e18a7750ea	M2	M	2	Cuadrante M2	\N	\N	-17.81700000	-17.80800000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:56	-17.81250000	-63.23350000
019ad127-82d4-71b5-8c91-b51a39199f3d	M3	M	3	Cuadrante M3	\N	\N	-17.81700000	-17.80800000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:46:58	-17.81250000	-63.22250000
019ad127-8f5f-72b5-b599-1d54a536f699	M4	M	4	Cuadrante M4	\N	\N	-17.81700000	-17.80800000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:02	-17.81250000	-63.21150000
019ad127-9d96-7375-8987-2d12711a1752	M5	M	5	Cuadrante M5	\N	\N	-17.81700000	-17.80800000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:05	-17.81250000	-63.20050000
019ad127-a61b-7207-8713-4148a7ce4419	M6	M	6	Cuadrante M6	\N	\N	-17.81700000	-17.80800000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:07	-17.81250000	-63.18950000
019ad127-b147-71e5-b197-168632fc652a	M7	M	7	Cuadrante M7	\N	\N	-17.81700000	-17.80800000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:10	-17.81250000	-63.17850000
019ad127-b9d2-7219-ad6f-825e6152c4c0	M8	M	8	Cuadrante M8	\N	\N	-17.81700000	-17.80800000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:12	-17.81250000	-63.16750000
019ad127-c27d-7056-a7cc-2ff85061792e	M9	M	9	Cuadrante M9	\N	\N	-17.81700000	-17.80800000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:15	-17.81250000	-63.15650000
019ad127-cf5c-7313-8756-90217e0b4a1a	M10	M	10	Cuadrante M10	\N	\N	-17.81700000	-17.80800000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:18	-17.81250000	-63.14550000
019ad127-dc4d-732f-b867-6e858e9e1be0	M11	M	11	Cuadrante M11	\N	\N	-17.81700000	-17.80800000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:21	-17.81250000	-63.13450000
019ad127-e75e-731d-800f-6c5eae82b981	M12	M	12	Cuadrante M12	\N	\N	-17.81700000	-17.80800000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:24	-17.81250000	-63.12350000
019ad127-f49a-71e9-9f99-3a809484aab9	M13	M	13	Cuadrante M13	\N	\N	-17.81700000	-17.80800000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:28	-17.81250000	-63.11250000
019ad128-0381-733e-9738-af129dab192d	M14	M	14	Cuadrante M14	\N	\N	-17.81700000	-17.80800000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:31	-17.81250000	-63.10150000
019ad128-0c0e-722b-b97f-7d13f309dcc7	N1	N	1	Cuadrante N1	\N	\N	-17.82600000	-17.81700000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:34	-17.82150000	-63.24450000
019ad128-1b4c-725e-881d-923320341f05	N2	N	2	Cuadrante N2	\N	\N	-17.82600000	-17.81700000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:37	-17.82150000	-63.23350000
019ad128-2a0e-7347-aee4-f544c368d00f	N3	N	3	Cuadrante N3	\N	\N	-17.82600000	-17.81700000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:41	-17.82150000	-63.22250000
019ad128-38fb-7270-baf4-a20bb374bcf0	N4	N	4	Cuadrante N4	\N	\N	-17.82600000	-17.81700000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:45	-17.82150000	-63.21150000
019ad128-432d-70c5-b3c8-566001d0cde8	N5	N	5	Cuadrante N5	\N	\N	-17.82600000	-17.81700000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:48	-17.82150000	-63.20050000
019ad128-4f3d-70bc-b4cf-9a034c55e088	N6	N	6	Cuadrante N6	\N	\N	-17.82600000	-17.81700000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:47:51	-17.82150000	-63.18950000
019ad128-5a36-720e-8c4b-524150b38a46	N7	N	7	Cuadrante N7	\N	\N	-17.82600000	-17.81700000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:54	-17.82150000	-63.17850000
019ad128-6680-7038-bd60-a2ffd587fc18	N8	N	8	Cuadrante N8	\N	\N	-17.82600000	-17.81700000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:47:57	-17.82150000	-63.16750000
019ad128-7269-71e1-8265-bbb735ed4dd8	N9	N	9	Cuadrante N9	\N	\N	-17.82600000	-17.81700000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:00	-17.82150000	-63.15650000
019ad128-7efd-7162-8457-afc36737c8d9	N10	N	10	Cuadrante N10	\N	\N	-17.82600000	-17.81700000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:03	-17.82150000	-63.14550000
019ad128-8e7d-736a-9ff0-3ba4d2030332	N11	N	11	Cuadrante N11	\N	\N	-17.82600000	-17.81700000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:07	-17.82150000	-63.13450000
019ad128-9d64-7245-9219-ccc45589f4a9	N12	N	12	Cuadrante N12	\N	\N	-17.82600000	-17.81700000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:11	-17.82150000	-63.12350000
019ad128-a7d5-7297-bea2-d2c012972553	N13	N	13	Cuadrante N13	\N	\N	-17.82600000	-17.81700000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:13	-17.82150000	-63.11250000
019ad128-b61d-71a6-afee-e6835989c7cf	N14	N	14	Cuadrante N14	\N	\N	-17.82600000	-17.81700000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:17	-17.82150000	-63.10150000
019ad128-c09e-7116-9ee9-f32e32efcd84	O1	O	1	Cuadrante O1	\N	\N	-17.83500000	-17.82600000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:48:20	-17.83050000	-63.24450000
019ad128-ce88-72ab-888e-1a400ec9bd84	O2	O	2	Cuadrante O2	\N	\N	-17.83500000	-17.82600000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:48:23	-17.83050000	-63.23350000
019ad128-dd10-71e9-b4ae-87a99a9f89ab	O3	O	3	Cuadrante O3	\N	\N	-17.83500000	-17.82600000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:48:27	-17.83050000	-63.22250000
019ad128-ec0d-71f8-8a0d-14257173677c	O4	O	4	Cuadrante O4	\N	\N	-17.83500000	-17.82600000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:48:31	-17.83050000	-63.21150000
019ad128-fa5e-73c9-bf99-5410c5119f29	O5	O	5	Cuadrante O5	\N	\N	-17.83500000	-17.82600000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:48:35	-17.83050000	-63.20050000
019ad129-02c8-725f-a0f7-8c8f2141ff3e	O6	O	6	Cuadrante O6	\N	\N	-17.83500000	-17.82600000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:48:37	-17.83050000	-63.18950000
019ad129-0f63-7183-9aa7-60ee9f9a64ca	O7	O	7	Cuadrante O7	\N	\N	-17.83500000	-17.82600000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:40	-17.83050000	-63.17850000
019ad129-19f8-70df-ad54-e06628ab0541	O8	O	8	Cuadrante O8	\N	\N	-17.83500000	-17.82600000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:43	-17.83050000	-63.16750000
019ad129-256a-73ec-964a-dd3e86be121d	O9	O	9	Cuadrante O9	\N	\N	-17.83500000	-17.82600000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:46	-17.83050000	-63.15650000
019ad129-33e3-70ca-bc69-de05379a3905	O10	O	10	Cuadrante O10	\N	\N	-17.83500000	-17.82600000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:49	-17.83050000	-63.14550000
019ad129-3e95-7305-8a0a-caab679e7401	O11	O	11	Cuadrante O11	\N	\N	-17.83500000	-17.82600000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:52	-17.83050000	-63.13450000
019ad129-4c8b-709b-a27a-790d15a34423	O12	O	12	Cuadrante O12	\N	\N	-17.83500000	-17.82600000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:56	-17.83050000	-63.12350000
019ad129-5aa0-72b7-a209-bb3a6129a7b8	O13	O	13	Cuadrante O13	\N	\N	-17.83500000	-17.82600000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:48:59	-17.83050000	-63.11250000
019ad129-672b-7343-bc3c-0aaa78b6644c	O14	O	14	Cuadrante O14	\N	\N	-17.83500000	-17.82600000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:02	-17.83050000	-63.10150000
019ad129-7330-70fc-b43a-89ef1b66b9b8	P1	P	1	Cuadrante P1	\N	\N	-17.84400000	-17.83500000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:05	-17.83950000	-63.24450000
019ad129-81b0-736b-85a7-4ae840ca4a81	P2	P	2	Cuadrante P2	\N	\N	-17.84400000	-17.83500000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:09	-17.83950000	-63.23350000
019ad129-9064-707c-b5d3-ca7600e3e91c	P3	P	3	Cuadrante P3	\N	\N	-17.84400000	-17.83500000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:13	-17.83950000	-63.22250000
019ad129-9eff-7381-b73d-7c92c2d22ea2	P4	P	4	Cuadrante P4	\N	\N	-17.84400000	-17.83500000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:17	-17.83950000	-63.21150000
019ad129-a704-728c-912a-e1296785a2a7	P5	P	5	Cuadrante P5	\N	\N	-17.84400000	-17.83500000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:19	-17.83950000	-63.20050000
019ad129-af6d-73eb-a201-8fc9587240a7	P6	P	6	Cuadrante P6	\N	\N	-17.84400000	-17.83500000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:21	-17.83950000	-63.18950000
019ad129-bbee-7311-bacf-c9869897b239	P7	P	7	Cuadrante P7	\N	\N	-17.84400000	-17.83500000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:24	-17.83950000	-63.17850000
019ad129-c820-70e2-94cc-fca1a84a0f0b	P8	P	8	Cuadrante P8	\N	\N	-17.84400000	-17.83500000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:27	-17.83950000	-63.16750000
019ad129-d467-70d9-81d4-f6e5af643be8	P9	P	9	Cuadrante P9	\N	\N	-17.84400000	-17.83500000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:30	-17.83950000	-63.15650000
019ad129-debb-7261-800e-d8334ad7a932	P10	P	10	Cuadrante P10	\N	\N	-17.84400000	-17.83500000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:33	-17.83950000	-63.14550000
019ad129-ed02-7238-b88e-c35c305f1138	P11	P	11	Cuadrante P11	\N	\N	-17.84400000	-17.83500000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:37	-17.83950000	-63.13450000
019ad129-f5ba-73d0-9fff-c40ae9294f3c	P12	P	12	Cuadrante P12	\N	\N	-17.84400000	-17.83500000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:39	-17.83950000	-63.12350000
019ad12a-0489-72f4-a46e-c7ccac08e0da	P13	P	13	Cuadrante P13	\N	\N	-17.84400000	-17.83500000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:43	-17.83950000	-63.11250000
019ad12a-1087-70eb-ab1b-b5f01e0084f8	P14	P	14	Cuadrante P14	\N	\N	-17.84400000	-17.83500000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:49:46	-17.83950000	-63.10150000
019ad12a-1a5a-71d2-9512-526ea3c25ebe	Q1	Q	1	Cuadrante Q1	\N	\N	-17.85300000	-17.84400000	-63.25000000	-63.23900000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:48	-17.84850000	-63.24450000
019ad12a-259a-70e9-9687-af59d0de33ba	Q2	Q	2	Cuadrante Q2	\N	\N	-17.85300000	-17.84400000	-63.23900000	-63.22800000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:51	-17.84850000	-63.23350000
019ad12a-3402-708f-99a5-35228523c459	Q3	Q	3	Cuadrante Q3	\N	\N	-17.85300000	-17.84400000	-63.22800000	-63.21700000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:55	-17.84850000	-63.22250000
019ad12a-3c29-703b-b61c-b96a2892dad8	Q4	Q	4	Cuadrante Q4	\N	\N	-17.85300000	-17.84400000	-63.21700000	-63.20600000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:49:57	-17.84850000	-63.21150000
019ad12a-485b-701c-9b9c-3fb4e2717798	Q5	Q	5	Cuadrante Q5	\N	\N	-17.85300000	-17.84400000	-63.20600000	-63.19500000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:50:00	-17.84850000	-63.20050000
019ad12a-53bb-7219-bdfc-68945d619b26	Q6	Q	6	Cuadrante Q6	\N	\N	-17.85300000	-17.84400000	-63.19500000	-63.18400000	Santa Cruz de la Sierra	Sur	\N	t	2025-11-29 19:50:03	-17.84850000	-63.18950000
019ad12a-5c0c-7361-804d-cb3c2033ab37	Q7	Q	7	Cuadrante Q7	\N	\N	-17.85300000	-17.84400000	-63.18400000	-63.17300000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:05	-17.84850000	-63.17850000
019ad12a-681f-7374-8152-1306f6b2e85b	Q8	Q	8	Cuadrante Q8	\N	\N	-17.85300000	-17.84400000	-63.17300000	-63.16200000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:08	-17.84850000	-63.16750000
019ad12a-70b3-713d-8e5b-0323c338e2d4	Q9	Q	9	Cuadrante Q9	\N	\N	-17.85300000	-17.84400000	-63.16200000	-63.15100000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:10	-17.84850000	-63.15650000
019ad12a-7b07-7261-86b5-b59ff4cbe2fa	Q10	Q	10	Cuadrante Q10	\N	\N	-17.85300000	-17.84400000	-63.15100000	-63.14000000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:13	-17.84850000	-63.14550000
019ad12a-8364-70c6-b2d5-3ff080252d25	Q11	Q	11	Cuadrante Q11	\N	\N	-17.85300000	-17.84400000	-63.14000000	-63.12900000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:15	-17.84850000	-63.13450000
019ad12a-8bc5-72d8-8e25-718b740135b1	Q12	Q	12	Cuadrante Q12	\N	\N	-17.85300000	-17.84400000	-63.12900000	-63.11800000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:17	-17.84850000	-63.12350000
019ad12a-9b1a-7132-a570-b57e3e07a8a8	Q13	Q	13	Cuadrante Q13	\N	\N	-17.85300000	-17.84400000	-63.11800000	-63.10700000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:21	-17.84850000	-63.11250000
019ad12a-a7d7-73a8-a569-62a2ddd043c1	Q14	Q	14	Cuadrante Q14	\N	\N	-17.85300000	-17.84400000	-63.10700000	-63.09600000	Santa Cruz de la Sierra	Este	\N	t	2025-11-29 19:50:24	-17.84850000	-63.10150000
\.


--
-- Data for Name: expansiones_reporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expansiones_reporte (id, reporte_id, cuadrante_original_id, cuadrante_expandido_id, nivel, fecha_expansion, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: grupo_miembros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo_miembros (id, grupo_id, usuario_id, rol, notificaciones_activas, joined_at, created_at, updated_at) FROM stdin;
019aeaee-283d-7109-917b-75a152f5b185	019ad121-3173-73a3-a651-956ff0625eaa	019aeaee-0755-72ad-8b98-5ae66bf1d489	miembro	t	2025-12-04 19:54:27	2025-12-13 11:56:21	\N
019aeaf2-ccca-7145-921c-d3bbde6a0fec	019ad121-3173-73a3-a651-956ff0625eaa	019aeaf2-c3fb-7044-857a-163ee20bb36c	miembro	t	2025-12-04 19:59:32	2025-12-13 11:56:21	\N
019aec74-b353-7221-ae8d-06719c8011bd	019ad123-5496-7181-8c2b-a6602d43a2bc	019ad0d8-55b1-7145-9af2-905afadc3730	miembro	t	2025-12-05 03:01:02	2025-12-13 11:56:21	\N
019aec78-f565-701f-bc5a-7d12801c9539	019ad123-5496-7181-8c2b-a6602d43a2bc	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	miembro	t	2025-12-05 03:05:41	2025-12-13 11:56:21	\N
\.


--
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupos (id, cuadrante_id, nombre, descripcion, imagen_url, publico, requiere_aprobacion, miembros_count, reportes_activos_count, reportes_resueltos_count, created_at, updated_at) FROM stdin;
019ad11f-9c88-709f-8017-dbe4e689960f	019ad11f-93c9-7099-9542-88e8e959b99d	Grupo Cuadrante A1	Grupo comunitario del Cuadrante A1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:38:21	2025-11-29 19:38:21
019ad11f-a710-708c-acb4-745e90d48a1c	019ad11f-9edc-71c7-9d9b-8da1371ca5e0	Grupo Cuadrante A2	Grupo comunitario del Cuadrante A2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:38:23	2025-11-29 19:38:23
019ad11f-b442-7337-838e-dbf5098a8bba	019ad11f-a8e7-72bf-9c65-32ab9bb6d571	Grupo Cuadrante A3	Grupo comunitario del Cuadrante A3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:38:27	2025-11-29 19:38:27
019ad11f-bee8-7067-afb4-96e2da5554d7	019ad11f-b649-7172-afe8-bef6f2865a80	Grupo Cuadrante A4	Grupo comunitario del Cuadrante A4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:38:29	2025-11-29 19:38:29
019ad11f-c97d-713d-82d2-188bffa9fa1d	019ad11f-c0db-72b1-804d-1df0b91e01a0	Grupo Cuadrante A5	Grupo comunitario del Cuadrante A5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:38:32	2025-11-29 19:38:32
019ad11f-d478-732e-aaf3-cda434b53eaf	019ad11f-cc1d-73b3-8864-9c9ea2d7299b	Grupo Cuadrante A6	Grupo comunitario del Cuadrante A6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:38:35	2025-11-29 19:38:35
019ad11f-dc46-726c-a0ad-6db1f1cc5f08	019ad11f-d653-71d2-be73-0a87e453cf87	Grupo Cuadrante A7	Grupo comunitario del Cuadrante A7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:37	2025-11-29 19:38:37
019ad11f-e6cd-72df-ba2e-12e818271fd4	019ad11f-de3b-7354-b4cd-58f5f42ea670	Grupo Cuadrante A8	Grupo comunitario del Cuadrante A8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:40	2025-11-29 19:38:40
019ad11f-f2ee-7072-8bc1-1d3369d850df	019ad11f-e910-7015-af14-50722fd9eeeb	Grupo Cuadrante A9	Grupo comunitario del Cuadrante A9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:43	2025-11-29 19:38:43
019ad11f-fff7-7238-a522-6db1bd0fb759	019ad11f-f536-7145-b0cf-778bcebcbfdf	Grupo Cuadrante A10	Grupo comunitario del Cuadrante A10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:46	2025-11-29 19:38:46
019ad120-0d53-7149-b8de-0fdfcc8fdd06	019ad120-01ee-71a8-b7bd-fdee54895cad	Grupo Cuadrante A11	Grupo comunitario del Cuadrante A11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:50	2025-11-29 19:38:50
019ad120-1997-72d1-b91f-26c2ad504396	019ad120-0fb1-7167-be1f-77d3a197244b	Grupo Cuadrante A12	Grupo comunitario del Cuadrante A12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:53	2025-11-29 19:38:53
019ad120-220e-71ec-907c-63e37ea73459	019ad120-1bdf-7263-abb3-59bb576df920	Grupo Cuadrante A13	Grupo comunitario del Cuadrante A13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:55	2025-11-29 19:38:55
019ad120-2ec2-73d1-a738-c1ad1c9c3b11	019ad120-23e8-73de-a677-4c5185af27f0	Grupo Cuadrante A14	Grupo comunitario del Cuadrante A14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:38:58	2025-11-29 19:38:58
019ad120-3d53-713b-9594-e8cdfbc0492b	019ad120-3110-7345-a11e-ff591319d967	Grupo Cuadrante B1	Grupo comunitario del Cuadrante B1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:02	2025-11-29 19:39:02
019ad120-4cd1-73e7-8f53-64b590cfca2a	019ad120-3fea-70a3-ac08-471dd0060eaf	Grupo Cuadrante B2	Grupo comunitario del Cuadrante B2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:06	2025-11-29 19:39:06
019ad120-58b8-7398-b441-49045e28e7fa	019ad120-4f05-7354-abcf-2e4d969da2ee	Grupo Cuadrante B3	Grupo comunitario del Cuadrante B3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:09	2025-11-29 19:39:09
019ad120-61e4-7030-9330-2e73ed7711d9	019ad120-5b6e-7228-845f-00433a02d2d5	Grupo Cuadrante B4	Grupo comunitario del Cuadrante B4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:11	2025-11-29 19:39:11
019ad120-71b9-7359-be21-2a360a3064fd	019ad120-63cd-7181-a99a-aa451f5db3d8	Grupo Cuadrante B5	Grupo comunitario del Cuadrante B5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:15	2025-11-29 19:39:15
019ad120-7c8c-7391-84d5-9678a073c8d9	019ad120-7410-7312-80c5-c5865b70b333	Grupo Cuadrante B6	Grupo comunitario del Cuadrante B6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:18	2025-11-29 19:39:18
019ad120-89b1-72d0-beaa-34534f51ea96	019ad120-7f62-70f0-8312-6a6dcf1cfd7b	Grupo Cuadrante B7	Grupo comunitario del Cuadrante B7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:21	2025-11-29 19:39:21
019ad120-9750-731d-a1f1-813930d86022	019ad120-8c7d-7244-8899-50f49ae84b12	Grupo Cuadrante B8	Grupo comunitario del Cuadrante B8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:25	2025-11-29 19:39:25
019ad120-a1d6-707e-a46f-dbc8a826e1bf	019ad120-994c-71b0-80db-73c31500fb65	Grupo Cuadrante B9	Grupo comunitario del Cuadrante B9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:28	2025-11-29 19:39:28
019ad120-aec8-703c-a82a-1bb14763c60f	019ad120-a3c3-71da-9668-07a31c600b03	Grupo Cuadrante B10	Grupo comunitario del Cuadrante B10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:31	2025-11-29 19:39:31
019ad120-b96a-70eb-b49b-51242e1b802c	019ad120-b0b5-73ef-8328-5bce7948cd19	Grupo Cuadrante B11	Grupo comunitario del Cuadrante B11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:34	2025-11-29 19:39:34
019ad120-c457-73ea-9abe-6e4dab0dbf34	019ad120-bbd6-72dd-a2c4-ccadb90be88f	Grupo Cuadrante B12	Grupo comunitario del Cuadrante B12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:36	2025-11-29 19:39:36
019ad120-d0d6-72f2-aeb2-4b8eafbaed59	019ad120-c642-70ab-a243-63d667c9ccd0	Grupo Cuadrante B13	Grupo comunitario del Cuadrante B13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:40	2025-11-29 19:39:40
019ad120-d99c-7162-bf33-152d3d580e0a	019ad120-d2b1-724a-b4b7-bb8b9492bb3c	Grupo Cuadrante B14	Grupo comunitario del Cuadrante B14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:39:42	2025-11-29 19:39:42
019ad120-e19d-737d-80b7-a8084c5665b2	019ad120-db91-705e-9ffc-0252e97b2bc1	Grupo Cuadrante C1	Grupo comunitario del Cuadrante C1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:44	2025-11-29 19:39:44
019ad120-f1d9-71c8-879f-1529db4840c1	019ad120-e3da-7363-95f9-9a5fc1920ed5	Grupo Cuadrante C2	Grupo comunitario del Cuadrante C2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:48	2025-11-29 19:39:48
019ad121-0028-728d-bc53-de0cd6308f27	019ad120-f3ad-73a5-9143-ba8f60034202	Grupo Cuadrante C3	Grupo comunitario del Cuadrante C3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:52	2025-11-29 19:39:52
019ad121-0d07-701d-9b83-3ac2c6614a7d	019ad121-028e-73be-bb89-01679a2aff90	Grupo Cuadrante C4	Grupo comunitario del Cuadrante C4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:55	2025-11-29 19:39:55
019ad121-1a7c-7347-9584-6fdbfa63e613	019ad121-0ef0-7224-9b3e-eb3f7a5eecf1	Grupo Cuadrante C5	Grupo comunitario del Cuadrante C5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:39:58	2025-11-29 19:39:58
019ad121-227e-7069-877c-582641ba8aff	019ad121-1c62-7274-8d0d-540878d127f5	Grupo Cuadrante C6	Grupo comunitario del Cuadrante C6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:40:01	2025-11-29 19:40:01
019ad121-3173-73a3-a651-956ff0625eaa	019ad121-24fd-731b-b538-e23c7822e1b5	Grupo Cuadrante C7	Grupo comunitario del Cuadrante C7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:04	2025-11-29 19:40:04
019ad121-3eb1-7186-9d76-57ffaa2fb31e	019ad121-33f4-71e0-9cd5-fccd55a73d43	Grupo Cuadrante C8	Grupo comunitario del Cuadrante C8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:08	2025-11-29 19:40:08
019ad121-4aea-735a-b7be-71a439289df8	019ad121-4096-7359-9d9b-521c6c6889aa	Grupo Cuadrante C9	Grupo comunitario del Cuadrante C9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:11	2025-11-29 19:40:11
019ad121-5712-7141-b184-5a32a231875a	019ad121-4d2d-7201-937e-0164ae9adde8	Grupo Cuadrante C10	Grupo comunitario del Cuadrante C10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:14	2025-11-29 19:40:14
019ad121-6639-707e-b637-109307130494	019ad121-59af-7282-8874-008208d4b228	Grupo Cuadrante C11	Grupo comunitario del Cuadrante C11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:18	2025-11-29 19:40:18
019ad121-6eaf-7326-aade-03897a828aac	019ad121-689e-736e-8f24-3adac30d5ec6	Grupo Cuadrante C12	Grupo comunitario del Cuadrante C12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:20	2025-11-29 19:40:20
019ad121-7931-72d4-a96b-ed60d67903c8	019ad121-70a3-707e-8991-7a00f2401c2f	Grupo Cuadrante C13	Grupo comunitario del Cuadrante C13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:23	2025-11-29 19:40:23
019ad121-8381-70af-b36c-4f814b5830dd	019ad121-7b14-7129-a192-cfbbd05f9d3f	Grupo Cuadrante C14	Grupo comunitario del Cuadrante C14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:25	2025-11-29 19:40:25
019ad121-9295-70bb-aae8-6c5c903ad252	019ad121-85cd-7216-bd0a-b89abcecac4d	Grupo Cuadrante D1	Grupo comunitario del Cuadrante D1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:40:29	2025-11-29 19:40:29
019ad121-a25a-7101-81c5-91214917e93c	019ad121-948e-72ba-a607-c447d0f7142c	Grupo Cuadrante D2	Grupo comunitario del Cuadrante D2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:40:33	2025-11-29 19:40:33
019ad121-ad0e-728c-9d44-abc8524a8fbd	019ad121-a42b-734e-8a92-5c60486b1443	Grupo Cuadrante D3	Grupo comunitario del Cuadrante D3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:40:36	2025-11-29 19:40:36
019ad121-b5db-73f3-a7fb-fafb94ecacd0	019ad121-af1c-7119-a214-86de277bcffe	Grupo Cuadrante D4	Grupo comunitario del Cuadrante D4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:40:38	2025-11-29 19:40:38
019ad121-c4d2-7318-8084-cce4bf5fd4fc	019ad121-b7d1-7159-aadb-4708fabc0883	Grupo Cuadrante D5	Grupo comunitario del Cuadrante D5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:40:42	2025-11-29 19:40:42
019ad121-d397-7047-9f3a-57cb07ef4273	019ad121-c71c-7160-8f1f-76bb7be2493f	Grupo Cuadrante D6	Grupo comunitario del Cuadrante D6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:40:46	2025-11-29 19:40:46
019ad121-e052-703e-bdd8-98032c45db81	019ad121-d5f5-73bf-9102-8c3ea8bf7f7d	Grupo Cuadrante D7	Grupo comunitario del Cuadrante D7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:49	2025-11-29 19:40:49
019ad121-ea86-73d4-80a4-c5b2d6f20eed	019ad121-e23b-7008-82e9-9c5a6dc48c65	Grupo Cuadrante D8	Grupo comunitario del Cuadrante D8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:52	2025-11-29 19:40:52
019ad121-f383-71f2-bd54-971e56b6d79e	019ad121-ecf8-739c-97c0-49a1e1a0dd5e	Grupo Cuadrante D9	Grupo comunitario del Cuadrante D9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:54	2025-11-29 19:40:54
019ad122-0072-706e-a2e9-149a9aa09a65	019ad121-f56d-7311-bb95-5f8314c30d02	Grupo Cuadrante D10	Grupo comunitario del Cuadrante D10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:40:57	2025-11-29 19:40:57
019ad122-0ac2-72a1-9847-3392279dee93	019ad122-025d-71d3-badd-2acc9285dd06	Grupo Cuadrante D11	Grupo comunitario del Cuadrante D11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:00	2025-11-29 19:41:00
019ad122-1ad0-71f6-aff2-442f12fb795a	019ad122-0d0d-7200-94cc-b2cc9068f0e2	Grupo Cuadrante D12	Grupo comunitario del Cuadrante D12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:04	2025-11-29 19:41:04
019ad122-2b15-7049-ab97-26b583d9325e	019ad122-1cc5-726f-89d2-bcbf49aee788	Grupo Cuadrante D13	Grupo comunitario del Cuadrante D13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:08	2025-11-29 19:41:08
019ad122-3809-708a-a31c-8d6e2621bc08	019ad122-2d6e-739a-95ed-d091372687c9	Grupo Cuadrante D14	Grupo comunitario del Cuadrante D14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:12	2025-11-29 19:41:12
019ad122-4546-7053-8179-a3304edfadf5	019ad122-39eb-72af-a1e1-d81066fe703f	Grupo Cuadrante E1	Grupo comunitario del Cuadrante E1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:41:15	2025-11-29 19:41:15
019ad122-5271-73a5-8ca7-4773b8f2247e	019ad122-4798-7081-b1d4-5b66fc5d9f70	Grupo Cuadrante E2	Grupo comunitario del Cuadrante E2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:41:18	2025-11-29 19:41:18
019ad122-60ff-7134-8654-dd962cd9f2cb	019ad122-544b-7212-850f-1196c2092b30	Grupo Cuadrante E3	Grupo comunitario del Cuadrante E3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:41:22	2025-11-29 19:41:22
019ad122-6d08-7126-9380-0f8f540fec3e	019ad122-62de-705f-ae1e-93d0b9a0dfff	Grupo Cuadrante E4	Grupo comunitario del Cuadrante E4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:41:25	2025-11-29 19:41:25
019ad122-74f0-710f-b9d9-a693e1ba71c9	019ad122-6efc-70cb-b36b-31828140b288	Grupo Cuadrante E5	Grupo comunitario del Cuadrante E5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:41:27	2025-11-29 19:41:27
019ad122-81a3-71aa-99a9-99cb88cc2f1d	019ad122-7774-71e3-8e5a-8aeb8771701b	Grupo Cuadrante E6	Grupo comunitario del Cuadrante E6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:41:30	2025-11-29 19:41:30
019ad122-8cca-7078-b07f-ebd45bdf3b4a	019ad122-83ec-72d8-9871-897d12966042	Grupo Cuadrante E7	Grupo comunitario del Cuadrante E7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:33	2025-11-29 19:41:33
019ad122-95d5-738e-812c-131db24409d5	019ad122-8f2d-73b3-b91e-11848d9794f8	Grupo Cuadrante E8	Grupo comunitario del Cuadrante E8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:36	2025-11-29 19:41:36
019ad122-a076-7233-a715-bf3d445c31f4	019ad122-97cb-71fa-8f99-336ee2270965	Grupo Cuadrante E9	Grupo comunitario del Cuadrante E9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:38	2025-11-29 19:41:38
019ad122-aaf7-70c1-8b5b-1918cd8cd866	019ad122-a2d7-7356-92ca-880c8cec5874	Grupo Cuadrante E10	Grupo comunitario del Cuadrante E10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:41	2025-11-29 19:41:41
019ad122-b3bc-71ec-9155-eb7793be2d1a	019ad122-ad53-733c-a6a2-8baedaff8058	Grupo Cuadrante E11	Grupo comunitario del Cuadrante E11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:43	2025-11-29 19:41:43
019ad122-c31f-7215-a440-8ce186ae4988	019ad122-b61d-7395-9159-42319dd91914	Grupo Cuadrante E12	Grupo comunitario del Cuadrante E12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:47	2025-11-29 19:41:47
019ad122-cd97-7391-a5ec-616eff0a2561	019ad122-c529-7348-ac7e-459398a558c4	Grupo Cuadrante E13	Grupo comunitario del Cuadrante E13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:50	2025-11-29 19:41:50
019ad122-dcb8-7249-868b-590c99f433ce	019ad122-cf98-7071-ad9f-63c6316044cf	Grupo Cuadrante E14	Grupo comunitario del Cuadrante E14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:41:54	2025-11-29 19:41:54
019ad122-e9a0-71b5-9c8b-af13e0416185	019ad122-df13-708e-a597-989a222f1789	Grupo Cuadrante F1	Grupo comunitario del Cuadrante F1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:41:57	2025-11-29 19:41:57
019ad122-f752-72d4-b35d-4e34659ff6ba	019ad122-ec50-7164-84ad-eea8c619e7cd	Grupo Cuadrante F2	Grupo comunitario del Cuadrante F2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:01	2025-11-29 19:42:01
019ad123-006d-72ba-88c0-e170b2bdf22f	019ad122-f935-70a4-84e7-af226d0d011d	Grupo Cuadrante F3	Grupo comunitario del Cuadrante F3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:03	2025-11-29 19:42:03
019ad123-0d95-7047-bcfb-c231df71bf7c	019ad123-02a9-73fd-8c4a-16d9996b4e0a	Grupo Cuadrante F4	Grupo comunitario del Cuadrante F4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:06	2025-11-29 19:42:06
019ad123-1ca9-7336-9301-a6ea67dabd19	019ad123-0f6f-7111-a995-5864a15b3e8e	Grupo Cuadrante F5	Grupo comunitario del Cuadrante F5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:10	2025-11-29 19:42:10
019ad123-2b3f-7095-b5cb-0155f9c9bf8f	019ad123-1ef7-731b-aa46-df35ec9345e7	Grupo Cuadrante F6	Grupo comunitario del Cuadrante F6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:14	2025-11-29 19:42:14
019ad123-3378-71f5-89f8-f3f3061c8226	019ad123-2d2b-730d-8a58-389ce9aaea6d	Grupo Cuadrante F7	Grupo comunitario del Cuadrante F7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:16	2025-11-29 19:42:16
019ad123-40be-71fd-9950-ed405ebfa057	019ad123-35df-718c-8488-aa0f1202135d	Grupo Cuadrante F8	Grupo comunitario del Cuadrante F8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:19	2025-11-29 19:42:19
019ad123-4b70-711e-a153-c27b88237920	019ad123-42c1-7367-b965-906b77867688	Grupo Cuadrante F9	Grupo comunitario del Cuadrante F9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:22	2025-11-29 19:42:22
019ad123-5496-7181-8c2b-a6602d43a2bc	019ad123-4dcf-70fe-9706-42ce093c7ef9	Grupo Cuadrante F10	Grupo comunitario del Cuadrante F10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:24	2025-11-29 19:42:24
019ad123-619f-714a-8deb-cc9b9a26ada6	019ad123-56d5-7181-8d3e-e2c32ee2f9a9	Grupo Cuadrante F11	Grupo comunitario del Cuadrante F11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:28	2025-11-29 19:42:28
019ad123-6e8c-730d-a7b0-ebf677775d93	019ad123-63aa-725b-9413-b8608fda48ee	Grupo Cuadrante F12	Grupo comunitario del Cuadrante F12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:31	2025-11-29 19:42:31
019ad123-7991-723d-aee3-60744de887ef	019ad123-7081-73a1-a438-df0f6b141b82	Grupo Cuadrante F13	Grupo comunitario del Cuadrante F13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:34	2025-11-29 19:42:34
019ad123-8246-7010-9d03-cda6a4a4e38f	019ad123-7be2-7029-8bba-1546a2e45a47	Grupo Cuadrante F14	Grupo comunitario del Cuadrante F14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:36	2025-11-29 19:42:36
019ad123-8d18-73b8-a89c-310ca817d7b6	019ad123-8441-7396-a494-e0532fc4052f	Grupo Cuadrante G1	Grupo comunitario del Cuadrante G1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:39	2025-11-29 19:42:39
019ad123-9c8d-705e-b3bc-77d3f1da587e	019ad123-8f5a-72a9-8c50-2ac8b07599bc	Grupo Cuadrante G2	Grupo comunitario del Cuadrante G2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:43	2025-11-29 19:42:43
019ad123-a6b6-7057-94d0-72569412c6a0	019ad123-9e73-706a-b979-d2352e7d107a	Grupo Cuadrante G3	Grupo comunitario del Cuadrante G3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:45	2025-11-29 19:42:45
019ad123-b2da-707a-a465-f0b34d17d5f3	019ad123-a8a1-70a7-ba89-379e6b7a285b	Grupo Cuadrante G4	Grupo comunitario del Cuadrante G4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:49	2025-11-29 19:42:49
019ad123-bfbd-71d1-8f73-f6e96f1106b9	019ad123-b516-727a-bfa8-d8b1bccfd009	Grupo Cuadrante G5	Grupo comunitario del Cuadrante G5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:52	2025-11-29 19:42:52
019ad123-c83d-70ff-94a8-5ef7b43f1478	019ad123-c214-71a9-a6fd-28bf2b7c981f	Grupo Cuadrante G6	Grupo comunitario del Cuadrante G6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:42:54	2025-11-29 19:42:54
019ad123-d6d1-7023-b6b6-090118f3f345	019ad123-ca79-7377-9b89-7b3eadc8f974	Grupo Cuadrante G7	Grupo comunitario del Cuadrante G7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:42:58	2025-11-29 19:42:58
019ad123-e63d-7334-920d-856657add6c4	019ad123-d923-7209-868b-884d794bd927	Grupo Cuadrante G8	Grupo comunitario del Cuadrante G8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:02	2025-11-29 19:43:02
019ad123-f4d8-700a-be6c-21c2d28f2cf2	019ad123-e835-7366-ae21-d54021259015	Grupo Cuadrante G9	Grupo comunitario del Cuadrante G9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:05	2025-11-29 19:43:05
019ad124-0241-722d-a4c1-d4d5d07fb404	019ad123-f6c0-7057-9954-782bf5e37746	Grupo Cuadrante G10	Grupo comunitario del Cuadrante G10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:09	2025-11-29 19:43:09
019ad124-10eb-71ed-aa6f-ab6711a8da12	019ad124-04ad-71bc-926b-b85ec1dd015f	Grupo Cuadrante G11	Grupo comunitario del Cuadrante G11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:13	2025-11-29 19:43:13
019ad124-2026-711a-9726-16963bbc0f35	019ad124-1338-72aa-8a04-c68c8743c41b	Grupo Cuadrante G12	Grupo comunitario del Cuadrante G12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:17	2025-11-29 19:43:17
019ad124-2c58-72f2-88b2-cfa443a57932	019ad124-21ff-7310-a1a7-4770f85e9ed2	Grupo Cuadrante G13	Grupo comunitario del Cuadrante G13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:20	2025-11-29 19:43:20
019ad124-3667-72a4-b2f2-bec3854d1275	019ad124-2e38-718a-8d42-9c91ac03eb73	Grupo Cuadrante G14	Grupo comunitario del Cuadrante G14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:22	2025-11-29 19:43:22
019ad124-3ed5-7150-8ade-e2d9f96c6fd1	019ad124-3866-7353-996f-04876d745709	Grupo Cuadrante H1	Grupo comunitario del Cuadrante H1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:43:24	2025-11-29 19:43:24
019ad124-4724-7094-b8bb-a30b96e2da0f	019ad124-4119-72c4-892f-b195145ede0c	Grupo Cuadrante H2	Grupo comunitario del Cuadrante H2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:43:27	2025-11-29 19:43:27
019ad124-541f-71cb-a200-9631b8b589d6	019ad124-4909-70e5-87da-201d1f7cd740	Grupo Cuadrante H3	Grupo comunitario del Cuadrante H3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:43:30	2025-11-29 19:43:30
019ad124-5c96-73fd-a253-4369e8b3a4b6	019ad124-567f-71e1-b2ea-5a0bcf65f900	Grupo Cuadrante H4	Grupo comunitario del Cuadrante H4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:43:32	2025-11-29 19:43:32
019ad124-67a0-7176-928a-e46b107bc76e	019ad124-5e99-7251-9324-86f698d3bc5e	Grupo Cuadrante H5	Grupo comunitario del Cuadrante H5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:43:35	2025-11-29 19:43:35
019ad124-7690-73c0-a44c-236e040c479f	019ad124-69eb-71ab-b429-dd9e887c6b6b	Grupo Cuadrante H6	Grupo comunitario del Cuadrante H6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:43:39	2025-11-29 19:43:39
019ad124-8562-722d-abf5-6c3d8c91c21e	019ad124-786e-73e7-9a9b-acb07ee80fe4	Grupo Cuadrante H7	Grupo comunitario del Cuadrante H7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:42	2025-11-29 19:43:42
019ad124-8dc0-71ce-a512-5d8a1ccdb65d	019ad124-87ac-707c-b150-a1796a67b3c4	Grupo Cuadrante H8	Grupo comunitario del Cuadrante H8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:45	2025-11-29 19:43:45
019ad124-9a48-71a3-aaba-e59e4dacab4b	019ad124-9004-72e8-8469-dca2061f4500	Grupo Cuadrante H9	Grupo comunitario del Cuadrante H9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:48	2025-11-29 19:43:48
019ad124-a2ad-709d-a4dd-217d50640020	019ad124-9ca8-71f2-8c8a-69dbf1980700	Grupo Cuadrante H10	Grupo comunitario del Cuadrante H10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:50	2025-11-29 19:43:50
019ad124-af29-711a-87c5-9756a7b62d14	019ad124-a497-715c-b0b0-c17c50c4b2d3	Grupo Cuadrante H11	Grupo comunitario del Cuadrante H11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:53	2025-11-29 19:43:53
019ad124-b9e1-71b5-949b-7d4424f40287	019ad124-b170-710f-9a5f-311b4fcb2ce8	Grupo Cuadrante H12	Grupo comunitario del Cuadrante H12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:56	2025-11-29 19:43:56
019ad124-c211-7270-829a-ca36c4d529b1	019ad124-bbc9-72a2-9ad4-f17593c94707	Grupo Cuadrante H13	Grupo comunitario del Cuadrante H13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:43:58	2025-11-29 19:43:58
019ad124-ce22-7181-a3e5-86bfa5111104	019ad124-c469-7196-8065-a47c1e915776	Grupo Cuadrante H14	Grupo comunitario del Cuadrante H14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:01	2025-11-29 19:44:01
019ad124-dc36-721f-a002-d176e7b208eb	019ad124-d010-7396-bfdb-41d6a29622b1	Grupo Cuadrante I1	Grupo comunitario del Cuadrante I1 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:44:05	2025-11-29 19:44:05
019ad124-e533-727c-9453-278bf75efea8	019ad124-dea1-736a-9e00-c8e10e3aa9a8	Grupo Cuadrante I2	Grupo comunitario del Cuadrante I2 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:44:07	2025-11-29 19:44:07
019ad124-f363-720a-8adf-772b3db89b96	019ad124-e71e-7246-a53e-d95dbfac6ae0	Grupo Cuadrante I3	Grupo comunitario del Cuadrante I3 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:44:11	2025-11-29 19:44:11
019ad124-fc70-712d-a0c0-87c188510724	019ad124-f616-71d7-9c57-bbb94fa64ddb	Grupo Cuadrante I4	Grupo comunitario del Cuadrante I4 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:44:13	2025-11-29 19:44:13
019ad125-093d-71eb-9478-e4cc441878d9	019ad124-fec1-7113-a7bc-f6a6c7ecc270	Grupo Cuadrante I5	Grupo comunitario del Cuadrante I5 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:44:16	2025-11-29 19:44:16
019ad125-12e0-72d9-9156-b52f2163c55f	019ad125-0c12-739e-b211-b9596a24ce2f	Grupo Cuadrante I6	Grupo comunitario del Cuadrante I6 - Zona Norte	\N	t	f	0	0	0	2025-11-29 19:44:19	2025-11-29 19:44:19
019ad125-21c8-72a2-ae97-7a543d90945b	019ad125-14c6-7338-934c-7535e4c89c11	Grupo Cuadrante I7	Grupo comunitario del Cuadrante I7 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:22	2025-11-29 19:44:22
019ad125-2e2e-70b7-85ac-82ef7a9203e3	019ad125-23a9-701e-b4a4-bb765af061f8	Grupo Cuadrante I8	Grupo comunitario del Cuadrante I8 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:26	2025-11-29 19:44:26
019ad125-3b68-73d9-812d-ebfc50c6d8ea	019ad125-3012-736e-bf47-e257f9b30a60	Grupo Cuadrante I9	Grupo comunitario del Cuadrante I9 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:29	2025-11-29 19:44:29
019ad125-4780-7235-817b-4404c0e671b5	019ad125-3d53-728a-86e1-d7e0bc8e56d8	Grupo Cuadrante I10	Grupo comunitario del Cuadrante I10 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:32	2025-11-29 19:44:32
019ad125-5662-7024-afda-d0489e4fabcb	019ad125-4a48-7265-b6c7-f9cf8bf4785b	Grupo Cuadrante I11	Grupo comunitario del Cuadrante I11 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:36	2025-11-29 19:44:36
019ad125-6375-7178-9e78-cca25ee783ba	019ad125-58ca-71e8-8218-27edb3fe40c3	Grupo Cuadrante I12	Grupo comunitario del Cuadrante I12 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:39	2025-11-29 19:44:39
019ad125-6c08-71f5-bfd8-e619105f9527	019ad125-65de-7204-9d4e-92a721ab1d94	Grupo Cuadrante I13	Grupo comunitario del Cuadrante I13 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:41	2025-11-29 19:44:41
019ad125-74d5-725b-9dfc-0319d0e9bd36	019ad125-6de0-720b-9b8f-95b438003aec	Grupo Cuadrante I14	Grupo comunitario del Cuadrante I14 - Zona Noreste	\N	t	f	0	0	0	2025-11-29 19:44:44	2025-11-29 19:44:44
019ad125-7f7e-729f-baa6-17c55c160e41	019ad125-76bb-7167-b726-a19f97fa4a2e	Grupo Cuadrante J1	Grupo comunitario del Cuadrante J1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:44:46	2025-11-29 19:44:46
019ad125-8788-73de-abb8-23fdda279256	019ad125-8173-7097-b706-38868e3b80a1	Grupo Cuadrante J2	Grupo comunitario del Cuadrante J2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:44:49	2025-11-29 19:44:49
019ad125-9328-7299-b4b2-a4f65ec9d86e	019ad125-89cf-73f7-951f-8305fdd9dde0	Grupo Cuadrante J3	Grupo comunitario del Cuadrante J3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:44:52	2025-11-29 19:44:52
019ad125-a1d5-7154-9b95-37c5b15b003a	019ad125-951a-72d2-846b-ecc35575a4de	Grupo Cuadrante J4	Grupo comunitario del Cuadrante J4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:44:55	2025-11-29 19:44:55
019ad125-a9fe-73e1-8b9a-34d79d5a673e	019ad125-a3b0-73df-a6a3-89df080f1bec	Grupo Cuadrante J5	Grupo comunitario del Cuadrante J5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:44:57	2025-11-29 19:44:57
019ad125-b6e2-7308-9a80-1a42fc165b18	019ad125-ac68-7270-83f3-edd7fe7294b8	Grupo Cuadrante J6	Grupo comunitario del Cuadrante J6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:45:01	2025-11-29 19:45:01
019ad125-c437-72af-97b7-7612e3b6a9e1	019ad125-b936-732e-9009-da9c77de85b4	Grupo Cuadrante J7	Grupo comunitario del Cuadrante J7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:04	2025-11-29 19:45:04
019ad125-d0bb-7085-b3d9-997f34f01fc2	019ad125-c61a-7137-9a95-b3a380f11e49	Grupo Cuadrante J8	Grupo comunitario del Cuadrante J8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:07	2025-11-29 19:45:07
019ad125-dff4-710b-be28-5fb6a2686d9e	019ad125-d294-7192-9840-f9eeb3086e77	Grupo Cuadrante J9	Grupo comunitario del Cuadrante J9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:11	2025-11-29 19:45:11
019ad125-e884-73e5-8b54-a432915b2d9c	019ad125-e243-7265-a825-5815f4dc4e4d	Grupo Cuadrante J10	Grupo comunitario del Cuadrante J10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:13	2025-11-29 19:45:13
019ad125-f72f-7008-82d5-b92f2eb897d3	019ad125-ea66-7248-9b22-b5613f692a32	Grupo Cuadrante J11	Grupo comunitario del Cuadrante J11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:17	2025-11-29 19:45:17
019ad126-03be-70d6-8566-4236c815c199	019ad125-f950-71ec-97a8-fd867f080025	Grupo Cuadrante J12	Grupo comunitario del Cuadrante J12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:20	2025-11-29 19:45:20
019ad126-12e3-722c-8145-9df6d904c26b	019ad126-0627-7138-a832-c95789db03c6	Grupo Cuadrante J13	Grupo comunitario del Cuadrante J13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:24	2025-11-29 19:45:24
019ad126-218f-713f-b1c3-6f21de71bef7	019ad126-152b-719e-a225-c1f5d4c7d153	Grupo Cuadrante J14	Grupo comunitario del Cuadrante J14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:28	2025-11-29 19:45:28
019ad126-2c80-702f-ba6e-2f70f1cde99e	019ad126-236c-7011-9337-b8e2ac1a6d77	Grupo Cuadrante K1	Grupo comunitario del Cuadrante K1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:45:31	2025-11-29 19:45:31
019ad126-39be-71d0-b340-0d1a73fab81d	019ad126-2ed8-7153-aa64-5edc41846459	Grupo Cuadrante K2	Grupo comunitario del Cuadrante K2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:45:34	2025-11-29 19:45:34
019ad126-48c2-7071-b302-39895e545092	019ad126-3bbf-717d-91ee-a77f1d17ed77	Grupo Cuadrante K3	Grupo comunitario del Cuadrante K3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:45:38	2025-11-29 19:45:38
019ad126-55d2-7152-a0f7-4405f02518c1	019ad126-4abd-71ff-9e69-b6a19a9b340d	Grupo Cuadrante K4	Grupo comunitario del Cuadrante K4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:45:41	2025-11-29 19:45:41
019ad126-6509-733a-b4b2-8a5df95eaad3	019ad126-57c4-724f-82c8-e76a6ea85c3b	Grupo Cuadrante K5	Grupo comunitario del Cuadrante K5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:45:45	2025-11-29 19:45:45
019ad126-6d95-7134-9015-9a43c3bf0f0e	019ad126-6769-723c-9c40-447a04bbef8f	Grupo Cuadrante K6	Grupo comunitario del Cuadrante K6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:45:47	2025-11-29 19:45:47
019ad126-75ff-7329-b976-04fdb25fd2ef	019ad126-6f85-70e1-83a7-d986305d8b92	Grupo Cuadrante K7	Grupo comunitario del Cuadrante K7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:50	2025-11-29 19:45:50
019ad126-85db-72e3-bf17-39fac280d0a7	019ad126-7804-73e8-b06d-072a734a8d7c	Grupo Cuadrante K8	Grupo comunitario del Cuadrante K8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:54	2025-11-29 19:45:54
019ad126-942e-7061-952b-4efdbf347934	019ad126-87c6-703e-a730-23b301bb1997	Grupo Cuadrante K9	Grupo comunitario del Cuadrante K9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:45:57	2025-11-29 19:45:57
019ad126-9d4b-726d-9d3d-5e4bd7744df6	019ad126-9692-7308-8aec-cc70eaae0eb3	Grupo Cuadrante K10	Grupo comunitario del Cuadrante K10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:00	2025-11-29 19:46:00
019ad126-ac4f-711e-9cdd-2caf43b96a81	019ad126-9fbe-72f6-9f57-b4de32a17a07	Grupo Cuadrante K11	Grupo comunitario del Cuadrante K11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:03	2025-11-29 19:46:03
019ad126-b77b-739b-98d3-619ecebd6f25	019ad126-aea1-720f-aece-1b621cca7668	Grupo Cuadrante K12	Grupo comunitario del Cuadrante K12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:06	2025-11-29 19:46:06
019ad126-c55f-737d-8a5f-ea89057ea736	019ad126-b967-7357-813f-ad260e2bb656	Grupo Cuadrante K13	Grupo comunitario del Cuadrante K13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:10	2025-11-29 19:46:10
019ad126-ce39-7119-80ec-7cfcfb1f4b96	019ad126-c7cb-7331-ba6f-a72c71e8192b	Grupo Cuadrante K14	Grupo comunitario del Cuadrante K14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:12	2025-11-29 19:46:12
019ad126-dbc8-7241-9d3d-9a3dc51a2ce3	019ad126-d084-7188-a17f-12cea270d305	Grupo Cuadrante L1	Grupo comunitario del Cuadrante L1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:16	2025-11-29 19:46:16
019ad126-e848-7101-8beb-cf9619a10e9e	019ad126-de2b-7189-9f63-8d2aec540598	Grupo Cuadrante L2	Grupo comunitario del Cuadrante L2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:19	2025-11-29 19:46:19
019ad126-f2f1-7131-9e9b-fcd1d416d534	019ad126-ea1e-7211-8fe0-c80a851736a2	Grupo Cuadrante L3	Grupo comunitario del Cuadrante L3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:22	2025-11-29 19:46:22
019ad126-fd9a-70d1-9f65-19ab152af83b	019ad126-f4df-73b3-8b5c-fb0afe1d9b61	Grupo Cuadrante L4	Grupo comunitario del Cuadrante L4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:24	2025-11-29 19:46:24
019ad127-08fc-7134-9a66-a6b76f4c413e	019ad127-0029-70f8-9613-268b4ce0a5af	Grupo Cuadrante L5	Grupo comunitario del Cuadrante L5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:27	2025-11-29 19:46:27
019ad127-180e-703d-8205-833d6883c80a	019ad127-0af2-71bc-bcd3-8aa01e7156f8	Grupo Cuadrante L6	Grupo comunitario del Cuadrante L6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:31	2025-11-29 19:46:31
019ad127-20c6-7014-9dc5-64e1c0601036	019ad127-19f9-7054-8d17-349961227666	Grupo Cuadrante L7	Grupo comunitario del Cuadrante L7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:33	2025-11-29 19:46:33
019ad127-294b-7344-bd4d-bef188c12935	019ad127-22b3-725b-b6fe-cccfec1539b7	Grupo Cuadrante L8	Grupo comunitario del Cuadrante L8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:35	2025-11-29 19:46:35
019ad127-3428-7064-8724-0c6cd2071d12	019ad127-2b87-700f-9a0f-70cd2dae0cd0	Grupo Cuadrante L9	Grupo comunitario del Cuadrante L9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:38	2025-11-29 19:46:38
019ad127-3edf-70ca-83cf-744e1f6d7832	019ad127-3622-738d-ab33-86d1e30f5e6b	Grupo Cuadrante L10	Grupo comunitario del Cuadrante L10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:41	2025-11-29 19:46:41
019ad127-49ab-73fd-9d08-07fd9462a246	019ad127-412b-70f3-ba2f-372a51966a28	Grupo Cuadrante L11	Grupo comunitario del Cuadrante L11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:44	2025-11-29 19:46:44
019ad127-51fc-7081-9bee-74a2c64f3d2a	019ad127-4b8e-701e-81b8-07cff06d06fe	Grupo Cuadrante L12	Grupo comunitario del Cuadrante L12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:46	2025-11-29 19:46:46
019ad127-5f14-7076-b1b1-3634aeb5d955	019ad127-54cc-7222-b609-471036a2c681	Grupo Cuadrante L13	Grupo comunitario del Cuadrante L13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:49	2025-11-29 19:46:49
019ad127-6bb4-71c1-aa0a-ad35e647cea9	019ad127-6108-71d0-83b1-65c13974fcca	Grupo Cuadrante L14	Grupo comunitario del Cuadrante L14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:46:52	2025-11-29 19:46:52
019ad127-765c-72c2-a907-160ee2db9a8c	019ad127-6de7-7299-aa3c-6bd685633f5a	Grupo Cuadrante M1	Grupo comunitario del Cuadrante M1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:55	2025-11-29 19:46:55
019ad127-80e5-721e-8b63-3d259f2b907c	019ad127-78c1-71a7-84bc-66e18a7750ea	Grupo Cuadrante M2	Grupo comunitario del Cuadrante M2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:46:58	2025-11-29 19:46:58
019ad127-8d26-70e8-9d5e-d2d5309633de	019ad127-82d4-71b5-8c91-b51a39199f3d	Grupo Cuadrante M3	Grupo comunitario del Cuadrante M3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:01	2025-11-29 19:47:01
019ad127-9bae-7244-911b-3bde0bd95d96	019ad127-8f5f-72b5-b599-1d54a536f699	Grupo Cuadrante M4	Grupo comunitario del Cuadrante M4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:05	2025-11-29 19:47:05
019ad127-a3e0-72d6-8615-0bd8bfb7c83e	019ad127-9d96-7375-8987-2d12711a1752	Grupo Cuadrante M5	Grupo comunitario del Cuadrante M5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:07	2025-11-29 19:47:07
019ad127-aefc-70a8-93e3-79cfd4122a48	019ad127-a61b-7207-8713-4148a7ce4419	Grupo Cuadrante M6	Grupo comunitario del Cuadrante M6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:10	2025-11-29 19:47:10
019ad127-b7f7-7102-9017-38d5dff383db	019ad127-b147-71e5-b197-168632fc652a	Grupo Cuadrante M7	Grupo comunitario del Cuadrante M7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:12	2025-11-29 19:47:12
019ad127-c079-7103-bec1-020c234bb41d	019ad127-b9d2-7219-ad6f-825e6152c4c0	Grupo Cuadrante M8	Grupo comunitario del Cuadrante M8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:14	2025-11-29 19:47:14
019ad127-cd74-703c-9edb-9a9148e95cdf	019ad127-c27d-7056-a7cc-2ff85061792e	Grupo Cuadrante M9	Grupo comunitario del Cuadrante M9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:18	2025-11-29 19:47:18
019ad127-da65-70dc-bb40-e3a8c1fee4c5	019ad127-cf5c-7313-8756-90217e0b4a1a	Grupo Cuadrante M10	Grupo comunitario del Cuadrante M10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:21	2025-11-29 19:47:21
019ad127-e58a-7395-a569-bb84e472f469	019ad127-dc4d-732f-b867-6e858e9e1be0	Grupo Cuadrante M11	Grupo comunitario del Cuadrante M11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:24	2025-11-29 19:47:24
019ad127-f237-73f7-9626-cc87458858d4	019ad127-e75e-731d-800f-6c5eae82b981	Grupo Cuadrante M12	Grupo comunitario del Cuadrante M12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:27	2025-11-29 19:47:27
019ad128-0119-735a-8d3f-d7f37e39264f	019ad127-f49a-71e9-9f99-3a809484aab9	Grupo Cuadrante M13	Grupo comunitario del Cuadrante M13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:31	2025-11-29 19:47:31
019ad128-09b3-7234-a9dd-b90b75285dfe	019ad128-0381-733e-9738-af129dab192d	Grupo Cuadrante M14	Grupo comunitario del Cuadrante M14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:33	2025-11-29 19:47:33
019ad128-1967-70e3-9260-9e741eb0afd3	019ad128-0c0e-722b-b97f-7d13f309dcc7	Grupo Cuadrante N1	Grupo comunitario del Cuadrante N1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:37	2025-11-29 19:47:37
019ad128-2831-72e6-8646-8ce61d244048	019ad128-1b4c-725e-881d-923320341f05	Grupo Cuadrante N2	Grupo comunitario del Cuadrante N2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:41	2025-11-29 19:47:41
019ad128-369e-7046-8059-5facf9592910	019ad128-2a0e-7347-aee4-f544c368d00f	Grupo Cuadrante N3	Grupo comunitario del Cuadrante N3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:44	2025-11-29 19:47:44
019ad128-40f6-7113-953c-7f1e939ba903	019ad128-38fb-7270-baf4-a20bb374bcf0	Grupo Cuadrante N4	Grupo comunitario del Cuadrante N4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:47	2025-11-29 19:47:47
019ad128-4d61-70c6-be7a-79a4ac6a6868	019ad128-432d-70c5-b3c8-566001d0cde8	Grupo Cuadrante N5	Grupo comunitario del Cuadrante N5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:50	2025-11-29 19:47:50
019ad128-57fb-7387-ba71-fd66902e4e47	019ad128-4f3d-70bc-b4cf-9a034c55e088	Grupo Cuadrante N6	Grupo comunitario del Cuadrante N6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:47:53	2025-11-29 19:47:53
019ad128-64a5-7091-98da-54d0609eb82e	019ad128-5a36-720e-8c4b-524150b38a46	Grupo Cuadrante N7	Grupo comunitario del Cuadrante N7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:56	2025-11-29 19:47:56
019ad128-709a-731f-ba76-592dbe42754a	019ad128-6680-7038-bd60-a2ffd587fc18	Grupo Cuadrante N8	Grupo comunitario del Cuadrante N8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:47:59	2025-11-29 19:47:59
019ad128-7ca1-7017-989c-abfd1b790982	019ad128-7269-71e1-8265-bbb735ed4dd8	Grupo Cuadrante N9	Grupo comunitario del Cuadrante N9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:02	2025-11-29 19:48:02
019ad128-8c9f-7059-87f6-b93aaa85bb3a	019ad128-7efd-7162-8457-afc36737c8d9	Grupo Cuadrante N10	Grupo comunitario del Cuadrante N10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:06	2025-11-29 19:48:06
019ad128-9b80-719d-abcd-d52ba6fb279b	019ad128-8e7d-736a-9ff0-3ba4d2030332	Grupo Cuadrante N11	Grupo comunitario del Cuadrante N11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:10	2025-11-29 19:48:10
019ad128-a5f6-727a-9de9-e27dfce2ecbf	019ad128-9d64-7245-9219-ccc45589f4a9	Grupo Cuadrante N12	Grupo comunitario del Cuadrante N12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:13	2025-11-29 19:48:13
019ad128-b3f5-7292-ac7c-51b42bdb796f	019ad128-a7d5-7297-bea2-d2c012972553	Grupo Cuadrante N13	Grupo comunitario del Cuadrante N13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:17	2025-11-29 19:48:17
019ad128-be3e-728b-8f59-1e5e758ace63	019ad128-b61d-71a6-afee-e6835989c7cf	Grupo Cuadrante N14	Grupo comunitario del Cuadrante N14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:19	2025-11-29 19:48:19
019ad128-cc9a-7061-be4f-527c40e4fe01	019ad128-c09e-7116-9ee9-f32e32efcd84	Grupo Cuadrante O1	Grupo comunitario del Cuadrante O1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:48:23	2025-11-29 19:48:23
019ad128-db2a-73fa-b59a-89b50be805b7	019ad128-ce88-72ab-888e-1a400ec9bd84	Grupo Cuadrante O2	Grupo comunitario del Cuadrante O2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:48:27	2025-11-29 19:48:27
019ad128-ea20-718d-9dfe-5aa23e4fea69	019ad128-dd10-71e9-b4ae-87a99a9f89ab	Grupo Cuadrante O3	Grupo comunitario del Cuadrante O3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:48:30	2025-11-29 19:48:30
019ad128-f870-721d-94a4-5ce5a8b31391	019ad128-ec0d-71f8-8a0d-14257173677c	Grupo Cuadrante O4	Grupo comunitario del Cuadrante O4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:48:34	2025-11-29 19:48:34
019ad129-00de-70b7-88f0-cf06865b14c1	019ad128-fa5e-73c9-bf99-5410c5119f29	Grupo Cuadrante O5	Grupo comunitario del Cuadrante O5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:48:36	2025-11-29 19:48:36
019ad129-0d6e-7389-8da9-936bdc1fa792	019ad129-02c8-725f-a0f7-8c8f2141ff3e	Grupo Cuadrante O6	Grupo comunitario del Cuadrante O6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:48:39	2025-11-29 19:48:39
019ad129-1820-7387-bef0-270d40e26986	019ad129-0f63-7183-9aa7-60ee9f9a64ca	Grupo Cuadrante O7	Grupo comunitario del Cuadrante O7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:42	2025-11-29 19:48:42
019ad129-2378-7328-97fc-af83235f07eb	019ad129-19f8-70df-ad54-e06628ab0541	Grupo Cuadrante O8	Grupo comunitario del Cuadrante O8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:45	2025-11-29 19:48:45
019ad129-31f8-7229-9214-317f44946940	019ad129-256a-73ec-964a-dd3e86be121d	Grupo Cuadrante O9	Grupo comunitario del Cuadrante O9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:49	2025-11-29 19:48:49
019ad129-3c51-7031-860b-6343de2bbe7a	019ad129-33e3-70ca-bc69-de05379a3905	Grupo Cuadrante O10	Grupo comunitario del Cuadrante O10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:51	2025-11-29 19:48:51
019ad129-4a97-711e-a46f-04b1296d8f5a	019ad129-3e95-7305-8a0a-caab679e7401	Grupo Cuadrante O11	Grupo comunitario del Cuadrante O11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:55	2025-11-29 19:48:55
019ad129-5830-70e9-8d55-c36510d26114	019ad129-4c8b-709b-a27a-790d15a34423	Grupo Cuadrante O12	Grupo comunitario del Cuadrante O12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:48:59	2025-11-29 19:48:59
019ad129-6551-71ec-9ac2-ee3163aed783	019ad129-5aa0-72b7-a209-bb3a6129a7b8	Grupo Cuadrante O13	Grupo comunitario del Cuadrante O13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:02	2025-11-29 19:49:02
019ad129-713b-71f6-8918-98bb753d8786	019ad129-672b-7343-bc3c-0aaa78b6644c	Grupo Cuadrante O14	Grupo comunitario del Cuadrante O14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:05	2025-11-29 19:49:05
019ad129-7fda-724f-ac1f-907968389fc5	019ad129-7330-70fc-b43a-89ef1b66b9b8	Grupo Cuadrante P1	Grupo comunitario del Cuadrante P1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:09	2025-11-29 19:49:09
019ad129-8e81-7031-a425-072c01d07067	019ad129-81b0-736b-85a7-4ae840ca4a81	Grupo Cuadrante P2	Grupo comunitario del Cuadrante P2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:12	2025-11-29 19:49:12
019ad129-9ca2-711c-9f71-c5e2b2c0718c	019ad129-9064-707c-b5d3-ca7600e3e91c	Grupo Cuadrante P3	Grupo comunitario del Cuadrante P3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:16	2025-11-29 19:49:16
019ad129-a50c-70f4-9486-7393b4b6c95e	019ad129-9eff-7381-b73d-7c92c2d22ea2	Grupo Cuadrante P4	Grupo comunitario del Cuadrante P4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:18	2025-11-29 19:49:18
019ad129-ad1b-72e3-aee4-0b3081f5d7da	019ad129-a704-728c-912a-e1296785a2a7	Grupo Cuadrante P5	Grupo comunitario del Cuadrante P5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:20	2025-11-29 19:49:20
019ad129-b9b0-71e5-81a7-bb7c0c57414b	019ad129-af6d-73eb-a201-8fc9587240a7	Grupo Cuadrante P6	Grupo comunitario del Cuadrante P6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:24	2025-11-29 19:49:24
019ad129-c5e3-70ca-b3bd-2ff2e943b810	019ad129-bbee-7311-bacf-c9869897b239	Grupo Cuadrante P7	Grupo comunitario del Cuadrante P7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:27	2025-11-29 19:49:27
019ad129-d202-7358-bd17-9bb83d1b0174	019ad129-c820-70e2-94cc-fca1a84a0f0b	Grupo Cuadrante P8	Grupo comunitario del Cuadrante P8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:30	2025-11-29 19:49:30
019ad129-dc56-7131-aef2-445d29c6494f	019ad129-d467-70d9-81d4-f6e5af643be8	Grupo Cuadrante P9	Grupo comunitario del Cuadrante P9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:32	2025-11-29 19:49:32
019ad129-eb1f-709f-b311-603a765739d5	019ad129-debb-7261-800e-d8334ad7a932	Grupo Cuadrante P10	Grupo comunitario del Cuadrante P10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:36	2025-11-29 19:49:36
019ad129-f30e-7291-8a6f-c5b7275de92b	019ad129-ed02-7238-b88e-c35c305f1138	Grupo Cuadrante P11	Grupo comunitario del Cuadrante P11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:38	2025-11-29 19:49:38
019ad12a-0249-71cf-8aa9-19b420eb0c02	019ad129-f5ba-73d0-9fff-c40ae9294f3c	Grupo Cuadrante P12	Grupo comunitario del Cuadrante P12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:42	2025-11-29 19:49:42
019ad12a-0e56-7039-a094-b53776c495a9	019ad12a-0489-72f4-a46e-c7ccac08e0da	Grupo Cuadrante P13	Grupo comunitario del Cuadrante P13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:45	2025-11-29 19:49:45
019ad12a-1871-71e6-8c75-0a689bf1b633	019ad12a-1087-70eb-ab1b-b5f01e0084f8	Grupo Cuadrante P14	Grupo comunitario del Cuadrante P14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:49:48	2025-11-29 19:49:48
019ad12a-23bc-7278-9e64-3ac778903f8f	019ad12a-1a5a-71d2-9512-526ea3c25ebe	Grupo Cuadrante Q1	Grupo comunitario del Cuadrante Q1 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:51	2025-11-29 19:49:51
019ad12a-321d-707d-809c-832d4b112de4	019ad12a-259a-70e9-9687-af59d0de33ba	Grupo Cuadrante Q2	Grupo comunitario del Cuadrante Q2 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:54	2025-11-29 19:49:54
019ad12a-3a5d-7326-a502-c770b3e3be46	019ad12a-3402-708f-99a5-35228523c459	Grupo Cuadrante Q3	Grupo comunitario del Cuadrante Q3 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:49:56	2025-11-29 19:49:56
019ad12a-4672-72ec-a4b0-ec9a7456dfbd	019ad12a-3c29-703b-b61c-b96a2892dad8	Grupo Cuadrante Q4	Grupo comunitario del Cuadrante Q4 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:50:00	2025-11-29 19:50:00
019ad12a-512e-731c-a803-07f35b0bfdb0	019ad12a-485b-701c-9b9c-3fb4e2717798	Grupo Cuadrante Q5	Grupo comunitario del Cuadrante Q5 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:50:02	2025-11-29 19:50:02
019ad12a-5a26-7330-8c64-16f340acedec	019ad12a-53bb-7219-bdfc-68945d619b26	Grupo Cuadrante Q6	Grupo comunitario del Cuadrante Q6 - Zona Sur	\N	t	f	0	0	0	2025-11-29 19:50:05	2025-11-29 19:50:05
019ad12a-664d-7117-83b4-1fa2285c871a	019ad12a-5c0c-7361-804d-cb3c2033ab37	Grupo Cuadrante Q7	Grupo comunitario del Cuadrante Q7 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:08	2025-11-29 19:50:08
019ad12a-6e53-7075-b94f-58aba3189e75	019ad12a-681f-7374-8152-1306f6b2e85b	Grupo Cuadrante Q8	Grupo comunitario del Cuadrante Q8 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:10	2025-11-29 19:50:10
019ad12a-78ab-723b-a9c5-82f5468ca4ea	019ad12a-70b3-713d-8e5b-0323c338e2d4	Grupo Cuadrante Q9	Grupo comunitario del Cuadrante Q9 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:12	2025-11-29 19:50:12
019ad12a-811b-70d1-8b1f-7100af3aa9ba	019ad12a-7b07-7261-86b5-b59ff4cbe2fa	Grupo Cuadrante Q10	Grupo comunitario del Cuadrante Q10 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:15	2025-11-29 19:50:15
019ad12a-8964-71dd-b950-aff54a1c0e9f	019ad12a-8364-70c6-b2d5-3ff080252d25	Grupo Cuadrante Q11	Grupo comunitario del Cuadrante Q11 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:17	2025-11-29 19:50:17
019ad12a-98bc-71bc-8253-0cf6a4957f40	019ad12a-8bc5-72d8-8e25-718b740135b1	Grupo Cuadrante Q12	Grupo comunitario del Cuadrante Q12 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:21	2025-11-29 19:50:21
019ad12a-a5f4-724c-9de4-5ab34c2e0dfa	019ad12a-9b1a-7132-a570-b57e3e07a8a8	Grupo Cuadrante Q13	Grupo comunitario del Cuadrante Q13 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:24	2025-11-29 19:50:24
019ad12a-b47f-71c2-b675-e973074f14f4	019ad12a-a7d7-73a8-a569-62a2ddd043c1	Grupo Cuadrante Q14	Grupo comunitario del Cuadrante Q14 - Zona Este	\N	t	f	0	0	0	2025-11-29 19:50:28	2025-11-29 19:50:28
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
1	default	{"uuid":"f0ff86e2-1096-4f53-88e4-f232da974805","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019adc13-28a9-736f-a233-71b44da70530\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019ad751-43fd-70c6-b8d7-95a3dbba3d1e\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764628834,"delay":null}	0	\N	1764628834	1764628834
2	default	{"uuid":"18735232-ae3d-4799-ac1f-36c5803bab63","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019adc13-e857-7273-8c16-6fb80138a6f3\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764628883,"delay":null}	0	\N	1764628883	1764628883
3	default	{"uuid":"dde98ced-1228-4b5b-bfa8-7c1500accb86","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019adc13-e830-7122-a2e4-e9763652e2c2\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad123-5496-7181-8c2b-a6602d43a2bc\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764628883,"delay":null}	0	\N	1764628883	1764628883
4	default	{"uuid":"49495064-eb08-46a9-b92a-4e0efb589817","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019adc1a-b018-709b-9cfe-625b2b0e458b\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019ad746-8edc-7026-9d52-b979b5b16b8f\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764629327,"delay":null}	0	\N	1764629327	1764629327
5	default	{"uuid":"2a58ca16-9cef-4645-93b3-1e8dafbc2034","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019adc13-e830-7122-a2e4-e9763652e2c2\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad122-97cb-71fa-8f99-336ee2270965\\";s:6:\\"codigo\\";s:2:\\"E9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante E9\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad122-a2d7-7356-92ca-880c8cec5874\\";s:6:\\"codigo\\";s:3:\\"E10\\";s:6:\\"nombre\\";s:13:\\"Cuadrante E10\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad122-ad53-733c-a6a2-8baedaff8058\\";s:6:\\"codigo\\";s:3:\\"E11\\";s:6:\\"nombre\\";s:13:\\"Cuadrante E11\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad123-42c1-7367-b965-906b77867688\\";s:6:\\"codigo\\";s:2:\\"F9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante F9\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad123-56d5-7181-8d3e-e2c32ee2f9a9\\";s:6:\\"codigo\\";s:3:\\"F11\\";s:6:\\"nombre\\";s:13:\\"Cuadrante F11\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad123-e835-7366-ae21-d54021259015\\";s:6:\\"codigo\\";s:2:\\"G9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante G9\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad123-f6c0-7057-9954-782bf5e37746\\";s:6:\\"codigo\\";s:3:\\"G10\\";s:6:\\"nombre\\";s:13:\\"Cuadrante G10\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad124-04ad-71bc-926b-b85ec1dd015f\\";s:6:\\"codigo\\";s:3:\\"G11\\";s:6:\\"nombre\\";s:13:\\"Cuadrante G11\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764686091,"delay":null}	0	\N	1764686091	1764686091
6	default	{"uuid":"77c78017-91a6-4f37-897b-6f2ee29b5c78","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae072-2157-7353-ac1a-5bb9181daa4e\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764702167,"delay":null}	0	\N	1764702167	1764702167
7	default	{"uuid":"67a23828-3e72-436c-899d-81da4675a2ea","displayName":"App\\\\Events\\\\CambioGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:22:\\"App\\\\Events\\\\CambioGrupo\\":4:{s:9:\\"usuarioId\\";s:36:\\"019ad0d8-55b1-7145-9af2-905afadc3730\\";s:13:\\"grupoAnterior\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:16:\\"App\\\\Models\\\\Grupo\\";s:2:\\"id\\";s:36:\\"019ad123-5496-7181-8c2b-a6602d43a2bc\\";s:9:\\"relations\\";a:1:{i:0;s:9:\\"cuadrante\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"grupoNuevo\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:16:\\"App\\\\Models\\\\Grupo\\";s:2:\\"id\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";s:9:\\"relations\\";a:1:{i:0;s:9:\\"cuadrante\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:15:\\"cuadranteActual\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Cuadrante\\";s:2:\\"id\\";s:36:\\"019ad121-24fd-731b-b538-e23c7822e1b5\\";s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764702284,"delay":null}	0	\N	1764702284	1764702284
8	default	{"uuid":"6e071706-331a-4863-92c7-a326e42d8b1d","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019ae089-70a2-70be-85f7-9ecbaa7da782\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019ae072-2157-7353-ac1a-5bb9181daa4e\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764703695,"delay":null}	0	\N	1764703695	1764703695
9	default	{"uuid":"4ab74300-9c3c-4552-84c1-a89ed06ddbe2","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019ae08c-0ad5-73b1-a1f3-79edd2d9eb1a\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764703865,"delay":null}	0	\N	1764703865	1764703865
10	default	{"uuid":"50743700-dcb4-44b5-9862-a37ea38e8cbe","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae08c-0ab8-736a-b180-0e76ec715190\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764703865,"delay":null}	0	\N	1764703865	1764703865
11	default	{"uuid":"e8018d71-82cf-4cb1-8012-8f045a1b048f","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019ae08d-2c11-7173-b2c7-e1eb64d50c25\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019ae08c-0ab8-736a-b180-0e76ec715190\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764703939,"delay":null}	0	\N	1764703939	1764703939
12	default	{"uuid":"0e999370-d2c1-4daa-a53d-249af387879e","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019ae092-2a14-7046-b677-f4bdb6233f3c\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad0d8-55b1-7145-9af2-905afadc3730\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764704266,"delay":null}	0	\N	1764704266	1764704266
13	default	{"uuid":"83b87c88-ee16-454e-8235-5b6d378dab6a","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae092-2a02-7120-8cdc-6fb515197ef4\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764704266,"delay":null}	0	\N	1764704266	1764704266
14	default	{"uuid":"766beba6-6be9-481c-bd54-23cb8b0a3479","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae08c-0ab8-736a-b180-0e76ec715190\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7410-7312-80c5-c5865b70b333\\";s:6:\\"codigo\\";s:2:\\"B6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B6\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7f62-70f0-8312-6a6dcf1cfd7b\\";s:6:\\"codigo\\";s:2:\\"B7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B7\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad120-8c7d-7244-8899-50f49ae84b12\\";s:6:\\"codigo\\";s:2:\\"B8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B8\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad121-1c62-7274-8d0d-540878d127f5\\";s:6:\\"codigo\\";s:2:\\"C6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C6\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad121-33f4-71e0-9cd5-fccd55a73d43\\";s:6:\\"codigo\\";s:2:\\"C8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C8\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad121-c71c-7160-8f1f-76bb7be2493f\\";s:6:\\"codigo\\";s:2:\\"D6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D6\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad121-d5f5-73bf-9102-8c3ea8bf7f7d\\";s:6:\\"codigo\\";s:2:\\"D7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D7\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad121-e23b-7008-82e9-9c5a6dc48c65\\";s:6:\\"codigo\\";s:2:\\"D8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D8\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764790540,"delay":null}	0	\N	1764790540	1764790540
15	default	{"uuid":"c63f09e0-618d-4856-8cb3-8c0ebef42881","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae092-2a02-7120-8cdc-6fb515197ef4\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7410-7312-80c5-c5865b70b333\\";s:6:\\"codigo\\";s:2:\\"B6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B6\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7f62-70f0-8312-6a6dcf1cfd7b\\";s:6:\\"codigo\\";s:2:\\"B7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B7\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad120-8c7d-7244-8899-50f49ae84b12\\";s:6:\\"codigo\\";s:2:\\"B8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B8\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad121-1c62-7274-8d0d-540878d127f5\\";s:6:\\"codigo\\";s:2:\\"C6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C6\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad121-33f4-71e0-9cd5-fccd55a73d43\\";s:6:\\"codigo\\";s:2:\\"C8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C8\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad121-c71c-7160-8f1f-76bb7be2493f\\";s:6:\\"codigo\\";s:2:\\"D6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D6\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad121-d5f5-73bf-9102-8c3ea8bf7f7d\\";s:6:\\"codigo\\";s:2:\\"D7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D7\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad121-e23b-7008-82e9-9c5a6dc48c65\\";s:6:\\"codigo\\";s:2:\\"D8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D8\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764790540,"delay":null}	0	\N	1764790540	1764790540
16	default	{"uuid":"5f713a52-9e0d-4d12-a4a3-7ff45fe92800","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019ae5e0-c1e6-73e9-89b5-783b22df1e78\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019ae092-2a02-7120-8cdc-6fb515197ef4\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764793303,"delay":null}	0	\N	1764793303	1764793303
17	default	{"uuid":"c35aa377-ee1b-441e-829e-fe11e9bd4b36","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019ae5e2-cddd-7103-a70b-271ed5b2fa22\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019ae092-2a02-7120-8cdc-6fb515197ef4\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764793437,"delay":null}	0	\N	1764793437	1764793437
18	default	{"uuid":"6d9ae53d-e591-40f2-925a-d3d433c47f37","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019ae5e4-8649-71de-b131-047e68632c62\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764793550,"delay":null}	0	\N	1764793550	1764793550
19	default	{"uuid":"dc4256f9-1a1c-4317-9d7b-56c267685686","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae5e4-861d-704e-a8d6-cff23d55e3ff\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764793550,"delay":null}	0	\N	1764793550	1764793550
20	default	{"uuid":"8fdd9801-e996-460e-8815-996123a15c39","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019ae613-d668-721c-b4dd-b9de5661a850\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764796651,"delay":null}	0	\N	1764796651	1764796651
21	default	{"uuid":"03d15461-5c8c-4378-9604-2d036dd9960e","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae613-d64a-72c0-8f3d-0b5682aa958e\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764796651,"delay":null}	0	\N	1764796651	1764796651
22	default	{"uuid":"ee9176dc-1b23-465b-8dbe-ad547efcc904","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae5e4-861d-704e-a8d6-cff23d55e3ff\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7410-7312-80c5-c5865b70b333\\";s:6:\\"codigo\\";s:2:\\"B6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B6\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7f62-70f0-8312-6a6dcf1cfd7b\\";s:6:\\"codigo\\";s:2:\\"B7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B7\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad120-8c7d-7244-8899-50f49ae84b12\\";s:6:\\"codigo\\";s:2:\\"B8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B8\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad121-1c62-7274-8d0d-540878d127f5\\";s:6:\\"codigo\\";s:2:\\"C6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C6\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad121-33f4-71e0-9cd5-fccd55a73d43\\";s:6:\\"codigo\\";s:2:\\"C8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C8\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad121-c71c-7160-8f1f-76bb7be2493f\\";s:6:\\"codigo\\";s:2:\\"D6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D6\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad121-d5f5-73bf-9102-8c3ea8bf7f7d\\";s:6:\\"codigo\\";s:2:\\"D7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D7\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad121-e23b-7008-82e9-9c5a6dc48c65\\";s:6:\\"codigo\\";s:2:\\"D8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D8\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764875821,"delay":null}	0	\N	1764875821	1764875821
23	default	{"uuid":"cc72b32d-df28-40ec-a78e-5b01f89e2dd1","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019ae613-d64a-72c0-8f3d-0b5682aa958e\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7410-7312-80c5-c5865b70b333\\";s:6:\\"codigo\\";s:2:\\"B6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B6\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7f62-70f0-8312-6a6dcf1cfd7b\\";s:6:\\"codigo\\";s:2:\\"B7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B7\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad120-8c7d-7244-8899-50f49ae84b12\\";s:6:\\"codigo\\";s:2:\\"B8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B8\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad121-1c62-7274-8d0d-540878d127f5\\";s:6:\\"codigo\\";s:2:\\"C6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C6\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad121-33f4-71e0-9cd5-fccd55a73d43\\";s:6:\\"codigo\\";s:2:\\"C8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C8\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad121-c71c-7160-8f1f-76bb7be2493f\\";s:6:\\"codigo\\";s:2:\\"D6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D6\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad121-d5f5-73bf-9102-8c3ea8bf7f7d\\";s:6:\\"codigo\\";s:2:\\"D7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D7\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad121-e23b-7008-82e9-9c5a6dc48c65\\";s:6:\\"codigo\\";s:2:\\"D8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D8\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764875821,"delay":null}	0	\N	1764875821	1764875821
24	default	{"uuid":"a75bc3a5-c51a-4aa5-9a4e-7c70e144e766","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aeacf-f12e-7282-a5ef-cbefe13e39cf\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-ea86-73d4-80a4-c5b2d6f20eed\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764876087,"delay":null}	0	\N	1764876087	1764876087
25	default	{"uuid":"325a1f6f-d871-47e5-81c3-99e9ab0f6503","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aeaef-0beb-72b0-b1b4-5bd905499526\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad0d8-55b1-7145-9af2-905afadc3730\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878126,"delay":null}	0	\N	1764878126	1764878126
26	default	{"uuid":"9aef8c25-da3a-40e2-8960-bb79d162c024","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aeaef-0bfe-71c6-bb6c-fcf18e9aa37e\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878126,"delay":null}	0	\N	1764878126	1764878126
27	default	{"uuid":"50b2bf48-db38-45cf-bfcf-b167d349757a","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aeaef-0bcb-714e-abba-8f52282f1d62\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878126,"delay":null}	0	\N	1764878126	1764878126
28	default	{"uuid":"cdcf08be-7373-4d4d-a7b7-cb2ed8176ca9","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019aeaef-f1f5-7238-aa27-647ae99850fa\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019aeaef-0bcb-714e-abba-8f52282f1d62\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878184,"delay":null}	0	\N	1764878184	1764878184
29	default	{"uuid":"1b6df97f-8313-42f3-aae4-72517495a35e","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019aeaf1-1a79-733e-abca-c5ca9bdfc7d0\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019aeaef-0bcb-714e-abba-8f52282f1d62\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878260,"delay":null}	0	\N	1764878260	1764878260
30	default	{"uuid":"c610b33b-0cfb-487f-a292-85b6a71c262e","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aeaf5-cf5b-7334-9265-33db99065957\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad123-f4d8-700a-be6c-21c2d28f2cf2\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878569,"delay":null}	0	\N	1764878569	1764878569
31	default	{"uuid":"c920b2f8-2e7b-4a13-b369-9ecde1c0e172","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aeaf8-564f-7292-8c76-bf030d98ff91\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad0d8-55b1-7145-9af2-905afadc3730\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878734,"delay":null}	0	\N	1764878734	1764878734
32	default	{"uuid":"98d2b9bd-6696-4816-ad19-8fac70661d04","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aeaf8-5659-7106-b10c-107ea2cef112\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019aeaee-0755-72ad-8b98-5ae66bf1d489\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878734,"delay":null}	0	\N	1764878734	1764878734
33	default	{"uuid":"e7c673d1-5e0e-441b-92d1-e717a1f853f4","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aeaf8-565e-70e6-ab7d-f3842fecf825\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878734,"delay":null}	0	\N	1764878734	1764878734
34	default	{"uuid":"0ee19170-b644-4cdb-8cca-f0710c6740ef","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aeaf8-563c-7201-9b88-442545ff364e\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764878734,"delay":null}	0	\N	1764878734	1764878734
35	default	{"uuid":"f2b6f5d4-6b40-4d7a-b5ff-734999f87b2c","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aeaf8-563c-7201-9b88-442545ff364e\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7410-7312-80c5-c5865b70b333\\";s:6:\\"codigo\\";s:2:\\"B6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B6\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad120-7f62-70f0-8312-6a6dcf1cfd7b\\";s:6:\\"codigo\\";s:2:\\"B7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B7\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad120-8c7d-7244-8899-50f49ae84b12\\";s:6:\\"codigo\\";s:2:\\"B8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante B8\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad121-1c62-7274-8d0d-540878d127f5\\";s:6:\\"codigo\\";s:2:\\"C6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C6\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad121-33f4-71e0-9cd5-fccd55a73d43\\";s:6:\\"codigo\\";s:2:\\"C8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C8\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad121-c71c-7160-8f1f-76bb7be2493f\\";s:6:\\"codigo\\";s:2:\\"D6\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D6\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad121-d5f5-73bf-9102-8c3ea8bf7f7d\\";s:6:\\"codigo\\";s:2:\\"D7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D7\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad121-e23b-7008-82e9-9c5a6dc48c65\\";s:6:\\"codigo\\";s:2:\\"D8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D8\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764894831,"delay":null}	0	\N	1764894831	1764894831
36	default	{"uuid":"ede936a0-57f5-4e3b-a3ff-766e9612f481","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aebed-f396-708a-a261-42ca1ed400eb\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019aeaee-0755-72ad-8b98-5ae66bf1d489\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764894831,"delay":null}	0	\N	1764894831	1764894831
37	default	{"uuid":"388ef5d8-731a-4cfc-8244-4e351a155add","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aebed-f3a4-73f6-9075-599e7448de79\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764894831,"delay":null}	0	\N	1764894831	1764894831
38	default	{"uuid":"3bd995b2-4257-4c04-979b-ade903297aa7","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aebed-f3ac-718a-a2c1-f7bf3e01b98a\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019aeaf2-c3fb-7044-857a-163ee20bb36c\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764894831,"delay":null}	0	\N	1764894831	1764894831
39	default	{"uuid":"8479f255-2743-4121-a27b-bf91b3fdff07","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aeacf-f12e-7282-a5ef-cbefe13e39cf\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad121-24fd-731b-b538-e23c7822e1b5\\";s:6:\\"codigo\\";s:2:\\"C7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C7\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad121-33f4-71e0-9cd5-fccd55a73d43\\";s:6:\\"codigo\\";s:2:\\"C8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C8\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad121-4096-7359-9d9b-521c6c6889aa\\";s:6:\\"codigo\\";s:2:\\"C9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante C9\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad121-d5f5-73bf-9102-8c3ea8bf7f7d\\";s:6:\\"codigo\\";s:2:\\"D7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D7\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad121-ecf8-739c-97c0-49a1e1a0dd5e\\";s:6:\\"codigo\\";s:2:\\"D9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante D9\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad122-83ec-72d8-9871-897d12966042\\";s:6:\\"codigo\\";s:2:\\"E7\\";s:6:\\"nombre\\";s:12:\\"Cuadrante E7\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad122-8f2d-73b3-b91e-11848d9794f8\\";s:6:\\"codigo\\";s:2:\\"E8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante E8\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad122-97cb-71fa-8f99-336ee2270965\\";s:6:\\"codigo\\";s:2:\\"E9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante E9\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764894831,"delay":null}	0	\N	1764894831	1764894831
40	default	{"uuid":"89bb9469-a5c3-4fed-b102-d2dd23cb1376","displayName":"App\\\\Events\\\\ReporteExpandido","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\ReporteExpandido\\":3:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aeaf5-cf5b-7334-9265-33db99065957\\";s:9:\\"relations\\";a:3:{i:0;s:9:\\"cuadrante\\";i:1;s:9:\\"categoria\\";i:2;s:7:\\"usuario\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:10:\\"nuevoNivel\\";i:2;s:20:\\"cuadrantesExpandidos\\";a:8:{i:0;a:3:{s:2:\\"id\\";s:36:\\"019ad123-35df-718c-8488-aa0f1202135d\\";s:6:\\"codigo\\";s:2:\\"F8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante F8\\";}i:1;a:3:{s:2:\\"id\\";s:36:\\"019ad123-42c1-7367-b965-906b77867688\\";s:6:\\"codigo\\";s:2:\\"F9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante F9\\";}i:2;a:3:{s:2:\\"id\\";s:36:\\"019ad123-4dcf-70fe-9706-42ce093c7ef9\\";s:6:\\"codigo\\";s:3:\\"F10\\";s:6:\\"nombre\\";s:13:\\"Cuadrante F10\\";}i:3;a:3:{s:2:\\"id\\";s:36:\\"019ad123-d923-7209-868b-884d794bd927\\";s:6:\\"codigo\\";s:2:\\"G8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante G8\\";}i:4;a:3:{s:2:\\"id\\";s:36:\\"019ad123-f6c0-7057-9954-782bf5e37746\\";s:6:\\"codigo\\";s:3:\\"G10\\";s:6:\\"nombre\\";s:13:\\"Cuadrante G10\\";}i:5;a:3:{s:2:\\"id\\";s:36:\\"019ad124-87ac-707c-b150-a1796a67b3c4\\";s:6:\\"codigo\\";s:2:\\"H8\\";s:6:\\"nombre\\";s:12:\\"Cuadrante H8\\";}i:6;a:3:{s:2:\\"id\\";s:36:\\"019ad124-9004-72e8-8469-dca2061f4500\\";s:6:\\"codigo\\";s:2:\\"H9\\";s:6:\\"nombre\\";s:12:\\"Cuadrante H9\\";}i:7;a:3:{s:2:\\"id\\";s:36:\\"019ad124-9ca8-71f2-8c8a-69dbf1980700\\";s:6:\\"codigo\\";s:3:\\"H10\\";s:6:\\"nombre\\";s:13:\\"Cuadrante H10\\";}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764894831,"delay":null}	0	\N	1764894831	1764894831
41	default	{"uuid":"14e69ce9-dd9a-4812-bddd-4ae738fab3e6","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aec0a-7b67-71e0-b008-4b5e15153c74\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019aeaee-0755-72ad-8b98-5ae66bf1d489\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764896701,"delay":null}	0	\N	1764896701	1764896701
42	default	{"uuid":"94e13795-91f8-4738-bff9-86b4267f96c3","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aec0a-7b7a-73c9-b0d0-92dd4717b969\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad2fb-1bd4-7157-9d95-bd081a5ddb43\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764896701,"delay":null}	0	\N	1764896701	1764896701
43	default	{"uuid":"62a2207b-ab8e-43d9-a033-5d0f72ee3741","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aec0a-7b7e-700a-8438-c82603e9680f\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019aeaf2-c3fb-7044-857a-163ee20bb36c\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764896701,"delay":null}	0	\N	1764896701	1764896701
44	default	{"uuid":"3cbb18c0-b436-4cbb-aea3-7772c4310c74","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aec0a-7b40-7107-957f-264fdabb276a\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad121-3173-73a3-a651-956ff0625eaa\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764896701,"delay":null}	0	\N	1764896701	1764896701
45	default	{"uuid":"43a7d47d-c6cf-44f0-9801-a34f8b1c8d47","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019aec0b-f819-72af-8aa0-2b2440f48136\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019aec0a-7b40-7107-957f-264fdabb276a\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764896798,"delay":null}	0	\N	1764896798	1764896798
46	default	{"uuid":"5f97c791-8ec0-46bf-aed2-3aa7170bf050","displayName":"App\\\\Events\\\\NuevaNotificacion","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevaNotificacion\\":2:{s:12:\\"notificacion\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Notificacion\\";s:2:\\"id\\";s:36:\\"019aec7b-d0c3-72a7-a0df-988ca7970ad5\\";s:9:\\"relations\\";a:1:{i:0;s:5:\\"datos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"usuarioId\\";s:36:\\"019ad0d8-55b1-7145-9af2-905afadc3730\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764904128,"delay":null}	0	\N	1764904128	1764904128
47	default	{"uuid":"2e7fde28-90c4-4814-a027-569846f49c50","displayName":"App\\\\Events\\\\NuevoReporteGrupo","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:28:\\"App\\\\Events\\\\NuevoReporteGrupo\\":2:{s:7:\\"reporte\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:18:\\"App\\\\Models\\\\Reporte\\";s:2:\\"id\\";s:36:\\"019aec7b-d0aa-70d6-8281-10513a3f1477\\";s:9:\\"relations\\";a:5:{i:0;s:9:\\"categoria\\";i:1;s:7:\\"usuario\\";i:2;s:8:\\"imagenes\\";i:3;s:6:\\"videos\\";i:4;s:15:\\"caracteristicas\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:7:\\"grupoId\\";s:36:\\"019ad123-5496-7181-8c2b-a6602d43a2bc\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764904128,"delay":null}	0	\N	1764904128	1764904128
48	default	{"uuid":"046c9aab-0674-42c8-81e3-02aa31d0963b","displayName":"App\\\\Events\\\\NuevaRespuestaReporte","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":15:{s:5:\\"event\\";O:32:\\"App\\\\Events\\\\NuevaRespuestaReporte\\":2:{s:9:\\"respuesta\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:20:\\"App\\\\Models\\\\Respuesta\\";s:2:\\"id\\";s:36:\\"019aec7d-c0cc-739a-94a7-0667c1bd9d09\\";s:9:\\"relations\\";a:3:{i:0;s:7:\\"usuario\\";i:1;s:8:\\"imagenes\\";i:2;s:6:\\"videos\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:9:\\"reporteId\\";s:36:\\"019aec7b-d0aa-70d6-8281-10513a3f1477\\";}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:12:\\"messageGroup\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"},"createdAt":1764904255,"delay":null}	0	\N	1764904255	1764904255
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2024_01_01_000000_create_permission_tables	1
5	2025_12_11_005646_modify_model_has_roles_for_uuid_support	1
6	2025_12_13_000001_create_categorias_table	1
7	2025_12_13_000002_create_configuracion_sistema_table	1
8	2025_12_13_000003_create_cuadrantes_table	1
9	2025_12_13_000004_create_usuarios_table	1
10	2025_12_13_000005_create_grupos_table	1
11	2025_12_13_000006_create_reportes_table	1
12	2025_12_13_000007_create_notificaciones_table	1
13	2025_12_13_000008_create_grupo_miembros_table	1
14	2025_12_13_000009_create_reporte_imagenes_table	1
15	2025_12_13_000010_create_respuestas_table	1
16	2025_12_13_000011_create_expansiones_reporte_table	1
\.


--
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
1	App\\Models\\Usuario	019b18c3-de19-7227-af12-16da5e6c5969
3	App\\Models\\Usuario	019b18c3-de19-7227-af12-16da5e6c5969
4	App\\Models\\User	5
4	App\\Models\\User	6
3	App\\Models\\User	1
1	App\\Models\\User	3
1	App\\Models\\User	2
1	App\\Models\\Usuario	019aeaf2-c3fb-7044-857a-163ee20bb36c
1	App\\Models\\Usuario	019ad2fb-1bd4-7157-9d95-bd081a5ddb43
4	App\\Models\\User	4
1	App\\Models\\Usuario	019aeaee-0755-72ad-8b98-5ae66bf1d489
1	App\\Models\\Usuario	019ad0d8-55b1-7145-9af2-905afadc3730
3	App\\Models\\User	9
\.


--
-- Data for Name: notificaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificaciones (id, usuario_id, tipo, titulo, mensaje, datos, leida, enviada_push, enviada_email, created_at, updated_at) FROM stdin;
019ad5cc-6a7e-73f5-abfe-68b21c763efe	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: tyy	\N	t	f	f	2025-11-30 17:25:34	\N
019ad5c6-8d81-73f5-85e6-26ba86e6a46b	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: prueba	\N	t	f	f	2025-11-30 17:19:10	\N
019ad54f-0f82-701c-8ccb-aee6f0ff8fc3	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: carnet	\N	t	f	f	2025-11-30 15:08:39	\N
019ad54e-7aeb-711f-9c6b-7a7b74b9b863	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: carnet	\N	t	f	f	2025-11-30 15:08:01	\N
019ad54d-3602-72a3-b624-abcadd953600	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: carnet	\N	t	f	f	2025-11-30 15:06:38	\N
019ad308-fe27-71fb-a26e-fab05c17eec8	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: prueba	\N	t	f	f	2025-11-30 04:32:53	\N
019ad304-069b-7281-942e-f93f7e44fe0c	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: prueba	\N	t	f	f	2025-11-30 04:27:27	\N
019ad2fd-24ad-731c-a5bf-b22c200b4504	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: prueba	\N	t	f	f	2025-11-30 04:19:56	\N
019ad2fc-b6e8-7234-93b1-3f623032c4aa	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: prueba	\N	t	f	f	2025-11-30 04:19:28	\N
019ad2fc-1d0f-7262-a8a0-36442e25f603	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: prueba	\N	t	f	f	2025-11-30 04:18:49	\N
019ad5cb-6c01-70cc-b6dd-4f10405fa339	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: tyy	\N	t	f	f	2025-11-30 17:24:29	\N
019ad5c8-4225-717d-84f6-320971a4196b	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: rt	\N	t	f	f	2025-11-30 17:21:02	\N
019ad554-3788-7249-9609-075ae6142970	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: tarea	\N	t	f	f	2025-11-30 15:14:17	\N
019ad60a-adc8-726d-a673-a32fc1944c5d	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: tr	\N	t	f	f	2025-11-30 18:33:35	\N
019ad60b-9d0e-7330-8abe-7a1eba2f92ea	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: tr	\N	t	f	f	2025-11-30 18:34:36	\N
019ad60c-fd5e-71e9-84b8-580933454901	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: tr	\N	t	f	f	2025-11-30 18:36:06	\N
019ad757-83e2-70be-8684-03cb023ce93a	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: prueva	\N	t	f	f	2025-12-01 00:37:08	\N
019ad751-4426-7230-b90c-d37098dcf6c7	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: ttty	\N	t	f	f	2025-12-01 00:30:18	\N
019ad746-8f14-736b-b48e-63d00df3f0a5	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: yyy	\N	t	f	f	2025-12-01 00:18:36	\N
019ad7f3-7e96-7277-90bd-2c135f3fdc0a	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: prueva	\N	t	f	f	2025-12-01 03:27:30	\N
019adb72-a82f-7077-b0d5-08eb4b48f14c	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	test	Prueba Flutter	Si ves esto, WebSocket funciona! 	\N	t	f	f	2025-12-01 19:45:15	\N
019adc13-28ae-7380-b5b8-26b3d49914b1	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: ttty	\N	t	f	f	2025-12-01 22:40:34	\N
019adc13-e857-7273-8c16-6fb80138a6f3	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: tr	\N	t	f	f	2025-12-01 22:41:23	\N
019adc1a-b01b-731c-90c0-83c3731877c6	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	Alguien tiene información	Han respondido a tu reporte: yyy	\N	t	f	f	2025-12-01 22:48:47	\N
019ae089-70a5-70a0-bc95-09ee103ea0a7	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: carnet	\N	t	f	f	2025-12-02 19:28:15	\N
019ae08c-0ad5-73b1-a1f3-79edd2d9eb1a	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: carnet	\N	t	f	f	2025-12-02 19:31:05	\N
019ae08d-2c15-70ba-924e-a9b3593e56fe	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: carnet	\N	t	f	f	2025-12-02 19:32:19	\N
019ae092-2a14-7046-b677-f4bdb6233f3c	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: collar perdido	\N	t	f	f	2025-12-02 19:37:46	\N
019ae613-d668-721c-b4dd-b9de5661a850	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: tr	\N	t	f	f	2025-12-03 21:17:31	\N
019ae5e4-8649-71de-b131-047e68632c62	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: trtr	\N	t	f	f	2025-12-03 20:25:50	\N
019ae5e2-cde5-7013-afa1-6ea3580ef1f4	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: collar perdido	\N	t	f	f	2025-12-03 20:23:57	\N
019ae5e0-c1f3-72b4-b0ff-3f520c4256a9	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: collar perdido	\N	t	f	f	2025-12-03 20:21:43	\N
019aeaef-0bfe-71c6-bb6c-fcf18e9aa37e	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: hh	\N	t	f	f	2025-12-04 19:55:26	\N
019aeaef-f1f9-7010-a065-aa004e52339f	019aeaee-0755-72ad-8b98-5ae66bf1d489	respuesta_reporte	Alguien reportó un avistamiento	Han respondido a tu reporte: hh	\N	t	f	f	2025-12-04 19:56:24	\N
019aeaf1-1a7e-73b2-9af3-068642ae3bf9	019aeaee-0755-72ad-8b98-5ae66bf1d489	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: hh	\N	t	f	f	2025-12-04 19:57:40	\N
019aeaef-0beb-72b0-b1b4-5bd905499526	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: hh	\N	t	f	f	2025-12-04 19:55:26	\N
019aeaf8-564f-7292-8c76-bf030d98ff91	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: perro husky matador	\N	t	f	f	2025-12-04 20:05:34	\N
019aeaf8-5659-7106-b10c-107ea2cef112	019aeaee-0755-72ad-8b98-5ae66bf1d489	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: perro husky matador	\N	t	f	f	2025-12-04 20:05:34	\N
019aebed-f396-708a-a261-42ca1ed400eb	019aeaee-0755-72ad-8b98-5ae66bf1d489	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: un abuelito	\N	f	f	f	2025-12-05 00:33:51	\N
019aebed-f3ac-718a-a2c1-f7bf3e01b98a	019aeaf2-c3fb-7044-857a-163ee20bb36c	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: un abuelito	\N	f	f	f	2025-12-05 00:33:51	\N
019aec0a-7b67-71e0-b008-4b5e15153c74	019aeaee-0755-72ad-8b98-5ae66bf1d489	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: carnet	\N	f	f	f	2025-12-05 01:05:01	\N
019aec0a-7b7e-700a-8438-c82603e9680f	019aeaf2-c3fb-7044-857a-163ee20bb36c	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: carnet	\N	f	f	f	2025-12-05 01:05:01	\N
019aec0a-7b7a-73c9-b0d0-92dd4717b969	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: carnet	\N	t	f	f	2025-12-05 01:05:01	\N
019aebed-f3a4-73f6-9075-599e7448de79	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: un abuelito	\N	t	f	f	2025-12-05 00:33:51	\N
019aeaf8-565e-70e6-ab7d-f3842fecf825	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: perro husky matador	\N	t	f	f	2025-12-04 20:05:34	\N
019aec0b-f823-70e9-817d-79cee35be48d	019ad0d8-55b1-7145-9af2-905afadc3730	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: carnet	\N	t	f	f	2025-12-05 01:06:38	\N
019aec7b-d0c3-72a7-a0df-988ca7970ad5	019ad0d8-55b1-7145-9af2-905afadc3730	nuevo_reporte	Nuevo reporte en tu zona	Se ha reportado: carnet	\N	t	f	f	2025-12-05 03:08:48	\N
019aec7d-c0d2-7309-909c-41a95daf77ab	019ad2fb-1bd4-7157-9d95-bd081a5ddb43	respuesta_reporte	¡Alguien encontró tu objeto!	Han respondido a tu reporte: carnet	\N	t	f	f	2025-12-05 03:10:55	\N
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reporte_imagenes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reporte_imagenes (id, reporte_id, ruta, tipo, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reportes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reportes (id, usuario_id, categoria_id, cuadrante_id, tipo_reporte, titulo, descripcion, ubicacion_exacta_lat, ubicacion_exacta_lng, direccion_referencia, fecha_perdida, fecha_reporte, estado, prioridad, nivel_expansion, max_expansion, proxima_expansion, contacto_publico, telefono_contacto, email_contacto, recompensa, vistas, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: respuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuestas (id, reporte_id, usuario_id, tipo_respuesta, mensaje, ubicacion, direccion_referencia, imagenes, videos, verificada, util, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
1	usuario	web	2025-12-13 17:28:48	2025-12-13 17:28:48
3	administrador	web	2025-12-13 17:40:16	2025-12-13 17:40:16
4	editor	web	2025-12-13 18:49:42	2025-12-13 18:49:42
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
APNj6PBNUNSFJERYRZjKnsrRR5KyfFQvmECzoHyC	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiRWlHZWhCZk84ZFBNdFlwdm12emZUUllUVTQ0dGl6MllJNTVCanhzVSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fX0=	1765654490
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
1	Fabian	fpandojus@gmail.com	\N	$2y$12$0H.TiJSFzN.5h910pnZIte7bmpjkkxEtaw7Rhrg.grU/ZKEvF8MJy	\N	2025-12-13 17:25:32	2025-12-13 17:25:32
2	Valeria	valeria@gmail.com	\N	$2y$12$BfsZf/3aaroZ3s9w1vZaXuxDBEHB.vgmEK.NZwUbg3URY2fQRKgO2	\N	2025-12-13 18:52:44	2025-12-13 18:52:44
3	Juan	juan@gmail.com	\N	$2y$12$WrRsQV0rAUgAuaGZNApDZ..AI3qOPGs7iyzomLKDZPPJbG4AaQeSO	\N	2025-12-13 18:54:43	2025-12-13 18:54:43
4	jose	jose@gmail.com	\N	$2y$12$Oi7FCECVkM.4ZKekmz1pOuhbb.WzgJbNbulBOUo0eyklpCP/q7n9e	\N	2025-12-13 18:57:16	2025-12-13 18:57:16
5	pedro	pedro@gmail.com	\N	$2y$12$TRAPKxKT09vNbbAzW4Obkukn4.7QLTDlbF/QoiTZjPjkhEoMbEQMy	\N	2025-12-13 19:01:27	2025-12-13 19:01:27
6	lucas	lucas@gmail.com	\N	$2y$12$yQo3Y8sAwLnGG3lklJnWf.kfmyeGjUZZ6O6T9pKVtLPmbmzfy0U7u	\N	2025-12-13 19:02:39	2025-12-13 19:02:39
9	juan jose ardaya	juanjo@gmail.com	\N	$2y$12$AO3aMPoAu8wNuohoUwOhG.5cPHIg70EXXjpB2gimFo12l3zFRydsq	\N	2025-12-13 19:17:35	2025-12-13 19:17:35
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, email, telefono, avatar_url, puntos_ayuda, activo, fecha_registro, created_at, updated_at, ubicacion_actual_lat, ubicacion_actual_lng, rol, contrasena) FROM stdin;
019aeaee-0755-72ad-8b98-5ae66bf1d489	rodrigo	rgg@gmail.com	63526749	\N	0	t	2025-12-04 15:54:19	2025-12-04 19:54:19	2025-12-04 19:54:19	\N	\N	cliente	$2y$12$jG/YuXzAwcW/7c/ySKzHVuejM1XSTj4b/5p6Mb7oUCeZch3a8a/.2
019aeaf2-c3fb-7044-857a-163ee20bb36c	Andres Ortega	eliasandres2504@gmail.com	77618892	\N	0	t	2025-12-04 15:59:30	2025-12-04 19:59:29	2025-12-04 19:59:29	\N	\N	cliente	$2y$12$of.aNsWCIO27y4y6JCK4zOsA.fB8nrBjls.a0wwRJATaXLP1vQSAe
019ad2fb-1bd4-7157-9d95-bd081a5ddb43	roderich	rode@gmail.com	63526749	\N	50	t	2025-11-30 00:17:43	2025-11-30 04:17:43	2025-12-05 01:07:38	\N	\N	cliente	$2y$12$w8TyY4kEtDG5SBdMJ9VaQu.Vr2/9/zjH3/fsZg7nfvbSGkVpKlbxi
019ad0d8-55b1-7145-9af2-905afadc3730	rodrigo	rcr@gmail.com	63526749	\N	30	t	2025-11-29 14:20:30	2025-11-29 18:20:30	2025-12-05 03:11:48	\N	\N	cliente	$2y$12$oEQTQuGiLcPdqjXHfRXUyOT4KUdAGIECH/Occ3lliZue.kQqmNOc2
019b18c3-de19-7227-af12-16da5e6c5969	Fabian Pando Justiniano	fpandojus@gmail.com	\N	\N	0	t	2025-12-13 11:30:48	2025-12-13 17:30:48	2025-12-13 17:40:20	\N	\N	administrador	$2y$12$KF8g/007e/Xk4IGfDCpVuugIe7vqLV.f2KuF/R/QLgoXd0Q9OHkRW
019b1922-fccd-7054-89d6-afe056ca6527	Test API Admin	test_admin_api_1765653281@example.com	\N	\N	0	t	2025-12-13 13:14:42	2025-12-13 19:14:41	2025-12-13 19:14:41	\N	\N	editor	$2y$12$0bM8SBtTfPHctUV3Fkgs4euWSorIuF5ofxqduJPWQoY2ZRbT3ER4u
019b1923-8130-7021-a210-bfce62d44c65	Verify API Admin	verify_admin_api_1765653315@example.com	\N	\N	0	t	2025-12-13 13:15:16	2025-12-13 19:15:15	2025-12-13 19:15:15	\N	\N	editor	$2y$12$/Lw/I3O/zwVZctWZY74tiuKrD4SNr9esgQ/uoPuueWmZJgiVTzSwy
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 48, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 8, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: reporte_imagenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reporte_imagenes_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: configuracion_sistema configuracion_sistema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion_sistema
    ADD CONSTRAINT configuracion_sistema_pkey PRIMARY KEY (clave);


--
-- Name: cuadrante_barrios cuadrante_barrios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuadrante_barrios
    ADD CONSTRAINT cuadrante_barrios_pkey PRIMARY KEY (id);


--
-- Name: cuadrantes cuadrantes_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuadrantes
    ADD CONSTRAINT cuadrantes_codigo_unique UNIQUE (codigo);


--
-- Name: cuadrantes cuadrantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuadrantes
    ADD CONSTRAINT cuadrantes_pkey PRIMARY KEY (id);


--
-- Name: expansiones_reporte expansiones_reporte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expansiones_reporte
    ADD CONSTRAINT expansiones_reporte_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: grupo_miembros grupo_miembros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_miembros
    ADD CONSTRAINT grupo_miembros_pkey PRIMARY KEY (id);


--
-- Name: grupos grupos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: notificaciones notificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: reporte_imagenes reporte_imagenes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reporte_imagenes
    ADD CONSTRAINT reporte_imagenes_pkey PRIMARY KEY (id);


--
-- Name: reportes reportes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_pkey PRIMARY KEY (id);


--
-- Name: respuestas respuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_pkey PRIMARY KEY (id);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_unique UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: cuadrante_barrios cuadrante_barrios_cuadrante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuadrante_barrios
    ADD CONSTRAINT cuadrante_barrios_cuadrante_id_fkey FOREIGN KEY (cuadrante_id) REFERENCES public.cuadrantes(id) ON DELETE CASCADE;


--
-- Name: expansiones_reporte expansiones_reporte_cuadrante_expandido_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expansiones_reporte
    ADD CONSTRAINT expansiones_reporte_cuadrante_expandido_id_foreign FOREIGN KEY (cuadrante_expandido_id) REFERENCES public.cuadrantes(id) ON DELETE CASCADE;


--
-- Name: expansiones_reporte expansiones_reporte_cuadrante_original_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expansiones_reporte
    ADD CONSTRAINT expansiones_reporte_cuadrante_original_id_foreign FOREIGN KEY (cuadrante_original_id) REFERENCES public.cuadrantes(id) ON DELETE CASCADE;


--
-- Name: expansiones_reporte expansiones_reporte_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expansiones_reporte
    ADD CONSTRAINT expansiones_reporte_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: grupo_miembros grupo_miembros_grupo_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_miembros
    ADD CONSTRAINT grupo_miembros_grupo_id_foreign FOREIGN KEY (grupo_id) REFERENCES public.grupos(id) ON DELETE CASCADE;


--
-- Name: grupo_miembros grupo_miembros_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_miembros
    ADD CONSTRAINT grupo_miembros_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: grupos grupos_cuadrante_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_cuadrante_id_foreign FOREIGN KEY (cuadrante_id) REFERENCES public.cuadrantes(id) ON DELETE CASCADE;


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: notificaciones notificaciones_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: reporte_imagenes reporte_imagenes_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reporte_imagenes
    ADD CONSTRAINT reporte_imagenes_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: reportes reportes_categoria_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_categoria_id_foreign FOREIGN KEY (categoria_id) REFERENCES public.categorias(id) ON DELETE CASCADE;


--
-- Name: reportes reportes_cuadrante_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_cuadrante_id_foreign FOREIGN KEY (cuadrante_id) REFERENCES public.cuadrantes(id) ON DELETE CASCADE;


--
-- Name: reportes reportes_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reportes
    ADD CONSTRAINT reportes_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: respuestas respuestas_reporte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_reporte_id_foreign FOREIGN KEY (reporte_id) REFERENCES public.reportes(id) ON DELETE CASCADE;


--
-- Name: respuestas respuestas_usuario_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_usuario_id_foreign FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 0fRJbDA0rczuovACNVOie1QiJeDDAaSAM6uJKygx727RP0GCCe2kgLqg8g4aEta

