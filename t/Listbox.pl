use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$listbox = $mw->Listbox(@font)->pack;

while(<DATA>){
    $listbox->insert('end', $_);
}

MainLoop;

__END__
�\
�\
�����
