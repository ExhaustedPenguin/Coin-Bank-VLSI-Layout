**Parameter (if needed)**


**I/O signal**
* input: M3 M2 M1 M0 Store Power Clk VDD VSS
* output: State1 State0 S3 S2 S1 S0 Mo3 Mo2 Mo1 Mo0 Init3 Init2 Init1 Init0

**Main circuit**
**Don't modify the circuit name or the ordering of signal**
.subckt Coin_bank State1 State0 S3 S2 S1 S0 Mo3 Mo2 Mo1 Mo0 Init3 Init2 Init1 Init0 M3 M2 M1 M0 Store Power Clk VDD VSS

******* FSM *********
Xfsm Power Store State1 State0 State1n State0n Next_State1 Next_State0 VDD VSS FSM

******* DFF_State *********
Xdff1 Clk Next_State1 State1 State1n VDD VSS DFF
Xdff2 Clk Next_State0 State0 State0n VDD VSS DFF

******* Decoder *********
Xdecode1 State1 State0 S3 S2 S1 S0 VDD VSS DECODE

******* Combinational before money_in DFF  *********
Xnand2 S1 Store if VDD VSS NAND2
Xnot3 if iff VDD VSS NOT 
Xmux211 VSS M3 iff Mdff3 VDD VSS MUX21
Xmux212 VSS M2 iff Mdff2 VDD VSS MUX21
Xmux213 VSS M1 iff Mdff1 VDD VSS MUX21
Xmux214 VSS M0 iff Mdff0 VDD VSS MUX21

******* DFF_MoneyIn *********
Xdff3 Clk Mdff3 Min3 Min3n VDD VSS DFF
Xdff4 Clk Mdff2 Min2 Min2n VDD VSS DFF
Xdff5 Clk Mdff1 Min1 Min1n VDD VSS DFF
Xdff6 Clk Mdff0 Min0 Min0n VDD VSS DFF

******* Adder *********
Xadd41 Min3 Min2 Min1 Min0 Init3 Init2 Init1 Init0 VSS Msum3 Msum2 Msum1 Msum0 Cout VDD VSS AADD4

******* DFF_MoneyDFF *********
Xdff7 Clk Msum3 Init3 Init3n VDD VSS DFF
Xdff8 Clk Msum2 Init2 Init2n VDD VSS DFF
Xdff9 Clk Msum1 Init1 Init1n VDD VSS DFF
Xdff10 Clk Msum0 Init0 Init0n VDD VSS DFF

******* Showing information  *********
Xmux411 VSS VSS Min3 Init3 State1 State0 Mo3 VDD VSS MUX41
Xmux412 VSS VSS Min2 Init2 State1 State0 Mo2 VDD VSS MUX41
Xmux413 VSS VSS Min1 Init1 State1 State0 Mo1 VDD VSS MUX41
Xmux414 VSS VSS Min0 Init0 State1 State0 Mo0 VDD VSS MUX41
.ends Coin_bank






**Subcircuit (if needed)**

.subckt FSM Power Store State1 State0 State1n State0n Next_State1 Next_State0 VDD VSS
Xnot1 Power Powern VDD VSS NOT
Xnot2 Store Storen VDD VSS NOT

Xnand41 State1n State0 Power Store w1 VDD VSS NAND4
Xnand31 State1 State0n Power w2 VDD VSS NAND3
Xnand1 w1 w2 Next_State1 VDD VSS NAND2

Xnor31 State0n Storen State1 w3 VDD VSS NOR3
Xnor1 Powern w3 Next_State0 VDD VSS NOR2
.ends



.subckt AADD4 A3 A2 A1 A0 B3 B2 B1 B0 C S3 S2 S1 S0 COUT VDD VSS
Xadd1 A0 B0 C S0 C0 VDD VSS ADDD1
Xadd2 A1 B1 C0 S1 C1 VDD VSS ADDD1
Xadd3 A2 B2 C1 S2 C2 VDD VSS ADDD1
Xadd4 A3 B3 C2 S3 COUT VDD VSS ADDD1
.ends

.subckt ADDD1 A B C SUM COUT VDD VSS
Xnand1 A B w1 VDD VSS NAND2
Xnand2 A w1 w2 VDD VSS NAND2
Xnand3 B w1 w3 VDD VSS NAND2
Xnand4 w2 w3 w4 VDD VSS NAND2
Xnand5 w4 C w5 VDD VSS NAND2
Xnand6 w4 w5 w6 VDD VSS NAND2
Xnand7 w5 C w7 VDD VSS NAND2
Xnand8 w6 w7 SUM VDD VSS NAND2
Xnand9 w5 w1 COUT VDD VSS NAND2
.ends

.subckt DECODE A B D3 D2 D1 D0 VDD VSS
Xnot1 A An VDD VSS NOT
Xnot2 B Bn VDD VSS NOT

Xnand1 An Bn D0n VDD VSS NAND2
Xnand2 An B D1n VDD VSS NAND2
Xnand3 A Bn D2n VDD VSS NAND2
Xnand4 A B D3n VDD VSS NAND2

Xnot3 D0n D0 VDD VSS NOT
Xnot4 D1n D1 VDD VSS NOT
Xnot5 D2n D2 VDD VSS NOT
Xnot6 D3n D3 VDD VSS NOT
.ends

