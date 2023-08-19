*2017 NYCHVS Stata IMPORT PROGRAM

* cd "LOCATION OF TEXT FILES"

* OCCUPIED DATA FILE
clear
infix	recid	1	///
	boro	2	///
	uf1_1	4	///
	uf1_3	5	///
	uf1_4	6	///
	uf1_5	7	///
	uf1_6	8	///
	uf1_7	9	///
	uf1_8	10	///
	uf1_9	11	///
	uf1_10	12	///
	uf1_11	13	///
	uf1_12	14	///
	uf1_13	15	///
	uf1_14	16	///
	uf1_15	17	///
	uf1_16	18	///
	uf1_35	19	///
	uf1_17	20	///
	uf1_19	21	///
	uf1_20	22	///
	uf1_21	23	///
	uf1_22	24	///
	sc23	26	///
	sc24	27	///
	sc36	28	///
	sc37	29	///
	sc38	30	///
	hhr2	33	///
	hhr3t	34-35	///
	hhr5	36	///
	uf61	37-38	///
	uf2a_1	60	///
	uf79	61-62	///
	uf66	66-69	///
	sc54	70	///
	uf67	71-72	///
	sc111	73-74	///
	sc112	75-76	///
	sc113	77-78	///
	sc114	79	///
	sc115	80	///
	sc116	81	///
	sc117	82	///
	sc118	83	///
	sc120	88	///
	sc121	89	///
	uf5	98-104	///
	sc125	105	///
	uf6	106-112	///
	sc127	113	///
	uf68	120-123	///
	uf7a	124-127	///
	sc141	131	///
	sc144	132	///
	uf47	140-141	///
	sc147	142	///
	uf11	143-144	///
	sc149	147	///
	sc173	148	///
	sc171	149	///
	uf77	150-151	///
	uf78	152-153	///
	uf81	154	///
	uf82	155	///
	uf83	156	///
	sc157	158	///
	sc158	159	///
	sc159	160	///
	uf12	161-164	///
	sc161	165	///
	uf13	166-169	///
	uf14	170-173	///
	sc164	174	///
	uf15	175-178	///
	sc166	179	///
	uf16	180-184	///
	uf17	191-195	///
	sc181	196	///
	sc541	206	///
	uf107	207	///
	uf17a	223-227	///
	sc185	228	///
	sc186	229	///
	sc197	230	///
	sc187	236	///
	sc188	237	///
	sc571	238	///
	sc189	239	///
	sc190	240	///
	sc191	241	///
	sc192	242	///
	sc193	243	///
	sc194	244	///
	sc196	245	///
	uf108	246	///
	sc575	256	///
	uf72	257	///
	sc574	259	///
	sc198	260	///
	sc647	261	///
	sc648	262	///
	sc649	263	///
	sc650	264	///
	sc651	265	///
	sc131	266	///
	sc132	267	///
	sc136	268	///
	sc137	269	///
	sc138	270	///
	sc168	271	///
	sc169	272	///
	sc183	273	///
	sc560	274	///
	uf53	275-278	///
	uf54	279-282	///
	uf_csr	412-413	///
	uf74	414-415	///
	uf76	416-417	///
	uf23	419-420	///
	rec21	421	///
	uf71	422	///
	rec1	424-425	///
	uf46	426	///
	uf69	427	///
	uf60	428	///
	uf105	429-434	///
	rec54	438	///
	rec53	439	///
	tot_per	440-441	///
	cppr	442-444	///
	uf26	445-449	///
	uf28	450-453	///
	uf27	454-457	///
	rec39	458	///
	uf42	459-465	///
	uf42a	466	///
	uf34	467-473	///
	uf34a	474	///
	uf35	475-481	///
	uf35a	482	///
	uf36	483-489	///
	uf36a	490	///
	uf37	491-497	///
	uf37a	498	///
	uf38	499-505	///
	uf38a	506	///
	uf39	507-513	///
	uf39a	514	///
	uf40	515-521	///
	uf40a	522	///
	cd	526-527	///
	uf30	528-531	///
	uf29	532-535	///
	uf75	536	///
	rec7	537	///
	fw	538-546	///
	chufw	547-555	///
	seqno	556-561	///
	flg_sx1	571	///
	flg_ag1	572	///
	flg_hs1	573	///
	flg_rc1	574	///
	hflag2	575	///
	hflag1	576	///
	hflag13	577	///
	hflag6	578	///
	hflag3	579	///
	hflag14	580	///
	hflag16	581	///
	hflag7	582	///
	hflag9	583	///
	hflag10	584	///
	hflag91	585	///
	hflag11	586	///
	hflag12	587	///
	hflag4	588	///
	hflag18	589	///
	uf52h_h	591	///
	uf52h_a	592	///
	uf52h_b	593	///
	uf52h_c	594	///
	uf52h_d	595	///
	uf52h_e	596	///
	uf52h_f	597	///
	uf52h_g	598	///
	fw1	599-607	///
	fw2	608-616	///
	fw3	617-625	///
	fw4	626-634	///
	fw5	635-643	///
	fw6	644-652	///
	fw7	653-661	///
	fw8	662-670	///
	fw9	671-679	///
	fw10	680-688	///
	fw11	689-697	///
	fw12	698-706	///
	fw13	707-715	///
	fw14	716-724	///
	fw15	725-733	///
	fw16	734-742	///
	fw17	743-751	///
	fw18	752-760	///
	fw19	761-769	///
	fw20	770-778	///
	fw21	779-787	///
	fw22	788-796	///
	fw23	797-805	///
	fw24	806-814	///
	fw25	815-823	///
	fw26	824-832	///
	fw27	833-841	///
	fw28	842-850	///
	fw29	851-859	///
	fw30	860-868	///
	fw31	869-877	///
	fw32	878-886	///
	fw33	887-895	///
	fw34	896-904	///
	fw35	905-913	///
	fw36	914-922	///
	fw37	923-931	///
	fw38	932-940	///
	fw39	941-949	///
	fw40	950-958	///
	fw41	959-967	///
	fw42	968-976	///
	fw43	977-985	///
	fw44	986-994	///
	fw45	995-1003	///
	fw46	1004-1012	///
	fw47	1013-1021	///
	fw48	1022-1030	///
	fw49	1031-1039	///
	fw50	1040-1048	///
	fw51	1049-1057	///
	fw52	1058-1066	///
	fw53	1067-1075	///
	fw54	1076-1084	///
	fw55	1085-1093	///
	fw56	1094-1102	///
	fw57	1103-1111	///
	fw58	1112-1120	///
	fw59	1121-1129	///
	fw60	1130-1138	///
	fw61	1139-1147	///
	fw62	1148-1156	///
	fw63	1157-1165	///
	fw64	1166-1174	///
	fw65	1175-1183	///
	fw66	1184-1192	///
	fw67	1193-1201	///
	fw68	1202-1210	///
	fw69	1211-1219	///
	fw70	1220-1228	///
	fw71	1229-1237	///
	fw72	1238-1246	///
	fw73	1247-1255	///
	fw74	1256-1264	///
	fw75	1265-1273	///
	fw76	1274-1282	///
	fw77	1283-1291	///
	fw78	1292-1300	///
	fw79	1301-1309	///
	fw80	1310-1318	///
	il30per	1319-1323	///
	il50per	1324-1328	///
	il80per	1329-1333	///
