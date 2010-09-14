use Sjis 0.64;
use Tk;
@font = ('-font' => ['‚l‚r@‚oƒSƒVƒbƒN', 12, 'normal']);

$mw = MainWindow->new;
$mw->Button(
    @font,
    '-text'    => 'ƒ\',
    '-command' => sub {},
)->pack;
$textvariable = '•\';
$mw->Button(
    @font,
    '-textvariable' => \$textvariable,
    '-command'      => sub {},
)->pack;
MainLoop;
