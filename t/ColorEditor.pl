use Sjis 0.64;
use Tk;
use Tk::ColorEditor;

$mw = MainWindow->new;
$cref = $mw->ColorEditor(
    '-title' => 'ƒ\',
    '-cursor' => 'hand2',
);
$cref->Show;
MainLoop;
