function [gamma_s,gamma_ss]=post_prob(st_in,obs_in,obs,alpha,beta,TP,EP,Likelihood,IP)

T=length(st_in);
L=Likelihood;
%%

for  n=1:T    
   gamma_s(:,n)=(diag(beta(:,n))*alpha(:,n))/L;    
end

%%
for t=2:T

%st_in(t-1) because for trust state transition , it is considering what
%happened in the last trial resulting to the experience at t

%obs_in(t) because it is considering the current human action at the
%current environemnt t

%s1,s1   P(x_t-1=s1 , x_t=s1) 
gamma_ss(1,t)=alpha(1,t-1)*TP(1,1,st_in(t-1))*EP(1,obs(t),obs_in(t))*beta(1,t)/L;    
%s1,s2 P(x_t-1=s2 , x_t=s1)
gamma_ss(2,t)=alpha(2,t-1)*TP(2,1,st_in(t-1))*EP(1,obs(t),obs_in(t))*beta(1,t)/L; 
%s2,s1  P(x_t-1=s1, x_t=s2)
gamma_ss(3,t)=alpha(1,t-1)*TP(1,2,st_in(t-1))*EP(2,obs(t),obs_in(t))*beta(2,t)/L;  
%s2,s2  P(x_t-1=s2, x_t=s2)
gamma_ss(4,t)=alpha(2,t-1)*TP(2,2,st_in(t-1))*EP(2,obs(t),obs_in(t))*beta(2,t)/L; 
end


