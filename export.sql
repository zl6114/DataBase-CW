--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.10
-- Dumped by pg_dump version 9.5.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: monarch; Type: TABLE; Schema: public; Owner: pjm
--

CREATE TABLE monarch (
    name character varying(35) NOT NULL,
    house character varying(8),
    accession date NOT NULL,
    coronation date,
    CONSTRAINT monarch_house_check CHECK (((house)::text = ANY ((ARRAY['Windsor'::character varying, 'Hanover'::character varying, 'Tudor'::character varying, 'Stuart'::character varying])::text[])))
);


ALTER TABLE monarch OWNER TO pjm;

--
-- Name: person; Type: TABLE; Schema: public; Owner: pjm
--

CREATE TABLE person (
    name character varying(35) NOT NULL,
    gender character(1) NOT NULL,
    dob date NOT NULL,
    dod date,
    father character varying(35),
    mother character varying(35),
    born_in character varying(24) NOT NULL,
    CONSTRAINT person_gender_check CHECK ((gender = ANY (ARRAY['F'::bpchar, 'M'::bpchar])))
);


ALTER TABLE person OWNER TO pjm;

--
-- Name: prime_minister; Type: TABLE; Schema: public; Owner: pjm
--

CREATE TABLE prime_minister (
    name character varying(35) NOT NULL,
    party character varying(12) NOT NULL,
    entry date NOT NULL,
    CONSTRAINT prime_minister_party_check CHECK (((party)::text = ANY ((ARRAY['Conservative'::character varying, 'Labour'::character varying, 'Liberal'::character varying])::text[])))
);


ALTER TABLE prime_minister OWNER TO pjm;

--
-- Data for Name: monarch; Type: TABLE DATA; Schema: public; Owner: pjm
--

COPY monarch (name, house, accession, coronation) FROM stdin;
James I	Stuart	1603-03-24	1603-07-25
Charles I	Stuart	1625-03-27	1626-02-02
Oliver Cromwell	\N	1649-01-30	\N
Richard Cromwell	\N	1658-09-03	\N
Charles II	Stuart	1659-05-25	1626-02-02
James II	Stuart	1685-02-06	1685-04-23
Mary II	Stuart	1689-02-13	1689-04-11
William III	Stuart	1689-02-13	1689-04-11
Anne	Stuart	1702-03-08	1702-04-23
George I	Hanover	1714-08-01	1714-10-20
George II	Hanover	1727-06-22	1727-10-22
George III	Hanover	1760-10-25	1761-09-22
George IV	Hanover	1820-01-29	1821-07-19
William IV	Hanover	1830-06-26	1837-06-20
Victoria	Hanover	1837-06-20	1838-06-28
Edward VII	Windsor	1901-01-22	1902-08-09
George V	Windsor	1910-05-06	1911-06-22
Edward VIII	Windsor	1936-01-20	\N
George VI	Windsor	1936-12-11	1937-05-12
Elizabeth II	Windsor	1952-02-06	1953-06-02
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: pjm
--

