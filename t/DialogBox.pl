use Sjis 0.64;
use Tk;
use Tk::DialogBox;

$mw = MainWindow->new;
$mw->DialogBox(
    '-title'          => '�\',
    '-buttons'        => ['�\', '�\'],
    '-default_button' => '�\',
    '-cancel_button'  => '�\',
)->Show;
MainLoop;
