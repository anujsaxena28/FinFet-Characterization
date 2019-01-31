********* Options *********
.options
+ post
+ measout
********* Models *********
.param lg=55n
.param wd=110n
.hdl ../../code/bsimimg.va
.include "../../code/modelcard.pmos"
.include "../../code/modelcard.nmos"
********* Voltage Sources *********
v0 vdd 0 1.0
vd d 0 pulse 0 1.0 0 5p 5p 1990p 4n
vc c 0 pulse 0 1.0 0 5p 5p 3990p 8n
vb b 0 pulse 0 1.0 0 5p 5p 7990p 16n
va a 0 pulse 0 1.0 0 5p 5p 15990p 32n  
vclk clk 0 pulse 0 1.0 0 5p 5p 990p 2n

********* Circuits *********
.subckt pdn_and a b c d x y
X1 x a n1 a nmos1 l=lg w=wd nf=5
X2 n1 b n2 b nmos1 l=lg w=wd nf=5
X3 n2 c n3 c nmos1 l=lg w=wd nf=5
X4 n3 d y d nmos1 l=lg w=wd nf=5
.ends

.subckt inv in out vvdd vgnd
X1 out in vvdd in pmos1 l=lg w=wd nf=2
X2 out in vgnd in nmos1 l=lg w=wd nf=1
.ends

********* Implementation of circuit*********

X1 x clk vdd clk pmos1 l=lg w=wd nf=1
X2 x out vdd out pmos1 l=lg w=wd nf=1
xinv x out vdd gnd inv
xpdn_and a b c d x y pdn_and
X3 y clk gnd clk nmos1 l=lg w=wd nf=5
xinv_1 out out1 vdd gnd inv
xinv_2 out out1 vdd gnd inv
xinv_3 out out1 vdd gnd inv
xinv_4 out out1 vdd gnd inv
.tran 1p 33.0n UIC
.ic v(x)=1

.meas tran pwr_1111 avg i(v0) from=0.300n to=0.900n
.meas tran pwr_1110 avg i(v0) from=2.300n to=2.900n
.meas tran pwr_1101 avg i(v0) from=4.300n to=4.900n
.meas tran pwr_1100 avg i(v0) from=6.300n to=6.900n
.meas tran pwr_1011 avg i(v0) from=8.300n to=8.900n
.meas tran pwr_1010 avg i(v0) from=10.300n to=10.900n
.meas tran pwr_1001 avg i(v0) from=12.300n to=12.900n
.meas tran pwr_1000 avg i(v0) from=14.300n to=14.900n
.meas tran pwr_0111 avg i(v0) from=16.300n to=16.900n
.meas tran pwr_0110 avg i(v0) from=18.300n to=18.900n
.meas tran pwr_0101 avg i(v0) from=20.300n to=20.900n
.meas tran pwr_0100 avg i(v0) from=22.300n to=22.900n
.meas tran pwr_0011 avg i(v0) from=24.300n to=24.900n
.meas tran pwr_0010 avg i(v0) from=26.300n to=26.900n
.meas tran pwr_0001 avg i(v0) from=28.300n to=28.900n
.meas tran pwr_0000 avg i(v0) from=30.300n to=30.900n


.meas tran pwr_total avg i(v0) from=0.300n to=30.900n

.meas tran leakage_average_power param='(pwr_0000 + pwr_0001 + pwr_0010 + pwr_0011 + pwr_0100 + pwr_0101 + pwr_0110 + pwr_0111 + pwr_1000 + pwr_1001 + pwr_1010 + pwr_1011 + pwr_1100 + pwr_1101 + pwr_1110 + pwr_1111)/16'

.meas tran dynamic_power param='pwr_total - leakage_average_power'
.end
