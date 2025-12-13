<?php



namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\ConfiguracionSistema;
use Illuminate\Http\Request;

class ConfiguracionWebController extends Controller
{
    public function index()
    {
        $configuraciones = ConfiguracionSistema::orderBy('clave')->get();
        return view('configuracion.index', compact('configuraciones'));
    }
}