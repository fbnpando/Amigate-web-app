<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ReporteController;

/*
|--------------------------------------------------------------------------
| API Routes - Puerto 8001: Lectura de Reportes (MUY FRECUENTE)
|--------------------------------------------------------------------------
| Optimizado para consultas de lectura de reportes
*/

// ============================================
// REPORTES - Solo lectura
// ============================================
Route::prefix('reportes')->group(function () {
    // Obtener reportes del usuario
    Route::get('usuario/{usuarioId}', [ReporteController::class, 'reportesDelUsuario']);
    
    // Obtener reportes de un grupo (MUY FRECUENTE)
    Route::get('grupo/{grupoId}', [ReporteController::class, 'reportesDelGrupo']);
    
    // Obtener reporte específico
    Route::get('{id}', [ReporteController::class, 'show']);
});

// ============================================
// RUTA DE PRUEBA
// ============================================
Route::get('/ping', function () {
    return response()->json([
        'success' => true,
        'message' => 'API Puerto 8001 funcionando correctamente',
        'timestamp' => now(),
        'port' => 8001
    ]);
});

