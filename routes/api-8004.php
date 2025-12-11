<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RespuestaController;

/*
|--------------------------------------------------------------------------
| API Routes - Puerto 8004: Lectura de Respuestas
|--------------------------------------------------------------------------
| Optimizado para consultas de lectura de respuestas
*/

// ============================================
// RESPUESTAS - Solo lectura
// ============================================
Route::prefix('respuestas')->group(function () {
    // Obtener respuestas de un reporte (FRECUENTE)
    Route::get('reporte/{reporteId}', [RespuestaController::class, 'respuestasDelReporte']);
    
    // Obtener solo respuestas tipo "encontrado"
    Route::get('reporte/{reporteId}/encontrado', [RespuestaController::class, 'respuestasEncontrado']);
    
    // Obtener respuesta específica
    Route::get('{id}', [RespuestaController::class, 'show']);
});

// ============================================
// RUTA DE PRUEBA
// ============================================
Route::get('/ping', function () {
    return response()->json([
        'success' => true,
        'message' => 'API Puerto 8004 funcionando correctamente',
        'timestamp' => now(),
        'port' => 8004
    ]);
});