COPY person (name, gender, dob, dod, father, mother, born_in) FROM stdin;
Charles I	M	1600-11-19	1649-01-30	James I	\N	Dumfermline
Charles II	M	1630-06-08	1685-02-06	Charles I	Henrietta Maria	London
James II	M	1633-10-24	1701-09-16	Charles I	Henrietta Maria	London
Henrietta Maria	F	1609-11-25	1669-09-10	\N	\N	Paris
Mary (Princess Royal)	F	1631-11-04	1660-12-24	Charles I	Henrietta Maria	London
Anne Hyde	F	1638-03-22	1671-04-10	\N	\N	Windsor
Mary II	F	1662-05-10	1695-01-07	James II	Anne Hyde	London
William II of Orange	M	1626-05-27	1650-11-06	\N	\N	The Hague
William III	M	1650-11-14	1702-03-08	William II of Orange	Mary (Princess Royal)	London
Anne	F	1665-02-06	1714-08-01	James II	Anne Hyde	London
Ernest Augustus	M	1629-11-20	1698-01-23	\N	\N	Herzberg am Harz
Palatine Sophia	F	1630-10-14	1714-06-08	\N	Elizabeth of Bohemia	The Hague
Elizabeth of Bohemia	F	1596-08-19	1662-02-13	James I	\N	Fife
James I	M	1566-06-19	1625-03-27	\N	\N	Fife
George I	M	1660-06-07	1727-06-22	Ernest Augustus	Palatine Sophia	Hanover
George II	M	1683-11-09	1760-10-25	George I	\N	Hanover
Frederick	M	1707-02-01	1751-03-20	George II	\N	Hanover
George III	M	1738-08-21	1820-01-29	Frederick	Augusta of Saxe-Gotha	London
Augusta of Saxe-Gotha	F	1719-11-30	1772-02-08	\N	\N	Gotha
Charlotte	F	1744-05-19	1818-11-17	\N	\N	Mecklenburg-Streliz
George IV	M	1765-08-21	1830-06-26	George III	Charlotte	London
Frederick (Prince)	M	1763-08-16	1827-01-05	George III	Charlotte	London
William IV	M	1765-08-21	1837-06-20	George III	Charlotte	London
Victoria	F	1819-05-24	1901-01-22	Edward (Prince)	\N	London
Edward (Prince)	M	1767-11-02	1820-01-23	George III	Charlotte	London
Albert	M	1819-08-26	1861-12-14	\N	\N	Coburg
Victoria (Princess Royal)	F	1840-11-21	1901-08-05	Albert	Victoria	London
Edward VII	M	1841-11-09	1910-05-06	Albert	Victoria	London
Alexandra (Queen)	F	1844-12-01	1925-11-20	\N	\N	Copenhagen
Alice (Princess)	F	1843-04-25	1878-12-14	Albert	Victoria	London
Alfred	M	1844-08-06	1900-07-30	Albert	Victoria	Windsor Castle
Albert Victor	M	1864-01-08	1892-01-14	Edward VII	Alexandra (Queen)	Frogmore
George V	M	1865-06-03	1936-01-20	Edward VII	Alexandra (Queen)	London
Alice (Princess Royal)	F	1867-02-20	1931-01-04	Edward VII	Alexandra (Queen)	London
Mary of Teck	F	1867-05-26	1953-03-24	\N	\N	London
George VI	M	1895-12-14	1952-02-06	George V	Mary of Teck	Sandringham
Edward VIII	M	1894-06-23	1972-05-28	George V	Mary of Teck	Sandringham
Elizabeth	F	1900-08-04	2002-03-30	\N	\N	London
Elizabeth II	F	1926-04-21	\N	George VI	Elizabeth	London
Margaret	F	1930-08-21	2002-02-09	George VI	Elizabeth	Glamis Castle
George I of Greece	M	1845-12-24	1913-03-18	\N	\N	Copenhagen
Andrew of Greece	M	1882-02-02	1944-12-03	George I of Greece	\N	Athens
Constantine I of Greece	M	1868-08-02	1923-01-11	George I of Greece	\N	Athens
Alice	F	1885-02-25	1969-12-05	\N	\N	Windsor
Philip	M	1921-06-10	\N	Andrew of Greece	Alice	Corfu
Charles	M	1948-11-14	\N	Philip	Elizabeth II	London
Anne (Princess)	F	1950-08-15	\N	Philip	Elizabeth II	London
Andrew	M	1960-02-19	\N	Philip	Elizabeth II	London
Edward	M	1964-03-10	\N	Philip	Elizabeth II	London
Frances	F	1936-01-20	2004-06-03	\N	\N	Sandringham
Diana	F	1961-07-01	1997-08-31	\N	Frances	Sandringham
Henry	M	1984-09-15	\N	Charles	Diana	London
William	M	1982-06-21	\N	Charles	Diana	London
Oliver Cromwell	M	1599-04-25	1658-09-03	\N	\N	Huntingdon
Richard Cromwell	M	1626-10-04	1659-05-25	Oliver Cromwell	\N	Huntingdon
David Cameron	M	1966-10-09	\N	\N	\N	London
Gordon Brown	M	1951-02-20	\N	\N	\N	Giffnock
Tony Blair	M	1953-05-06	\N	\N	\N	Edinburgh
John Major	M	1943-03-29	\N	\N	\N	Carshalton
Margaret Thatcher	F	1925-10-13	\N	\N	\N	Grantham
James Callaghan	M	1912-03-27	2005-03-26	\N	\N	Portsmouth
Harold Wilson	M	1916-03-11	1995-05-24	\N	\N	Huddersfield
Edward Heath	M	1916-07-09	2005-07-17	\N	\N	Huddersfield
Alec Douglas-Home	M	1903-07-02	1995-10-09	\N	\N	Coldstream
Harold Macmillan	M	1894-02-10	1986-12-29	\N	\N	London
Anthony Eden	M	1897-06-12	1977-01-14	\N	\N	London
Winston Churchill	M	1874-11-30	1965-01-24	\N	\N	Woodstock
Clement Attlee	M	1883-01-03	1967-10-08	\N	\N	London
Neville Chamberlain	M	1869-03-18	1940-11-09	\N	\N	Birmingham
Stanley Baldwin	M	1867-08-03	1947-12-14	\N	\N	Bewdley
Ramsay MacDonald	M	1866-10-12	1937-11-09	\N	\N	Lossiemouth
Andrew Bonar Law	M	1858-09-16	1923-10-30	\N	\N	Rexton
David Lloyd George	M	1863-01-17	1945-03-26	\N	\N	Rexton
Herbert Henry Asquith	M	1852-09-12	1928-02-15	\N	\N	Morley
Henry Campbell-Bannerman	M	1836-09-07	1908-04-22	\N	\N	Glasgow
Arthur Balfour	M	1848-07-25	1930-03-19	\N	\N	Whittingehame
Lord Salisbury	M	1830-02-03	1903-08-22	\N	\N	Hatfield
William Ewart Gladstone	M	1809-12-29	1898-05-19	\N	\N	Liverpool
Benjamin Disraeli	M	1804-12-21	1881-04-19	\N	\N	London
Earl of Rosebery	M	1847-05-07	1929-05-21	\N	\N	London
\.


