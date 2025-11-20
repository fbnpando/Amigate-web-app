<?php

namespace App\Http\Controllers;

use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class UsuarioController extends Controller
{
    // ========== AUTENTICACIÓN ==========
    
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Buscar usuario
        $usuario = Usuario::where('email', $request->email)->first();

        if (!$usuario) {
            return response()->json([
                'message' => 'Usuario no encontrado'
            ], 404);
        }

        // Verificar contraseña
        if (!Hash::check($request->password, $usuario->contrasena)) {
            return response()->json([
                'message' => 'Contraseña incorrecta'
            ], 401);
        }

        // Verificar si está activo
        if (!$usuario->activo) {
            return response()->json([
                'message' => 'Usuario inactivo'
            ], 403);
        }

        // Generar token (sin Sanctum por ahora)
        $token = base64_encode($usuario->id . '|' . time());

        return response()->json([
            'message' => 'Login exitoso',
            'token' => $token,
            'usuario' => $usuario
        ], 200);
    }

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nombre' => 'required|string|max:100',
            'email' => 'required|email|unique:usuarios,email|max:255',
            'password' => 'required|string|min:6',
            'telefono' => 'nullable|string|max:20',
            'avatar_url' => 'nullable|url',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $usuario = Usuario::create([
            'nombre' => $request->nombre,
            'email' => $request->email,
            'contrasena' => Hash::make($request->password),
            'telefono' => $request->telefono,
            'avatar_url' => $request->avatar_url,
            'rol' => 'cliente',
            'activo' => true,
        ]);

        return response()->json([
            'message' => 'Usuario registrado exitosamente',
            'usuario' => $usuario
        ], 201);
    }

    // ========== CRUD NORMAL ==========

    public function index()
    {
        $usuarios = Usuario::with('configuracionNotificaciones')
            ->paginate(15);
        
        return response()->json($usuarios);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nombre' => 'required|string|max:100',
            'email' => 'required|email|unique:usuarios,email|max:255',
            'password' => 'required|string|min:6',
            'telefono' => 'nullable|string|max:20',
            'avatar_url' => 'nullable|url',
            'ubicacion_actual_lat' => 'nullable|numeric|between:-90,90',
            'ubicacion_actual_lng' => 'nullable|numeric|between:-180,180',
            'rol' => 'nullable|in:cliente,moderador,admin'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $data = $request->all();
        $data['contrasena'] = Hash::make($request->password);
        unset($data['password']);

        $usuario = Usuario::create($data);
        
        return response()->json($usuario, 201);
    }

    public function show($id)
    {
        $usuario = Usuario::with(['reportes', 'respuestas', 'grupos'])
            ->findOrFail($id);
        
        return response()->json($usuario);
    }

    public function update(Request $request, $id)
    {
        $usuario = Usuario::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'nombre' => 'sometimes|string|max:100',
            'email' => 'sometimes|email|unique:usuarios,email,' . $id . '|max:255',
            'password' => 'sometimes|string|min:6',
            'telefono' => 'nullable|string|max:20',
            'avatar_url' => 'nullable|url',
            'ubicacion_actual_lat' => 'nullable|numeric|between:-90,90',
            'ubicacion_actual_lng' => 'nullable|numeric|between:-180,180',
            'activo' => 'nullable|boolean',
            'rol' => 'nullable|in:cliente,moderador,admin'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $data = $request->all();
        
        // Si se envía password, hashearlo
        if (isset($data['password'])) {
            $data['contrasena'] = Hash::make($data['password']);
            unset($data['password']);
        }

        $usuario->update($data);
        
        return response()->json($usuario);
    }

    public function destroy($id)
    {
        $usuario = Usuario::findOrFail($id);
        $usuario->delete();
        
        return response()->json(['message' => 'Usuario eliminado correctamente'], 200);
    }

    public function reportes($id)
    {
        $usuario = Usuario::findOrFail($id);
        $reportes = $usuario->reportes()->with(['categoria', 'cuadrante'])->get();
        
        return response()->json($reportes);
    }

    public function actualizarUbicacion(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'ubicacion_actual_lat' => 'required|numeric|between:-90,90',
            'ubicacion_actual_lng' => 'required|numeric|between:-180,180'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $usuario = Usuario::findOrFail($id);
        $usuario->update([
            'ubicacion_actual_lat' => $request->ubicacion_actual_lat,
            'ubicacion_actual_lng' => $request->ubicacion_actual_lng
        ]);
        
        return response()->json($usuario);
    }
}