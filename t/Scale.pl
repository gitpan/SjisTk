use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$mw->Scale(
    @font,
    '-from'         => 0,
    '-to'           => 100,
    '-label'        => '�\',
    '-bigincrement' => 10,
    '-length'       => 200,
    '-orient'       => 'horizontal',
    '-resolution'   => 2,
    '-showvalue'    => 'yes',
    '-sliderlength' => 20,
    '-sliderrelief' => 'raised',
    '-tickinterval' => 10,
    '-variable'     => \$variable,
    '-width'        => 20,
    '-command'      => sub {},
)->pack;
MainLoop;
