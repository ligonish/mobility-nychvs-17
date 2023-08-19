*2017 NYCHVS Stata IMPORT PROGRAM: Vacant Files

* VACANT DATA FILE
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

save hvs_17_vac.dta, replace

