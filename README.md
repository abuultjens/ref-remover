# ref-remover
This program removes a specific entry (eg. 'Reference') from a fasta file and outputs snp sites




# Original alignment containing reference sequence
![alt text](https://github.com/abuultjens/ref-remover/blob/master/ref_aln.png)

# Example 1: Removing the reference but keeping all original sites
![alt text](https://github.com/abuultjens/ref-remover/blob/master/just_remove_ref.png)

# Example 2: Removing the reference and extracting core snps
![alt text](https://github.com/abuultjens/ref-remover/blob/master/no_ref_core-snps.png)

# Example 2: Removing the reference and extracting core and accessory snps

```
# run ref-remover
sh ref-remover.sh test_ref.fa Reference test_wo-ref core_and_accessory_snps_without_ref

# inspect fasta output
cat test_wo-ref.aln
>TAXA_A
TT
>TAXA_B
GA
>TAXA_C
GN

# inspect table output
cat test_wo-ref.tab
#CHROM	POS	TAXA_A	TAXA_B	TAXA_C
1	2	T	G	G
1	3	T	A	N
```
