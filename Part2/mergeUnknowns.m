function unknowns= mergeUnknowns(unknowns,symb)

    for i=1:length(symb)
        found = 0 ;
        for j=1:length(unknowns)
            if(symb{i}== unknowns{j})
                found = 1 ;
            end
        end
        if(found==0)
            unknowns{length(unknowns)}=symb{i};
            unknowns{length(unknowns)+1}=' ';
        end
    end