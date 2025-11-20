<?php

namespace App\Http\Controllers;

use App\Models\ReporteImagen;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ReporteImagenController extends Controller
{
    public function index($reporteId)
    {
        $imagenes = ReporteImagen::where('reporte_id', $reporteId)
            ->orderBy('orden')
            ->get();
        
        return response()->json($imagenes);
    }

    public function store(Request $request, $reporteId)
    {
        $validator = Validator::make($request->all(), [
            'url' => 'required|url',
            'orden' => 'nullable|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $imagen = ReporteImagen::create([
            'reporte_id' => $reporteId,
            'url' => $request->url,
            'orden' => $request->orden ?? 0
        ]);
        
        return response()->json($imagen, 201);
    }

    public function update(Request $request, $reporteId, $id)
    {
        $imagen = ReporteImagen::where('reporte_id', $reporteId)
            ->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'url' => 'sometimes|url',
            'orden' => 'nullable|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $imagen->update($request->all());
        
        return response()->json($imagen);
    }

    public function destroy($reporteId, $id)
    {
        $imagen = ReporteImagen::where('reporte_id', $reporteId)
            ->findOrFail($id);
        $imagen->delete();
        
        return response()->json(['message' => 'Imagen eliminada correctamente'], 200);
    }

    public function reordenar(Request $request, $reporteId)
    {
        $validator = Validator::make($request->all(), [
            'imagenes' => 'required|array',
            'imagenes.*.id' => 'required|exists:reporte_imagenes,id',
            'imagenes.*.orden' => 'required|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        foreach ($request->imagenes as $item) {
            ReporteImagen::where('id', $item['id'])
                ->where('reporte_id', $reporteId)
                ->update(['orden' => $item['orden']]);
        }
        
        return response()->json(['message' => 'Imágenes reordenadas correctamente'], 200);
    }
}