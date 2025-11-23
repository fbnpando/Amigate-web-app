<?php

namespace App\Http\Controllers;

use App\Models\NotificacionDato;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Validator;

class NotificacionDatoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        try {
            $notificacionDatos = NotificacionDato::with('notificacion')
                ->orderBy('created_at', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $notificacionDatos
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los datos de notificación',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'notificacion_id' => 'required|uuid|exists:notificaciones,id',
            'clave' => 'required|string|max:255',
            'valor' => 'required|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $notificacionDato = NotificacionDato::create($request->all());

            return response()->json([
                'success' => true,
                'message' => 'Dato de notificación creado exitosamente',
                'data' => $notificacionDato->load('notificacion')
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear el dato de notificación',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id): JsonResponse
    {
        try {
            $notificacionDato = NotificacionDato::with('notificacion')->find($id);

            if (!$notificacionDato) {
                return response()->json([
                    'success' => false,
                    'message' => 'Dato de notificación no encontrado'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $notificacionDato
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener el dato de notificación',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'notificacion_id' => 'sometimes|uuid|exists:notificaciones,id',
            'clave' => 'sometimes|string|max:255',
            'valor' => 'sometimes|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $notificacionDato = NotificacionDato::find($id);

            if (!$notificacionDato) {
                return response()->json([
                    'success' => false,
                    'message' => 'Dato de notificación no encontrado'
                ], 404);
            }

            $notificacionDato->update($request->all());

            return response()->json([
                'success' => true,
                'message' => 'Dato de notificación actualizado exitosamente',
                'data' => $notificacionDato->load('notificacion')
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar el dato de notificación',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id): JsonResponse
    {
        try {
            $notificacionDato = NotificacionDato::find($id);

            if (!$notificacionDato) {
                return response()->json([
                    'success' => false,
                    'message' => 'Dato de notificación no encontrado'
                ], 404);
            }

            $notificacionDato->delete();

            return response()->json([
                'success' => true,
                'message' => 'Dato de notificación eliminado exitosamente'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar el dato de notificación',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get all datos for a specific notificacion
     */
    public function getByNotificacion(string $notificacionId): JsonResponse
    {
        try {
            $notificacionDatos = NotificacionDato::where('notificacion_id', $notificacionId)
                ->orderBy('created_at', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $notificacionDatos
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los datos de la notificación',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}