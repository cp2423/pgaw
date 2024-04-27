--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: database; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.database (
    id integer NOT NULL,
    schema_res character varying,
    server integer NOT NULL
);


ALTER TABLE public.database OWNER TO postgres;

--
-- Name: debugger_function_arguments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.debugger_function_arguments (
    server_id integer NOT NULL,
    database_id integer NOT NULL,
    schema_id integer NOT NULL,
    function_id integer NOT NULL,
    arg_id integer NOT NULL,
    is_null integer NOT NULL,
    is_expression integer NOT NULL,
    use_default integer,
    value character varying NOT NULL,
    CONSTRAINT debugger_function_arguments_is_expression_check CHECK (((is_expression >= 0) AND (is_expression <= 1))),
    CONSTRAINT debugger_function_arguments_is_null_check CHECK (((is_null >= 0) AND (is_null <= 1))),
    CONSTRAINT debugger_function_arguments_use_default_check CHECK (((use_default >= 0) AND (use_default <= 1)))
);


ALTER TABLE public.debugger_function_arguments OWNER TO postgres;

--
-- Name: keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keys (
    name character varying NOT NULL,
    value character varying NOT NULL
);


ALTER TABLE public.keys OWNER TO postgres;

--
-- Name: macros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.macros (
    id integer NOT NULL,
    alt boolean NOT NULL,
    control boolean NOT NULL,
    key character varying(128) NOT NULL,
    key_code integer NOT NULL
);


ALTER TABLE public.macros OWNER TO postgres;

--
-- Name: macros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.macros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.macros_id_seq OWNER TO postgres;

--
-- Name: macros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.macros_id_seq OWNED BY public.macros.id;


