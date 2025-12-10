<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reporte extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'reportes';

    protected $fillable = [
        'usuario_id',
        'categoria_id',
        'cuadrante_id',
        'tipo_reporte',
        'titulo',
        'descripcion',
        'ubicacion_exacta_lat',      // ← Cambio: eran columnas separadas
        'ubicacion_exacta_lng',      // ← Cambio: no un array
        'direccion_referencia',
        // 'caracteristicas',        // ← NO existe en la tabla principal
        'fecha_perdida',
        'fecha_reporte',
        'estado',
        'prioridad',
        // 'cuadrantes_expandidos',  // ← NO existe en la tabla
        'nivel_expansion',
        'max_expansion',
        'proxima_expansion',
        // 'imagenes',               // ← Tabla separada: reporte_imagenes
        // 'videos',                 // ← Tabla separada: reporte_videos
        'contacto_publico',
        'telefono_contacto',
        'email_contacto',
        'recompensa',
        'vistas',
        // 'respuestas_count',       // ← ELIMINADO: no existe
    ];

    protected $casts = [
        'ubicacion_exacta_lat' => 'decimal:8',
        'ubicacion_exacta_lng' => 'decimal:8',
        // 'ubicacion_exacta' => 'array',     // ← ELIMINAR
        // 'caracteristicas' => 'array',      // ← ELIMINAR
        'fecha_perdida' => 'datetime',
        'fecha_reporte' => 'datetime',
        'proxima_expansion' => 'datetime',
        // 'imagenes' => 'array',             // ← ELIMINAR
        // 'videos' => 'array',               // ← ELIMINAR
        // 'cuadrantes_expandidos' => 'array', // ← ELIMINAR
        'contacto_publico' => 'boolean',
        'recompensa' => 'decimal:2',
        'vistas' => 'integer',
        // 'respuestas_count' => 'integer',   // ← ELIMINAR
        'nivel_expansion' => 'integer',
        'max_expansion' => 'integer',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    protected $attributes = [
        'estado' => 'activo',
        'prioridad' => 'normal',
        'nivel_expansion' => 1,
        'max_expansion' => 3,
        'contacto_publico' => true,
        'vistas' => 0,
        // 'respuestas_count' => 0,  // ← ELIMINAR
        // 'imagenes' => '[]',       // ← ELIMINAR
        // 'videos' => '[]',         // ← ELIMINAR
        // 'cuadrantes_expandidos' => '[]', // ← ELIMINAR
    ];

    // ==========================================
    // RELACIONES
    // ==========================================

    public function usuario()
    {
        return $this->belongsTo(Usuario::class);
    }

    public function categoria()
    {
        return $this->belongsTo(Categoria::class);
    }

    public function cuadrante()
    {
        return $this->belongsTo(Cuadrante::class);
    }

    public function respuestas()
    {
        return $this->hasMany(Respuesta::class);
    }

    public function expansiones()
    {
        return $this->hasMany(ExpansionReporte::class, 'reporte_id');
    }

    // Nuevas relaciones según tu estructura de BD
    public function imagenes()
    {
        return $this->hasMany(ReporteImagen::class, 'reporte_id');
    }

    public function videos()
    {
        return $this->hasMany(ReporteVideo::class, 'reporte_id');
    }

    public function caracteristicas()
    {
        return $this->hasMany(ReporteCaracteristica::class, 'reporte_id');
    }

    // ==========================================
    // SCOPES
    // ==========================================

    public function scopeActivos($query)
    {
        return $query->where('estado', 'activo');
    }

    public function scopeResueltos($query)
    {
        return $query->where('estado', 'resuelto');
    }

    public function scopePerdidos($query)
    {
        return $query->where('tipo_reporte', 'perdido');
    }

    public function scopeEncontrados($query)
    {
        return $query->where('tipo_reporte', 'encontrado');
    }

    public function scopePorCategoria($query, $categoriaId)
    {
        return $query->where('categoria_id', $categoriaId);
    }

    public function scopePorCuadrante($query, $cuadranteId)
    {
        return $query->where('cuadrante_id', $cuadranteId);
    }

    public function scopeUrgentes($query)
    {
        return $query->where('prioridad', 'urgente');
    }

    public function scopeConRecompensa($query)
    {
        return $query->whereNotNull('recompensa')->where('recompensa', '>', 0);
    }

    public function scopeRecientes($query)
    {
        return $query->where('created_at', '>=', now()->subDays(7));
    }

    // ==========================================
    // MÉTODOS AUXILIARES
    // ==========================================

    public function estaActivo()
    {
        return $this->estado === 'activo';
    }

    public function estaResuelto()
    {
        return $this->estado === 'resuelto';
    }

    public function esPerdido()
    {
        return $this->tipo_reporte === 'perdido';
    }

    public function esEncontrado()
    {
        return $this->tipo_reporte === 'encontrado';
    }

    public function tieneRecompensa()
    {
        return $this->recompensa && $this->recompensa > 0;
    }

    public function tieneImagenes()
    {
        return $this->imagenes()->exists();
    }

    public function tieneVideos()
    {
        return $this->videos()->exists();
    }

    public function cantidadImagenes()
    {
        return $this->imagenes()->count();
    }

    public function cantidadVideos()
    {
        return $this->videos()->count();
    }

    public function getPrimeraImagenAttribute()
    {
        $primeraImagen = $this->imagenes()->first();
        if ($primeraImagen) {
            return asset('storage/' . $primeraImagen->ruta);
        }
        return asset('images/placeholder-reporte.png');
    }

    public function marcarComoResuelto()
    {
        return $this->update(['estado' => 'resuelto']);
    }

    public function incrementarVistas()
    {
        return $this->increment('vistas');
    }

    /**
     * Obtiene el contador de respuestas dinámicamente
     */
    public function getRespuestasCountAttribute()
    {
        return $this->respuestas()->count();
    }

    public function puedeExpandirse()
    {
        return $this->nivel_expansion < $this->max_expansion;
    }

    public function debeExpandirse()
    {
        return $this->puedeExpandirse() 
            && $this->proxima_expansion 
            && now()->greaterThanOrEqualTo($this->proxima_expansion);
    }

    public function getBadgeEstadoAttribute()
    {
        $badges = [
            'activo' => '<span class="badge bg-warning text-dark">Activo</span>',
            'resuelto' => '<span class="badge bg-success">Resuelto</span>',
            'inactivo' => '<span class="badge bg-secondary">Inactivo</span>',
            'spam' => '<span class="badge bg-danger">Spam</span>',
        ];

        return $badges[$this->estado] ?? '<span class="badge bg-secondary">Desconocido</span>';
    }

    public function getBadgePrioridadAttribute()
    {
        $badges = [
            'baja' => '<span class="badge bg-info">Baja</span>',
            'normal' => '<span class="badge bg-primary">Normal</span>',
            'alta' => '<span class="badge bg-warning text-dark">Alta</span>',
            'urgente' => '<span class="badge bg-danger">Urgente</span>',
        ];

        return $badges[$this->prioridad] ?? '<span class="badge bg-secondary">Normal</span>';
    }

    public function getBadgeTipoAttribute()
    {
        $badges = [
            'perdido' => '<span class="badge bg-danger"><i class="bi bi-exclamation-triangle me-1"></i>Perdido</span>',
            'encontrado' => '<span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Encontrado</span>',
        ];

        return $badges[$this->tipo_reporte] ?? '<span class="badge bg-secondary">Desconocido</span>';
    }

    public function getDireccionCortaAttribute()
    {
        if (!$this->direccion_referencia) {
            return 'Sin ubicación especificada';
        }
        return \Str::limit($this->direccion_referencia, 50);
    }

    public function getDiasDesdeReporteAttribute()
    {
        return $this->created_at->diffInDays(now());
    }

    /**
     * Accessor para obtener ubicación como array
     */
    public function getUbicacionExactaAttribute()
    {
        if ($this->ubicacion_exacta_lat && $this->ubicacion_exacta_lng) {
            return [
                'lat' => (float) $this->ubicacion_exacta_lat,
                'lng' => (float) $this->ubicacion_exacta_lng,
            ];
        }
        return null;
    }
}