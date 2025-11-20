<?php
namespace App\Http\Controllers;

use App\Models\ReporteCaracteristica;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ReporteCaracteristicaController extends Controller
{
    public function index($reporteId)
    {
        $caracteristicas = ReporteCaracteristica::where('reporte_id', $reporteId)->get();
        
        return response()->json($caracteristicas);
    }

    public function store(Request $request, $reporteId)
    {
        $validator = Validator::make($request->all(), [
            'clave' => 'required|string|max:100',
            'valor' => 'required|string'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $caracteristica = ReporteCaracteristica::create([
            'reporte_id' => $reporteId,
            'clave' => $request->clave,
            'valor' => $request->valor
        ]);
        
        return response()->json($caracteristica, 201);
    }

    public function update(Request $request, $reporteId, $id)
    {
        $caracteristica = ReporteCaracteristica::where('reporte_id', $reporteId)
            ->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'valor' => 'required|string'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $caracteristica->update(['valor' => $request->valor]);
        
        return response()->json($caracteristica);
    }

    public function destroy($reporteId, $id)
    {
        $caracteristica = ReporteCaracteristica::where('reporte_id', $reporteId)
            ->findOrFail($id);
        $caracteristica->delete();
        
        return response()->json(['message' => 'Característica eliminada correctamente'], 200);
    }
}