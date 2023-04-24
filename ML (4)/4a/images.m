function images(algorithm,dataset,confus_matrix,k)
%creates and save image in results folder

f = figure('units','normalized','outerposition',[0 0 1 1], 'visible', 'off');
sInd=[1,2;3,4];
clrs = {'Yellow','red','red','Yellow'};
    

outHtml = strcat('<html><table border=0 width=800 bgcolor=', ...
clrs(sInd), ... 
'"><TR><TD>', ...
cellfun(@num2str,num2cell(confus_matrix),'UniformOutput',false), ... 
'</TD></TR></body></html>');


VariableNames = {'Positive outcome','Negative outcome'};
RowNames = {'Positive label','Negative label'}; 
    
u = uitable(f,'Data',outHtml,'RowName',RowNames,'ColumnName',VariableNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
figName=sprintf('Results/%s/%s_with_k=%d_.jpg',dataset, algorithm, k);
saveas(f, figName)
    
end