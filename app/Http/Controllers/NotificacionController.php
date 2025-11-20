<?php

namespace App\Http\Controllers;

use App\Models\Notificacion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class NotificacionController extends Controller
{
    public function index($usuarioId)
    {
        $notificaciones = Notificacion::where('usuario_id', $usuarioId)
            ->with('datos')
            ->orderBy('created_at', 'desc')
            ->paginate(20);
        
        return response()->json($notificaciones);
    }

    public function noLeidas($usuarioId)
    {
        $notificaciones = Notificacion::where('usuario_id', $usuarioId)
            ->where('leida', false)
            ->with('datos')
            ->orderBy('created_at', 'desc')
            ->get();
        
        return response()->json($notificaciones);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'usuario_id' => 'required|exists:usuarios,id',
            'tipo' => 'required|string|max:50',
            'titulo' => 'required|string|max:200',
            'mensaje' => 'required|string',
            'datos' => 'nullable|array'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        DB::beginTransaction();
        try {
            $notificacion = Notificacion::create($request->except('datos'));

            if ($request->has('datos')) {
                foreach ($request->datos as $clave => $valor) {
                    $notificacion->datos()->create([
                        'clave' => $clave,
                        'valor' => $valor
                    ]);
                }
            }

            DB::commit();
            
            return response()->json($notificacion->load('datos'), 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Error al crear notificación: ' . $e->getMessage()], 500);
        }
    }

    public function marcarLeida($id)
    {
        $notificacion = Notificacion::findOrFail($id);
        $notificacion->update(['leida' => true]);
        
        return response()->json($notificacion);
    }

    public function marcarTodasLeidas($usuarioId)
    {
        Notificacion::where('usuario_id', $usuarioId)
            ->where('leida', false)
            ->update(['leida' => true]);
        
        return response()->json(['message' => 'Todas las notificaciones marcadas como leídas'], 200);
    }

    public function destroy($id)
    {
        $notificacion = Notificacion::findOrFail($id);
        $notificacion->delete();
        
        return response()->json(['message' => 'Notificación eliminada correctamente'], 200);
    }
}