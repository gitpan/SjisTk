use Sjis 0.64;
use Tk;
use Tk::LabFrame;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$f1 = $mw->LabFrame(
    @font,
    '-label'       => '�\',
    '-labelside'   => 'acrosstop',
    '-borderwidth' => 2,
    '-relief'      => 'raised',
)->pack;
$f1->Button(
    @font,
    '-text'    => '�{�^��',
    '-command' => sub {},
)->pack;
$labelvariable = '�\';
$f2 = $mw->LabFrame(
    @font,
    '-labelvariable' => \$labelvariable,
    '-labelside'     => 'acrosstop',
    '-borderwidth'   => 2,
    '-relief'        => 'raised',
)->pack;
$f2->Button(
    @font,
    '-text'    => '�{�^��',
    '-command' => sub {},
)->pack;

MainLoop;
