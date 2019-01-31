**Task1_ntype netlist
********* Options *********
.options
+ post
********* Models *********
.param lg=55n
.param wd=110n
.hdl ../../code/bsimimg.va
.include "../../code/modelcard.nmos_ig"
.include "../../code/modelcard.nmos"********* Voltage Sources *********s
vs s 0 0.0
vds d s 1.0
vgbs b s 0.0
vgfs a s 0.0
vbias1 vbg1 0 -0.2 
vbias2 vbg2 0 -0.4 
********* Circuits *********
X1 d a s a nmos1 l=lg w=wd nf=1
X2 d a s vbg1 nmos1 l=lg w=wd nf=1
X3 d a s vbg2 nmos1 l=lg w=wd nf=1
X4 d a s b nmosig l=lg w=wd nf=1
********* Simulation *********
.tran 1p 10n
.DC vgfs START=0.0 STOP=1.0 STEP=0.01
.measure ids1 avg i(X1.d)
.measure ids2 avg i(X2.d)
.measure ids3 avg i(X3.d)
.measure ids4 avg i(X4.d)
.end

