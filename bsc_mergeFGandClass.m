function [mergedFG, mergedClassification]=bsc_mergeFGandClass(inputFGs,inputClassifications)
% [mergedFG, mergedClassification]=bsc_mergeFGandClass(inputFGs,inputClassifications)
%
%  Requires vistasoft

if length(inputFGs)~=length(inputClassifications)
    error('Mismatch between length of input fiber groups and classification structures')
end



for iInputs=1:length(inputFGs)
    if iInputs==1
        if iscell(inputFGs)
            [mergedFG, ~] = bsc_LoadAndParseFiberStructure(inputFGs{iInputs});
        end
        if iscell(inputClassifications)
            if or(ischar(inputClassifications{iInputs}),inputClassifications(inputFGs{iInputs}))
                mergedClassification=load(inputClassifications{iInputs});
            elseif isstruc(ischar(inputClassifications{iInputs}))
                mergedClassification=inputClassifications{iInputs};
            else
                warning('\n Input classification type not recognized for input %i',iInputs)
            end
        end
    end
    if iInputs>=2
        if iscell(inputFGs)
            [toMergeFG, ~] = bsc_LoadAndParseFiberStructure(inputFGs{iInputs});
        end
        if iscell(inputClassifications)
            if or(ischar(inputClassifications{iInputs}),inputClassifications(inputFGs{iInputs}))
                toMergeclassification=load(inputClassifications{iInputs});
            elseif isstruc(ischar(inputClassifications{iInputs}))
                toMergeclassification=inputClassifications{iInputs};
            else
                warning('\n Input classification type not recognized for input %i',iInputs)
            end
        end
        
        
        mergedFG=fgMerge(mergedFG,toMergeFG);
        mergedClassification = bsc_mergeClassifications(mergedClassification,toMergeclassification);       
    end
end

end