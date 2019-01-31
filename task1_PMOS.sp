**Task1_ntype netlist
********* Options *********
.options
+ post
********* Models *********
.param lg=55n
.param wd=110n
.hdl ../../code/bsimimg.va
.include "../../code/modelcard.pmos_ig"
.include "../../code/modelcard.pmos"********* Voltage Sources *********s
vd d 0 0.0
vds d s -1.0
vgbs b d 1.0
vgfd a d 0.0
vbias1 vbg1 0 1.2 
vbias2 vbg2 0 1.4 
********* Circuits *********
X1 d a s a pmos1 l=lg w=wd nf=1
X2 d a s vbg1 pmos1 l=lg w=wd nf=1
X3 d a s vbg2 pmos1 l=lg w=wd nf=1
X4 d a s b pmosig l=lg w=wd nf=1
********* Simulation *********
.tran 1p 10n
.DC vgfd START=0.0 STOP=1.0 STEP=0.01
.measure ids1 avg i(X1.s)
.measure ids2 avg i(X2.s)
.measure ids3 avg i(X3.s)
.measure ids4 avg i(X4.s)
.end