--
-- Data for Name: prime_minister; Type: TABLE DATA; Schema: public; Owner: pjm
--

COPY prime_minister (name, party, entry) FROM stdin;
David Cameron	Conservative	2010-05-11
Gordon Brown	Labour	2007-06-27
Tony Blair	Labour	1997-05-02
John Major	Conservative	1990-11-28
Margaret Thatcher	Conservative	1979-05-04
James Callaghan	Labour	1976-04-05
Harold Wilson	Labour	1974-03-04
Edward Heath	Conservative	1970-06-19
Harold Wilson	Labour	1964-10-16
Alec Douglas-Home	Conservative	1963-10-18
Harold Macmillan	Conservative	1957-01-10
Anthony Eden	Conservative	1955-04-07
Winston Churchill	Conservative	1951-10-26
Clement Attlee	Labour	1945-07-26
Winston Churchill	Conservative	1940-05-10
Neville Chamberlain	Conservative	1937-05-28
Stanley Baldwin	Conservative	1935-06-07
Stanley Baldwin	Conservative	1924-11-04
Stanley Baldwin	Conservative	1923-05-23
Ramsay MacDonald	Labour	1924-01-22
Ramsay MacDonald	Labour	1929-06-05
Andrew Bonar Law	Labour	1922-10-23
David Lloyd George	Liberal	1916-12-07
Herbert Henry Asquith	Conservative	1908-04-05
Henry Campbell-Bannerman	Liberal	1905-12-05
Arthur Balfour	Conservative	1902-07-11
Lord Salisbury	Conservative	1895-06-25
Earl of Rosebery	Liberal	1894-03-05
William Ewart Gladstone	Liberal	1892-08-15
Lord Salisbury	Conservative	1886-07-25
William Ewart Gladstone	Liberal	1886-02-01
Lord Salisbury	Conservative	1885-06-23
William Ewart Gladstone	Liberal	1880-04-23
Benjamin Disraeli	Conservative	1874-02-20
William Ewart Gladstone	Liberal	1868-12-03
Benjamin Disraeli	Conservative	1868-02-27
\.


--
-- Name: monarch_pkey; Type: CONSTRAINT; Schema: public; Owner: pjm
--

ALTER TABLE ONLY monarch
    ADD CONSTRAINT monarch_pkey PRIMARY KEY (name);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: pjm
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (name);


--
-- Name: prime_minister_pk; Type: CONSTRAINT; Schema: public; Owner: pjm
--

ALTER TABLE ONLY prime_minister
    ADD CONSTRAINT prime_minister_pk PRIMARY KEY (name, entry);


--
-- Name: monarch_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pjm
--

ALTER TABLE ONLY monarch
    ADD CONSTRAINT monarch_name_fkey FOREIGN KEY (name) REFERENCES person(name);


--
-- Name: person_father_fk; Type: FK CONSTRAINT; Schema: public; Owner: pjm
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_father_fk FOREIGN KEY (father) REFERENCES person(name);


--
-- Name: person_mother_fk; Type: FK CONSTRAINT; Schema: public; Owner: pjm
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_mother_fk FOREIGN KEY (mother) REFERENCES person(name);


--
-- Name: prime_minister_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pjm
--

ALTER TABLE ONLY prime_minister
    ADD CONSTRAINT prime_minister_name_fkey FOREIGN KEY (name) REFERENCES person(name);


--
-- Name: public; Type: ACL; Schema: -; Owner: pjm
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM pjm;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON SCHEMA public TO postgres;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON SCHEMA public TO tora;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT ALL ON SCHEMA public TO pjm;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION postgres;
GRANT USAGE ON SCHEMA public TO lab;
RESET SESSION AUTHORIZATION;


--
-- Name: monarch; Type: ACL; Schema: public; Owner: pjm
--

REVOKE ALL ON TABLE monarch FROM PUBLIC;
REVOKE ALL ON TABLE monarch FROM pjm;
GRANT ALL ON TABLE monarch TO pjm;
GRANT SELECT ON TABLE monarch TO PUBLIC;


--
-- Name: person; Type: ACL; Schema: public; Owner: pjm
--

REVOKE ALL ON TABLE person FROM PUBLIC;
REVOKE ALL ON TABLE person FROM pjm;
GRANT ALL ON TABLE person TO pjm;
GRANT SELECT ON TABLE person TO PUBLIC;


--
-- Name: prime_minister; Type: ACL; Schema: public; Owner: pjm
--

REVOKE ALL ON TABLE prime_minister FROM PUBLIC;
REVOKE ALL ON TABLE prime_minister FROM pjm;
GRANT ALL ON TABLE prime_minister TO pjm;
GRANT SELECT ON TABLE prime_minister TO PUBLIC;


--
-- PostgreSQL database dump complete
--

