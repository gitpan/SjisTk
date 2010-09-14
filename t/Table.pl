use Sjis 0.64;
use Tk;
use Tk::Table;

$mw = MainWindow->new;
$table = $mw->Table(
    '-rows'    => 3,
    '-columns' => 3,
)->pack;

for my $x (1,2,3){
    for my $y (1,2,3){
        if ($] >= 5.007) {
            $table->put($x, $y, 'ƒ\');
        }
        else {
            $table->put($x, $y, 'A');
        }
    }
}

MainLoop;
