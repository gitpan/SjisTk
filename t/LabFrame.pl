use Sjis 0.64;
use Tk;
use Tk::LabFrame;
@font = ('-font' => ['ＭＳ　Ｐゴシック', 12, 'normal']);

$mw = MainWindow->new;
$f1 = $mw->LabFrame(
    @font,
    '-label'       => 'ソ',
    '-labelside'   => 'acrosstop',
    '-borderwidth' => 2,
    '-relief'      => 'raised',
)->pack;
$f1->Button(
    @font,
    '-text'    => 'ボタン',
    '-command' => sub {},
)->pack;
$labelvariable = '表';
$f2 = $mw->LabFrame(
    @font,
    '-labelvariable' => \$labelvariable,
    '-labelside'     => 'acrosstop',
    '-borderwidth'   => 2,
    '-relief'        => 'raised',
)->pack;
$f2->Button(
    @font,
    '-text'    => 'ボタン',
    '-command' => sub {},
)->pack;

MainLoop;
