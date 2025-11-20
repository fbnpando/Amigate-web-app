<?php

namespace App\Http\Controllers;

use App\Models\CuadranteBarrio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CuadranteBarrioController extends Controller
{
    public function index($cuadranteId)
    {
        $barrios = CuadranteBarrio::where('cuadrante_id', $cuadranteId)
            ->orderBy('nombre_barrio')
            ->get();
        
        return response()->json($barrios);
    }

    public function store(Request $request, $cuadranteId)
    {
        $validator = Validator::make($request->all(), [
            'nombre_barrio' => 'required|string|max:200'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $barrio = CuadranteBarrio::create([
            'cuadrante_id' => $cuadranteId,
            'nombre_barrio' => $request->nombre_barrio
        ]);
        
        return response()->json($barrio, 201);
    }

    public function show($cuadranteId, $id)
    {
        $barrio = CuadranteBarrio::where('cuadrante_id', $cuadranteId)
            ->findOrFail($id);
        
        return response()->json($barrio);
    }

    public function update(Request $request, $cuadranteId, $id)
    {
        $barrio = CuadranteBarrio::where('cuadrante_id', $cuadranteId)
            ->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'nombre_barrio' => 'required|string|max:200'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $barrio->update($request->all());
        
        return response()->json($barrio);
    }

    public function destroy($cuadranteId, $id)
    {
        $barrio = CuadranteBarrio::where('cuadrante_id', $cuadranteId)
            ->findOrFail($id);
        $barrio->delete();
        
        return response()->json(['message' => 'Barrio eliminado correctamente'], 200);
    }
}