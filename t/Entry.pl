use Sjis 0.64;
use Tk;
@font = ('-font' => ['‚l‚r@‚oƒSƒVƒbƒN', 12, 'normal']);

$mw = MainWindow->new;
$e1 = $mw->Entry(
    @font,
    '-textvariable' => \$textvariable1,
    '-width'        => 20,
)->pack;
$e2 = $mw->Entry(
    @font,
    '-textvariable' => \$textvariable2,
    '-width'        => 20,
    '-show'         => '#',
)->pack;
$mw->Button(
    @font,
    '-text'    => '•\Ž¦‚·‚é',
    '-command' => sub {
        if ($] >= 5.007) {
            require Encode;
            print Encode::encode('cp932', $textvariable1), "\n";
            print Encode::encode('cp932', $textvariable2), "\n";
            print "\n";
        }
        else {
            print $textvariable1, "\n";
            print $textvariable2, "\n";
            print "\n";
        }
    },
)->pack;
MainLoop;
