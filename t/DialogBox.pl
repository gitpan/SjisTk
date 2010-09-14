use Sjis 0.64;
use Tk;
use Tk::DialogBox;

$mw = MainWindow->new;
$mw->DialogBox(
    '-title'          => 'ソ',
    '-buttons'        => ['表', 'ソ'],
    '-default_button' => '表',
    '-cancel_button'  => 'ソ',
)->Show;
MainLoop;
