function plotting_func(Test_set,classification,k,d)
% For plotting
plotting=reshape(Test_set,[28,28]);
imshow(plotting)
if classification==10
   classification=0;
end
if d~=0
   title(['Digit tested : ', num2str(d), 'Prediction : ', num2str(classification), '          k: ', num2str(k) ])
else
   title(['Prediction : ', num2str(classification), '          k: ', num2str(k)])
end

end