using "uf_17_occ_web_b.txt"

label variable recid "Record Type"
label variable boro "Borough"
label variable uf1_1 "External Walls--Missing brick and sloping walls"
label variable uf1_3 "External Walls--Major cracks in walls"
label variable uf1_4 "External Walls--Loose or hanging cornice"
label variable uf1_5 "External Walls--No problems"
label variable uf1_6 "External Walls--Unable to observe"
label variable uf1_7 "Condition of Windows--Broken/missing"
label variable uf1_8 "Condition of Windows--Rotten/loose"
label variable uf1_9 "Condition of Windows--Boarded-up"
label variable uf1_10 "Condition of Windows--No problems"
label variable uf1_11 "Condition of Windows--Unable to observe"
label variable uf1_12 "Condition of Stairways--Loose/broken railings"
label variable uf1_13 "Condition of Stairways--Loose/broken steps"
label variable uf1_14 "Condition of Stairways--No problems"
label variable uf1_15 "Condition of Stairways--No interior steps"
label variable uf1_16 "Condition of Stairways--No exterior steps"
label variable uf1_35 "Condition of Stairways--Unable to observe"
label variable uf1_17 "Condition of Floors--Sagging/sloping and slanted doors"
label variable uf1_19 "Condition of Floors--Deep wear"
label variable uf1_20 "Condition of Floors--Holes/missing flooring"
label variable uf1_21 "Condition of Floors--None of these problems"
label variable uf1_22 "Condition of Floors--Unable to observe"
label variable sc23 "Condition of building"
label variable sc24 "Broken/Boarded Windows--observation"
label variable sc36 "Wheelchair accessibility--Street entry"
label variable sc37 "Wheelchair accessibility--Elevator"
label variable sc38 "Wheelchair accessibility--Unit entrance"
label variable hhr2 "Sex of householder"
label variable hhr3t "Age of householder"
label variable hhr5 "Hispanic origin"
label variable uf61 "Race of householder"
label variable uf2a_1 "Number of persons from temporary residence"
label variable uf79 "Most recent place lived"
label variable uf66 "Year Householder Moved into Unit Recode"
label variable sc54 "First occupants of unit"
label variable uf67 "Reason for moving"
label variable sc111 "Place of birth-householder"
label variable sc112 "Place of birth-father"
label variable sc113 "Place of birth-mother"
label variable sc114 "Coop/condo status"
label variable sc115 "Tenure(1)"
label variable sc116 "Tenure(2)"
label variable sc117 "Lived in unit at time of coop/condo conversion"
label variable sc118 "Coop/condo conv. through a non-eviction plan"
label variable sc120 "Occupancy status before acquisition"
label variable sc121 "Condo/Coop before acquisition"
label variable uf5 "Down payment(1)"
label variable sc125 "Down payment(2)"
label variable uf6 "Value"
label variable sc127 "Mortgage status"
label variable uf68 "When Did Most Recent Mortgage Originate"
label variable uf7a "Current Interest Rate"
label variable sc141 "Fire and liability insurance paid separately"
label variable sc144 "Real estate taxes paid separately"
label variable uf47 "Units in building"
label variable sc147 "Owner in building"
label variable uf11 "Stories in building" 
label variable sc149 "Elevator in building"
label variable sc173 "Sidewalk to elevator"
label variable sc171 "Sidewalk to unit"
label variable uf77 "Number of rooms"
label variable uf78 "Number of bedrooms"
label variable uf81 "Complete plumbing facilities"
label variable uf82 "Toilet breakdown"
label variable uf83 "Complete kitchen facilities"
label variable sc157 "Kitchen facilities functioning"
label variable sc158 "Type of heating fuel"
label variable sc159 "Electricity-paid separately"
label variable uf12 "Monthly electricity cost"
label variable sc161 "Gas-paid separately"
label variable uf13 "Monthly gas cost"
label variable uf14 "Combined gas/electricity"
label variable sc164 "Water and sewer-paid separately"
label variable uf15 "Yearly water and sewer cost"
label variable sc166 "Other fuels-paid separately"
label variable uf16 "Yearly cost for other fuels"
label variable uf17 "Contract rent"
label variable sc181 "Length of lease"
label variable sc541 "Federal section 8" 
label variable uf107 "Other rental subsidy" 
label variable uf17a "Out of pocket rent"
label variable sc185 "Heating equipment breakdown"
label variable sc186 "Number of heating breakdowns"
label variable sc197 "Functioning Air Conditioning"
label variable sc187 "Additional sources of heat"
label variable sc188 "Presence of mice and rates"
label variable sc571 "Number of Cockroaches"
label variable sc189 "Exterminator service"
label variable sc190 "Cracks/holes in interior walls"
label variable sc191 "Holes in floors"
label variable sc192 "Broken plaster/peeling paint"
label variable sc193 "Plaster/paint> 8.5 x 11"
label variable sc194 "Water leakage"
label variable sc196 "Respondent rating of structures in neighborhood" 
label variable uf108 "Receipt of public assistance or welfare payments" 
label variable sc575 "Land-line Telephone in House"
label variable uf72 "Number of Adults with a cell phone"
label variable sc574 "General Health (respondent)"
label variable sc198 "Medical device in home"
label variable sc647 "Dental"
label variable sc648 "Preventative care/check-up"
label variable sc649 "Mental health"
label variable sc650 "Treatment or diagnosis of illness"
label variable sc651 "Prescription drugs"
label variable sc131 "One or more utility"
label variable sc132 "Landline telephone"
label variable sc136 "Cell phone"
label variable sc137 "Cable/internet"
label variable sc138 "Other"
label variable sc168 "Affordable"
label variable sc169 "Too expensive given its condition"
label variable sc183 "Too expensive given its location"
label variable sc560 "Moved to the US as immigrant"
label variable uf53 "Year moved to US as immigrant"
label variable uf54 "Year moved to NYC"
label variable uf_csr "New control status recode"
label variable uf74 "Structure class recode"
label variable uf76 "Type of schedule code"
label variable uf23 "Year built recode"
label variable rec21 "Condition of unit recode"
label variable uf71 "Respondent line number"
label variable rec1 "Household composition recode"
label variable uf46 "Presence of nonrelatives"
label variable uf69 "Race and Ethnicity of householder"
label variable uf60 "Race Recode 1"
label variable uf105 "Monthly owner cost recode"
label variable rec54 "Number of 1987 maintenance deficiencies"
label variable rec53 "Number of 2017 maintenance deficiencies"
label variable tot_per "Total persons recode"
label variable cppr "Persons per room"
label variable uf26 "Monthly gross rent"
label variable uf28 "Monthly gross rent per room recode"
label variable uf27 "Monthly contract rent per room recode"
label variable rec39 "Household below poverty"
label variable uf42 "Household income recode"
label variable uf42a "Household income flag"
label variable uf34 "Salary"
label variable uf34a "Salary flag"
label variable uf35 "Business income"
label variable uf35a "Business income flag"
label variable uf36 "Interest income"
label variable uf36a "Interest income flag"
label variable uf37 "Retirement income (1)"
label variable uf37a "Retirement income (1) flag"
label variable uf38 "Retirement income (2)"
label variable uf38a "Retirement income (2) flag"
label variable uf39 "Government income"
label variable uf39a "Government income flag"
label variable uf40 "Other income"
label variable uf40a "Other income flag"
label variable cd "Sub-borough area"
label variable uf30 "Gross rent/income ratio"
label variable uf29 "Contract rent/income ratio"
label variable uf75 "Household members under 6"
label variable rec7 "Household members under 18"
label variable fw "Household weight"
label variable chufw "Final household weight"
label variable seqno "Sequence number"
label variable flg_sx1 "Sex of householder"
label variable flg_ag1 "Age of householder"
label variable flg_hs1 "Hispanic Origin"
label variable flg_rc1 "Race of householder"
label variable hflag2 "Year moved in flag"
label variable hflag1 "Year acquired flag"
label variable hflag13 "Value flag"
label variable hflag6 "Stories in building flag"
label variable hflag3 "Rooms/Bedrooms flag"
label variable hflag14 "Plumbing facilities flag"
label variable hflag16 "Kitchen facilities flag"
label variable hflag7 "Type of heating fuel flag"
label variable hflag9 "Electricity cost flag"
label variable hflag10 "Gas cost flag"
label variable hflag91 "Combined gas/electricity cost flag"
label variable hflag11 "Water and sewer cost flag"
label variable hflag12 "Other fuels cost flag"
label variable hflag4 "Contract rent flag"
label variable hflag18 "Rental assistance flag"
label variable uf52h_h "Household income flag"
label variable uf52h_a "Salary income flag"
label variable uf52h_b "Business income flag"
label variable uf52h_c "Interest income flag"
label variable uf52h_d "Retirement income(1) flag"
label variable uf52h_e "Government income flag"
label variable uf52h_f "Retirement income(2) flag"
label variable uf52h_g "Other income flag"
label variable fw1 "Replicate Weight #1" 
label variable fw2 "Replicate Weight #2"
label variable fw3 "Replicate Weight #3"
label variable fw4 "Replicate Weight #4"
label variable fw5 "Replicate Weight #5"
label variable fw6 "Replicate Weight #6"
label variable fw7 "Replicate Weight #7"
label variable fw8 "Replicate Weight #8"
label variable fw9 "Replicate Weight #9"
label variable fw10 "Replicate Weight #10"
label variable fw11 "Replicate Weight #11"
label variable fw12 "Replicate Weight #12"
label variable fw13 "Replicate Weight #13"
label variable fw14 "Replicate Weight #14"
label variable fw15 "Replicate Weight #15"
label variable fw16 "Replicate Weight #16"
label variable fw17 "Replicate Weight #17"
label variable fw18 "Replicate Weight #18"
label variable fw19 "Replicate Weight #19"
label variable fw20 "Replicate Weight #20"
label variable fw21 "Replicate Weight #21"
label variable fw22 "Replicate Weight #22"
label variable fw23 "Replicate Weight #23"
label variable fw24 "Replicate Weight #24"
label variable fw25 "Replicate Weight #25"
label variable fw26 "Replicate Weight #26"
label variable fw27 "Replicate Weight #27"
label variable fw28 "Replicate Weight #28"
label variable fw29 "Replicate Weight #29"
label variable fw30 "Replicate Weight #30"
label variable fw31 "Replicate Weight #31"
label variable fw32 "Replicate Weight #32"
label variable fw33 "Replicate Weight #33"
label variable fw34 "Replicate Weight #34"
label variable fw35 "Replicate Weight #35"
label variable fw36 "Replicate Weight #36"
label variable fw37 "Replicate Weight #37"
label variable fw38 "Replicate Weight #38"
label variable fw39 "Replicate Weight #39"
label variable fw40 "Replicate Weight #40"
label variable fw41 "Replicate Weight #41"
label variable fw42 "Replicate Weight #42"
label variable fw43 "Replicate Weight #43"
label variable fw44 "Replicate Weight #44"
label variable fw45 "Replicate Weight #45"
label variable fw46 "Replicate Weight #46"
label variable fw47 "Replicate Weight #47"
label variable fw48 "Replicate Weight #48"
label variable fw49 "Replicate Weight #49"
label variable fw50 "Replicate Weight #50"
label variable fw51 "Replicate Weight #51"
label variable fw52 "Replicate Weight #52"
label variable fw53 "Replicate Weight #53"
label variable fw54 "Replicate Weight #54"
label variable fw55 "Replicate Weight #55"
label variable fw56 "Replicate Weight #56"
label variable fw57 "Replicate Weight #57"
label variable fw58 "Replicate Weight #58"
label variable fw59 "Replicate Weight #59"
label variable fw60 "Replicate Weight #60"
label variable fw61 "Replicate Weight #61"
label variable fw62 "Replicate Weight #62"
label variable fw63 "Replicate Weight #63"
label variable fw64 "Replicate Weight #64"
label variable fw65 "Replicate Weight #65"
label variable fw66 "Replicate Weight #66"
label variable fw67 "Replicate Weight #67"
label variable fw68 "Replicate Weight #68"
label variable fw69 "Replicate Weight #69"
label variable fw70 "Replicate Weight #70"
label variable fw71 "Replicate Weight #71"
label variable fw72 "Replicate Weight #72"
label variable fw73 "Replicate Weight #73"
label variable fw74 "Replicate Weight #74"
label variable fw75 "Replicate Weight #75"
label variable fw76 "Replicate Weight #76"
label variable fw77 "Replicate Weight #77"
label variable fw78 "Replicate Weight #78"
label variable fw79 "Replicate Weight #79"
label variable fw80 "Replicate Weight #80"
label variable il30per "30% HUD Income Limits"
label variable il50per "50% HUD Income Limits"
label variable il80per "80% HUD Income Limits"

