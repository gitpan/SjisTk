use Sjis 0.64;
use Tk;
use Tk::ROText;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$rotext = $mw->ROText(@font)->pack;

while(<DATA>){
    $rotext->insert('end', $_);
}

MainLoop;

__END__
�\
�\
�����
