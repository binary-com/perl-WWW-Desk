use lib '/home/rakesh/binary.com/Dev/WWW-Desk/lib/';

use WWW::Desk::Auth::HTTP;
use Data::Dumper;

my $r = WWW::Desk::Auth::HTTP->new(
    'base_url' => 'http://binary.desk.com',
    'username' => 'rakesh@regentmarkets.com',
    'password' => 'rAKESH1234'
);
print Dumper $r->login_headers;
