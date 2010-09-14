use Sjis 0.64;
use Tk;
@font = ('-font' => ['ＭＳ　Ｐゴシック', 12, 'normal']);

$mw = MainWindow->new;
if ($] >= 5.007) {
    $f1 = $mw->Frame(
        '-label'       => 'ソ',
        '-borderwidth' => 2,
        '-relief'      => 'raised',
    )->pack;
}
else {
    $f1 = $mw->Frame(
        '-label'       => 'A',
        '-borderwidth' => 2,
        '-relief'      => 'raised',
    )->pack;
}
$f1->Button(
    @font,
    '-text'    => 'ソ',
    '-command' => sub {},
)->pack;
if ($] >= 5.007) {
    $labelVariable = '表';
    $f2 = $mw->Frame(
        '-labelVariable' => \$labelVariable,
        '-borderwidth'   => 2,
        '-relief'        => 'raised',
    )->pack;
    $f2->Button(
        @font,
        '-text'    => '更新',
        '-command' => sub {
            require Encode;
            $labelVariable = Encode::decode('cp932', "表" . ++$no);
        },
    )->pack;
}
MainLoop;
