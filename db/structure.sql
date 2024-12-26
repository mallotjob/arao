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

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admins (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying,
    last_name character varying,
    phone_number character varying,
    email character varying,
    username character varying,
    company_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: balances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.balances (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    companies_id uuid NOT NULL,
    currency character varying,
    beneficiary_currency character varying,
    diff double precision,
    from_date timestamp(6) without time zone DEFAULT CURRENT_DATE NOT NULL,
    to_date timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    shipping_time_id uuid NOT NULL,
    type_config_id uuid NOT NULL,
    shipping_id uuid NOT NULL,
    quantity integer,
    length double precision,
    width double precision,
    heigth double precision,
    weight double precision,
    commodity character varying,
    tracking_number character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    aasm_state character varying,
    balance_id uuid
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shipping_times; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_times (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    given_date date,
    company_id uuid NOT NULL,
    type_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: shippings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shippings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    mark character varying,
    company_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: type_configs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type_configs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type_id uuid NOT NULL,
    price integer,
    unit_id uuid NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    company_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.units (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    unit character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying,
    last_name character varying,
    phone_number character varying,
    email character varying,
    username character varying,
    company_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying
);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: balances balances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.balances
    ADD CONSTRAINT balances_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shipping_times shipping_times_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_times
    ADD CONSTRAINT shipping_times_pkey PRIMARY KEY (id);


--
-- Name: shippings shippings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shippings
    ADD CONSTRAINT shippings_pkey PRIMARY KEY (id);


--
-- Name: type_configs type_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_configs
    ADD CONSTRAINT type_configs_pkey PRIMARY KEY (id);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_admins_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admins_on_company_id ON public.admins USING btree (company_id);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_email ON public.admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON public.admins USING btree (reset_password_token);


--
-- Name: index_admins_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_username ON public.admins USING btree (username);


--
-- Name: index_balances_on_companies_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_balances_on_companies_id ON public.balances USING btree (companies_id);


--
-- Name: index_products_on_balance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_balance_id ON public.products USING btree (balance_id);


--
-- Name: index_products_on_shipping_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_shipping_id ON public.products USING btree (shipping_id);


--
-- Name: index_products_on_shipping_time_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_shipping_time_id ON public.products USING btree (shipping_time_id);


--
-- Name: index_products_on_type_config_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_type_config_id ON public.products USING btree (type_config_id);


--
-- Name: index_shipping_times_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shipping_times_on_company_id ON public.shipping_times USING btree (company_id);


--
-- Name: index_shipping_times_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shipping_times_on_type_id ON public.shipping_times USING btree (type_id);


--
-- Name: index_shippings_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shippings_on_company_id ON public.shippings USING btree (company_id);


--
-- Name: index_type_configs_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_type_configs_on_type_id ON public.type_configs USING btree (type_id);


--
-- Name: index_type_configs_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_type_configs_on_unit_id ON public.type_configs USING btree (unit_id);


--
-- Name: index_types_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_types_on_company_id ON public.types USING btree (company_id);


--
-- Name: index_users_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_company_id ON public.users USING btree (company_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON public.users USING btree (username);


--
-- Name: shipping_times fk_rails_009d1a554e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_times
    ADD CONSTRAINT fk_rails_009d1a554e FOREIGN KEY (type_id) REFERENCES public.types(id);


--
-- Name: type_configs fk_rails_01583167b0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_configs
    ADD CONSTRAINT fk_rails_01583167b0 FOREIGN KEY (type_id) REFERENCES public.types(id);


--
-- Name: products fk_rails_02956797cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_02956797cb FOREIGN KEY (balance_id) REFERENCES public.balances(id);


--
-- Name: types fk_rails_07fd3a2f43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT fk_rails_07fd3a2f43 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: balances fk_rails_162a922efa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.balances
    ADD CONSTRAINT fk_rails_162a922efa FOREIGN KEY (companies_id) REFERENCES public.companies(id);


--
-- Name: products fk_rails_415b55c1ba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_415b55c1ba FOREIGN KEY (shipping_time_id) REFERENCES public.shipping_times(id);


--
-- Name: products fk_rails_642677d43f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_642677d43f FOREIGN KEY (type_config_id) REFERENCES public.type_configs(id);


--
-- Name: users fk_rails_7682a3bdfe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_7682a3bdfe FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: shipping_times fk_rails_787a818726; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_times
    ADD CONSTRAINT fk_rails_787a818726 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: type_configs fk_rails_9ff85e75d4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_configs
    ADD CONSTRAINT fk_rails_9ff85e75d4 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: shippings fk_rails_c1d191effb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shippings
    ADD CONSTRAINT fk_rails_c1d191effb FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: admins fk_rails_e493fcc5fa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT fk_rails_e493fcc5fa FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: products fk_rails_ea52b43f2a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_ea52b43f2a FOREIGN KEY (shipping_id) REFERENCES public.shippings(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20241226180832'),
('20241226180253'),
('20241226173943'),
('20241226173359'),
('20241217075348'),
('20241216054613'),
('20241211173125'),
('20241211163416'),
('20241211161501'),
('20241211161338'),
('20241211071653'),
('20241211064644'),
('20241210180759'),
('20241210162321'),
('20241209135629'),
('20241209135524'),
('20241209102142'),
('20241209101716'),
('20241209101446'),
('20241209101143');

