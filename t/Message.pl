use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$mw->Message(
    @font,
    '-text' => '�\',
)->pack;
$textvariable = '�\';
$mw->Message(
    @font,
    '-textvariable' => \$textvariable,
)->pack;
MainLoop;
