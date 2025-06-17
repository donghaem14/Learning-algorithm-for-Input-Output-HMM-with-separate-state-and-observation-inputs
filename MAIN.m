%%
%This code is written for an input output hidden markov model (IOHMM) with
%2 states, 6 possible input for state transition, 2 possible observation
%and 4 possible input for emission probability function

%load observaiton inputs
obs_seq=load('observation_seq.mat');
observations=struct2array(obs_seq);
observations=observations(seq,:);

%load state transition inputs
state_input=load('state_input.mat');
st_in=struct2array(state_input);
st_in=st_in(seq,:);

%load observation sequence
obs_input=load('obs_input.mat');
obs_in=struct2array(obs_input);
obs_in=obs_in(seq,:);



%%
%Initial guess for parameters
%initial probability is 1x2, representing for probability of initially
%being in one of two possible states.

IP=[];

%State transition probability is 2x2x6, representing for each possible
%state transition input
%[s1 -> s1, s1 ->s2]
%[s1 -> s2, s2 ->s2]
TP(:,:,1)=[];
TP(:,:,2)=[];
TP(:,:,3)=[];
TP(:,:,4)=[];
TP(:,:,5)=[];
TP(:,:,6)=[];

%State transition probability is 2x2x4, representing for each possible
%emission probability input
%[P(o1|s1), P(o2|s1)]
%[P(o1|s2), P(o2|s2)]
EP(:,:,1)=[];
EP(:,:,2)=[];
EP(:,:,3)=[];
EP(:,:,4)=[];


%%

iteration=500;%number of iteration

for iter=1:iteration

    for seq=1:num_seq
        
        [alpha(:,:,seq),beta(:,:,seq),L(seq)]=alpha_beta(st_in(seq,:),obs_in(seq,:),observations(seq,:),TP,EP,IP);

        [gamma_s(:,:,seq),gamma_ss(:,:,seq)]=post_prob(st_in(seq,:),obs_in(seq,:),observations(seq,:),alpha(:,:,seq),beta(:,:,seq),TP,EP,L(:,seq),IP);

        [num1(:,:,seq),num2(:,:,seq),den(:,:,seq),initial(:,seq)]=identifier(gamma_s(:,:,seq),gamma_ss(:,:,seq),st_in(seq,:),obs_in(seq,:),observations(seq,:));        
    
    end
    
    LL(iter)=sum(log(L));
    iter
    
    [TP,EP,IP]=prob_functions(num1,num2,den,initial,num_seq);
    TPs{iter}=TP;
    EPs{iter}=EP;
    IPs{iter}=IP;
    
end

save('IP.mat','TP')
save('TP.mat','TP')
save('EP.mat','EP')