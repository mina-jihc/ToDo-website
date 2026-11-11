--
-- PostgreSQL database dump
--

\restrict excYgn2COJ11JOMaC6XsxEPiThqHHsFQJcvdIlNwoDnIqJdIdfKEvWDkUf8QyLt

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    username character varying(50),
    email character varying(100) NOT NULL,
    password text,
    role character varying(50) DEFAULT 'user'::character varying
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: app_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_users (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.app_users OWNER TO postgres;

--
-- Name: app_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_users_id_seq OWNER TO postgres;

--
-- Name: app_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_users_id_seq OWNED BY public.app_users.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer CONSTRAINT cards_id_not_null NOT NULL,
    name character varying(100),
    price numeric(10,2),
    image text,
    description text,
    category character varying(50)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_id_seq OWNER TO postgres;

--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cards_id_seq OWNED BY public.products.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    name character varying(100),
    price numeric,
    status character varying(20) DEFAULT 'pending'::character varying,
    user_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: task_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_tags (
    task_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.task_tags OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    user_id integer,
    title character varying(100) NOT NULL,
    completed boolean DEFAULT false
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
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
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: app_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_users ALTER COLUMN id SET DEFAULT nextval('public.app_users_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, username, email, password, role) FROM stdin;
2	mina	mina07@gmail.com	$2b$10$Msu9zzcWE2O60I9gLXfsF.mQrv1s9.BRgxqhpR6LmwCE6z0cusfum	admin
1	mina	fgkl73243@gmail.com	$2b$10$uCNuv9pJldVv9FKrlSCR1OsuVKSQudsuMKIzn8th5m4pxG/kifXuy	user
3	hm	amina77@gmail.com	$2b$10$9ybgWdicGTeVffoJGeNkt.z7ecf4S.74xfj26Aw.6TuqwUW1M1bgK	user
4	aiganym	aiganym@gmail.com	$2b$10$n6wWt2klvQDxvUwQivFtfObjmmm8eqWQcVtR7uErFnYa2eXexRLo2	user
\.


--
-- Data for Name: app_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_users (id, name) FROM stdin;
1	Kate
2	Dan
3	Jane
4	Ed
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, name, price, status, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, price, image, description, category) FROM stdin;
2	Oat Milk Latte	5.25	https://images.unsplash.com/photo-1541167760496-1628856ab772?auto=format&fit=crop&w=600&q=80	Double espresso, steamed oat milk, and light caramel sweetness.	coffee
3	Honey Cinnamon Latte	5.75	https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?auto=format&fit=crop&w=600&q=80	Espresso, steamed milk, local honey, and cinnamon.	coffee
4	Cold Brew	4.75	https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=600&q=80	Slow-steeped for 18 hours with a smooth cocoa finish.	coffee
5	Cappuccino	4.75	https://images.unsplash.com/photo-1534778101976-62847782c213?auto=format&fit=crop&w=600&q=80	Double espresso with silky steamed milk and a soft foam finish.	coffee
6	Chai Latte	5.25	https://images.unsplash.com/photo-1576092768241-dec231879fc3?auto=format&fit=crop&w=600&q=80	Black tea, warm spices, steamed milk, and a touch of honey.	tea
7	Earl Grey	4.00	https://images.unsplash.com/photo-1597481499750-3e6b22637e12?auto=format&fit=crop&w=600&q=80	Traditional bergamot scented black tea.	tea
8	Jasmine Tea	4.00	https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?auto=format&fit=crop&w=600&q=80	Fragrant green tea infused with jasmine blossoms.	tea
9	Almond Croissant	4.50	https://images.unsplash.com/photo-1555507036-ab1f4038808a?auto=format&fit=crop&w=600&q=80	Buttery laminated pastry filled with almond cream.	pastries
10	Chocolate Croissant	4.25	https://images.unsplash.com/photo-1608198093002-ad4e005484ec?auto=format&fit=crop&w=600&q=80	Flaky croissant filled with rich dark chocolate.	pastries
11	Cinnamon Roll	4.25	https://images.unsplash.com/photo-1509365465985-25d11c17e812?auto=format&fit=crop&w=600&q=80	Soft baked roll with cinnamon, brown sugar, and vanilla glaze.	pastries
12	Morning Bun	4.00	https://images.unsplash.com/photo-1586444248902-2f64eddc13df?auto=format&fit=crop&w=600&q=80	Crispy pastry rolled with cinnamon and orange zest.	pastries
1	Espresso (strong)	6.25	https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?auto=format&fit=crop&w=600&q=80	Double shot with notes of dark chocolate and toasted almond.	coffee
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, name) FROM stdin;
1	Work
2	Urgent
3	Personal
4	Study
\.


--
-- Data for Name: task_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_tags (task_id, tag_id) FROM stdin;
1	4
2	3
3	2
4	1
5	4
6	3
1	2
3	1
5	2
2414	1
2416	1
2419	1
2421	1
2423	1
2426	1
2428	1
2430	1
2432	1
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, user_id, title, completed) FROM stdin;
1	1	Study web	f
2	1	Go to the cafe	t
3	2	Read a book	f
4	2	Buy products	t
5	3	Present a topic	f
6	3	Watch a film	t
210	1	task 1	f
7	\N	Learn PostgreSQL and finish the project	t
9	2	Hang out with friends	f
212	3	task 3	f
213	1	task 4	f
214	2	task 5	f
215	1	task 6	f
216	1	task 7	f
217	3	task 8	f
218	2	task 9	f
219	2	task 10	f
220	3	task 11	f
221	2	task 12	f
222	2	task 13	f
223	1	task 14	f
224	3	task 15	f
225	1	task 16	f
226	1	task 17	f
227	3	task 18	f
228	2	task 19	f
229	2	task 20	f
230	1	task 21	f
231	3	task 22	f
232	3	task 23	f
233	3	task 24	f
234	1	task 25	f
235	2	task 26	f
236	3	task 27	f
237	2	task 28	f
238	3	task 29	f
239	1	task 30	f
240	3	task 31	f
241	3	task 32	f
242	2	task 33	f
243	3	task 34	f
244	3	task 35	f
245	2	task 36	f
246	1	task 37	f
247	3	task 38	f
248	1	task 39	f
249	2	task 40	f
250	1	task 41	f
251	1	task 42	f
252	3	task 43	f
253	1	task 44	f
254	2	task 45	f
255	2	task 46	f
256	2	task 47	f
257	2	task 48	f
258	3	task 49	f
259	3	task 50	f
260	2	task 51	f
261	1	task 52	f
262	3	task 53	f
263	1	task 54	f
264	3	task 55	f
265	1	task 56	f
266	2	task 57	f
267	3	task 58	f
268	3	task 59	f
269	2	task 60	f
270	2	task 61	f
271	3	task 62	f
272	2	task 63	f
273	2	task 64	f
274	3	task 65	f
275	2	task 66	f
276	1	task 67	f
277	2	task 68	f
278	2	task 69	f
279	1	task 70	f
280	2	task 71	f
281	2	task 72	f
282	2	task 73	f
283	3	task 74	f
284	3	task 75	f
285	2	task 76	f
286	1	task 77	f
287	3	task 78	f
288	3	task 79	f
289	1	task 80	f
290	3	task 81	f
291	3	task 82	f
292	3	task 83	f
293	2	task 84	f
294	2	task 85	f
295	3	task 86	f
296	1	task 87	f
297	1	task 88	f
298	3	task 89	f
299	2	task 90	f
300	1	task 91	f
301	1	task 92	f
302	2	task 93	f
303	2	task 94	f
304	2	task 95	f
305	2	task 96	f
306	1	task 97	f
307	2	task 98	f
308	2	task 99	f
309	2	task 100	f
310	1	task 101	f
311	2	task 102	f
312	1	task 103	f
313	2	task 104	f
314	2	task 105	f
315	1	task 106	f
316	3	task 107	f
317	1	task 108	f
318	2	task 109	f
319	2	task 110	f
320	1	task 111	f
321	3	task 112	f
322	3	task 113	f
323	2	task 114	f
324	1	task 115	f
325	3	task 116	f
326	2	task 117	f
327	3	task 118	f
328	1	task 119	f
329	2	task 120	f
330	2	task 121	f
331	3	task 122	f
332	2	task 123	f
333	2	task 124	f
334	3	task 125	f
335	1	task 126	f
336	2	task 127	f
337	3	task 128	f
338	1	task 129	f
339	2	task 130	f
340	3	task 131	f
341	1	task 132	f
342	2	task 133	f
343	1	task 134	f
344	2	task 135	f
345	2	task 136	f
346	3	task 137	f
347	3	task 138	f
348	1	task 139	f
349	3	task 140	f
350	2	task 141	f
351	3	task 142	f
352	2	task 143	f
353	2	task 144	f
354	1	task 145	f
355	2	task 146	f
356	3	task 147	f
357	2	task 148	f
358	2	task 149	f
359	2	task 150	f
360	2	task 151	f
361	2	task 152	f
362	2	task 153	f
363	1	task 154	f
364	1	task 155	f
365	3	task 156	f
366	3	task 157	f
367	3	task 158	f
368	2	task 159	f
369	2	task 160	f
370	1	task 161	f
371	2	task 162	f
372	2	task 163	f
373	1	task 164	f
374	1	task 165	f
375	1	task 166	f
376	2	task 167	f
377	3	task 168	f
378	3	task 169	f
379	2	task 170	f
380	1	task 171	f
381	1	task 172	f
382	3	task 173	f
383	2	task 174	f
384	3	task 175	f
385	2	task 176	f
386	2	task 177	f
387	2	task 178	f
388	1	task 179	f
389	1	task 180	f
390	3	task 181	f
391	2	task 182	f
392	3	task 183	f
393	2	task 184	f
394	1	task 185	f
395	3	task 186	f
396	1	task 187	f
397	2	task 188	f
398	1	task 189	f
399	1	task 190	f
400	2	task 191	f
401	2	task 192	f
402	2	task 193	f
403	1	task 194	f
404	2	task 195	f
405	2	task 196	f
406	1	task 197	f
407	2	task 198	f
408	2	task 199	f
409	1	task 200	f
410	3	task 1	f
411	2	task 2	f
412	3	task 3	f
413	1	task 4	f
414	1	task 5	f
415	3	task 6	f
416	2	task 7	f
417	2	task 8	f
418	2	task 9	f
419	3	task 10	f
420	1	task 11	f
421	1	task 12	f
422	3	task 13	f
423	3	task 14	f
424	2	task 15	f
425	1	task 16	f
426	1	task 17	f
427	2	task 18	f
428	2	task 19	f
429	1	task 20	f
430	2	task 21	f
431	2	task 22	f
432	3	task 23	f
433	2	task 24	f
434	2	task 25	f
435	2	task 26	f
436	2	task 27	f
437	2	task 28	f
438	2	task 29	f
439	3	task 30	f
440	1	task 31	f
441	2	task 32	f
442	1	task 33	f
443	2	task 34	f
444	2	task 35	f
445	2	task 36	f
446	2	task 37	f
447	2	task 38	f
448	1	task 39	f
449	3	task 40	f
450	2	task 41	f
451	2	task 42	f
452	2	task 43	f
453	3	task 44	f
454	2	task 45	f
455	1	task 46	f
456	1	task 47	f
457	2	task 48	f
458	1	task 49	f
459	3	task 50	f
460	2	task 51	f
461	2	task 52	f
462	1	task 53	f
463	1	task 54	f
464	1	task 55	f
465	2	task 56	f
466	2	task 57	f
467	2	task 58	f
468	2	task 59	f
469	2	task 60	f
470	3	task 61	f
471	2	task 62	f
472	1	task 63	f
473	3	task 64	f
474	2	task 65	f
475	3	task 66	f
476	1	task 67	f
477	2	task 68	f
478	2	task 69	f
479	3	task 70	f
480	2	task 71	f
481	2	task 72	f
482	1	task 73	f
483	1	task 74	f
484	3	task 75	f
485	2	task 76	f
486	1	task 77	f
487	2	task 78	f
488	3	task 79	f
489	2	task 80	f
490	2	task 81	f
491	2	task 82	f
492	2	task 83	f
493	1	task 84	f
494	2	task 85	f
495	2	task 86	f
496	3	task 87	f
497	3	task 88	f
498	2	task 89	f
499	3	task 90	f
500	2	task 91	f
501	3	task 92	f
502	2	task 93	f
503	2	task 94	f
504	3	task 95	f
505	2	task 96	f
506	1	task 97	f
507	2	task 98	f
508	2	task 99	f
509	2	task 100	f
510	3	task 101	f
511	2	task 102	f
512	3	task 103	f
513	1	task 104	f
514	2	task 105	f
515	1	task 106	f
516	3	task 107	f
517	2	task 108	f
518	3	task 109	f
519	3	task 110	f
520	2	task 111	f
521	1	task 112	f
522	1	task 113	f
523	2	task 114	f
524	3	task 115	f
525	3	task 116	f
526	2	task 117	f
527	2	task 118	f
528	2	task 119	f
529	2	task 120	f
530	1	task 121	f
531	2	task 122	f
532	1	task 123	f
533	2	task 124	f
534	3	task 125	f
535	3	task 126	f
536	1	task 127	f
537	1	task 128	f
538	3	task 129	f
539	1	task 130	f
540	2	task 131	f
541	2	task 132	f
542	2	task 133	f
543	3	task 134	f
544	3	task 135	f
545	3	task 136	f
546	2	task 137	f
547	2	task 138	f
548	2	task 139	f
549	2	task 140	f
550	3	task 141	f
551	1	task 142	f
552	2	task 143	f
553	3	task 144	f
554	3	task 145	f
555	1	task 146	f
556	3	task 147	f
557	2	task 148	f
558	1	task 149	f
559	2	task 150	f
560	2	task 151	f
561	3	task 152	f
562	2	task 153	f
563	3	task 154	f
564	2	task 155	f
565	3	task 156	f
566	3	task 157	f
567	2	task 158	f
568	2	task 159	f
569	2	task 160	f
570	2	task 161	f
571	1	task 162	f
572	2	task 163	f
573	2	task 164	f
574	2	task 165	f
575	2	task 166	f
576	2	task 167	f
577	3	task 168	f
578	1	task 169	f
579	2	task 170	f
580	1	task 171	f
581	3	task 172	f
582	2	task 173	f
583	2	task 174	f
584	1	task 175	f
585	3	task 176	f
586	1	task 177	f
587	3	task 178	f
588	3	task 179	f
589	2	task 180	f
590	2	task 181	f
591	2	task 182	f
592	1	task 183	f
593	3	task 184	f
594	3	task 185	f
595	3	task 186	f
596	3	task 187	f
597	2	task 188	f
598	2	task 189	f
599	3	task 190	f
600	2	task 191	f
601	2	task 192	f
602	2	task 193	f
603	3	task 194	f
604	3	task 195	f
605	3	task 196	f
606	2	task 197	f
607	2	task 198	f
608	3	task 199	f
609	3	task 200	f
610	2	task 201	f
611	2	task 202	f
612	2	task 203	f
613	2	task 204	f
614	3	task 205	f
615	1	task 206	f
616	3	task 207	f
617	2	task 208	f
618	2	task 209	f
619	2	task 210	f
620	3	task 211	f
621	2	task 212	f
622	2	task 213	f
623	2	task 214	f
624	3	task 215	f
625	2	task 216	f
626	2	task 217	f
627	1	task 218	f
628	3	task 219	f
629	1	task 220	f
630	1	task 221	f
631	2	task 222	f
632	2	task 223	f
633	2	task 224	f
634	2	task 225	f
635	1	task 226	f
636	3	task 227	f
637	3	task 228	f
638	2	task 229	f
639	3	task 230	f
640	2	task 231	f
641	3	task 232	f
642	2	task 233	f
643	2	task 234	f
644	3	task 235	f
645	2	task 236	f
646	2	task 237	f
647	2	task 238	f
648	2	task 239	f
649	1	task 240	f
650	3	task 241	f
651	1	task 242	f
652	2	task 243	f
653	2	task 244	f
654	2	task 245	f
655	2	task 246	f
656	2	task 247	f
657	3	task 248	f
658	2	task 249	f
659	3	task 250	f
660	2	task 251	f
661	2	task 252	f
662	2	task 253	f
663	1	task 254	f
664	3	task 255	f
665	1	task 256	f
666	2	task 257	f
667	2	task 258	f
668	2	task 259	f
669	1	task 260	f
670	2	task 261	f
671	1	task 262	f
672	1	task 263	f
673	1	task 264	f
674	2	task 265	f
675	1	task 266	f
676	2	task 267	f
677	1	task 268	f
678	3	task 269	f
679	1	task 270	f
680	3	task 271	f
681	2	task 272	f
682	3	task 273	f
683	3	task 274	f
684	1	task 275	f
685	2	task 276	f
686	1	task 277	f
687	3	task 278	f
688	3	task 279	f
689	3	task 280	f
690	2	task 281	f
691	3	task 282	f
692	2	task 283	f
693	2	task 284	f
694	3	task 285	f
695	3	task 286	f
696	2	task 287	f
697	2	task 288	f
698	1	task 289	f
699	3	task 290	f
700	2	task 291	f
701	3	task 292	f
702	3	task 293	f
703	1	task 294	f
704	2	task 295	f
705	2	task 296	f
706	2	task 297	f
707	1	task 298	f
708	3	task 299	f
709	2	task 300	f
710	2	task 301	f
711	1	task 302	f
712	2	task 303	f
713	2	task 304	f
714	3	task 305	f
715	2	task 306	f
716	3	task 307	f
717	2	task 308	f
718	3	task 309	f
719	1	task 310	f
720	2	task 311	f
721	2	task 312	f
722	2	task 313	f
723	2	task 314	f
724	2	task 315	f
725	3	task 316	f
726	2	task 317	f
727	3	task 318	f
728	2	task 319	f
729	2	task 320	f
730	3	task 321	f
731	1	task 322	f
732	2	task 323	f
733	2	task 324	f
734	1	task 325	f
735	2	task 326	f
736	1	task 327	f
737	1	task 328	f
738	2	task 329	f
739	2	task 330	f
740	1	task 331	f
741	2	task 332	f
742	1	task 333	f
743	2	task 334	f
744	2	task 335	f
745	2	task 336	f
746	2	task 337	f
747	1	task 338	f
748	2	task 339	f
749	2	task 340	f
750	2	task 341	f
751	1	task 342	f
752	1	task 343	f
753	2	task 344	f
754	3	task 345	f
755	3	task 346	f
756	1	task 347	f
757	2	task 348	f
758	3	task 349	f
759	3	task 350	f
760	2	task 351	f
761	3	task 352	f
762	1	task 353	f
763	2	task 354	f
764	2	task 355	f
765	2	task 356	f
766	2	task 357	f
767	2	task 358	f
768	2	task 359	f
769	3	task 360	f
770	2	task 361	f
771	2	task 362	f
772	2	task 363	f
773	2	task 364	f
774	2	task 365	f
775	3	task 366	f
776	1	task 367	f
777	2	task 368	f
778	3	task 369	f
779	3	task 370	f
780	2	task 371	f
781	1	task 372	f
782	2	task 373	f
783	1	task 374	f
784	3	task 375	f
785	2	task 376	f
786	2	task 377	f
787	2	task 378	f
788	2	task 379	f
789	2	task 380	f
790	1	task 381	f
791	1	task 382	f
792	2	task 383	f
793	2	task 384	f
794	1	task 385	f
795	2	task 386	f
796	2	task 387	f
797	1	task 388	f
798	3	task 389	f
799	2	task 390	f
800	2	task 391	f
801	2	task 392	f
802	2	task 393	f
803	3	task 394	f
804	1	task 395	f
805	2	task 396	f
806	2	task 397	f
807	2	task 398	f
808	2	task 399	f
809	2	task 400	f
810	1	task 401	f
811	3	task 402	f
812	1	task 403	f
813	1	task 404	f
814	2	task 405	f
815	1	task 406	f
816	3	task 407	f
817	2	task 408	f
818	1	task 409	f
819	2	task 410	f
820	2	task 411	f
821	2	task 412	f
822	2	task 413	f
823	2	task 414	f
824	3	task 415	f
825	1	task 416	f
826	2	task 417	f
827	1	task 418	f
828	2	task 419	f
829	2	task 420	f
830	3	task 421	f
831	3	task 422	f
832	3	task 423	f
833	1	task 424	f
834	3	task 425	f
835	1	task 426	f
836	3	task 427	f
837	2	task 428	f
838	2	task 429	f
839	2	task 430	f
840	3	task 431	f
841	1	task 432	f
842	3	task 433	f
843	3	task 434	f
844	1	task 435	f
845	2	task 436	f
846	2	task 437	f
847	2	task 438	f
848	2	task 439	f
849	2	task 440	f
850	2	task 441	f
851	1	task 442	f
852	1	task 443	f
853	2	task 444	f
854	3	task 445	f
855	2	task 446	f
856	1	task 447	f
857	2	task 448	f
858	2	task 449	f
859	1	task 450	f
860	2	task 451	f
861	3	task 452	f
862	2	task 453	f
863	2	task 454	f
864	2	task 455	f
865	2	task 456	f
866	2	task 457	f
867	1	task 458	f
868	1	task 459	f
869	3	task 460	f
870	2	task 461	f
871	3	task 462	f
872	2	task 463	f
873	2	task 464	f
874	3	task 465	f
875	3	task 466	f
876	3	task 467	f
877	2	task 468	f
878	2	task 469	f
879	2	task 470	f
880	2	task 471	f
881	2	task 472	f
882	3	task 473	f
883	2	task 474	f
884	2	task 475	f
885	2	task 476	f
886	2	task 477	f
887	2	task 478	f
888	2	task 479	f
889	1	task 480	f
890	3	task 481	f
891	2	task 482	f
892	2	task 483	f
893	1	task 484	f
894	3	task 485	f
895	2	task 486	f
896	2	task 487	f
897	3	task 488	f
898	2	task 489	f
899	2	task 490	f
900	3	task 491	f
901	2	task 492	f
902	3	task 493	f
903	3	task 494	f
904	2	task 495	f
905	2	task 496	f
906	2	task 497	f
907	1	task 498	f
908	2	task 499	f
909	3	task 500	f
910	2	task 501	f
911	1	task 502	f
912	2	task 503	f
913	2	task 504	f
914	2	task 505	f
915	2	task 506	f
916	2	task 507	f
917	2	task 508	f
918	2	task 509	f
919	1	task 510	f
920	2	task 511	f
921	3	task 512	f
922	2	task 513	f
923	2	task 514	f
924	2	task 515	f
925	2	task 516	f
926	3	task 517	f
927	2	task 518	f
928	2	task 519	f
929	2	task 520	f
930	3	task 521	f
931	2	task 522	f
932	1	task 523	f
933	1	task 524	f
934	3	task 525	f
935	3	task 526	f
936	2	task 527	f
937	2	task 528	f
938	2	task 529	f
939	1	task 530	f
940	3	task 531	f
941	1	task 532	f
942	2	task 533	f
943	1	task 534	f
944	3	task 535	f
945	3	task 536	f
946	2	task 537	f
947	2	task 538	f
948	1	task 539	f
949	2	task 540	f
950	1	task 541	f
951	1	task 542	f
952	2	task 543	f
953	3	task 544	f
954	2	task 545	f
955	2	task 546	f
956	2	task 547	f
957	2	task 548	f
958	2	task 549	f
959	2	task 550	f
960	1	task 551	f
961	2	task 552	f
962	1	task 553	f
963	1	task 554	f
964	2	task 555	f
965	2	task 556	f
966	3	task 557	f
967	2	task 558	f
968	2	task 559	f
969	2	task 560	f
970	1	task 561	f
971	3	task 562	f
972	2	task 563	f
973	2	task 564	f
974	1	task 565	f
975	1	task 566	f
976	2	task 567	f
977	2	task 568	f
978	2	task 569	f
979	3	task 570	f
980	2	task 571	f
981	1	task 572	f
982	2	task 573	f
983	2	task 574	f
984	2	task 575	f
985	2	task 576	f
986	2	task 577	f
987	3	task 578	f
988	1	task 579	f
989	1	task 580	f
990	3	task 581	f
991	1	task 582	f
992	1	task 583	f
993	2	task 584	f
994	2	task 585	f
995	1	task 586	f
996	2	task 587	f
997	1	task 588	f
998	2	task 589	f
999	3	task 590	f
1000	3	task 591	f
1001	1	task 592	f
1002	2	task 593	f
1003	2	task 594	f
1004	2	task 595	f
1005	1	task 596	f
1006	2	task 597	f
1007	2	task 598	f
1008	1	task 599	f
1009	3	task 600	f
1010	2	task 601	f
1011	2	task 602	f
1012	2	task 603	f
1013	3	task 604	f
1014	2	task 605	f
1015	1	task 606	f
1016	3	task 607	f
1017	1	task 608	f
1018	1	task 609	f
1019	2	task 610	f
1020	3	task 611	f
1021	2	task 612	f
1022	2	task 613	f
1023	3	task 614	f
1024	2	task 615	f
1025	3	task 616	f
1026	1	task 617	f
1027	1	task 618	f
1028	1	task 619	f
1029	3	task 620	f
1030	2	task 621	f
1031	2	task 622	f
1032	2	task 623	f
1033	2	task 624	f
1034	1	task 625	f
1035	2	task 626	f
1036	3	task 627	f
1037	2	task 628	f
1038	2	task 629	f
1039	2	task 630	f
1040	1	task 631	f
1041	1	task 632	f
1042	3	task 633	f
1043	2	task 634	f
1044	2	task 635	f
1045	3	task 636	f
1046	2	task 637	f
1047	2	task 638	f
1048	3	task 639	f
1049	1	task 640	f
1050	3	task 641	f
1051	3	task 642	f
1052	3	task 643	f
1053	1	task 644	f
1054	2	task 645	f
1055	2	task 646	f
1056	2	task 647	f
1057	3	task 648	f
1058	1	task 649	f
1059	3	task 650	f
1060	1	task 651	f
1061	2	task 652	f
1062	2	task 653	f
1063	2	task 654	f
1064	2	task 655	f
1065	3	task 656	f
1066	2	task 657	f
1067	1	task 658	f
1068	2	task 659	f
1069	2	task 660	f
1070	2	task 661	f
1071	2	task 662	f
1072	2	task 663	f
1073	2	task 664	f
1074	2	task 665	f
1075	1	task 666	f
1076	3	task 667	f
1077	3	task 668	f
1078	3	task 669	f
1079	1	task 670	f
1080	3	task 671	f
1081	1	task 672	f
1082	2	task 673	f
1083	2	task 674	f
1084	2	task 675	f
1085	1	task 676	f
1086	2	task 677	f
1087	1	task 678	f
1088	2	task 679	f
1089	2	task 680	f
1090	3	task 681	f
1091	1	task 682	f
1092	3	task 683	f
1093	3	task 684	f
1094	3	task 685	f
1095	3	task 686	f
1096	3	task 687	f
1097	1	task 688	f
1098	2	task 689	f
1099	2	task 690	f
1100	1	task 691	f
1101	1	task 692	f
1102	2	task 693	f
1103	2	task 694	f
1104	3	task 695	f
1105	2	task 696	f
1106	2	task 697	f
1107	2	task 698	f
1108	3	task 699	f
1109	2	task 700	f
1110	3	task 701	f
1111	3	task 702	f
1112	2	task 703	f
1113	1	task 704	f
1114	2	task 705	f
1115	1	task 706	f
1116	2	task 707	f
1117	2	task 708	f
1118	1	task 709	f
1119	2	task 710	f
1120	3	task 711	f
1121	3	task 712	f
1122	2	task 713	f
1123	1	task 714	f
1124	3	task 715	f
1125	2	task 716	f
1126	1	task 717	f
1127	1	task 718	f
1128	2	task 719	f
1129	2	task 720	f
1130	1	task 721	f
1131	2	task 722	f
1132	2	task 723	f
1133	2	task 724	f
1134	3	task 725	f
1135	1	task 726	f
1136	2	task 727	f
1137	2	task 728	f
1138	2	task 729	f
1139	2	task 730	f
1140	3	task 731	f
1141	2	task 732	f
1142	2	task 733	f
1143	1	task 734	f
1144	1	task 735	f
1145	2	task 736	f
1146	2	task 737	f
1147	3	task 738	f
1148	2	task 739	f
1149	3	task 740	f
1150	3	task 741	f
1151	1	task 742	f
1152	1	task 743	f
1153	1	task 744	f
1154	1	task 745	f
1155	3	task 746	f
1156	3	task 747	f
1157	3	task 748	f
1158	3	task 749	f
1159	2	task 750	f
1160	2	task 751	f
1161	2	task 752	f
1162	2	task 753	f
1163	1	task 754	f
1164	2	task 755	f
1165	3	task 756	f
1166	1	task 757	f
1167	2	task 758	f
1168	3	task 759	f
1169	2	task 760	f
1170	3	task 761	f
1171	3	task 762	f
1172	1	task 763	f
1173	2	task 764	f
1174	3	task 765	f
1175	2	task 766	f
1176	1	task 767	f
1177	2	task 768	f
1178	1	task 769	f
1179	3	task 770	f
1180	1	task 771	f
1181	2	task 772	f
1182	2	task 773	f
1183	3	task 774	f
1184	1	task 775	f
1185	2	task 776	f
1186	1	task 777	f
1187	1	task 778	f
1188	1	task 779	f
1189	2	task 780	f
1190	3	task 781	f
1191	2	task 782	f
1192	2	task 783	f
1193	2	task 784	f
1194	1	task 785	f
1195	3	task 786	f
1196	2	task 787	f
1197	3	task 788	f
1198	2	task 789	f
1199	2	task 790	f
1200	2	task 791	f
1201	2	task 792	f
1202	1	task 793	f
1203	1	task 794	f
1204	1	task 795	f
1205	2	task 796	f
1206	1	task 797	f
1207	1	task 798	f
1208	3	task 799	f
1209	3	task 800	f
1210	2	task 801	f
1211	2	task 802	f
1212	1	task 803	f
1213	1	task 804	f
1214	2	task 805	f
1215	2	task 806	f
1216	2	task 807	f
1217	1	task 808	f
1218	2	task 809	f
1219	2	task 810	f
1220	2	task 811	f
1221	2	task 812	f
1222	2	task 813	f
1223	2	task 814	f
1224	2	task 815	f
1225	3	task 816	f
1226	2	task 817	f
1227	2	task 818	f
1228	1	task 819	f
1229	2	task 820	f
1230	2	task 821	f
1231	3	task 822	f
1232	3	task 823	f
1233	2	task 824	f
1234	2	task 825	f
1235	3	task 826	f
1236	2	task 827	f
1237	2	task 828	f
1238	1	task 829	f
1239	2	task 830	f
1240	3	task 831	f
1241	2	task 832	f
1242	3	task 833	f
1243	3	task 834	f
1244	1	task 835	f
1245	3	task 836	f
1246	3	task 837	f
1247	3	task 838	f
1248	3	task 839	f
1249	3	task 840	f
1250	2	task 841	f
1251	2	task 842	f
1252	1	task 843	f
1253	2	task 844	f
1254	2	task 845	f
1255	2	task 846	f
1256	2	task 847	f
1257	3	task 848	f
1258	2	task 849	f
1259	2	task 850	f
1260	3	task 851	f
1261	1	task 852	f
1262	1	task 853	f
1263	1	task 854	f
1264	1	task 855	f
1265	2	task 856	f
1266	1	task 857	f
1267	3	task 858	f
1268	1	task 859	f
1269	2	task 860	f
1270	2	task 861	f
1271	1	task 862	f
1272	2	task 863	f
1273	3	task 864	f
1274	2	task 865	f
1275	2	task 866	f
1276	2	task 867	f
1277	3	task 868	f
1278	1	task 869	f
1279	3	task 870	f
1280	3	task 871	f
1281	1	task 872	f
1282	1	task 873	f
1283	1	task 874	f
1284	3	task 875	f
1285	3	task 876	f
1286	3	task 877	f
1287	3	task 878	f
1288	1	task 879	f
1289	2	task 880	f
1290	1	task 881	f
1291	1	task 882	f
1292	2	task 883	f
1293	1	task 884	f
1294	1	task 885	f
1295	2	task 886	f
1296	2	task 887	f
1297	1	task 888	f
1298	3	task 889	f
1299	2	task 890	f
1300	1	task 891	f
1301	3	task 892	f
1302	2	task 893	f
1303	3	task 894	f
1304	1	task 895	f
1305	3	task 896	f
1306	2	task 897	f
1307	2	task 898	f
1308	1	task 899	f
1309	2	task 900	f
1310	2	task 901	f
1311	1	task 902	f
1312	2	task 903	f
1313	3	task 904	f
1314	2	task 905	f
1315	1	task 906	f
1316	2	task 907	f
1317	3	task 908	f
1318	2	task 909	f
1319	2	task 910	f
1320	2	task 911	f
1321	3	task 912	f
1322	2	task 913	f
1323	1	task 914	f
1324	2	task 915	f
1325	1	task 916	f
1326	2	task 917	f
1327	2	task 918	f
1328	2	task 919	f
1329	1	task 920	f
1330	2	task 921	f
1331	2	task 922	f
1332	2	task 923	f
1333	3	task 924	f
1334	1	task 925	f
1335	1	task 926	f
1336	3	task 927	f
1337	1	task 928	f
1338	2	task 929	f
1339	3	task 930	f
1340	1	task 931	f
1341	1	task 932	f
1342	2	task 933	f
1343	2	task 934	f
1344	2	task 935	f
1345	2	task 936	f
1346	2	task 937	f
1347	1	task 938	f
1348	1	task 939	f
1349	3	task 940	f
1350	1	task 941	f
1351	2	task 942	f
1352	2	task 943	f
1353	2	task 944	f
1354	3	task 945	f
1355	2	task 946	f
1356	2	task 947	f
1357	2	task 948	f
1358	3	task 949	f
1359	3	task 950	f
1360	2	task 951	f
1361	3	task 952	f
1362	2	task 953	f
1363	1	task 954	f
1364	2	task 955	f
1365	2	task 956	f
1366	3	task 957	f
1367	2	task 958	f
1368	3	task 959	f
1369	3	task 960	f
1370	3	task 961	f
1371	2	task 962	f
1372	2	task 963	f
1373	2	task 964	f
1374	3	task 965	f
1375	2	task 966	f
1376	2	task 967	f
1377	2	task 968	f
1378	2	task 969	f
1379	2	task 970	f
1380	1	task 971	f
1381	2	task 972	f
1382	1	task 973	f
1383	3	task 974	f
1384	1	task 975	f
1385	1	task 976	f
1386	1	task 977	f
1387	2	task 978	f
1388	1	task 979	f
1389	2	task 980	f
1390	2	task 981	f
1391	2	task 982	f
1392	3	task 983	f
1393	2	task 984	f
1394	3	task 985	f
1395	3	task 986	f
1396	2	task 987	f
1397	2	task 988	f
1398	1	task 989	f
1399	2	task 990	f
1400	1	task 991	f
1401	2	task 992	f
1402	3	task 993	f
1403	3	task 994	f
1404	2	task 995	f
1405	2	task 996	f
1406	3	task 997	f
1407	3	task 998	f
1408	2	task 999	f
1409	1	task 1000	f
1410	1	task 1	f
1411	2	task 2	f
1412	2	task 3	f
1413	3	task 4	f
1414	2	task 5	f
1415	3	task 6	f
1416	2	task 7	f
1417	2	task 8	f
1418	2	task 9	f
1419	2	task 10	f
1420	2	task 11	f
1421	2	task 12	f
1422	3	task 13	f
1423	2	task 14	f
1424	2	task 15	f
1425	2	task 16	f
1426	2	task 17	f
1427	1	task 18	f
1428	3	task 19	f
1429	1	task 20	f
1430	2	task 21	f
1431	2	task 22	f
1432	2	task 23	f
1433	2	task 24	f
1434	1	task 25	f
1435	3	task 26	f
1436	2	task 27	f
1437	2	task 28	f
1438	3	task 29	f
1439	3	task 30	f
1440	2	task 31	f
1441	1	task 32	f
1442	2	task 33	f
1443	3	task 34	f
1444	3	task 35	f
1445	2	task 36	f
1446	2	task 37	f
1447	1	task 38	f
1448	1	task 39	f
1449	3	task 40	f
1450	2	task 41	f
1451	1	task 42	f
1452	3	task 43	f
1453	2	task 44	f
1454	1	task 45	f
1455	3	task 46	f
1456	3	task 47	f
1457	2	task 48	f
1458	3	task 49	f
1459	3	task 50	f
1460	2	task 51	f
1461	2	task 52	f
1462	3	task 53	f
1463	2	task 54	f
1464	1	task 55	f
1465	2	task 56	f
1466	2	task 57	f
1467	3	task 58	f
1468	2	task 59	f
1469	2	task 60	f
1470	3	task 61	f
1471	2	task 62	f
1472	3	task 63	f
1473	1	task 64	f
1474	2	task 65	f
1475	1	task 66	f
1476	3	task 67	f
1477	3	task 68	f
1478	2	task 69	f
1479	3	task 70	f
1480	1	task 71	f
1481	3	task 72	f
1482	2	task 73	f
1483	1	task 74	f
1484	2	task 75	f
1485	3	task 76	f
1486	2	task 77	f
1487	2	task 78	f
1488	1	task 79	f
1489	2	task 80	f
1490	3	task 81	f
1491	3	task 82	f
1492	2	task 83	f
1493	2	task 84	f
1494	1	task 85	f
1495	2	task 86	f
1496	2	task 87	f
1497	2	task 88	f
1498	2	task 89	f
1499	2	task 90	f
1500	1	task 91	f
1501	2	task 92	f
1502	2	task 93	f
1503	3	task 94	f
1504	1	task 95	f
1505	2	task 96	f
1506	2	task 97	f
1507	3	task 98	f
1508	1	task 99	f
1509	2	task 100	f
1510	1	task 101	f
1511	3	task 102	f
1512	3	task 103	f
1513	3	task 104	f
1514	2	task 105	f
1515	1	task 106	f
1516	2	task 107	f
1517	1	task 108	f
1518	1	task 109	f
1519	1	task 110	f
1520	2	task 111	f
1521	2	task 112	f
1522	1	task 113	f
1523	1	task 114	f
1524	2	task 115	f
1525	3	task 116	f
1526	2	task 117	f
1527	2	task 118	f
1528	2	task 119	f
1529	2	task 120	f
1530	1	task 121	f
1531	1	task 122	f
1532	1	task 123	f
1533	1	task 124	f
1534	1	task 125	f
1535	2	task 126	f
1536	2	task 127	f
1537	3	task 128	f
1538	3	task 129	f
1539	2	task 130	f
1540	1	task 131	f
1541	3	task 132	f
1542	2	task 133	f
1543	2	task 134	f
1544	2	task 135	f
1545	1	task 136	f
1546	2	task 137	f
1547	1	task 138	f
1548	2	task 139	f
1549	1	task 140	f
1550	3	task 141	f
1551	2	task 142	f
1552	2	task 143	f
1553	2	task 144	f
1554	2	task 145	f
1555	3	task 146	f
1556	2	task 147	f
1557	2	task 148	f
1558	3	task 149	f
1559	1	task 150	f
1560	3	task 151	f
1561	3	task 152	f
1562	3	task 153	f
1563	2	task 154	f
1564	2	task 155	f
1565	2	task 156	f
1566	2	task 157	f
1567	2	task 158	f
1568	1	task 159	f
1569	2	task 160	f
1570	2	task 161	f
1571	2	task 162	f
1572	1	task 163	f
1573	2	task 164	f
1574	1	task 165	f
1575	1	task 166	f
1576	2	task 167	f
1577	2	task 168	f
1578	2	task 169	f
1579	2	task 170	f
1580	1	task 171	f
1581	3	task 172	f
1582	2	task 173	f
1583	3	task 174	f
1584	1	task 175	f
1585	2	task 176	f
1586	1	task 177	f
1587	2	task 178	f
1588	1	task 179	f
1589	2	task 180	f
1590	2	task 181	f
1591	2	task 182	f
1592	2	task 183	f
1593	1	task 184	f
1594	3	task 185	f
1595	1	task 186	f
1596	2	task 187	f
1597	2	task 188	f
1598	1	task 189	f
1599	1	task 190	f
1600	2	task 191	f
1601	3	task 192	f
1602	2	task 193	f
1603	2	task 194	f
1604	3	task 195	f
1605	2	task 196	f
1606	1	task 197	f
1607	1	task 198	f
1608	2	task 199	f
1609	1	task 200	f
1610	3	task 201	f
1611	2	task 202	f
1612	3	task 203	f
1613	3	task 204	f
1614	1	task 205	f
1615	2	task 206	f
1616	3	task 207	f
1617	2	task 208	f
1618	3	task 209	f
1619	2	task 210	f
1620	2	task 211	f
1621	2	task 212	f
1622	2	task 213	f
1623	2	task 214	f
1624	2	task 215	f
1625	3	task 216	f
1626	1	task 217	f
1627	3	task 218	f
1628	1	task 219	f
1629	2	task 220	f
1630	1	task 221	f
1631	3	task 222	f
1632	1	task 223	f
1633	2	task 224	f
1634	2	task 225	f
1635	3	task 226	f
1636	2	task 227	f
1637	1	task 228	f
1638	2	task 229	f
1639	2	task 230	f
1640	3	task 231	f
1641	1	task 232	f
1642	2	task 233	f
1643	2	task 234	f
1644	3	task 235	f
1645	3	task 236	f
1646	3	task 237	f
1647	2	task 238	f
1648	2	task 239	f
1649	3	task 240	f
1650	1	task 241	f
1651	3	task 242	f
1652	2	task 243	f
1653	1	task 244	f
1654	2	task 245	f
1655	2	task 246	f
1656	2	task 247	f
1657	2	task 248	f
1658	3	task 249	f
1659	2	task 250	f
1660	1	task 251	f
1661	2	task 252	f
1662	2	task 253	f
1663	2	task 254	f
1664	2	task 255	f
1665	2	task 256	f
1666	1	task 257	f
1667	1	task 258	f
1668	2	task 259	f
1669	2	task 260	f
1670	2	task 261	f
1671	3	task 262	f
1672	3	task 263	f
1673	3	task 264	f
1674	2	task 265	f
1675	1	task 266	f
1676	2	task 267	f
1677	2	task 268	f
1678	1	task 269	f
1679	3	task 270	f
1680	2	task 271	f
1681	1	task 272	f
1682	3	task 273	f
1683	2	task 274	f
1684	2	task 275	f
1685	3	task 276	f
1686	1	task 277	f
1687	2	task 278	f
1688	2	task 279	f
1689	2	task 280	f
1690	1	task 281	f
1691	2	task 282	f
1692	2	task 283	f
1693	3	task 284	f
1694	3	task 285	f
1695	2	task 286	f
1696	3	task 287	f
1697	2	task 288	f
1698	3	task 289	f
1699	2	task 290	f
1700	2	task 291	f
1701	2	task 292	f
1702	3	task 293	f
1703	1	task 294	f
1704	1	task 295	f
1705	2	task 296	f
1706	2	task 297	f
1707	2	task 298	f
1708	2	task 299	f
1709	1	task 300	f
1710	1	task 301	f
1711	2	task 302	f
1712	2	task 303	f
1713	1	task 304	f
1714	2	task 305	f
1715	2	task 306	f
1716	2	task 307	f
1717	2	task 308	f
1718	3	task 309	f
1719	2	task 310	f
1720	1	task 311	f
1721	3	task 312	f
1722	2	task 313	f
1723	1	task 314	f
1724	1	task 315	f
1725	3	task 316	f
1726	2	task 317	f
1727	2	task 318	f
1728	1	task 319	f
1729	2	task 320	f
1730	1	task 321	f
1731	1	task 322	f
1732	2	task 323	f
1733	2	task 324	f
1734	3	task 325	f
1735	2	task 326	f
1736	2	task 327	f
1737	1	task 328	f
1738	2	task 329	f
1739	1	task 330	f
1740	1	task 331	f
1741	2	task 332	f
1742	3	task 333	f
1743	2	task 334	f
1744	3	task 335	f
1745	3	task 336	f
1746	2	task 337	f
1747	1	task 338	f
1748	2	task 339	f
1749	2	task 340	f
1750	2	task 341	f
1751	2	task 342	f
1752	1	task 343	f
1753	2	task 344	f
1754	1	task 345	f
1755	1	task 346	f
1756	2	task 347	f
1757	3	task 348	f
1758	2	task 349	f
1759	3	task 350	f
1760	2	task 351	f
1761	3	task 352	f
1762	1	task 353	f
1763	2	task 354	f
1764	1	task 355	f
1765	1	task 356	f
1766	1	task 357	f
1767	2	task 358	f
1768	2	task 359	f
1769	2	task 360	f
1770	2	task 361	f
1771	2	task 362	f
1772	2	task 363	f
1773	3	task 364	f
1774	3	task 365	f
1775	2	task 366	f
1776	1	task 367	f
1777	2	task 368	f
1778	2	task 369	f
1779	2	task 370	f
1780	3	task 371	f
1781	2	task 372	f
1782	3	task 373	f
1783	2	task 374	f
1784	2	task 375	f
1785	3	task 376	f
1786	2	task 377	f
1787	2	task 378	f
1788	1	task 379	f
1789	2	task 380	f
1790	3	task 381	f
1791	1	task 382	f
1792	1	task 383	f
1793	2	task 384	f
1794	1	task 385	f
1795	2	task 386	f
1796	2	task 387	f
1797	3	task 388	f
1798	2	task 389	f
1799	2	task 390	f
1800	3	task 391	f
1801	1	task 392	f
1802	1	task 393	f
1803	3	task 394	f
1804	2	task 395	f
1805	3	task 396	f
1806	2	task 397	f
1807	2	task 398	f
1808	3	task 399	f
1809	1	task 400	f
1810	2	task 401	f
1811	1	task 402	f
1812	1	task 403	f
1813	2	task 404	f
1814	1	task 405	f
1815	2	task 406	f
1816	3	task 407	f
1817	2	task 408	f
1818	2	task 409	f
1819	1	task 410	f
1820	1	task 411	f
1821	3	task 412	f
1822	1	task 413	f
1823	1	task 414	f
1824	3	task 415	f
1825	2	task 416	f
1826	2	task 417	f
1827	1	task 418	f
1828	1	task 419	f
1829	2	task 420	f
1830	3	task 421	f
1831	2	task 422	f
1832	2	task 423	f
1833	3	task 424	f
1834	1	task 425	f
1835	3	task 426	f
1836	1	task 427	f
1837	2	task 428	f
1838	2	task 429	f
1839	2	task 430	f
1840	1	task 431	f
1841	1	task 432	f
1842	3	task 433	f
1843	3	task 434	f
1844	2	task 435	f
1845	1	task 436	f
1846	2	task 437	f
1847	3	task 438	f
1848	1	task 439	f
1849	2	task 440	f
1850	1	task 441	f
1851	2	task 442	f
1852	3	task 443	f
1853	3	task 444	f
1854	2	task 445	f
1855	2	task 446	f
1856	2	task 447	f
1857	1	task 448	f
1858	1	task 449	f
1859	2	task 450	f
1860	2	task 451	f
1861	1	task 452	f
1862	2	task 453	f
1863	2	task 454	f
1864	2	task 455	f
1865	3	task 456	f
1866	2	task 457	f
1867	3	task 458	f
1868	3	task 459	f
1869	3	task 460	f
1870	2	task 461	f
1871	2	task 462	f
1872	1	task 463	f
1873	1	task 464	f
1874	2	task 465	f
1875	2	task 466	f
1876	2	task 467	f
1877	3	task 468	f
1878	2	task 469	f
1879	1	task 470	f
1880	2	task 471	f
1881	3	task 472	f
1882	3	task 473	f
1883	2	task 474	f
1884	1	task 475	f
1885	1	task 476	f
1886	3	task 477	f
1887	2	task 478	f
1888	3	task 479	f
1889	2	task 480	f
1890	3	task 481	f
1891	1	task 482	f
1892	2	task 483	f
1893	2	task 484	f
1894	2	task 485	f
1895	1	task 486	f
1896	2	task 487	f
1897	3	task 488	f
1898	1	task 489	f
1899	2	task 490	f
1900	2	task 491	f
1901	2	task 492	f
1902	2	task 493	f
1903	1	task 494	f
1904	3	task 495	f
1905	3	task 496	f
1906	1	task 497	f
1907	3	task 498	f
1908	2	task 499	f
1909	3	task 500	f
1910	2	task 501	f
1911	1	task 502	f
1912	2	task 503	f
1913	1	task 504	f
1914	2	task 505	f
1915	2	task 506	f
1916	1	task 507	f
1917	1	task 508	f
1918	3	task 509	f
1919	2	task 510	f
1920	1	task 511	f
1921	2	task 512	f
1922	2	task 513	f
1923	1	task 514	f
1924	1	task 515	f
1925	1	task 516	f
1926	1	task 517	f
1927	2	task 518	f
1928	3	task 519	f
1929	2	task 520	f
1930	3	task 521	f
1931	2	task 522	f
1932	3	task 523	f
1933	2	task 524	f
1934	2	task 525	f
1935	3	task 526	f
1936	1	task 527	f
1937	2	task 528	f
1938	2	task 529	f
1939	2	task 530	f
1940	3	task 531	f
1941	2	task 532	f
1942	2	task 533	f
1943	3	task 534	f
1944	1	task 535	f
1945	2	task 536	f
1946	3	task 537	f
1947	3	task 538	f
1948	1	task 539	f
1949	2	task 540	f
1950	3	task 541	f
1951	1	task 542	f
1952	1	task 543	f
1953	2	task 544	f
1954	2	task 545	f
1955	3	task 546	f
1956	2	task 547	f
1957	2	task 548	f
1958	2	task 549	f
1959	1	task 550	f
1960	2	task 551	f
1961	2	task 552	f
1962	3	task 553	f
1963	2	task 554	f
1964	2	task 555	f
1965	1	task 556	f
1966	2	task 557	f
1967	1	task 558	f
1968	1	task 559	f
1969	2	task 560	f
1970	2	task 561	f
1971	3	task 562	f
1972	2	task 563	f
1973	3	task 564	f
1974	3	task 565	f
1975	2	task 566	f
1976	1	task 567	f
1977	2	task 568	f
1978	2	task 569	f
1979	1	task 570	f
1980	2	task 571	f
1981	2	task 572	f
1982	2	task 573	f
1983	2	task 574	f
1984	2	task 575	f
1985	2	task 576	f
1986	1	task 577	f
1987	2	task 578	f
1988	2	task 579	f
1989	3	task 580	f
1990	2	task 581	f
1991	2	task 582	f
1992	2	task 583	f
1993	2	task 584	f
1994	2	task 585	f
1995	3	task 586	f
1996	2	task 587	f
1997	2	task 588	f
1998	2	task 589	f
1999	2	task 590	f
2000	2	task 591	f
2001	3	task 592	f
2002	1	task 593	f
2003	2	task 594	f
2004	3	task 595	f
2005	3	task 596	f
2006	1	task 597	f
2007	3	task 598	f
2008	2	task 599	f
2009	1	task 600	f
2010	1	task 601	f
2011	1	task 602	f
2012	2	task 603	f
2013	3	task 604	f
2014	3	task 605	f
2015	1	task 606	f
2016	2	task 607	f
2017	2	task 608	f
2018	3	task 609	f
2019	2	task 610	f
2020	3	task 611	f
2021	2	task 612	f
2022	3	task 613	f
2023	2	task 614	f
2024	2	task 615	f
2025	2	task 616	f
2026	2	task 617	f
2027	2	task 618	f
2028	2	task 619	f
2029	2	task 620	f
2030	2	task 621	f
2031	1	task 622	f
2032	2	task 623	f
2033	3	task 624	f
2034	2	task 625	f
2035	2	task 626	f
2036	1	task 627	f
2037	2	task 628	f
2038	2	task 629	f
2039	3	task 630	f
2040	1	task 631	f
2041	1	task 632	f
2042	2	task 633	f
2043	3	task 634	f
2044	2	task 635	f
2045	3	task 636	f
2046	2	task 637	f
2047	2	task 638	f
2048	2	task 639	f
2049	1	task 640	f
2050	2	task 641	f
2051	2	task 642	f
2052	3	task 643	f
2053	1	task 644	f
2054	2	task 645	f
2055	2	task 646	f
2056	3	task 647	f
2057	1	task 648	f
2058	2	task 649	f
2059	3	task 650	f
2060	2	task 651	f
2061	3	task 652	f
2062	3	task 653	f
2063	2	task 654	f
2064	2	task 655	f
2065	1	task 656	f
2066	1	task 657	f
2067	2	task 658	f
2068	2	task 659	f
2069	2	task 660	f
2070	1	task 661	f
2071	2	task 662	f
2072	1	task 663	f
2073	1	task 664	f
2074	2	task 665	f
2075	3	task 666	f
2076	1	task 667	f
2077	3	task 668	f
2078	2	task 669	f
2079	2	task 670	f
2080	2	task 671	f
2081	3	task 672	f
2082	3	task 673	f
2083	2	task 674	f
2084	1	task 675	f
2085	2	task 676	f
2086	2	task 677	f
2087	3	task 678	f
2088	2	task 679	f
2089	3	task 680	f
2090	2	task 681	f
2091	3	task 682	f
2092	1	task 683	f
2093	2	task 684	f
2094	3	task 685	f
2095	2	task 686	f
2096	2	task 687	f
2097	3	task 688	f
2098	3	task 689	f
2099	2	task 690	f
2100	2	task 691	f
2101	3	task 692	f
2102	2	task 693	f
2103	2	task 694	f
2104	2	task 695	f
2105	1	task 696	f
2106	2	task 697	f
2107	1	task 698	f
2108	3	task 699	f
2109	2	task 700	f
2110	2	task 701	f
2111	3	task 702	f
2112	1	task 703	f
2113	1	task 704	f
2114	1	task 705	f
2115	3	task 706	f
2116	3	task 707	f
2117	3	task 708	f
2118	2	task 709	f
2119	2	task 710	f
2120	2	task 711	f
2121	3	task 712	f
2122	2	task 713	f
2123	2	task 714	f
2124	3	task 715	f
2125	1	task 716	f
2126	2	task 717	f
2127	3	task 718	f
2128	2	task 719	f
2129	3	task 720	f
2130	2	task 721	f
2131	2	task 722	f
2132	1	task 723	f
2133	2	task 724	f
2134	3	task 725	f
2135	2	task 726	f
2136	3	task 727	f
2137	2	task 728	f
2138	1	task 729	f
2139	3	task 730	f
2140	3	task 731	f
2141	3	task 732	f
2142	2	task 733	f
2143	1	task 734	f
2144	3	task 735	f
2145	2	task 736	f
2146	2	task 737	f
2147	1	task 738	f
2148	1	task 739	f
2149	2	task 740	f
2150	2	task 741	f
2151	3	task 742	f
2152	2	task 743	f
2153	2	task 744	f
2154	2	task 745	f
2155	2	task 746	f
2156	3	task 747	f
2157	3	task 748	f
2158	2	task 749	f
2159	1	task 750	f
2160	2	task 751	f
2161	1	task 752	f
2162	2	task 753	f
2163	3	task 754	f
2164	3	task 755	f
2165	2	task 756	f
2166	3	task 757	f
2167	3	task 758	f
2168	1	task 759	f
2169	2	task 760	f
2170	2	task 761	f
2171	2	task 762	f
2172	2	task 763	f
2173	2	task 764	f
2174	1	task 765	f
2175	2	task 766	f
2176	2	task 767	f
2177	2	task 768	f
2178	1	task 769	f
2179	1	task 770	f
2180	2	task 771	f
2181	3	task 772	f
2182	2	task 773	f
2183	3	task 774	f
2184	1	task 775	f
2185	1	task 776	f
2186	2	task 777	f
2187	2	task 778	f
2188	2	task 779	f
2189	1	task 780	f
2190	3	task 781	f
2191	2	task 782	f
2192	2	task 783	f
2193	3	task 784	f
2194	2	task 785	f
2195	1	task 786	f
2196	1	task 787	f
2197	2	task 788	f
2198	3	task 789	f
2199	1	task 790	f
2200	2	task 791	f
2201	2	task 792	f
2202	1	task 793	f
2203	3	task 794	f
2204	2	task 795	f
2205	1	task 796	f
2206	2	task 797	f
2207	3	task 798	f
2208	1	task 799	f
2209	3	task 800	f
2210	1	task 801	f
2211	2	task 802	f
2212	2	task 803	f
2213	3	task 804	f
2214	2	task 805	f
2215	1	task 806	f
2216	1	task 807	f
2217	2	task 808	f
2218	3	task 809	f
2219	2	task 810	f
2220	2	task 811	f
2221	2	task 812	f
2222	2	task 813	f
2223	2	task 814	f
2224	2	task 815	f
2225	3	task 816	f
2226	2	task 817	f
2227	3	task 818	f
2228	3	task 819	f
2229	2	task 820	f
2230	1	task 821	f
2231	3	task 822	f
2232	1	task 823	f
2233	2	task 824	f
2234	2	task 825	f
2235	1	task 826	f
2236	1	task 827	f
2237	1	task 828	f
2238	3	task 829	f
2239	3	task 830	f
2240	2	task 831	f
2241	2	task 832	f
2242	1	task 833	f
2243	2	task 834	f
2244	3	task 835	f
2245	3	task 836	f
2246	1	task 837	f
2247	1	task 838	f
2248	2	task 839	f
2249	3	task 840	f
2250	3	task 841	f
2251	1	task 842	f
2252	2	task 843	f
2253	2	task 844	f
2254	1	task 845	f
2255	2	task 846	f
2256	2	task 847	f
2257	1	task 848	f
2258	3	task 849	f
2259	2	task 850	f
2260	1	task 851	f
2261	2	task 852	f
2262	1	task 853	f
2263	2	task 854	f
2264	2	task 855	f
2265	1	task 856	f
2266	1	task 857	f
2267	2	task 858	f
2268	1	task 859	f
2269	2	task 860	f
2270	2	task 861	f
2271	1	task 862	f
2272	3	task 863	f
2273	2	task 864	f
2274	2	task 865	f
2275	2	task 866	f
2276	2	task 867	f
2277	1	task 868	f
2278	2	task 869	f
2279	3	task 870	f
2280	2	task 871	f
2281	3	task 872	f
2282	3	task 873	f
2283	1	task 874	f
2284	1	task 875	f
2285	2	task 876	f
2286	3	task 877	f
2287	3	task 878	f
2288	2	task 879	f
2289	3	task 880	f
2290	2	task 881	f
2291	2	task 882	f
2292	2	task 883	f
2293	3	task 884	f
2294	2	task 885	f
2295	3	task 886	f
2296	3	task 887	f
2297	2	task 888	f
2298	2	task 889	f
2299	3	task 890	f
2300	2	task 891	f
2301	3	task 892	f
2302	3	task 893	f
2303	1	task 894	f
2304	2	task 895	f
2305	3	task 896	f
2306	1	task 897	f
2307	2	task 898	f
2308	2	task 899	f
2309	2	task 900	f
2310	2	task 901	f
2311	2	task 902	f
2312	3	task 903	f
2313	2	task 904	f
2314	3	task 905	f
2315	2	task 906	f
2316	2	task 907	f
2317	1	task 908	f
2318	2	task 909	f
2319	2	task 910	f
2320	2	task 911	f
2321	3	task 912	f
2322	1	task 913	f
2323	2	task 914	f
2324	2	task 915	f
2325	1	task 916	f
2326	2	task 917	f
2327	3	task 918	f
2328	1	task 919	f
2329	2	task 920	f
2330	3	task 921	f
2331	1	task 922	f
2332	2	task 923	f
2333	2	task 924	f
2334	1	task 925	f
2335	1	task 926	f
2336	3	task 927	f
2337	2	task 928	f
2338	3	task 929	f
2339	1	task 930	f
2340	2	task 931	f
2341	2	task 932	f
2342	3	task 933	f
2343	2	task 934	f
2344	2	task 935	f
2345	2	task 936	f
2346	1	task 937	f
2347	2	task 938	f
2348	2	task 939	f
2349	1	task 940	f
2350	2	task 941	f
2351	2	task 942	f
2352	2	task 943	f
2353	2	task 944	f
2354	1	task 945	f
2355	2	task 946	f
2356	3	task 947	f
2357	1	task 948	f
2358	2	task 949	f
2359	2	task 950	f
2360	3	task 951	f
2361	2	task 952	f
2362	2	task 953	f
2363	2	task 954	f
2364	2	task 955	f
2365	2	task 956	f
2366	2	task 957	f
2367	3	task 958	f
2368	1	task 959	f
2369	3	task 960	f
2370	2	task 961	f
2371	3	task 962	f
2372	3	task 963	f
2373	1	task 964	f
2374	1	task 965	f
2375	2	task 966	f
2376	1	task 967	f
2377	2	task 968	f
2378	2	task 969	f
2379	1	task 970	f
2380	3	task 971	f
2381	2	task 972	f
2382	2	task 973	f
2383	1	task 974	f
2384	2	task 975	f
2385	3	task 976	f
2386	1	task 977	f
2387	1	task 978	f
2388	1	task 979	f
2389	3	task 980	f
2390	1	task 981	f
2391	2	task 982	f
2392	1	task 983	f
2393	3	task 984	f
2394	2	task 985	f
2395	3	task 986	f
2396	2	task 987	f
2397	2	task 988	f
2398	1	task 989	f
2399	3	task 990	f
2400	2	task 991	f
2401	2	task 992	f
2402	1	task 993	f
2403	1	task 994	f
2404	1	task 995	f
2405	3	task 996	f
2406	2	task 997	f
2407	2	task 998	f
2408	2	task 999	f
2409	1	task 1000	f
2414	4	Test task	f
2416	4	Test task	f
2419	4	Test task	f
2421	4	Test task	f
2423	4	Test task	f
2425	2	Study for an hour	f
2426	4	Test task	f
2428	4	Test task	f
2430	4	Test task	f
2432	4	Test task	f
2434	3	Birbale	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, email) FROM stdin;
7	Aminaa	$2b$10$lR6jmk/dVUFxwbyXAhBkCu6UoxgdAaA03056uG21jnsViFewil.a6	aminaa@gmail.com
9	Nurayka	$2b$10$BqLI6kSp8qraQX59FLMe3eoVU.yP7K0VWdq9I1NrIAOzejeH4boKi	nurayka@gmail.com
11	Zhan	$2b$10$rfZeyHPB3Z8TArGNRoU0cOSCBb6ICD.26oOjz.PbHbnnglFpJ47eq	zhansdu@gmail.com
13	Alina	$2b$10$3/iK8PiyqpGbgQgVjBCyDuNfBHk8V.tXPDqONRSB7ikuRBQWJp8wq	alina@gmail.com
14	tiffany	$2b$10$uBPu./YpSthNTkjUeKim1uey.vfGZkI5TVWNOShF4BAU.GjrKCeky	tif@gmail.com
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 4, true);


--
-- Name: app_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_users_id_seq', 4, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_id_seq', 12, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 4, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 2434, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 14, true);


--
-- Name: accounts accounts_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_email_key UNIQUE (email);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: app_users app_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_pkey PRIMARY KEY (id);


--
-- Name: products cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: tags tags_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: task_tags task_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT task_tags_pkey PRIMARY KEY (task_id, tag_id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_tasks_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tasks_user_id ON public.tasks USING btree (user_id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id);


--
-- Name: task_tags task_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT task_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- Name: task_tags task_tags_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT task_tags_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: tasks tasks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.app_users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict excYgn2COJ11JOMaC6XsxEPiThqHHsFQJcvdIlNwoDnIqJdIdfKEvWDkUf8QyLt

