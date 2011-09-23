#!/usr/bin/perl
use strict;
use warnings;
use utf8;

use FindBin;
use lib "$FindBin::Bin/../perl/lib";

use Config::INI::Reader;
use OpenCorpora::Dict::Importer;

@ARGV or die "Usage: $0 <config>";

my $conf      = Config::INI::Reader->read_file($ARGV[0]);
my $root_path = $conf->{project}{root};

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my $importer = new OpenCorpora::Dict::Importer;
$importer->read_rules("$root_path/scripts/import_rules.txt");
$importer->read_bad_lemma_grammems("$root_path/scripts/bad_lemma_grammems.txt");
$importer->preload_list('anim0', "$root_path/scripts/lists/Del_anim-inan&Add_ANim.txt");
$importer->preload_list('anim1', "$root_path/scripts/lists/remove_ANim.txt");
$importer->preload_list('numr0', "$root_path/scripts/lists/list_numr_dupl_gent.txt");
$importer->preload_list('adjf_fixd_del', "$root_path/scripts/lists/list_adjf_fixd_delete.txt");
$importer->preload_list('adjf_fixd_advb', "$root_path/scripts/lists/list_adjf_fixd_ADVB.txt");
$importer->preload_list('adjf_fixd_noun', "$root_path/scripts/lists/list_adjf_fixd_NOUN.txt");
$importer->preload_list('nouns_subst', "$root_path/scripts/lists/nouns_subst.txt");
$importer->preload_list('arch', "$root_path/scripts/lists/add_Arch.txt");
$importer->preload_list('arch0', "$root_path/scripts/lists/add_Arch_nomn_plur.txt");
$importer->preload_list('infr0', "$root_path/scripts/lists/add_Infr_nomn_plur.txt");
$importer->preload_list('infr1', "$root_path/scripts/lists/add_Infr_gent_plur.txt");
$importer->preload_list('infr2', "$root_path/scripts/lists/add_Infr_VERB.txt");
$importer->preload_list('pred_del', "$root_path/scripts/lists/pred_del.txt");
$importer->preload_list('pred_intj', "$root_path/scripts/lists/pred_to_intj.txt");
$importer->preload_list('count', "$root_path/scripts/lists/add_Coun_gent_plur.txt");
$importer->read_aot("$root_path/scripts/lists/aot_dump.3");
#$importer->read_aot("test.txt");
