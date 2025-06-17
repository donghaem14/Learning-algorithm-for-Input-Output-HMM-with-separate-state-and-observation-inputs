function [TP,EP,IP]=prob_functions(num1,num2,den,initial,num_seq)
%CORRECT


%initial state probability
IP=[sum(initial(1,:))/num_seq;sum(initial(2,:))/num_seq];

num_sumA=0;
num_sumB=0;
den_sum=0;
for i=1:num_seq
    
num_sumA=num_sumA+num1(:,:,i);

den_sum=den_sum+den(:,:,i);

num_sumB=num_sumB+num2(:,:,i);

end

for i=1:6

    TP(:,:,i)=[num_sumA(i,1)/(num_sumA(i,1)+num_sumA(i,3)) num_sumA(i,3)/(num_sumA(i,1)+num_sumA(i,3));
                      num_sumA(i,2)/(num_sumA(i,2)+num_sumA(i,4)) num_sumA(i,4)/(num_sumA(i,2)+num_sumA(i,4))];
                         
end

for i=1:4

    EP(:,:,i)=[num_sumB(i,1)/den_sum(i,1) num_sumB(i,2)/den_sum(i,1);
              num_sumB(i,3)/den_sum(i,2) num_sumB(i,4)/den_sum(i,2)];    
   
end
