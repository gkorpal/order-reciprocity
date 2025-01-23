\\ combined N vectors stored in files with common filename portion.
\\ usage: combine("elements-1_2_1_", "elements-10_100", 10);

combine(common, out, N) = 
{
    combined_vector = vector(0); \\ Initialize an empty vector

    \\ Loop through the files and read the vectors
    for(i = 1, N, 
        filename = Str(common, i); 
        vec = read(filename); 
        combined_vector = concat(combined_vector, vec);
    );

    \\ Write the combined vector to a file
    write(out, combined_vector);
}