.subckt DFF Clk D Q Q_ VDD VSS
Mp1 Q_ w1 VDD VDD p_18 w=8.3u l=0.18u
Mp2 w2 D VDD VDD p_18 w=8.3u l=0.18u
Mp3 w1 Clk VDD VDD p_18 w=8.3u l=0.18u
Mp4 Q Q_ VDD VDD p_18 w=8.3u l=0.18u
Mp5 b Clk w2 VDD p_18 w=8.3u l=0.18u

Mn1 w1 b w3 VSS n_18 w=4u l=0.18u
Mn2 Q_ Clk w4 VSS n_18 w=4u l=0.18u
Mn3 Q Q_ VSS VSS n_18 w=4u l=0.18u
Mn4 b D VSS VSS n_18 w=4u l=0.18u
Mn5 w3 Clk VSS VSS n_18 w=4u l=0.18u
Mn6 w4 w1 VSS VSS n_18 w=4u l=0.18u
.ends

.subckt MUX41 A B C D S1 S0 OUT VDD VSS
Xmux211 A B S0 w1 VDD VSS MUX21
Xmux212 C D S0 w2 VDD VSS MUX21
Xmux213 w1 w2 S1 OUT VDD VSS MUX21 
.ends




.subckt MUX21 A B S OUT VDD VSS
**INVERTER**
Mp1 S_not S VDD VDD p_18 w=8.8u l=0.18u
Mn1 S_not S VSS VSS n_18 w=3u l=0.18u

**NAND**
Mp2 AS A VDD VDD p_18 w=8.8u l=0.18u
Mp3 AS S_not VDD VDD p_18 w=8.8u l=0.18u

Mn2 w1 A VSS VSS n_18 w=3u l=0.18u
Mn3 AS S_not w1 VSS n_18 w=3u l=0.18u

**NAND**
Mp4 BS B VDD VDD p_18 w=8.8u l=0.18u
Mp5 BS S VDD VDD p_18 w=8.8u l=0.18u

Mn4 w2 B VSS VSS n_18 w=3u l=0.18u
Mn5 BS S w2 VSS n_18 w=3u l=0.18u

**NAND**
Mp6 OUT AS VDD VDD p_18 w=8.8u l=0.18u
Mp7 OUT BS VDD VDD p_18 w=8.8u l=0.18u

Mn6 w3 AS VSS VSS n_18 w=3u l=0.18u
Mn7 OUT BS w3 VSS n_18 w=3u l=0.18u
.ends

***** NAND GATE *******
.subckt NAND2 A B OUT VDD VSS
Mp1 OUT A VDD VDD p_18 w=6u l=0.18u
Mp2 OUT B VDD VDD p_18 w=6u l=0.18u

Mn1 w1 A VSS VSS n_18 w=6u l=0.18u
Mn2 OUT B w1 VSS n_18 w=6u l=0.18u
.ends

.subckt NAND3 A B C OUT VDD VSS
Mp1 OUT A VDD VDD p_18 w=6u l=0.18u
Mp2 OUT B VDD VDD p_18 w=6u l=0.18u
Mp3 OUT C VDD VDD p_18 w=6u l=0.18u

Mn1 w1 A VSS VSS n_18 w=9u l=0.18u
Mn2 w2 B w1 VSS n_18 w=9u l=0.18u
Mn3 OUT C w2 VSS n_18 w=9u l=0.18u
.ends

.subckt NAND4 A B C D OUT VDD VSS
Mp1 OUT A VDD VDD p_18 w=6u l=0.18u
Mp2 OUT B VDD VDD p_18 w=6u l=0.18u
Mp3 OUT C VDD VDD p_18 w=6u l=0.18u
Mp4 OUT D VDD VDD p_18 w=6u l=0.18u

Mn1 w1 A VSS VSS n_18 w=9u l=0.18u
Mn2 w2 B w1 VSS n_18 w=9u l=0.18u
Mn3 w3 C w2 VSS n_18 w=9u l=0.18u
Mn4 OUT D w3 VSS n_18 w=9u l=0.18u
.ends

***** NOR GATE *******
.subckt NOR3 A B C OUT VDD VSS
Mp1 w1 A VDD VDD p_18 w=6u l=0.18u
Mp2 w2 B w1 VDD p_18 w=6u l=0.18u
Mp3 OUT C w2 VDD p_18 w=6u l=0.18u

Mn1 OUT A VSS VSS n_18 w=3u l=0.18u
Mn2 OUT B VSS VSS n_18 w=3u l=0.18u
Mn3 OUT C VSS VSS n_18 w=3u l=0.18u
.ends

.subckt NOR2 A B OUT VDD VSS
Mp1 w1 A VDD VDD p_18 w=6u l=0.18u
Mp2 OUT B w1 VDD p_18 w=6u l=0.18u

Mn1 OUT A VSS VSS n_18 w=3u l=0.18u
Mn2 OUT B VSS VSS n_18 w=3u l=0.18u
.ends

***** NOT GATE *******
.subckt NOT A OUT VDD VSS
Mp1 OUT A VDD VDD p_18 w=6u l=0.18u
Mn1 OUT A VSS VSS n_18 w=3u l=0.18u
.ends
