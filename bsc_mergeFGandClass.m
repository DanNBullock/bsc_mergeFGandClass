function [mergedFG, mergedClassification]=bsc_mergeFGandClass(inputFGs,inputClassifications)
% [mergedFG, mergedClassification]=bsc_mergeFGandClass(inputFGs,inputClassifications)
%
%  Requires vistasoft

if ~exist('inputClassifications') ==1
    inputClassifications=[];
end

for iInputs=1:length(inputFGs)
    
    [toMergeFG, ~] = bsc_LoadAndParseFiberStructure(inputFGs{iInputs});
    
    if ~or(length(toMergeFG.fibers)==0,length(toMergeFG.fibers{1})==0);
        if ~exist('mergedFG') ==1
            mergedFG=toMergeFG;
            mergedClassification.names=[];
            mergedClassification.index=[];
        else
            mergedFG=fgMerge(mergedFG,toMergeFG)
        end
        
        switch length(inputClassifications)
            case 0
                toMergeclassification.names{1}=toMergeFG.name;
                toMergeclassification.index(1:length(toMergeFG.fibers))=1;
            case 1
                if length(mergedClassification.names)==0
                    if or(ischar(inputClassifications{iInputs}),inputClassifications(inputFGs{iInputs}))
                        mergedClassification=load(inputClassifications{iInputs});
                    elseif isstruc(ischar(inputClassifications{iInputs}))
                        mergedClassification=inputClassifications{iInputs};
                    else
                        warning('\n Input classification type not recognized for input %i',iInputs)
                    end
                else
                    toMergeclassification.names{1}=toMergeFG.name;
                    toMergeclassification.index(1:length(toMergeFG.fibers))=1;
                end
            case length(inputFGs)
                 if or(ischar(inputClassifications{iInputs}),inputClassifications(inputFGs{iInputs}))
                    toMergeclassification=load(inputClassifications{iInputs});
                elseif isstruc(ischar(inputClassifications{iInputs}))
                    toMergeclassification=inputClassifications{iInputs};
                else
                    warning('\n Input classification type not recognized for input %i',iInputs)
                 end
        end
         mergedClassification = bsc_mergeClassifications(mergedClassification,toMergeclassification);
    end
end

end