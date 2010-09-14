use Sjis 0.64;
use Tk;
@font = ('-font' => ['ＭＳ　Ｐゴシック', 12, 'normal']);

$mw = MainWindow->new;
$mw->Label(
    @font,
    '-text' => 'ソ',
)->pack;
$textvariable = '表';
$mw->Label(
    @font,
    '-textvariable' => \$textvariable,
)->pack;
$mw->Button(
    @font,
    '-text'    => 'クリック',
    '-command' => sub {
        if ($] >= 5.007) {
            require Encode;
            $textvariable = Encode::decode('cp932', "表" . ++$no);
        }
        else {
            $textvariable = "表" . ++$no;
        }
    },
)->pack;
MainLoop;
