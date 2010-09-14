use Sjis 0.64;
use Tk;
@font = ('-font' => ['ＭＳ　Ｐゴシック', 12, 'normal']);

$mw = MainWindow->new;
$mw->Checkbutton(
    @font,
    '-text' => 'ソ',
    '-variable' => \$variable1,
    '-onvalue'  => '表裏',
    '-offvalue' => '裏表',
    '-command' => sub {
        print "値が $variable1 になりました。\n";
    },
)->pack;
$textvariable = '表';
$mw->Checkbutton(
    @font,
    '-textvariable' => \$textvariable,
    '-variable' => \$variable2,
    '-onvalue'  => 'あ',
    '-offvalue' => 'い',
    '-command' => sub {
        print "値が $variable2 になりました。\n";
    },
)->pack;
MainLoop;
