<?php
namespace App\Http\Controllers;

use App\Models\Reporte;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class ReporteController extends Controller
{
    public function index(Request $request)
    {
        $query = Reporte::with([
            'usuario', 
            'categoria', 
            'cuadrante', 
            'imagenes', 
            'videos'
        ]);

        if ($request->has('tipo_reporte')) {
            $query->where('tipo_reporte', $request->tipo_reporte);
        }

        if ($request->has('estado')) {
            $query->where('estado', $request->estado);
        }

        if ($request->has('categoria_id')) {
            $query->where('categoria_id', $request->categoria_id);
        }

        if ($request->has('cuadrante_id')) {
            $query->where('cuadrante_id', $request->cuadrante_id);
        }

        $reportes = $query->orderBy('fecha_reporte', 'desc')->paginate(15);
        
        return response()->json($reportes);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'usuario_id' => 'required|exists:usuarios,id',
            'categoria_id' => 'required|exists:categorias,id',
            'cuadrante_id' => 'required|exists:cuadrantes,id',
            'tipo_reporte' => 'required|in:perdido,encontrado',
            'titulo' => 'required|string|max:200',
            'descripcion' => 'required|string',
            'ubicacion_exacta_lat' => 'nullable|numeric|between:-90,90',
            'ubicacion_exacta_lng' => 'nullable|numeric|between:-180,180',
            'direccion_referencia' => 'nullable|string',
            'fecha_perdida' => 'nullable|date',
            'prioridad' => 'nullable|in:baja,normal,alta,urgente',
            'telefono_contacto' => 'nullable|string|max:20',
            'email_contacto' => 'nullable|email|max:255',
            'recompensa' => 'nullable|numeric|min:0',
            'caracteristicas' => 'nullable|array',
            'imagenes' => 'nullable|array',
            'videos' => 'nullable|array'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        DB::beginTransaction();
        try {
            $reporte = Reporte::create($request->except(['caracteristicas', 'imagenes', 'videos']));

            // Agregar características
            if ($request->has('caracteristicas')) {
                foreach ($request->caracteristicas as $clave => $valor) {
                    $reporte->caracteristicas()->create([
                        'clave' => $clave,
                        'valor' => $valor
                    ]);
                }
            }

            // Agregar imágenes
            if ($request->has('imagenes')) {
                foreach ($request->imagenes as $index => $url) {
                    $reporte->imagenes()->create([
                        'url' => $url,
                        'orden' => $index
                    ]);
                }
            }

            // Agregar videos
            if ($request->has('videos')) {
                foreach ($request->videos as $index => $url) {
                    $reporte->videos()->create([
                        'url' => $url,
                        'orden' => $index
                    ]);
                }
            }

            DB::commit();
            
            return response()->json($reporte->load(['caracteristicas', 'imagenes', 'videos']), 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Error al crear reporte: ' . $e->getMessage()], 500);
        }
    }

    public function show($id)
    {
        $reporte = Reporte::with([
            'usuario',
            'categoria',
            'cuadrante',
            'caracteristicas',
            'imagenes',
            'videos',
            'respuestas.usuario',
            'respuestas.imagenes',
            'respuestas.videos'
        ])->findOrFail($id);

        // Incrementar vistas
        $reporte->increment('vistas');
        
        return response()->json($reporte);
    }

    public function update(Request $request, $id)
    {
        $reporte = Reporte::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'titulo' => 'sometimes|string|max:200',
            'descripcion' => 'sometimes|string',
            'estado' => 'sometimes|in:activo,resuelto,inactivo,spam',
            'prioridad' => 'sometimes|in:baja,normal,alta,urgente',
            'telefono_contacto' => 'nullable|string|max:20',
            'email_contacto' => 'nullable|email|max:255',
            'recompensa' => 'nullable|numeric|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $reporte->update($request->all());
        
        return response()->json($reporte);
    }

    public function destroy($id)
    {
        $reporte = Reporte::findOrFail($id);
        $reporte->delete();
        
        return response()->json(['message' => 'Reporte eliminado correctamente'], 200);
    }

    public function cambiarEstado(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'estado' => 'required|in:activo,resuelto,inactivo,spam'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $reporte = Reporte::findOrFail($id);
        $reporte->update(['estado' => $request->estado]);
        
        return response()->json($reporte);
    }

    public function buscarCercanos(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'lat' => 'required|numeric|between:-90,90',
            'lng' => 'required|numeric|between:-180,180',
            'radio_km' => 'nullable|numeric|min:0|max:50'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $lat = $request->lat;
        $lng = $request->lng;
        $radio = $request->radio_km ?? 5;

        $reportes = Reporte::selectRaw("
                *,
                (6371 * acos(cos(radians(?)) * cos(radians(ubicacion_exacta_lat)) 
                * cos(radians(ubicacion_exacta_lng) - radians(?)) 
                + sin(radians(?)) * sin(radians(ubicacion_exacta_lat)))) AS distancia
            ", [$lat, $lng, $lat])
            ->having('distancia', '<=', $radio)
            ->where('estado', 'activo')
            ->with(['usuario', 'categoria', 'imagenes'])
            ->orderBy('distancia')
            ->get();
        
        return response()->json($reportes);
    }
}
