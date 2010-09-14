use Sjis 0.64;
use Tk;
@font = ('-font' => ['‚l‚r@‚oƒSƒVƒbƒN', 12, 'normal']);

$mw = MainWindow->new;
$can = $mw->Canvas(
    '-width'     => 200,
    '-height'    => 200,
    'background' => 'white',
)->pack;
$can->createText(
    100, 100,
    @font,
    '-text' => 'ƒ\',
);
MainLoop;
