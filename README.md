# ref-remover
This program removes a specific entry (eg. 'Reference') from a fasta file and outputs snp sites




# Original alignment containing reference sequence
```
cat test_ref.fa
>Reference
TTTA
>TAXA_A
ATTA
>TAXA_B
AGAA
>TAXA_C
AGNN
```
**The alignment contains:**
Site 1 = core position with snp (but not a snp when excluding the reference)   
Site 2 = core position with snp  
Site 3 = accessory position with snp  
Site 4 = accessory position with no snp

# Example 1: Removing the reference but keeping all original sites
run ref-remover with 'original_aln_without_ref' option
```
sh ref-remover.sh test_ref.fa Reference test_wo-ref original_aln_without_ref
```
inspect fasta output
```
cat test_wo-ref.aln
>TAXA_A
ATTA
>TAXA_B
AGAA
>TAXA_C
AGNN
```

# Example 2: Removing the reference and extracting core snps
run ref-remover with 'core_snps_without_ref' option
```
sh ref-remover.sh test_ref.fa Reference test_wo-ref core_snps_without_ref
```
inspect fasta output
```
cat test_wo-ref.tab
>TAXA_A
T
>TAXA_B
G
>TAXA_C
G
```
inspect table output
```
#CHROM	POS	TAXA_A	TAXA_B	TAXA_C
1	2	T	G	G
```

# Example 2: Removing the reference and extracting core and accessory snps
run ref-remover with 'core_and_accessory_snps_without_ref' option
```
sh ref-remover.sh test_ref.fa Reference test_wo-ref core_and_accessory_snps_without_ref
```
inspect fasta output
```
cat test_wo-ref.aln
>TAXA_A
TT
>TAXA_B
GA
>TAXA_C
GN
```
inspect table output
```
cat test_wo-ref.tab
#CHROM	POS	TAXA_A	TAXA_B	TAXA_C
1	2	T	G	G
1	3	T	A	N
```
