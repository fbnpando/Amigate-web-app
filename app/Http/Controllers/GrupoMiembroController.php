<?php

namespace App\Http\Controllers;

use App\Models\GrupoMiembro;
use App\Models\Grupo; // ← FALTABA ESTO
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator; // ← FALTABA ESTO

class GrupoMiembroController extends Controller
{
    /**
     * Mostrar todos los miembros de grupos
     */
    public function index()
    {
        return GrupoMiembro::with(['grupo', 'usuario'])->get();
    }

    /**
     * Crear un nuevo miembro en un grupo
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'grupo_id' => 'required|uuid|exists:grupos,id',
            'usuario_id' => 'required|uuid|exists:usuarios,id',
            'rol' => 'required|string|max:50',
            'notificaciones_activas' => 'boolean'
        ]);

        $miembro = GrupoMiembro::create($validated);

        return response()->json($miembro, 201);
    }

    /**
     * Mostrar un miembro por ID
     */
    public function show($id)
    {
        $miembro = GrupoMiembro::with(['grupo', 'usuario'])->find($id);

        if (!$miembro) {
            return response()->json(['message' => 'Miembro no encontrado'], 404);
        }

        return $miembro;
    }

    /**
     * Actualizar miembro
     */
    public function update(Request $request, $id)
    {
        $miembro = GrupoMiembro::find($id);

        if (!$miembro) {
            return response()->json(['message' => 'Miembro no encontrado'], 404);
        }

        $validated = $request->validate([
            'rol' => 'string|max:50',
            'notificaciones_activas' => 'boolean',
        ]);

        $miembro->update($validated);

        return response()->json($miembro);
    }

    /**
     * Eliminar miembro
     */
    public function destroy($id)
    {
        $miembro = GrupoMiembro::find($id);

        if (!$miembro) {
            return response()->json(['message' => 'Miembro no encontrado'], 404);
        }

        $miembro->delete();

        return response()->json(['message' => 'Miembro eliminado correctamente']);
    }

    /**
     * Obtener todos los miembros de un grupo específico
     */
    public function miembrosPorGrupo($grupoId)
    {
        return GrupoMiembro::where('grupo_id', $grupoId)
            ->with('usuario')
            ->get();
    }

    /**
     * Obtener todos los grupos donde pertenece un usuario
     */
    public function gruposPorUsuario($usuarioId)
    {
        return GrupoMiembro::where('usuario_id', $usuarioId)
            ->with('grupo')
            ->get();
    }

    /**
     * Agregar un miembro a un grupo
     */
    public function agregarMiembro(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'usuario_id' => 'required|exists:usuarios,id',
            'rol' => 'nullable|in:miembro,moderador,admin'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Verificar si ya es miembro
        $existente = GrupoMiembro::where('grupo_id', $id)
            ->where('usuario_id', $request->usuario_id)
            ->first();
        
        if ($existente) {
            return response()->json([
                'message' => 'El usuario ya es miembro del grupo',
                'miembro' => $existente
            ], 200);
        }
        
        // Crear miembro SIN timestamps
        $miembro = GrupoMiembro::create([
            'grupo_id' => $id,
            'usuario_id' => $request->usuario_id,
            'rol' => $request->rol ?? 'miembro',
            'notificaciones_activas' => true,
            'joined_at' => now()
        ]);
        
        return response()->json($miembro, 201);
    }
}