<?php




namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Reporte;
use App\Models\Usuario;
use App\Models\Categoria;
use App\Models\Cuadrante;
use Illuminate\Http\Request;

class ReporteWebController extends Controller
{
    public function index()
    {
        $reportes = Reporte::with(['usuario', 'categoria', 'cuadrante'])
            ->orderBy('created_at', 'desc')
            ->get();
        
        $categorias = Categoria::where('activo', true)->get();
        
        return view('reportes.index', compact('reportes', 'categorias'));
    }

    public function create()
    {
        $usuarios = Usuario::where('activo', true)->get();
        $categorias = Categoria::where('activo', true)->get();
        $cuadrantes = Cuadrante::where('activo', true)->get();
        
        return view('reportes.create', compact('usuarios', 'categorias', 'cuadrantes'));
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'usuario_id' => 'required|uuid|exists:usuarios,id',
            'categoria_id' => 'required|uuid|exists:categorias,id',
            'cuadrante_id' => 'required|uuid|exists:cuadrantes,id',
            'tipo_reporte' => 'required|in:perdido,encontrado',
            'titulo' => 'required|string|max:200',
            'descripcion' => 'required|string',
            'fecha_perdida' => 'nullable|date',
            'direccion_referencia' => 'nullable|string',
            'prioridad' => 'nullable|in:baja,normal,alta,urgente',
            'estado' => 'nullable|in:activo,resuelto,inactivo,spam',
            'contacto_publico' => 'nullable|boolean',
            'telefono_contacto' => 'nullable|string|max:20',
            'email_contacto' => 'nullable|email',
            'recompensa' => 'nullable|numeric|min:0'
        ]);

        Reporte::create($validatedData);

        return redirect()->route('reportes.index')
            ->with('success', 'Reporte creado exitosamente');
    }

    public function show(string $id)
    {
        $reporte = Reporte::with(['usuario', 'categoria', 'cuadrante', 'respuestas'])
            ->findOrFail($id);
        
        
        $reporte->increment('vistas');
        
        return view('reportes.show', compact('reporte'));
    }

    public function edit(string $id)
    {
        $reporte = Reporte::findOrFail($id);
        $usuarios = Usuario::where('activo', true)->get();
        $categorias = Categoria::where('activo', true)->get();
        $cuadrantes = Cuadrante::where('activo', true)->get();
        
        return view('reportes.edit', compact('reporte', 'usuarios', 'categorias', 'cuadrantes'));
    }

    public function update(Request $request, string $id)
    {
        $reporte = Reporte::findOrFail($id);

        $validatedData = $request->validate([
            'titulo' => 'required|string|max:200',
            'descripcion' => 'required|string',
            'estado' => 'nullable|in:activo,resuelto,inactivo,spam',
            'prioridad' => 'nullable|in:baja,normal,alta,urgente',
            'recompensa' => 'nullable|numeric|min:0'
        ]);

        $reporte->update($validatedData);

        return redirect()->route('reportes.index')
            ->with('success', 'Reporte actualizado exitosamente');
    }

    public function destroy(string $id)
    {
        $reporte = Reporte::findOrFail($id);
        $reporte->delete();

        return redirect()->route('reportes.index')
            ->with('success', 'Reporte eliminado exitosamente');
    }
}