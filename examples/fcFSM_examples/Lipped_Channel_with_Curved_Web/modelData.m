function [prop,node,elem,lengths,BC,m_all,springs,constraints,neigs,cornerStrips]=modelData(pathCUFSM)

%Material Properties
E=210000;
PoissonRto=0.3;
prop=[100 E E PoissonRto PoissonRto E/2/(1+PoissonRto)];
%
%Nodes
node=[1	-123.20508076	-85.0			1	1	1	1	1
	2	-123.20508076	-92.5			1	1	1	1	1
	3	-123.20508076	-100.0			1	1	1	1	1
	4	-139.8717474	-100.0			1	1	1	1	1
	5	-156.5384141	-100.0			1	1	1	1	1
	6	-173.20508076	-100.0			1	1	1	1	1
	7	-190.21130326	-61.80339887	1	1	1	1	1
	8	-198.90437907	-20.90569265	1	1	1	1	1
	9	-198.90437907	 20.90569265	1	1	1	1	1
	10	-190.21130326	 61.80339887	1	1	1	1	1
	11	-173.20508076	 100.0			1	1	1	1	1
	12	-156.53841409	 100.0			1	1	1	1	1
	13	-139.87174742	 100.0			1	1	1	1	1
	14	-123.20508076	 100.0			1	1	1	1	1
	15	-123.20508076	 92.5			1	1	1	1	1
	16	-123.20508076	 85.0			1	1	1	1	1];


%
%Elements
elem=[1	1	2	3	100
	2	2	3	3	100
	3	3	4	3	100
	4	4	5	3	100
	5	5	6	3	100
	6	6	7	3	100
	7	7	8	3	100
	8	8	9	3	100
	9	9	10	3	100
	10	10	11	3	100
	11	11	12	3	100
	12	12	13	3	100
	13	13	14	3	100
	14	14	15	3	100
	15	15	16	3	100];


%-----------------------------------------------------------------
%----------------additional input definitions---------------------
%-----------------------------------------------------------------
lengths=logspace(log10(10),log10(5120),145)';
BC='S-S';
for i=1:length(lengths)
    m_all{i}=[1];
end
springs=0;
constraints=0;
neigs=10;
cornerStrips=[];