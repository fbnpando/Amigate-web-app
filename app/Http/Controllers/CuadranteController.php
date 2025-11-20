<?php

namespace App\Http\Controllers;

use App\Models\Cuadrante;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Cache; // ← AGREGAR ESTO

class CuadranteController extends Controller
{
    public function index(Request $request)
    {
        // Cachear por 1 hora (opcional, puedes quitarlo si prefieres)
        $cuadrantes = Cache::remember('cuadrantes_activos', 3600, function () {
            return Cuadrante::with('barrios')
                ->where('activo', true)
                ->get();
        });
        
        return response()->json($cuadrantes);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'codigo' => 'required|string|max:20|unique:cuadrantes,codigo',
            'fila' => 'required|string|max:5',
            'columna' => 'required|integer',
            'nombre' => 'nullable|string|max:100',
            'lat_min' => 'required|numeric',
            'lat_max' => 'required|numeric',
            'lng_min' => 'required|numeric',
            'lng_max' => 'required|numeric',
            'centro_lat' => 'nullable|numeric',
            'centro_lng' => 'nullable|numeric',
            'ciudad' => 'required|string|max:100',
            'zona' => 'nullable|string|max:100'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $cuadrante = Cuadrante::create($request->all());
        
        // Limpiar caché cuando se crea un cuadrante nuevo
        Cache::forget('cuadrantes_activos');
        
        return response()->json($cuadrante, 201);
    }

    public function show($id)
    {
        $cuadrante = Cuadrante::with(['barrios', 'reportes', 'grupos'])
            ->findOrFail($id);
        
        return response()->json($cuadrante);
    }

    public function update(Request $request, $id)
    {
        $cuadrante = Cuadrante::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'codigo' => 'sometimes|string|max:20|unique:cuadrantes,codigo,' . $id,
            'nombre' => 'nullable|string|max:100',
            'ciudad' => 'sometimes|string|max:100',
            'zona' => 'nullable|string|max:100',
            'activo' => 'nullable|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $cuadrante->update($request->all());
        
        // Limpiar caché
        Cache::forget('cuadrantes_activos');
        
        return response()->json($cuadrante);
    }

    public function destroy($id)
    {
        $cuadrante = Cuadrante::findOrFail($id);
        $cuadrante->delete();
        
        // Limpiar caché
        Cache::forget('cuadrantes_activos');
        
        return response()->json(['message' => 'Cuadrante eliminado correctamente'], 200);
    }

    public function buscarPorCoordenadas(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'lat' => 'required|numeric|between:-90,90',
            'lng' => 'required|numeric|between:-180,180'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $cuadrante = Cuadrante::where('lat_min', '<=', $request->lat)
            ->where('lat_max', '>=', $request->lat)
            ->where('lng_min', '<=', $request->lng)
            ->where('lng_max', '>=', $request->lng)
            ->where('activo', true)
            ->with('barrios') // Incluir barrios
            ->first();

        if (!$cuadrante) {
            return response()->json(['message' => 'No se encontró cuadrante para estas coordenadas'], 404);
        }
        
        return response()->json($cuadrante);
    }

    public function obtenerCercanos(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'lat' => 'required|numeric',
                'lng' => 'required|numeric',
                'radio' => 'nullable|numeric|min:0.01|max:10'
            ]);

            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            $lat = $request->lat;
            $lng = $request->lng;
            $radio = $request->radio ?? 2; // km

            $formula = "
                6371 * acos(
                    cos(radians($lat)) *
                    cos(radians(centro_lat)) *
                    cos(radians(centro_lng) - radians($lng)) +
                    sin(radians($lat)) *
                    sin(radians(centro_lat))
                )
            ";

            $cuadrantes = Cuadrante::selectRaw("cuadrantes.*, $formula AS distancia")
                ->whereRaw("$formula < ?", [$radio])
                ->orderBy("distancia", "asc")
                ->with('barrios')
                ->limit(20)
                ->get();

            return response()->json($cuadrantes);

        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }



}