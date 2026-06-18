function main(imagePath)
    [label, ~] = predictImageClass(imagePath);
    fprintf('Sèrie predita pel model: %s\n', label);
    if isSpongeBob(imagePath)
        fprintf("S'ha reconegut al Bob Esponja\n");
    else
        fprintf("No s'ha reconegut al Bob Esponja\n");
    end
end