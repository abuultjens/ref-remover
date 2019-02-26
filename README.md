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
```
