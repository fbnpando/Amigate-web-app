<?php

namespace App\Http\Controllers;

use App\Models\Respuesta;
use App\Models\Reporte;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class RespuestaController extends Controller
{
    public function index($reporteId)
    {
        $respuestas = Respuesta::where('reporte_id', $reporteId)
            ->with(['usuario', 'imagenes', 'videos'])
            ->orderBy('created_at', 'desc')
            ->get();
        
        return response()->json($respuestas);
    }

    public function store(Request $request, $reporteId)
    {
        $validator = Validator::make($request->all(), [
            'usuario_id' => 'required|exists:usuarios,id',
            'tipo_respuesta' => 'required|in:avistamiento,encontrado,informacion,pregunta',
            'mensaje' => 'required|string',
            'ubicacion_lat' => 'nullable|numeric|between:-90,90',
            'ubicacion_lng' => 'nullable|numeric|between:-180,180',
            'direccion_referencia' => 'nullable|string',
            'imagenes' => 'nullable|array',
            'videos' => 'nullable|array'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $reporte = Reporte::findOrFail($reporteId);

        DB::beginTransaction();
        try {
            $respuesta = $reporte->respuestas()->create($request->except(['imagenes', 'videos']));

            // Agregar imágenes
            if ($request->has('imagenes')) {
                foreach ($request->imagenes as $index => $url) {
                    $respuesta->imagenes()->create([
                        'url' => $url,
                        'orden' => $index
                    ]);
                }
            }

            // Agregar videos
            if ($request->has('videos')) {
                foreach ($request->videos as $index => $url) {
                    $respuesta->videos()->create([
                        'url' => $url,
                        'orden' => $index
                    ]);
                }
            }

            DB::commit();
            
            return response()->json($respuesta->load(['imagenes', 'videos']), 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Error al crear respuesta: ' . $e->getMessage()], 500);
        }
    }

    public function show($reporteId, $id)
    {
        $respuesta = Respuesta::where('reporte_id', $reporteId)
            ->with(['usuario', 'imagenes', 'videos'])
            ->findOrFail($id);
        
        return response()->json($respuesta);
    }

    public function update(Request $request, $reporteId, $id)
    {
        $respuesta = Respuesta::where('reporte_id', $reporteId)->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'mensaje' => 'sometimes|string',
            'verificada' => 'nullable|boolean',
            'util' => 'nullable|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $respuesta->update($request->all());
        
        return response()->json($respuesta);
    }

    public function destroy($reporteId, $id)
    {
        $respuesta = Respuesta::where('reporte_id', $reporteId)->findOrFail($id);
        $respuesta->delete();
        
        return response()->json(['message' => 'Respuesta eliminada correctamente'], 200);
    }

    public function marcarVerificada($reporteId, $id)
    {
        $respuesta = Respuesta::where('reporte_id', $reporteId)->findOrFail($id);
        $respuesta->update(['verificada' => true]);
        
        return response()->json($respuesta);
    }

    public function marcarUtil(Request $request, $reporteId, $id)
    {
        $validator = Validator::make($request->all(), [
            'util' => 'required|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $respuesta = Respuesta::where('reporte_id', $reporteId)->findOrFail($id);
        $respuesta->update(['util' => $request->util]);
        
        return response()->json($respuesta);
    }
}