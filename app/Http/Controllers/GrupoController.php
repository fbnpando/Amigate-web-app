<?php

namespace App\Http\Controllers;

use App\Models\Grupo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class GrupoController extends Controller
{
    public function index()
    {
        $grupos = Grupo::with(['cuadrante', 'miembros.usuario'])
            ->where('publico', true)
            ->paginate(15);
        
        return response()->json($grupos);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'cuadrante_id' => 'required|exists:cuadrantes,id',
            'nombre' => 'required|string|max:200',
            'descripcion' => 'nullable|string',
            'imagen_url' => 'nullable|url',
            'publico' => 'nullable|boolean',
            'requiere_aprobacion' => 'nullable|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $grupo = Grupo::create($request->all());
        
        return response()->json($grupo, 201);
    }

    public function show($id)
    {
        $grupo = Grupo::with(['cuadrante', 'miembros.usuario'])
            ->findOrFail($id);
        
        return response()->json($grupo);
    }

    public function update(Request $request, $id)
    {
        $grupo = Grupo::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'nombre' => 'sometimes|string|max:200',
            'descripcion' => 'nullable|string',
            'imagen_url' => 'nullable|url',
            'publico' => 'nullable|boolean',
            'requiere_aprobacion' => 'nullable|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $grupo->update($request->all());
        
        return response()->json($grupo);
    }

    public function destroy($id)
    {
        $grupo = Grupo::findOrFail($id);
        $grupo->delete();
        
        return response()->json(['message' => 'Grupo eliminado correctamente'], 200);
    }

    public function agregarMiembro(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'usuario_id' => 'required|exists:usuarios,id',
            'rol' => 'nullable|in:miembro,moderador,admin'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $grupo = Grupo::findOrFail($id);
        
        $miembro = $grupo->miembros()->create([
            'usuario_id' => $request->usuario_id,
            'rol' => $request->rol ?? 'miembro'
        ]);
        
        return response()->json($miembro, 201);
    }

    public function eliminarMiembro($id, $usuarioId)
    {
        $grupo = Grupo::findOrFail($id);
        $miembro = $grupo->miembros()->where('usuario_id', $usuarioId)->firstOrFail();
        $miembro->delete();
        
        return response()->json(['message' => 'Miembro eliminado del grupo'], 200);
    }
    public function obtenerPorCuadrantes(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'cuadrante_ids' => 'required|array',
            'cuadrante_ids.*' => 'exists:cuadrantes,id'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $grupos = Grupo::with(['cuadrante'])
            ->whereIn('cuadrante_id', $request->cuadrante_ids)
            ->where('publico', true)
            ->get()
            ->groupBy('cuadrante_id');
        
        return response()->json($grupos);
    }
}