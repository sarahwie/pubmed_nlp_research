#!/usr/bin/env perl

# Download PubMed records corresponding to a list of PMIDs.
#input is a comma-separated string of PMID's
$id_list = <>;

use LWP::Simple;

# Download protein records corresponding to a list of GI numbers.

$db = 'pubmed';

#assemble the epost URL
$base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
$url = $base . "epost.fcgi?db=$db&id=$id_list";

#post the epost URL
$output = get($url);

#parse WebEnv and QueryKey
$web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
$key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);

### include this code for EPost-EFetch
#assemble the efetch URL
$url = $base . "efetch.fcgi?db=$db&query_key=$key&WebEnv=$web";
$url .= "&retmode=xml";

#post the efetch URL
$data = get($url);
print "$data";

#to run, use the following in terminal:
#perl efetch.pl < article_replication_PMIDs_list.txt > training_set_article.xml

#but first: to prep input file by making comma instead of line delimited (make sure no newline after last element in file first)
# $ tr '\n' ', ' input_file.txt > article_replication_PMIDs_list.txt
#(make sure no comma after last element in list)
#double check counts