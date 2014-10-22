use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$mw->Radiobutton(
    @font,
    '-text' => '�\',
    '-variable' => \$variable,
    '-value'    => '�\',
    '-command' => sub {
        if ($] >= 5.007) {
            require Encode;
            my $cp932 = Encode::encode('cp932', $variable);
            print "�l�� $cp932 �ɂȂ�܂����B\n";
        }
        else{
            print "�l�� $variable �ɂȂ�܂����B\n";
        }
    },
)->pack;
$textvariable = '�\';
$mw->Radiobutton(
    @font,
    '-textvariable' => \$textvariable,
    '-variable' => \$variable,
    '-value'    => '��',
    '-command' => sub {
        if ($] >= 5.007) {
            require Encode;
            my $cp932 = Encode::encode('cp932', $variable);
            print "�l�� $cp932 �ɂȂ�܂����B\n";
        }
        else{
            print "�l�� $variable �ɂȂ�܂����B\n";
        }
    },
)->pack;
MainLoop;