--
-- Name: module_preference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.module_preference (
    id integer NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE public.module_preference OWNER TO postgres;

--
-- Name: module_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.module_preference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.module_preference_id_seq OWNER TO postgres;

--
-- Name: module_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.module_preference_id_seq OWNED BY public.module_preference.id;


--
-- Name: preference_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preference_category (
    id integer NOT NULL,
    mid integer,
    name character varying(256) NOT NULL
);


ALTER TABLE public.preference_category OWNER TO postgres;

--
-- Name: preference_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preference_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preference_category_id_seq OWNER TO postgres;

--
-- Name: preference_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preference_category_id_seq OWNED BY public.preference_category.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preferences (
    id integer NOT NULL,
    cid integer NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE public.preferences OWNER TO postgres;

--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preferences_id_seq OWNER TO postgres;

--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preferences_id_seq OWNED BY public.preferences.id;


--
-- Name: process; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.process (
    user_id integer NOT NULL,
    pid character varying NOT NULL,
    "desc" character varying NOT NULL,
    command character varying NOT NULL,
    arguments character varying,
    start_time character varying,
    end_time character varying,
    logdir character varying,
    exit_code integer,
    acknowledge character varying,
    utility_pid integer,
    process_state integer DEFAULT 0,
    server_id integer DEFAULT 0
);


ALTER TABLE public.process OWNER TO postgres;

--
-- Name: query_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.query_history (
    srno integer NOT NULL,
    uid integer NOT NULL,
    sid integer NOT NULL,
    dbname character varying NOT NULL,
    query_info character varying NOT NULL,
    last_updated_flag character varying NOT NULL
);


ALTER TABLE public.query_history OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    description character varying(256) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_seq OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: roles_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_users (
    user_id integer,
    role_id integer
);


ALTER TABLE public.roles_users OWNER TO postgres;

--
-- Name: server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.server (
    id integer NOT NULL,
    user_id integer NOT NULL,
    servergroup_id integer NOT NULL,
    name character varying(128) NOT NULL,
    host character varying(128),
    port integer,
    maintenance_db character varying(64),
    username character varying(64),
    comment character varying(1024),
    password character varying,
    role character varying(64),
    discovery_id character varying,
    db_res character varying,
    bgcolor character varying(10),
    fgcolor character varying(10),
    service character varying,
    use_ssh_tunnel integer DEFAULT 0,
    tunnel_host character varying,
    tunnel_port character varying,
    tunnel_username character varying,
    tunnel_authentication integer DEFAULT 0,
    tunnel_identity_file character varying,
    tunnel_password character varying(64),
    save_password integer DEFAULT 0,
    shared boolean,
    kerberos_conn boolean DEFAULT false,
    cloud_status integer DEFAULT 0,
    passexec_cmd character varying,
    passexec_expiration integer,
    connection_params json,
    shared_username character varying(64),
    prepare_threshold integer,
    tunnel_keep_alive integer DEFAULT 0
);


ALTER TABLE public.server OWNER TO postgres;

--
-- Name: server_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.server_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.server_id_seq OWNER TO postgres;

--
-- Name: server_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.server_id_seq OWNED BY public.server.id;


--
-- Name: servergroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servergroup (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.servergroup OWNER TO postgres;

--
-- Name: servergroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servergroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servergroup_id_seq OWNER TO postgres;

--
-- Name: servergroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servergroup_id_seq OWNED BY public.servergroup.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.setting (
    user_id integer NOT NULL,
    setting character varying(256) NOT NULL,
    value text
);


ALTER TABLE public.setting OWNER TO postgres;

--
-- Name: sharedserver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sharedserver (
    id integer NOT NULL,
    user_id integer NOT NULL,
    server_owner character varying(64),
    servergroup_id integer NOT NULL,
    name character varying(128) NOT NULL,
    host character varying(128),
    port integer,
    maintenance_db character varying(64),
    username character varying(64),
    password character varying,
    role character varying(64),
    comment character varying(1024),
    discovery_id character varying(128),
    db_res character varying,
    bgcolor character varying(10),
    fgcolor character varying(10),
    service character varying,
    use_ssh_tunnel integer DEFAULT 0,
    tunnel_host character varying,
    tunnel_port character varying,
    tunnel_username character varying,
    tunnel_authentication integer DEFAULT 0,
    tunnel_identity_file character varying,
    shared boolean NOT NULL,
    save_password integer DEFAULT 0,
    tunnel_password character varying,
    osid integer,
    connection_params json,
    prepare_threshold integer,
    tunnel_keep_alive integer DEFAULT 0
);


ALTER TABLE public.sharedserver OWNER TO postgres;

--
-- Name: sharedserver_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sharedserver_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sharedserver_id_seq OWNER TO postgres;

--
-- Name: sharedserver_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sharedserver_id_seq OWNED BY public.sharedserver.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(256),
    password character varying,
    active boolean NOT NULL,
    confirmed_at timestamp without time zone,
    masterpass_check character varying(256),
    username character varying(256) DEFAULT ''::character varying NOT NULL,
    auth_source character varying(256) DEFAULT 'internal'::character varying NOT NULL,
    fs_uniquifier character varying NOT NULL,
    locked boolean DEFAULT false,
    login_attempts integer DEFAULT 0
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_macros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_macros (
    mid integer NOT NULL,
    uid integer NOT NULL,
    name character varying(1024) NOT NULL,
    sql character varying
);


ALTER TABLE public.user_macros OWNER TO postgres;

--
-- Name: user_mfa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_mfa (
    user_id integer NOT NULL,
    mfa_auth character varying(256) NOT NULL,
    options character varying
);


ALTER TABLE public.user_mfa OWNER TO postgres;

--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preferences (
    pid integer NOT NULL,
    uid integer NOT NULL,
    value character varying(1024) NOT NULL
);


ALTER TABLE public.user_preferences OWNER TO postgres;

--
-- Name: version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.version (
    name character varying(32) NOT NULL,
    value integer NOT NULL
);


ALTER TABLE public.version OWNER TO postgres;

--
-- Name: macros id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.macros ALTER COLUMN id SET DEFAULT nextval('public.macros_id_seq'::regclass);


--
-- Name: module_preference id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_preference ALTER COLUMN id SET DEFAULT nextval('public.module_preference_id_seq'::regclass);


--
-- Name: preference_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preference_category ALTER COLUMN id SET DEFAULT nextval('public.preference_category_id_seq'::regclass);


--
-- Name: preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences ALTER COLUMN id SET DEFAULT nextval('public.preferences_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: server id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server ALTER COLUMN id SET DEFAULT nextval('public.server_id_seq'::regclass);


--
-- Name: servergroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servergroup ALTER COLUMN id SET DEFAULT nextval('public.servergroup_id_seq'::regclass);


--
-- Name: sharedserver id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sharedserver ALTER COLUMN id SET DEFAULT nextval('public.sharedserver_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
ec0f11f9a4e6
\.


--
-- Data for Name: database; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.database (id, schema_res, server) FROM stdin;
\.


--
-- Data for Name: debugger_function_arguments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.debugger_function_arguments (server_id, database_id, schema_id, function_id, arg_id, is_null, is_expression, use_default, value) FROM stdin;
\.


--
-- Data for Name: keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keys (name, value) FROM stdin;
CSRF_SESSION_KEY	ehSsuJ05Oa-4oj7At-Op1QJ9HnW4JEO8Vx8EtqepPzw=
SECRET_KEY	r-z5LujfMi6l0_42l6tOfZOBQPCzROLndNP7Uzo1vyQ=
SECURITY_PASSWORD_SALT	EwRx3ZlhaNKLbzwNmsjKaiaVwC0AnfVSJDtOA5Xqg3g=
\.


--
-- Data for Name: macros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.macros (id, alt, control, key, key_code) FROM stdin;
1	f	t	1	49
2	f	t	2	50
3	f	t	3	51
4	f	t	4	52
5	f	t	5	53
6	f	t	6	54
7	f	t	7	55
8	f	t	8	56
9	f	t	9	57
10	f	t	0	48
11	t	f	F1	112
12	t	f	F2	113
13	t	f	F3	114
14	t	f	F4	115
15	t	f	F5	116
16	t	f	F6	117
17	t	f	F7	118
18	t	f	F8	119
19	t	f	F9	120
20	t	f	F10	121
21	t	f	F11	122
22	t	f	F12	123
\.


--
-- Data for Name: module_preference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.module_preference (id, name) FROM stdin;
1	kerberos
2	oauth2
3	webserver
4	about
5	authenticate
6	browser
7	NODE-server_group
8	NODE-server
9	paths
10	NODE-database
11	NODE-cast
12	NODE-event_trigger
13	NODE-extension
14	NODE-foreign_data_wrapper
15	NODE-foreign_server
16	NODE-user_mapping
17	NODE-language
18	NODE-publication
19	NODE-schema
20	NODE-aggregate
21	NODE-catalog_object
22	NODE-catalog_object_column
23	NODE-collation
24	NODE-domain
25	NODE-domain_constraints
26	NODE-foreign_table
27	NODE-trigger
28	NODE-constraints
29	NODE-check_constraint
30	NODE-exclusion_constraint
31	NODE-foreign_key
32	NODE-primary_key
33	NODE-unique_constraint
34	NODE-foreign_table_column
35	NODE-fts_configuration
36	NODE-fts_dictionary
37	NODE-fts_parser
38	NODE-fts_template
39	NODE-function
40	NODE-trigger_function
41	NODE-procedure
42	NODE-operator
43	NODE-package
44	NODE-edbfunc
45	NODE-edbproc
46	NODE-edbvar
47	NODE-sequence
48	NODE-synonym
49	NODE-table
50	NODE-column
51	NODE-compound_trigger
52	NODE-index
53	NODE-partition
54	NODE-row_security_policy
55	NODE-rule
56	NODE-type
57	NODE-view
58	NODE-mview
59	NODE-catalog
60	NODE-subscription
61	NODE-dbms_job_scheduler
62	NODE-dbms_job
63	NODE-dbms_program
64	NODE-dbms_schedule
65	NODE-pga_job
66	NODE-pga_schedule
67	NODE-pga_jobstep
68	NODE-resource_group
69	NODE-role
70	NODE-tablespace
71	NODE-replica_nodes
72	dashboard
73	dashboards
74	graphs
75	help
76	misc
77	bgprocess
78	cloud
79	azure
80	biganimal
81	rds
82	google
83	dependencies
84	dependents
85	file_manager
86	statistics
87	preferences
88	redirects
89	settings
90	tools
91	backup
92	debugger
93	erd
94	grant_wizard
95	import_export
96	import_export_servers
97	maintenance
98	psql
99	restore
100	schema_diff
101	search_objects
102	sqleditor
103	user_management
\.


--
-- Data for Name: preference_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preference_category (id, mid, name) FROM stdin;
1	6	display
2	6	properties
3	6	processes
4	6	keyboard_shortcuts
5	6	tab_settings
6	6	breadcrumbs
7	9	bin_paths
8	6	node
9	73	dashboards
10	73	display
11	74	graphs
12	9	help
13	76	user_language
14	76	themes
15	85	options
16	92	keyboard_shortcuts
17	93	keyboard_shortcuts
18	93	options
19	100	display
20	102	Explain
21	102	Options
22	102	Editor
23	102	CSV_output
24	102	Results_grid
25	102	display
26	102	keyboard_shortcuts
27	102	auto_completion
28	102	editor
29	102	graph_visualiser
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, cid, name) FROM stdin;
1	1	show_system_objects
2	1	show_empty_coll_nodes
3	1	show_user_defined_templates
4	1	hide_shared_server
5	1	browser_tree_state_save_interval
6	1	confirm_on_refresh_close
7	1	confirm_on_properties_close
8	1	auto_expand_sole_children
9	2	table_row_count_threshold
10	2	pgagent_row_threshold
11	3	process_retain_days
12	4	browser_tree
13	4	tabbed_panel_backward
14	4	tabbed_panel_forward
15	4	main_menu_file
16	4	main_menu_object
17	4	main_menu_tools
18	4	main_menu_help
19	4	sub_menu_query_tool
20	4	sub_menu_view_data
21	4	sub_menu_search_objects
22	4	sub_menu_create
23	4	sub_menu_properties
24	4	sub_menu_delete
25	4	context_menu
26	4	direct_debugging
27	4	sub_menu_refresh
28	4	add_grid_row
29	4	open_quick_search
30	5	dynamic_tabs
31	5	qt_tab_title_placeholder
32	5	vw_edt_tab_title_placeholder
33	5	debugger_tab_title_placeholder
34	5	new_browser_tab_open
35	6	breadcrumbs_enable
36	6	breadcrumbs_show_comment
37	7	pg_bin_dir
38	7	ppas_bin_dir
39	8	show_node_database
40	8	show_node_cast
41	8	show_node_event_trigger
42	8	show_node_extension
43	8	show_node_foreign_data_wrapper
44	8	show_node_foreign_server
45	8	show_node_user_mapping
46	8	show_node_language
47	8	show_node_publication
48	8	show_node_schema
49	8	show_node_aggregate
50	8	show_node_catalog_object
51	8	show_node_collation
52	8	show_node_domain
53	8	show_node_domain_constraints
54	8	show_node_foreign_table
55	8	show_node_trigger
56	8	show_node_constraints
57	8	show_node_check_constraint
58	8	show_node_exclusion_constraint
59	8	show_node_foreign_key
60	8	show_node_primary_key
61	8	show_node_unique_constraint
62	8	show_node_foreign_table_column
63	8	show_node_fts_configuration
64	8	show_node_fts_dictionary
65	8	show_node_fts_parser
66	8	show_node_fts_template
67	8	show_node_function
68	8	show_node_trigger_function
69	8	show_node_procedure
70	8	show_node_operator
71	8	show_node_package
72	8	show_node_edbfunc
73	8	show_node_edbproc
74	8	show_node_edbvar
75	8	show_node_sequence
76	8	show_node_synonym
77	8	show_node_table
78	8	show_node_column
79	8	show_node_compound_trigger
80	8	show_node_index
81	8	show_node_partition
82	8	show_node_row_security_policy
83	8	show_node_rule
84	8	show_node_type
85	8	show_node_view
86	8	show_node_mview
87	8	show_node_catalog
88	8	show_node_subscription
89	8	show_node_dbms_job_scheduler
90	8	show_node_dbms_job
91	8	show_node_dbms_program
92	8	show_node_dbms_schedule
93	8	show_node_pga_job
94	8	show_node_pga_schedule
95	8	show_node_pga_jobstep
96	8	show_node_resource_group
97	8	show_node_role
98	8	show_node_tablespace
99	8	show_node_replica_nodes
100	9	session_stats_refresh
101	9	tps_stats_refresh
102	9	ti_stats_refresh
103	9	to_stats_refresh
104	9	bio_stats_refresh
105	9	hpc_stats_refresh
106	9	cpu_stats_refresh
107	9	la_stats_refresh
108	9	pcpu_stats_refresh
109	9	m_stats_refresh
110	9	sm_stats_refresh
111	9	pmu_stats_refresh
112	9	io_stats_refresh
113	10	show_graphs
114	10	show_activity
115	10	long_running_query_threshold
116	11	graph_data_points
117	11	use_diff_point_style
118	11	graph_mouse_track
119	11	graph_line_border_width
120	12	pg_help_path
121	13	user_language
122	14	theme
123	15	file_upload_size
124	15	last_directory_visited
125	15	last_storage
126	15	file_dialog_view
127	15	show_hidden_files
128	16	btn_start
129	16	btn_stop
130	16	btn_step_into
131	16	btn_step_over
132	16	btn_toggle_breakpoint
133	16	btn_clear_breakpoints
134	16	edit_grid_values
135	16	move_previous
136	16	move_next
137	16	switch_panel
138	17	open_project
139	17	save_project
140	17	save_project_as
141	17	generate_sql
142	17	download_image
143	17	add_table
144	17	edit_table
145	17	clone_table
146	17	drop_table
147	17	add_edit_note
148	17	one_to_many
149	17	many_to_many
150	17	auto_align
151	17	show_details
152	17	zoom_to_fit
153	17	zoom_in
154	17	zoom_out
155	18	sql_with_drop
156	18	table_relation_depth
157	18	cardinality_notation
158	19	ignore_whitespaces
159	19	ignore_owner
160	19	ignore_tablespace
161	19	ignore_grants
162	20	explain_verbose
163	20	explain_costs
164	20	explain_buffers
165	20	explain_timing
166	20	explain_summary
167	20	explain_settings
168	20	explain_wal
169	21	auto_commit
170	21	auto_rollback
171	21	prompt_save_query_changes
172	21	table_view_data_by_pk
173	21	prompt_save_data_changes
174	21	prompt_commit_transaction
175	21	copy_sql_to_query_tool
176	22	plain_editor_mode
177	22	code_folding
178	22	wrap_code
179	22	insert_pair_brackets
180	22	brace_matching
181	22	view_edit_promotion_warning
182	23	csv_quoting
183	23	csv_quote_char
184	23	csv_field_separator
185	23	csv_replace_nulls_with
186	24	results_grid_quoting
187	24	results_grid_quote_char
188	24	results_grid_field_separator
189	24	column_data_auto_resize
190	24	column_data_max_width
191	24	on_demand_record_count
192	22	sql_font_size
193	25	connection_status
194	25	connection_status_fetch_time
195	25	query_success_notification
196	26	execute_query
197	26	save_data
198	26	explain_query
199	26	explain_analyze_query
200	26	clear_query
201	26	download_results
202	26	move_previous
203	26	move_next
204	26	switch_panel
205	26	btn_open_file
206	26	btn_save_file
207	26	btn_paste_row
208	26	btn_delete_row
209	26	btn_filter_dialog
210	26	btn_filter_options
211	26	btn_rows_limit
212	26	btn_execute_options
213	26	btn_cancel_query
214	26	btn_edit_options
215	26	toggle_case
216	27	keywords_in_uppercase
217	27	autocomplete_on_key_press
218	26	commit_transaction
219	26	rollback_transaction
220	28	keyword_case
221	28	identifier_case
222	28	function_case
223	28	data_type_case
224	28	spaces_around_operators
225	28	tab_size
226	28	use_spaces
227	28	expression_width
228	28	logical_operator_new_line
229	28	lines_between_queries
230	28	new_line_before_semicolon
231	29	row_limit
\.


--
-- Data for Name: process; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.process (user_id, pid, "desc", command, arguments, start_time, end_time, logdir, exit_code, acknowledge, utility_pid, process_state, server_id) FROM stdin;
\.


--
-- Data for Name: query_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.query_history (srno, uid, sid, dbname, query_info, last_updated_flag) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, name, description) FROM stdin;
1	Administrator	pgAdmin Administrator Role
2	User	pgAdmin User Role
\.


--
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_users (user_id, role_id) FROM stdin;
1	1
\.


--
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.server (id, user_id, servergroup_id, name, host, port, maintenance_db, username, comment, password, role, discovery_id, db_res, bgcolor, fgcolor, service, use_ssh_tunnel, tunnel_host, tunnel_port, tunnel_username, tunnel_authentication, tunnel_identity_file, tunnel_password, save_password, shared, kerberos_conn, cloud_status, passexec_cmd, passexec_expiration, connection_params, shared_username, prepare_threshold, tunnel_keep_alive) FROM stdin;
6	1	1	Postgres	aw-db	5432	postgres	readonly	\N	\N	\N	\N	adventureworks	\N	\N	\N	0	\N	22	\N	0	\N	\N	0	t	f	0	\N	\N	{"sslmode": "prefer", "connect_timeout": 10, "sslcert": "<STORAGE_DIR>/.postgresql/postgresql.crt", "sslkey": "<STORAGE_DIR>/.postgresql/postgresql.key"}	readonly	\N	0
\.


--
-- Data for Name: servergroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servergroup (id, user_id, name) FROM stdin;
1	1	Servers
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.setting (user_id, setting, value) FROM stdin;
1	LastUpdateCheck	20240427
1	Browser/Layout	{"dockbox":{"id":"+2","size":200,"mode":"horizontal","children":[{"id":"+3","size":20,"tabs":[{"id":"id-object-explorer"}],"group":"object-explorer","activeId":"id-object-explorer"},{"id":"id-main","size":80,"tabs":[{"id":"id-dashboard"},{"id":"id-properties"},{"id":"id-sql"},{"id":"id-statistics"},{"id":"id-dependencies"},{"id":"id-dependents"},{"id":"id-processes"}],"group":"playground","activeId":"id-dashboard"}]},"floatbox":{"id":"+7","size":0,"mode":"float","children":[{"id":"+10","size":200,"tabs":[{"id":"id-edit-properties178"}],"group":"dialogs","activeId":"id-edit-properties178","x":610,"y":53.8,"z":1,"w":700,"h":550}]},"windowbox":{"id":"+8","size":0,"mode":"window","children":[]},"maxbox":{"id":"+9","size":1,"mode":"maximize","children":[]}}
1	browser_tree_state	{"6": {"paths": ["browser,server_group_1,server_6,coll-database_6,database_16384"], "selected": {"server_6": "database_16384", "database_16384": "database_16384"}, "conn_status": {"database_16384": 1}, "is_opened": {"database_16384": 1}}}
\.


--
-- Data for Name: sharedserver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sharedserver (id, user_id, server_owner, servergroup_id, name, host, port, maintenance_db, username, password, role, comment, discovery_id, db_res, bgcolor, fgcolor, service, use_ssh_tunnel, tunnel_host, tunnel_port, tunnel_username, tunnel_authentication, tunnel_identity_file, shared, save_password, tunnel_password, osid, connection_params, prepare_threshold, tunnel_keep_alive) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, active, confirmed_at, masterpass_check, username, auth_source, fs_uniquifier, locked, login_attempts) FROM stdin;
1	admin@foo.com	$pbkdf2-sha512$25000$ZkzJuVcqhRACAKD0fg/hnA$tMUAYM3axlKAEzUmVq5OyPbewCp0RwFHrc/7alftpWJW84axgaCGXss2caLP.Np75ZZ0znL/6t5.FBd5tyxVPg	t	\N	38507570686230673763635656346359682f6248705244616b5165426635527357444b4575412b33412b66324b30324b67773d3d	admin@foo.com	internal	0dceb75380544219a922a93373a61fbd	f	0
\.


--
-- Data for Name: user_macros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_macros (mid, uid, name, sql) FROM stdin;
\.


--
-- Data for Name: user_mfa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_mfa (user_id, mfa_auth, options) FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preferences (pid, uid, value) FROM stdin;
121	1	en
\.


--
-- Data for Name: version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.version (name, value) FROM stdin;
ConfigDB	39
\.


--
-- Name: macros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.macros_id_seq', 22, true);


--
-- Name: module_preference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.module_preference_id_seq', 103, true);


--
-- Name: preference_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preference_category_id_seq', 29, true);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preferences_id_seq', 231, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 2, true);


--
-- Name: server_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.server_id_seq', 6, true);


--
-- Name: servergroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servergroup_id_seq', 1, true);


--
-- Name: sharedserver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sharedserver_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: database database_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.database
    ADD CONSTRAINT database_pkey PRIMARY KEY (id, server);


--
-- Name: debugger_function_arguments debugger_function_arguments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debugger_function_arguments
    ADD CONSTRAINT debugger_function_arguments_pkey PRIMARY KEY (server_id, database_id, schema_id, function_id, arg_id);


--
-- Name: keys keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keys
    ADD CONSTRAINT keys_pkey PRIMARY KEY (name);


--
-- Name: macros macros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.macros
    ADD CONSTRAINT macros_pkey PRIMARY KEY (id);


--
-- Name: module_preference module_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_preference
    ADD CONSTRAINT module_preference_pkey PRIMARY KEY (id);


--
-- Name: preference_category preference_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preference_category
    ADD CONSTRAINT preference_category_pkey PRIMARY KEY (id);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: process process_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.process
    ADD CONSTRAINT process_pkey PRIMARY KEY (pid);


--
-- Name: query_history query_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query_history
    ADD CONSTRAINT query_history_pkey PRIMARY KEY (srno, uid, sid, dbname);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: server server_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_pkey PRIMARY KEY (id);


--
-- Name: servergroup servergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servergroup
    ADD CONSTRAINT servergroup_pkey PRIMARY KEY (id);


--
-- Name: servergroup servergroup_user_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servergroup
    ADD CONSTRAINT servergroup_user_id_name_key UNIQUE (user_id, name);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (user_id, setting);


--
-- Name: sharedserver sharedserver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sharedserver
    ADD CONSTRAINT sharedserver_pkey PRIMARY KEY (id);


--
-- Name: user_macros user_macros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_macros
    ADD CONSTRAINT user_macros_pkey PRIMARY KEY (mid, uid);


--
-- Name: user_mfa user_mfa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_mfa
    ADD CONSTRAINT user_mfa_pkey PRIMARY KEY (user_id, mfa_auth);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (pid, uid);


--
-- Name: user user_unique_constraint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_unique_constraint UNIQUE (username, auth_source);


--
-- Name: version version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_pkey PRIMARY KEY (name);


--
-- Name: database database_server_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.database
    ADD CONSTRAINT database_server_fkey FOREIGN KEY (server) REFERENCES public.server(id) ON DELETE CASCADE;


--
-- Name: preference_category preference_category_mid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preference_category
    ADD CONSTRAINT preference_category_mid_fkey FOREIGN KEY (mid) REFERENCES public.module_preference(id);


--
-- Name: preferences preferences_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_cid_fkey FOREIGN KEY (cid) REFERENCES public.preference_category(id);


--
-- Name: process process_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.process
    ADD CONSTRAINT process_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: query_history query_history_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query_history
    ADD CONSTRAINT query_history_sid_fkey FOREIGN KEY (sid) REFERENCES public.server(id) ON DELETE CASCADE;


--
-- Name: query_history query_history_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query_history
    ADD CONSTRAINT query_history_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: roles_users roles_users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT roles_users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id) ON DELETE CASCADE;


--
-- Name: roles_users roles_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT roles_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: server server_servergroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_servergroup_id_fkey FOREIGN KEY (servergroup_id) REFERENCES public.servergroup(id);


--
-- Name: server server_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: servergroup servergroup_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servergroup
    ADD CONSTRAINT servergroup_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: setting setting_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: sharedserver sharedserver_servergroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sharedserver
    ADD CONSTRAINT sharedserver_servergroup_id_fkey FOREIGN KEY (servergroup_id) REFERENCES public.servergroup(id);


--
-- Name: sharedserver sharedserver_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sharedserver
    ADD CONSTRAINT sharedserver_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: user_macros user_macros_mid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_macros
    ADD CONSTRAINT user_macros_mid_fkey FOREIGN KEY (mid) REFERENCES public.macros(id) ON DELETE CASCADE;


--
-- Name: user_macros user_macros_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_macros
    ADD CONSTRAINT user_macros_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: user_mfa user_mfa_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_mfa
    ADD CONSTRAINT user_mfa_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: user_preferences user_preferences_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pid_fkey FOREIGN KEY (pid) REFERENCES public.preferences(id) ON DELETE CASCADE;


--
-- Name: user_preferences user_preferences_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_uid_fkey FOREIGN KEY (uid) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

