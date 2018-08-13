%Sistema b�sico de reconhecimento de fala
clc;

%PAR�METROS DA REDE
S=20;%N�mero m�ximo de neur�nios por camada
TF={'logsig'};
BTF='trainrp';
BLF='learngd';
PF='msereg';
IPF={'fixunknowns','removeconstantrows','mapminmax'};
IPF_fprint='default';
OPF={'removeconstantrows','mapminmax'};
OPF_fprint='default';
DDF='dividerand';
acerto_dadostreino=0;
acerto_dadosteste=0;
total_interacoes=0;%Total de intera��es realizadas pelo algoritmo.
TF_fprint='logsig';

%Criando a rede neural

net=cria_rede(S,TF,BTF,BLF,PF,IPF,OPF,DDF);
simula_rede(net);
