<?php

namespace App\Http\Controllers;

use App\Models\RespuestaImagen;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class RespuestaImagenController extends Controller
{
    public function index($respuestaId)
    {
        $imagenes = RespuestaImagen::where('respuesta_id', $respuestaId)
            ->orderBy('orden')
            ->get();
        
        return response()->json($imagenes);
    }

    public function store(Request $request, $respuestaId)
    {
        $validator = Validator::make($request->all(), [
            'url' => 'required|url',
            'orden' => 'nullable|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $imagen = RespuestaImagen::create([
            'respuesta_id' => $respuestaId,
            'url' => $request->url,
            'orden' => $request->orden ?? 0
        ]);
        
        return response()->json($imagen, 201);
    }

    public function destroy($respuestaId, $id)
    {
        $imagen = RespuestaImagen::where('respuesta_id', $respuestaId)
            ->findOrFail($id);
        $imagen->delete();
        
        return response()->json(['message' => 'Imagen eliminada correctamente'], 200);
    }
}
