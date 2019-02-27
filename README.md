# ref-remover
This program is a multi-option tool that removes a specific entry (eg. 'Reference') from a multi fasta file and returns either all sites, core snps sites or core and accessory snp sites in table and fasta format.

# Author
Andrew Buultjens

# Usage
```
sh ref-remover.sh [INFILE.fa] [ENTRY_TO_EXCLUDE] [PREFIX] [OUTFILE_DATA]
```
* note that the command options must be in the exact order as specified above as they are treated as positional arguments

# Options
* [ENTRY_TO_EXCLUDE] is the name of the fasta entry to exclude (eg. 'Reference')
* [OUTFILE_DATA] can be 'original_aln_without_ref', 'core_snps_without_ref' or 'core_and_accessory_snps_without_ref'

# Help
```
sh ref-remover.sh help
```

# Dependencies
* snp-sites (tested with 2.4.1)  
* samtools (tested with 1.3.1)  

# Examples

**Original alignment containing reference sequence:**   
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
ref-remover excluded the reference fasta entry and kept all of the sites in the original file  

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
**ref-remover kept:**  
Site 2 = core position with snp  
**ref-remover removed:**  

Site 1 = core position with snp (but not a snp when excluding the reference)  
Site 3 = accessory position with snp  
Site 4 = accessory position with no snp  

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
**ref-remover kept:**   
Site 2 = core position with snp   
Site 3 = accessory position with snp<br/>     
**ref-remover removed:**   
Site 1 = core position with snp (but not a snp when excluding the reference)   
Site 4 = accessory position with no snp  

# Extracting accessory sites without snps (invariant accessory sites)
Take the original alignment with reference excluded (output from example 1) and use accessory-sites:   https://github.com/abuultjens/accessory-sites