save hvs_17_occ.dta, replace

* PERSON DATA FILE
clear
infix	recid	1	///
	boro	2	///
	person	3-4	///
	sex	5	///
	uf43	6-7	///
	uf92	8-9	///
	hspanic	10	///
	uf62	11-12	///
	uf86	33-34	///
	uf87	35-36	///
	uf88	37-38	///
	uf3	39	///
	item40a	40	///
	uf95	41-42	///
	item41	43	///
	item42	44	///
	uf89	45-46	///
	item44	47	///
	item45c	48	///
	uf90	57	///
	item48a	58-59	///
	uf96	60-61	///
	uf18	63-69	///
	uf18a	70-76	///
	uf18b	77-83	///
	uf18c	84-90	///
	uf18d	91-97	///
	uf18e	98-104	///
	uf18f	105-111	///
	item50a	113	///
	eductn	114-115	///
	uf55	116-119	///
	uf41	121-127	///
	uf41a	128	///
	uf44	129	///
	uf45	130	///
	uf59	131	///
	chk_g	132	///
	uf70	133	///
	uf60	134	///
	pw	137-145	///
	seqno	146-151	///
	cd	152-153	///
	flg_sx	154	///
	flg_ag	155	///
	flg_hs	156	///
	flg_rc	157	///
	a1a40a	158	///
	a1a40b	159	///
	a1a41	160	///
	a1a42	161	///
	a1a43	162	///
	a1b44	163	///
	a1b45c	164	///
	a1b46a	165	///
	a1b46b	166	///
	a1b47	167	///
	a1b48a	168	///
	a1b48b	169	///
	a2salary	170	///
	a2businc	171	///
	aintinc	172	///
	aret1inc	173	///
	agovtinc	174	///
	aret2inc	175	///
	aothinc	176	///
	flg_educ	177	///
	pw1	178-186	///
	pw2	187-195	///
	pw3	196-204	///
	pw4	205-213	///
	pw5	214-222	///
	pw6	223-231	///
	pw7	232-240	///
	pw8	241-249	///
	pw9	250-258	///
	pw10	259-267	///
	pw11	268-276	///
	pw12	277-285	///
	pw13	286-294	///
	pw14	295-303	///
	pw15	304-312	///
	pw16	313-321	///
	pw17	322-330	///
	pw18	331-339	///
	pw19	340-348	///
	pw20	349-357	///
	pw21	358-366	///
	pw22	367-375	///
	pw23	376-384	///
	pw24	385-393	///
	pw25	394-402	///
	pw26	403-411	///
	pw27	412-420	///
	pw28	421-429	///
	pw29	430-438	///
	pw30	439-447	///
	pw31	448-456	///
	pw32	457-465	///
	pw33	466-474	///
	pw34	475-483	///
	pw35	484-492	///
	pw36	493-501	///
	pw37	502-510	///
	pw38	511-519	///
	pw39	520-528	///
	pw40	529-537	///
	pw41	538-546	///
	pw42	547-555	///
	pw43	556-564	///
	pw44	565-573	///
	pw45	574-582	///
	pw46	583-591	///
	pw47	592-600	///
	pw48	601-609	///
	pw49	610-618	///
	pw50	619-627	///
	pw51	628-636	///
	pw52	637-645	///
	pw53	646-654	///
	pw54	655-663	///
	pw55	664-672	///
	pw56	673-681	///
	pw57	682-690	///
	pw58	691-699	///
	pw59	700-708	///
	pw60	709-717	///
	pw61	718-726	///
	pw62	727-735	///
	pw63	736-744	///
	pw64	745-753	///
	pw65	754-762	///
	pw66	763-771	///
	pw67	772-780	///
	pw68	781-789	///
	pw69	790-798	///
	pw70	799-807	///
	pw71	808-816	///
	pw72	817-825	///
	pw73	826-834	///
	pw74	835-843	///
	pw75	844-852	///
	pw76	853-861	///
	pw77	862-870	///
	pw78	871-879	///
	pw79	880-888	///
	pw80	889-897	///
