<?php
// ============================================
// app/Http/Controllers/Web/DashboardController.php
// ============================================
namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Reporte;
use App\Models\Usuario;
use App\Models\Categoria;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        $totalReportes = Reporte::count();
        $totalUsuarios = Usuario::count();
        $reportesActivos = Reporte::where('estado', 'activo')->count();
        $reportesResueltos = Reporte::where('estado', 'resuelto')->count();
        $reportesPerdidos = Reporte::where('tipo_reporte', 'perdido')->count();
        $reportesEncontrados = Reporte::where('tipo_reporte', 'encontrado')->count();
        
        // Reportes por prioridad
        $reportesBaja = Reporte::where('prioridad', 'baja')->count();
        $reportesNormal = Reporte::where('prioridad', 'normal')->count();
        $reportesAlta = Reporte::where('prioridad', 'alta')->count();
        $reportesUrgente = Reporte::where('prioridad', 'urgente')->count();
        
        // Últimos reportes
        $ultimosReportes = Reporte::with(['usuario', 'categoria', 'cuadrante'])
            ->orderBy('created_at', 'desc')
            ->limit(10)
            ->get();
        
        // Nuevos usuarios
        $nuevosUsuarios = Usuario::orderBy('created_at', 'desc')
            ->limit(5)
            ->get();
        
        // Categorías populares
        $categoriasPopulares = Categoria::withCount('reportes')
            ->orderBy('reportes_count', 'desc')
            ->limit(5)
            ->get();
        
        return view('dashboard', compact(
            'totalReportes',
            'totalUsuarios',
            'reportesActivos',
            'reportesResueltos',
            'reportesPerdidos',
            'reportesEncontrados',
            'reportesBaja',
            'reportesNormal',
            'reportesAlta',
            'reportesUrgente',
            'ultimosReportes',
            'nuevosUsuarios',
            'categoriasPopulares'
        ));
    }
}



