PGDMP         -                y            postgres    11.12 (Debian 11.12-0+deb10u1)    11.12 (Debian 11.12-0+deb10u1)     ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            ?           1262    13101    postgres    DATABASE     z   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE postgres;
             postgres    false            ?           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                  postgres    false    2994            ?            1259    24780    contents    TABLE     ?  CREATE TABLE public.contents (
    id bigint NOT NULL,
    title text NOT NULL,
    url character(255) NOT NULL,
    short_description text NOT NULL,
    date_published timestamp(0) without time zone NOT NULL,
    author character(255),
    image character(255),
    created_at timestamp without time zone,
    guid character(255) NOT NULL,
    updated_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);
    DROP TABLE public.contents;
       public         postgres    false            ?            1259    24778    contents_id_seq    SEQUENCE     x   CREATE SEQUENCE public.contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.contents_id_seq;
       public       postgres    false    223            ?           0    0    contents_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.contents_id_seq OWNED BY public.contents.id;
            public       postgres    false    222            .           2604    24783    contents id    DEFAULT     j   ALTER TABLE ONLY public.contents ALTER COLUMN id SET DEFAULT nextval('public.contents_id_seq'::regclass);
 :   ALTER TABLE public.contents ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    222    223    223            ?          0    24780    contents 
   TABLE DATA               ?   COPY public.contents (id, title, url, short_description, date_published, author, image, created_at, guid, updated_at) FROM stdin;
    public       postgres    false    223   ?       ?           0    0    contents_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.contents_id_seq', 714, true);
            public       postgres    false    222            1           2606    24788    contents contents_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.contents DROP CONSTRAINT contents_pkey;
       public         postgres    false    223            ?      x?????? ? ?     