use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WebService::Embedly',
    AUTHOR              => q{Greg Heo <greg@node79.com>},
    VERSION_FROM        => 'lib/WebService/Embedly.pm',
    ABSTRACT_FROM       => 'lib/WebService/Embedly.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'mit')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Carp' => 0,
        'JSON' => 0,
        'LWP::UserAgent' => 0,
        'URI' => 0,
        'URI::Escape' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WebService-Embedly-*' },
);
