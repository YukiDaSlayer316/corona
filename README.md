# Goal of this project

Every living organism is made of ADN , a long sequence of character called nucleotides (desoxyribonucleotide), represented by the letter A, T, G or C. Each groupment of 3 nucleotides is called a codon, which reprensent an amino acid. In total, there are 24 combinations of nucleotides (4x3x2). However, when looking in the scientific litterature, there are only 20 amino acids listed. Our first goal will be to understand what happened to those 4 missing amino acid by analyzing the ADN of the corona virus. Then, we will transcribe each nucleotide sequence into their respective amino acid in order to recompose the corona virus. To vizualize it, we will use the biopython library  

# Trials

Technically, if we consider all 3-combinations of nucleotides, if we presume that the same nucleotide more than once in the same codon, there are 64 combinations (4x4x4). However, because different nucleotide have different roles, we assume that we don't want the codon to contain the same nucleotide twice. Therefore, we have 24 combinations (4x3x2). However, there are only 20 amino acids. That means that in the corona's ADN sequence, 4 of these sequences have been encoded differently and have been replaced by another amino-acid ie more than one codon can refer to the same amino-acid. This phenomenon is called the DEGENERACY OF THE CODE

To find these replacements, we have to search which of these combinations are missing from the sequence. To do so, we will cluster the ADN by its codon, associate each codon to its amino-acid and find which pairs are missing. I will assume that the missing pairs have been replaced by a similar amino acid. Consequently, we will compare the similarity of the 4 missing codons with the 20 amino acids using several metrics: 

- Gratham's distance (composition, polarity, molecular volume between two amino acid)
- Sneath's index (percentage value os the sum of all properties not shared between two amino acid)
- Epstein's coefficient of difference (difference in polarity ans size between two amino acids)
- Miyata's distance (volume, polarity between two amino acid)
- Experimental Exchangeability (mean effect of exchanging two amino acids)

We will combine those metrics into a single one that will reveal what are the properties of the missing codons.

# Useful Links

Amino Acids reference chart: https://www.sigmaaldrich.com/life-science/metabolomics/learning-center/amino-acid-reference-chart.html
Amino Acids Data Encryption: https://medcraveonline.com/JAPLR/amino-acids-in-data-encryption.html
Amino Acids replacement: https://en.wikipedia.org/wiki/Amino_acid_replacement

# Articles

Why are there obly 20 amino acids: https://www.chemistryworld.com/features/why-are-there-20-amino-acids/3009378.article

