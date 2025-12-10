<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\DashboardController;
use App\Http\Controllers\Web\UsuarioWebController;
use App\Http\Controllers\Web\ReporteWebController;
use App\Http\Controllers\Web\CategoriaWebController;
use App\Http\Controllers\Web\ConfiguracionWebController;
use App\Http\Controllers\GrupoController;
use App\Http\Controllers\Auth\LoginController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// Rutas públicas de autenticación
use App\Http\Controllers\Auth\RegisterController;

Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [LoginController::class, 'login']);
Route::get('/register', [RegisterController::class, 'showRegisterForm'])->name('register');
Route::post('/register', [RegisterController::class, 'register']);
Route::post('/logout', [LoginController::class, 'logout'])->name('logout');

// Redirect root - si está autenticado va al dashboard, si no al login
Route::get('/', function () {
    if (auth()->check()) {
        return redirect()->route('dashboard');
    }
    return redirect()->route('login');
});

// Rutas protegidas - requieren autenticación
Route::middleware(['auth'])->group(function () {
    // Dashboard
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

    // Usuarios
    Route::resource('usuarios', UsuarioWebController::class);

    // Reportes
    Route::resource('reportes', ReporteWebController::class);

    // Categorías
    Route::resource('categorias', CategoriaWebController::class);

    // Cuadrantes
    Route::prefix('cuadrantes')->name('cuadrantes.')->group(function () {
        Route::get('/', function () {
            $cuadrantes = \App\Models\Cuadrante::withCount('reportes')
                ->with('grupos')
                ->orderBy('fila')
                ->orderBy('columna')
                ->get();
            $grupos = \App\Models\Grupo::count();
            return view('cuadrantes.index', compact('cuadrantes', 'grupos'));
        })->name('index');
        
        Route::post('/', [\App\Http\Controllers\Web\CuadranteWebController::class, 'store'])->name('store');
    });

    // Grupos - ACTUALIZADO
    Route::prefix('grupos')->name('grupos.')->group(function () {
        Route::get('/', [GrupoController::class, 'index'])->name('index');
        Route::get('/{id}', [GrupoController::class, 'show'])->name('show');
        Route::post('/{id}/join', [GrupoController::class, 'join'])->name('join');
        Route::post('/{id}/leave', [GrupoController::class, 'leave'])->name('leave');
        
        Route::post('/', function (\Illuminate\Http\Request $request) {
            $validated = $request->validate([
                'cuadrante_id' => 'required|exists:cuadrantes,id',
                'nombre' => 'required|string|max:255',
                'descripcion' => 'nullable|string',
                'publico' => 'nullable|boolean',
                'requiere_aprobacion' => 'nullable|boolean'
            ]);
            
            $grupo = \App\Models\Grupo::create($validated);
            
            return response()->json($grupo, 201);
        })->name('store');
    });

    // Respuestas
    Route::prefix('respuestas')->name('respuestas.')->group(function () {
        Route::get('/', function () {
            $respuestas = \App\Models\Respuesta::with(['reporte', 'usuario'])->orderBy('created_at', 'desc')->get();
            return view('respuestas.index', compact('respuestas'));
        })->name('index');
    });

    // Notificaciones
    Route::prefix('notificaciones')->name('notificaciones.')->group(function () {
        Route::get('/', function () {
            $notificaciones = \App\Models\Notificacion::with('usuario')->orderBy('created_at', 'desc')->paginate(50);
            return view('notificaciones.index', compact('notificaciones'));
        })->name('index');
    });

    // Configuración
    Route::get('/configuracion', [ConfiguracionWebController::class, 'index'])->name('configuracion.index');
});