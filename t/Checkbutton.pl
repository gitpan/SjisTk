use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$mw->Checkbutton(
    @font,
    '-text' => '�\',
    '-variable' => \$variable1,
    '-onvalue'  => '�\��',
    '-offvalue' => '���\',
    '-command' => sub {
        print "�l�� $variable1 �ɂȂ�܂����B\n";
    },
)->pack;
$textvariable = '�\';
$mw->Checkbutton(
    @font,
    '-textvariable' => \$textvariable,
    '-variable' => \$variable2,
    '-onvalue'  => '��',
    '-offvalue' => '��',
    '-command' => sub {
        print "�l�� $variable2 �ɂȂ�܂����B\n";
    },
)->pack;
MainLoop;
