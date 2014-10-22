use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
if ($] >= 5.007) {
    $f1 = $mw->Frame(
        '-label'       => '�\',
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
    '-text'    => '�\',
    '-command' => sub {},
)->pack;
if ($] >= 5.007) {
    $labelVariable = '�\';
    $f2 = $mw->Frame(
        '-labelVariable' => \$labelVariable,
        '-borderwidth'   => 2,
        '-relief'        => 'raised',
    )->pack;
    $f2->Button(
        @font,
        '-text'    => '�X�V',
        '-command' => sub {
            require Encode;
            $labelVariable = Encode::decode('cp932', "�\" . ++$no);
        },
    )->pack;
}
MainLoop;
