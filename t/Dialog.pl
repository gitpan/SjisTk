use Sjis 0.64;
use Tk;
use Tk::Dialog;
@font = ('-font' => ['‚l‚r@‚oƒSƒVƒbƒN', 12, 'normal']);

$mw = MainWindow->new;
$mw->Dialog(
    @font,
    '-title'          => 'test',
    '-text'           => 'ƒ\',
    '-buttons'        => ['Yes', 'No'],
    '-default_button' => 'No',
)->Show;
MainLoop;
