use Sjis 0.64;
use Tk;
use Tk::Dialog;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$mw->Dialog(
    @font,
    '-title'          => 'test',
    '-text'           => '�\',
    '-buttons'        => ['Yes', 'No'],
    '-default_button' => 'No',
)->Show;
MainLoop;
