use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$mw->Label(
    @font,
    '-text' => '�\',
)->pack;
$textvariable = '�\';
$mw->Label(
    @font,
    '-textvariable' => \$textvariable,
)->pack;
$mw->Button(
    @font,
    '-text'    => '�N���b�N',
    '-command' => sub {
        if ($] >= 5.007) {
            require Encode;
            $textvariable = Encode::decode('cp932', "�\" . ++$no);
        }
        else {
            $textvariable = "�\" . ++$no;
        }
    },
)->pack;
MainLoop;
