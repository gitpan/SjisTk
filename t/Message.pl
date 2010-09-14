use Sjis 0.64;
use Tk;
@font = ('-font' => ['‚l‚r@‚oƒSƒVƒbƒN', 12, 'normal']);

$mw = MainWindow->new;
$mw->Message(
    @font,
    '-text' => 'ƒ\',
)->pack;
$textvariable = '•\';
$mw->Message(
    @font,
    '-textvariable' => \$textvariable,
)->pack;
MainLoop;
