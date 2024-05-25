%% read the excel file
filename = 'SWDay6.xlsx'; % fill in the filenamen of the file you want to make a boxplot of
data = readtable(filename);

boxplot(data.Value, data.Group);

xlabel('Condition');
% comment and uncomment the right ylabel
ylabel('Step Width');
%ylabel('Step Length');
% comment and uncomment the right title
%title('Boxplot of Step Width for different conditions on different training days');
%title('Boxplot of Step Width for different conditions on different training days');