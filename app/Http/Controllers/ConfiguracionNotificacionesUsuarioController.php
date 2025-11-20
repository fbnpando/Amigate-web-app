<?php

namespace App\Http\Controllers;

use App\Models\ConfiguracionNotificacionesUsuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ConfiguracionNotificacionesUsuarioController extends Controller
{
    public function show($usuarioId)
    {
        $config = ConfiguracionNotificacionesUsuario::where('usuario_id', $usuarioId)
            ->firstOrFail();
        
        return response()->json($config);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'usuario_id' => 'required|exists:usuarios,id|unique:configuracion_notificaciones_usuario,usuario_id',
            'push_activo' => 'nullable|boolean',
            'email_activo' => 'nullable|boolean',
            'sms_activo' => 'nullable|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $config = ConfiguracionNotificacionesUsuario::create($request->all());
        
        return response()->json($config, 201);
    }

    public function update(Request $request, $usuarioId)
    {
        $config = ConfiguracionNotificacionesUsuario::where('usuario_id', $usuarioId)
            ->firstOrFail();

        $validator = Validator::make($request->all(), [
            'push_activo' => 'nullable|boolean',
            'email_activo' => 'nullable|boolean',
            'sms_activo' => 'nullable|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $config->update($request->all());
        
        return response()->json($config);
    }

    public function destroy($usuarioId)
    {
        $config = ConfiguracionNotificacionesUsuario::where('usuario_id', $usuarioId)
            ->firstOrFail();
        $config->delete();
        
        return response()->json(['message' => 'Configuración eliminada correctamente'], 200);
    }
}
