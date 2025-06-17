function [numA,numB,den,initial]=identifier(gamma_s,gamma_ss,st_in,obs_in,obs)

initial=gamma_s(:,1);
st_in=st_in(1:70);
%%
%identifies the time steps for each state_inputs 
for a=1:6    
   STI{a}=find(st_in==a);     
end


%%
%identifies the time steps for each observation
O1=find(obs==1);
O2=find(obs==2);


%identifies the time steps for each observation inputs
for a=1:4    
   OBI{a}=find(obs_in==a);     
end

%identifies what the observation is for every obs_input.
for a=1:4   
    R{a}=intersect(O1,OBI{a});
    I{a}=intersect(O2,OBI{a});    
end





%%
%

for a=1:6
num1=0;num2=0;num3=0;num4=0;
den_tmp1=0;den_tmp2=0;

%For state transition probability function
    for n=1:length(STI{a})
       num1=num1+gamma_ss(1,STI{a}(n)+1);%(s1,s1)

       num2=num2+gamma_ss(2,STI{a}(n)+1);%(s2,s1)

       num3=num3+gamma_ss(3,STI{a}(n)+1);%(s1,s2)

       num4=num4+gamma_ss(4,STI{a}(n)+1);%(s2,s2) 
       
       den_tmp1=den_tmp1+gamma_s(1,STI{a}(n)+1);
       den_tmp2=den_tmp2+gamma_s(2,STI{a}(n)+1);
    end
    
numA(a,:)=[num1 num2 num3 num4 den_tmp1 den_tmp2];    
end

    
    
for a=1:4    
num5=0;num6=0;num7=0;num8=0;
den1=0;den2=0;
%for observation probability function
    for n=1:length(R{a})       
        num5=num5+gamma_s(1,R{a}(n));
        num7=num7+gamma_s(2,R{a}(n));       
    end
    
    for n=1:length(I{a})
        num6=num6+gamma_s(1,I{a}(n));
        num8=num8+gamma_s(2,I{a}(n));
    end
    
    for n=1:length(OBI{a})
       den1=den1+gamma_s(1,OBI{a}(n));
       den2=den2+gamma_s(2,OBI{a}(n));
    end
    
numB(a,:)=[num5 num6 num7 num8];
den(a,:)=[den1 den2];
end




