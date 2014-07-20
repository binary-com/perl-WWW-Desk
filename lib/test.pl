use lib '/home/rakesh/binary.com/Dev/WWW-Desk/lib/';

use WWW::Desk;
use WWW::Desk::Auth::HTTP;
use Data::Dumper;

my $auth = WWW::Desk::Auth::HTTP->new(
    'username' => 'rakesh@regentmarkets.com',
    'password' => 'rAKESH1234'
);
my $r = WWW::Desk->new(
    'base_url' => 'https://binary.desk.com/',
    'authentication' => $auth
);
print Dumper $r->list;
