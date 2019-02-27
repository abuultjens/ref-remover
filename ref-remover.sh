#!/bin/bash

#--------------------------------------------------------------------
# ref-remover   Andrew Buultjens 2019: buultjensa@gmail.com
#--------------------------------------------------------------------

INFILE=${1}
#INFILE=test_ref.fa
#INFILE=ground_truth/6_sc4.3.6.full.clean.WO-_noref.aln

# display help
if [ "${INFILE}" == "help" ]; then
    echo ""
    echo "--------------------------------------------------------------------"
    echo "ref-remover   Andrew Buultjens 2019: buultjensa@gmail.com"
    echo "--------------------------------------------------------------------"
    echo ""
    echo "VERSION:"
    echo "v1.02"
    echo ""
    echo "ABOUT:"
    echo "This program removes a specific entry (eg. 'Reference') from a fasta file and outputs snp sites"
    echo ""
    echo "USAGE:"
    echo "sh ref-remover.sh [INFILE.fa] [ENTRY_TO_EXCLUDE] [PREFIX] [OUTFILE_DATA]"
    echo ""
    echo "OPTIONS:"
    echo "[ENTRY_TO_EXCLUDE] is the name of the fasta entry to exclude (eg. 'Reference')"
    echo "[OUTFILE_DATA] can be 'original_aln_without_ref', 'core_snps_without_ref' or 'core_and_accessory_snps_without_ref'"
    echo "*note that the command options must be in the exact order as specified above as they are treated as positional arguments"    
    echo ""
    echo "EXAMPLE:"
    echo "remove 'Reference' and keeping all sites in original file"
    echo "sh ref-remover.sh inputfile.aln Reference PREFIX original_aln_without_ref"
    echo ""
    echo "remove 'Reference' and extract all core snps"
    echo "sh ref-remover.sh inputfile.aln Reference PREFIX core_snps_without_ref"
    echo ""
    echo "remove 'Reference' and extract all core and accessory snps"
    echo "sh ref-remover.sh inputfile.aln Reference PREFIX core_and_accessory_snps_without_ref"
    echo ""
    
    # crash script and exit
    exit 1
fi

REMOVE=${2}
#REMOVE=Reference

PREFIX=${3}
#PREFIX=6_sc4.3.6.full.clean.WO-_noref

OUTFILE_FORMAT=${4}
#OUTFILE_FORMAT=original_aln_without_ref
#OUTFILE_FORMAT=core_snps_without_ref
#OUTFILE_FORMAT=core_and_accessory_snps_without_ref

#------------------------------------------------

# check that infile exists
if [ -e "${INFILE}" ] 
then
    echo ""
else
    # print error
    echo "ERROR: cannot find ${INFILE}"  
    # crash script and exit
    exit 1
fi

#------------------------------------------------

# generate random prefix for all tmp files
RAND_1=`echo $((1 + RANDOM % 100))`
RAND_2=`echo $((100 + RANDOM % 200))`
RAND_3=`echo $((200 + RANDOM % 300))`
RAND=`echo "${RAND_1}${RAND_2}${RAND_3}"`

#------------------------------------------------

# make a list that excludes the entry to be removed
grep ">" ${INFILE} | tr -d ">" | grep -v "${REMOVE}" > ${RAND}_tmp_list.txt

# index fasta file
samtools faidx ${INFILE}

# loop through all keep entries and write to file
for TAXA in $(cat ${RAND}_tmp_list.txt); do
    samtools faidx ${INFILE} ${TAXA} >> ${RAND}_tmp_noref.fa
done

#----------------------------------------
# select outfiles

# output original aln without ref
if [ "${OUTFILE_FORMAT}" == "original_aln_without_ref" ]; then
    mv ${RAND}_tmp_noref.fa ${PREFIX}.aln
fi

# output just core snps without ref
if [ "${OUTFILE_FORMAT}" == "core_snps_without_ref" ]; then

    # prepare fasta
    snp-sites -c ${RAND}_tmp_noref.fa > ${PREFIX}.aln
    
    # check if snps were found
    WC=`wc -l ${PREFIX}.aln | awk '{print $1}'`
    
    # check if snps were found
    if [ "$WC" == "0" ]; then
    
        # print error
        echo "ERROR: could not find any snps"  
        # crash script and exit
        exit 1
    else
        # table
        snp-sites -c -v ${RAND}_tmp_noref.fa | vcf-to-tab | tr -d '/' | tr '*' 'N' | cut -f 1,2,4- > ${PREFIX}.tab
    fi
fi

# output both core and accessory snps without ref
if [ "${OUTFILE_FORMAT}" == "core_and_accessory_snps_without_ref" ]; then
    # fasta
    snp-sites ${RAND}_tmp_noref.fa > ${PREFIX}.aln   
    
    # check if snps were found
    WC=`wc -l ${PREFIX}.aln | awk '{print $1}'`
    
    # check if snps were found
    if [ "$WC" == "0" ]; then
    
        # print error
        echo "ERROR: could not find any snps"  
        # crash script and exit
        exit 1
    else
        # table
        snp-sites -v ${RAND}_tmp_noref.fa | vcf-to-tab | tr -d '/' | tr '*' 'N' | cut -f 1,2,4- > ${PREFIX}.tab
    fi    
fi

#----------------------------------------

# remove all tmp files
rm ${RAND}_tmp_*

