function [alpha,beta,Likelihood]=alpha_beta(st_in,obs_in,obs,TP,EP,IP)


T=length(obs);

%%
%initialisation
alpha(:,1)=diag(EP(:,obs(1),obs_in(1)))*IP;
beta(:,T)=[1;1];

%%
%recursive
for n=2:T
    temp=TP(:,:,st_in(n-1))'*alpha(:,n-1);
    alpha(:,n)=diag(EP(:,obs(n),obs_in(n)))*temp;
end
Likelihood=sum(alpha(:,T));

%%

for n=T-1:-1:1
    beta(:,n)=TP(:,:,st_in(n))*diag(EP(:,obs(n+1),obs_in(n+1)))*beta(:,n+1);
end








