<?php
namespace App\Http\Controllers;

use App\Models\ExpansionReporte;
use App\Models\Reporte;
use App\Models\Cuadrante;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ExpansionReporteController extends Controller
{
    public function index($reporteId)
    {
        $expansiones = ExpansionReporte::where('reporte_id', $reporteId)
            ->with('cuadranteExpandido')
            ->orderBy('nivel')
            ->get();
        
        return response()->json($expansiones);
    }

    public function store(Request $request, $reporteId)
    {
        $validator = Validator::make($request->all(), [
            'cuadrante_expandido_id' => 'required|exists:cuadrantes,id',
            'nivel' => 'required|integer|min:1|max:10'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $reporte = Reporte::findOrFail($reporteId);

        // Verificar que no se exceda el máximo de expansión
        if ($request->nivel > $reporte->max_expansion) {
            return response()->json([
                'error' => 'El nivel de expansión excede el máximo permitido'
            ], 422);
        }

        $expansion = ExpansionReporte::create([
            'reporte_id' => $reporteId,
            'cuadrante_expandido_id' => $request->cuadrante_expandido_id,
            'nivel' => $request->nivel
        ]);
        
        return response()->json($expansion, 201);
    }

    public function show($reporteId, $id)
    {
        $expansion = ExpansionReporte::where('reporte_id', $reporteId)
            ->with('cuadranteExpandido')
            ->findOrFail($id);
        
        return response()->json($expansion);
    }

    public function destroy($reporteId, $id)
    {
        $expansion = ExpansionReporte::where('reporte_id', $reporteId)
            ->findOrFail($id);
        $expansion->delete();
        
        return response()->json(['message' => 'Expansión eliminada correctamente'], 200);
    }

    public function expandirAutomatico($reporteId)
    {
        $reporte = Reporte::with('cuadrante', 'expansiones')->findOrFail($reporteId);

        // Verificar si puede expandir más
        if ($reporte->nivel_expansion >= $reporte->max_expansion) {
            return response()->json([
                'message' => 'El reporte ya alcanzó su nivel máximo de expansión'
            ], 422);
        }

        // Obtener cuadrantes adyacentes (esto es un ejemplo simplificado)
        $cuadranteActual = $reporte->cuadrante;
        $cuadrantesAdyacentes = Cuadrante::where('activo', true)
            ->where('id', '!=', $cuadranteActual->id)
            ->whereRaw('ABS(fila::int - ?::int) <= 1', [$cuadranteActual->fila])
            ->whereRaw('ABS(columna - ?) <= 1', [$cuadranteActual->columna])
            ->get();

        $nuevoNivel = $reporte->nivel_expansion + 1;
        $expansionesCreadas = [];

        foreach ($cuadrantesAdyacentes as $cuadrante) {
            // Verificar si no existe ya esta expansión
            $existente = $reporte->expansiones()
                ->where('cuadrante_expandido_id', $cuadrante->id)
                ->exists();

            if (!$existente) {
                $expansion = ExpansionReporte::create([
                    'reporte_id' => $reporteId,
                    'cuadrante_expandido_id' => $cuadrante->id,
                    'nivel' => $nuevoNivel
                ]);
                $expansionesCreadas[] = $expansion;
            }
        }

        // Actualizar el nivel de expansión del reporte
        $reporte->update([
            'nivel_expansion' => $nuevoNivel,
            'proxima_expansion' => now()->addHours(24) // 24 horas para la próxima expansión
        ]);

        return response()->json([
            'message' => 'Expansión automática realizada correctamente',
            'nivel_actual' => $nuevoNivel,
            'expansiones_creadas' => count($expansionesCreadas),
            'expansiones' => $expansionesCreadas
        ], 201);
    }
}
