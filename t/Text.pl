use Sjis 0.64;
use Tk;
@font = ('-font' => ['�l�r�@�o�S�V�b�N', 12, 'normal']);

$mw = MainWindow->new;
$text = $mw->Text(@font)->pack;

while(<DATA>){
    $text->insert('end', $_);
}

MainLoop;

__END__
�\
�\
�����
