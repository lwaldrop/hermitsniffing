function [testdots1,testdots2] = testdotshermit(XX_data,YY_data,hairs,maske)
% testdotshermit.m
% Tests positions of simulated odor molecules for inclusion within the aesthetascs of the 
% array.
% Called by: sniffmultihairs2.m

p = size(hairs);
p = p(1,2);
 

Np = size(XX_data);
Np1 = Np(1);
Np2 = Np(2);

testdots1 = zeros(Np1,Np2);

for i = 1:p

    test1 = inpolygon(XX_data,YY_data,hairs(1,i).x,hairs(1,i).y);
    testdots1 = testdots1 +test1;
end


testdots1 = logical(testdots1);

testdots2 = inpolygon(XX_data,YY_data,maske.idxw,maske.idyw);

