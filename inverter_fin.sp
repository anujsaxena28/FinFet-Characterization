**Inverter netlist
********* Options *********
.options
+ post
********* Models *********
.param lg=55n
.param wd=110n
.param bias=0.2
.hdl ../code/bsimimg.va
.include "../code/modelcard.pmos"
.include "../code/modelcard.nmos"
********* Voltage Sources *********
v0 vdd 0 1.0
vbias bias 0 0.0
vbias1 vbg1 0 (-1*bias) 
vbias2 vbg2 0 (1+bias) 
vin in 0 pulse 1.0 0 0 5p 5p 490p 1n 
********* Circuits *********
.subckt inv_LP in out vbg1 vbg2 vvdd vgnd
X1 out in vvdd vbg2 pmos1 l=lg w=wd nf=2
X2 out in vgnd vbg1 nmos1 l=lg w=wd nf=1
.ends

.subckt inv in out vvdd vgnd
X1 out in vvdd in pmos1 l=lg w=wd nf=2
X2 out in vgnd in nmos1 l=lg w=wd nf=1
.ends

********* Implementation *********
**xinv_LP in x vbg1 vbg2 vdd gnd inv_LP     **Uncomment for LP mode
xinv_0 in x vdd gnd inv		  	   **Uncoomment for SG mode
xinv_1 x out vdd gnd inv
xinv_2 x out vdd gnd inv
xinv_3 x out vdd gnd inv
xinv_4 x out vdd gnd inv
c0 out 0.0 0.1f

.DC bias START=0.0 STOP=0.4 STEP=0.001
.measure pwr avg p(v0) 
.tran 1p 10n SWEEP bias POI 5 0 0.1 0.2 0.3 0.4

.end