using "uf_17_pers_web_b.txt"
save hvs_17_pers.dta, replace

/* VACANT DATA FILE
clear
infix	recid	1	///
	boro	2	///
	uf1_1	4	///
	uf1_3	5	///
	uf1_4	6	///
	uf1_5	7	///
	uf1_6	8	///
	uf1_7	9	///
	uf1_8	10	///
	uf1_9	11	///
	uf1_10	12	///
	uf1_11	13	///
	uf1_12	14	///
	uf1_13	15	///
	uf1_14	16	///
	uf1_15	17	///
	uf1_16	18	///
	uf1_35	19	///
	uf1_17	20	///
	uf1_19	21	///
	uf1_20	22	///
	uf1_21	23	///
	uf1_22	24	///
	sc23	26	///
	sc24	27	///
	sc36	28	///
	sc37	29	///
	sc38	30	///
	sc30	31	///
	sc518	32	///
	uf47	33-34	///
	sc520	35	///
	uf33	36-37	///
	sc522	40	///
	sc553	41	///
	sc555	42	///
	uf77	43-44	///
	uf78	45-46	///
	uf81	47	///
	uf83	48	///
	sc529	49	///
	sc530	50	///
	sc531	51	///
	sc532	52	///
	sc533	53	///
	sc534	54	///
	uf80	55-56	///
	uf31	57-61	///
	uf_csr	68-69	///
	uf74	70-71	///
	uf76	72-73	///
	uf23	74-75	///
	uf32	76-79	///
	rec21	80	///
	cd	81-82	///
	seqno	83-88	///
	fw	89-97	///
	hflag6	98	///
	hflag3	99	///
	hflag15	100	///
	hflag17	101	///
	hflag8	102	///
	hflag5	103	///
	fw1	104-112	///
	fw2	113-121	///
	fw3	122-130	///
	fw4	131-139	///
	fw5	140-148	///
	fw6	149-157	///
	fw7	158-166	///
	fw8	167-175	///
	fw9	176-184	///
	fw10	185-193	///
	fw11	194-202	///
	fw12	203-211	///
	fw13	212-220	///
	fw14	221-229	///
	fw15	230-238	///
	fw16	239-247	///
	fw17	248-256	///
	fw18	257-265	///
	fw19	266-274	///
	fw20	275-283	///
	fw21	284-292	///
	fw22	293-301	///
	fw23	302-310	///
	fw24	311-319	///
	fw25	320-328	///
	fw26	329-337	///
	fw27	338-346	///
	fw28	347-355	///
	fw29	356-364	///
	fw30	365-373	///
	fw31	374-382	///
	fw32	383-391	///
	fw33	392-400	///
	fw34	401-409	///
	fw35	410-418	///
	fw36	419-427	///
	fw37	428-436	///
	fw38	437-445	///
	fw39	446-454	///
	fw40	455-463	///
	fw41	464-472	///
	fw42	473-481	///
	fw43	482-490	///
	fw44	491-499	///
	fw45	500-508	///
	fw46	509-517	///
	fw47	518-526	///
	fw48	527-535	///
	fw49	536-544	///
	fw50	545-553	///
	fw51	554-562	///
	fw52	563-571	///
	fw53	572-580	///
	fw54	581-589	///
	fw55	590-598	///
	fw56	599-607	///
	fw57	608-616	///
	fw58	617-625	///
	fw59	626-634	///
	fw60	635-643	///
	fw61	644-652	///
	fw62	653-661	///
	fw63	662-670	///
	fw64	671-679	///
	fw65	680-688	///
	fw66	689-697	///
	fw67	698-706	///
	fw68	707-715	///
	fw69	716-724	///
	fw70	725-733	///
	fw71	734-742	///
	fw72	743-751	///
	fw73	752-760	///
	fw74	761-769	///
	fw75	770-778	///
	fw76	779-787	///
	fw77	788-796	///
	fw78	797-805	///
	fw79	806-814	///
	fw80	815-823	///
using "uf_17_vac_web_b.txt"

label variable recid "Record Type"
label variable boro "Borough"
label variable uf1_1 "External Walls--Missing brick and sloping walls"
label variable uf1_3 "External Walls--Major cracks in walls"
label variable uf1_4 "External Walls--Loose or hanging cornice"
label variable uf1_5 "External Walls--No problems"
label variable uf1_6 "External Walls--Unable to observe"
label variable uf1_7 "Condition of Windows--Broken/missing"
label variable uf1_8 "Condition of Windows--Rotten/loose"
label variable uf1_9 "Condition of Windows--Boarded-up"
label variable uf1_10 "Condition of Windows--No problems"
label variable uf1_11 "Condition of Windows--Unable to observe"
label variable uf1_12 "Condition of Stairways--Loose/broken railings"
label variable uf1_13 "Condition of Stairways--Loose/broken steps"
label variable uf1_14 "Condition of Stairways--No problems"
label variable uf1_15 "Condition of Stairways--No interior steps"
label variable uf1_16 "Condition of Stairways--No exterior steps"
label variable uf1_35 "Condition of Stairways--Unable to observe"
label variable uf1_17 "Condition of Floors--Sagging/sloping and slanted doors"
label variable uf1_19 "Condition of Floors--Deep wear"
label variable uf1_20 "Condition of Floors--Holes/missing flooring"
label variable uf1_21 "Condition of Floors--None of these problems"
label variable uf1_22 "Condition of Floors--Unable to observe"
label variable sc23 "Condition of building"
label variable sc24 "Broken/Boarded Windows--observation"
label variable sc36 "Wheelchair accessibility--Street entry"
label variable sc37 "Wheelchair accessibility--Elevator"
label variable sc38 "Wheelchair accessibility--Unit entrance"
label variable sc30 "Vacant unit respondent"
label variable sc518 "First occupancy"
label variable uf47 "Number of units in building"
label variable sc520 "Owner in building"
label variable uf33 "Stories in building" 
label variable sc522 "Elevator in building"
label variable sc553 "Sidewalk to elevator"
label variable sc555 "Sidewalk to unit"
label variable uf77 "Number of Rooms"
label variable uf78 "Number of Bedrooms"
label variable uf81 "Complete plumbing facilities"
label variable uf83 "Kitchen facilities"
label variable sc529 "Type of Heating Fuel"
label variable sc530 "Condo/Coop Status"
label variable sc531 "Duration of Vacancy"
label variable sc532 "Status Prior to Vacancy"
label variable sc533 "Condo/Coop Status Before Vacancy"
label variable sc534 "Status of Vacant Unit"
label variable uf80 "Reason Unit Not Available for Rent/Sale"
label variable uf31 "Monthly Asking Rent"
label variable uf_csr "New Control Status Recode"
label variable uf74 "Structure Class Recode"
label variable uf76 "Type of Schedule"
label variable uf23 "Year Built Recode"
label variable uf32 "Rent per Room Recode"
label variable rec21 "Condition of Building"
label variable cd "Sub-borough Area"
label variable seqno "Sequence Number"
label variable fw "Final Housing Unit Weight"
label variable hflag6 "Stories in building flag"
label variable hflag3 "Rooms/Bedrooms flag"
label variable hflag15 "Complete plumbing facilities flag"
label variable hflag17 "Complete kitchen facilities flag"
label variable hflag8 "Type of heating fuel flag"
label variable hflag5 "Monthly asking rent flag"
label variable fw1 "Replicate Weight #1"
label variable fw2 "Replicate Weight #2"
label variable fw3 "Replicate Weight #3"
label variable fw4 "Replicate Weight #4"
label variable fw5 "Replicate Weight #5"
label variable fw6 "Replicate Weight #6"
label variable fw7 "Replicate Weight #7"
label variable fw8 "Replicate Weight #8"
label variable fw9 "Replicate Weight #9"
label variable fw10 "Replicate Weight #10"
label variable fw11 "Replicate Weight #11"
label variable fw12 "Replicate Weight #12"
label variable fw13 "Replicate Weight #13"
label variable fw14 "Replicate Weight #14"
label variable fw15 "Replicate Weight #15"
label variable fw16 "Replicate Weight #16"
label variable fw17 "Replicate Weight #17"
label variable fw18 "Replicate Weight #18"
label variable fw19 "Replicate Weight #19"
label variable fw20 "Replicate Weight #20"
label variable fw21 "Replicate Weight #21"
label variable fw22 "Replicate Weight #22"
label variable fw23 "Replicate Weight #23"
label variable fw24 "Replicate Weight #24"
label variable fw25 "Replicate Weight #25"
label variable fw26 "Replicate Weight #26"
label variable fw27 "Replicate Weight #27"
label variable fw28 "Replicate Weight #28"
label variable fw29 "Replicate Weight #29"
label variable fw30 "Replicate Weight #30"
label variable fw31 "Replicate Weight #31"
label variable fw32 "Replicate Weight #32"
label variable fw33 "Replicate Weight #33"
label variable fw34 "Replicate Weight #34"
label variable fw35 "Replicate Weight #35"
label variable fw36 "Replicate Weight #36"
label variable fw37 "Replicate Weight #37"
label variable fw38 "Replicate Weight #38"
label variable fw39 "Replicate Weight #39"
label variable fw40 "Replicate Weight #40"
label variable fw41 "Replicate Weight #41"
label variable fw42 "Replicate Weight #42"
label variable fw43 "Replicate Weight #43"
label variable fw44 "Replicate Weight #44"
label variable fw45 "Replicate Weight #45"
label variable fw46 "Replicate Weight #46"
label variable fw47 "Replicate Weight #47"
label variable fw48 "Replicate Weight #48"
label variable fw49 "Replicate Weight #49"
label variable fw50 "Replicate Weight #50"
label variable fw51 "Replicate Weight #51"
label variable fw52 "Replicate Weight #52"
label variable fw53 "Replicate Weight #53"
label variable fw54 "Replicate Weight #54"
label variable fw55 "Replicate Weight #55"
label variable fw56 "Replicate Weight #56"
label variable fw57 "Replicate Weight #57"
label variable fw58 "Replicate Weight #58"
label variable fw59 "Replicate Weight #59"
label variable fw60 "Replicate Weight #60"
label variable fw61 "Replicate Weight #61"
label variable fw62 "Replicate Weight #62"
label variable fw63 "Replicate Weight #63"
label variable fw64 "Replicate Weight #64"
label variable fw65 "Replicate Weight #65"
label variable fw66 "Replicate Weight #66"
label variable fw67 "Replicate Weight #67"
label variable fw68 "Replicate Weight #68"
label variable fw69 "Replicate Weight #69"
label variable fw70 "Replicate Weight #70"
label variable fw71 "Replicate Weight #71"
label variable fw72 "Replicate Weight #72"
label variable fw73 "Replicate Weight #73"
label variable fw74 "Replicate Weight #74"
label variable fw75 "Replicate Weight #75"
label variable fw76 "Replicate Weight #76"
label variable fw77 "Replicate Weight #77"
label variable fw78 "Replicate Weight #78"
label variable fw79 "Replicate Weight #79"
label variable fw80 "Replicate Weight #80"

save hvs_17_occ.dta, replace

