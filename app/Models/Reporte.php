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
        'ubicacion_exacta',
        'direccion_referencia',
        'caracteristicas',
        'fecha_perdida',
        'fecha_reporte',
        'estado',
        'prioridad',
        'cuadrantes_expandidos',
        'nivel_expansion',
        'max_expansion',
        'proxima_expansion',
        'imagenes',
        'videos',
        'contacto_publico',
        'telefono_contacto',
        'email_contacto',
        'recompensa',
        'vistas',
        'respuestas_count',
    ];

    protected $casts = [
        'ubicacion_exacta' => 'array',
        'caracteristicas' => 'array',
        'fecha_perdida' => 'datetime',
        'fecha_reporte' => 'datetime',
        'proxima_expansion' => 'datetime',
        'imagenes' => 'array',
        'videos' => 'array',
        'cuadrantes_expandidos' => 'array',
        'contacto_publico' => 'boolean',
        'recompensa' => 'decimal:2',
        'vistas' => 'integer',
        'respuestas_count' => 'integer',
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
        'respuestas_count' => 0,
        'imagenes' => '[]',
        'videos' => '[]',
        'cuadrantes_expandidos' => '[]',
    ];

    // ==========================================
    // RELACIONES
    // ==========================================

    /**
     * Usuario que creó el reporte
     */
    public function usuario()
    {
        return $this->belongsTo(Usuario::class);
    }

    /**
     * Categoría del reporte
     */
    public function categoria()
    {
        return $this->belongsTo(Categoria::class);
    }

    /**
     * Cuadrante donde se reportó
     */
    public function cuadrante()
    {
        return $this->belongsTo(Cuadrante::class);
    }

    /**
     * Respuestas al reporte
     */
    public function respuestas()
    {
        return $this->hasMany(Respuesta::class);
    }

    /**
     * Expansiones del reporte
     */
    public function expansiones()
    {
        return $this->hasMany(ExpansionReporte::class);
    }

    // ==========================================
    // SCOPES
    // ==========================================

    /**
     * Reportes activos
     */
    public function scopeActivos($query)
    {
        return $query->where('estado', 'activo');
    }

    /**
     * Reportes resueltos
     */
    public function scopeResueltos($query)
    {
        return $query->where('estado', 'resuelto');
    }

    /**
     * Reportes perdidos
     */
    public function scopePerdidos($query)
    {
        return $query->where('tipo_reporte', 'perdido');
    }

    /**
     * Reportes encontrados
     */
    public function scopeEncontrados($query)
    {
        return $query->where('tipo_reporte', 'encontrado');
    }

    /**
     * Reportes por categoría
     */
    public function scopePorCategoria($query, $categoriaId)
    {
        return $query->where('categoria_id', $categoriaId);
    }

    /**
     * Reportes por cuadrante
     */
    public function scopePorCuadrante($query, $cuadranteId)
    {
        return $query->where('cuadrante_id', $cuadranteId);
    }

    /**
     * Reportes con prioridad urgente
     */
    public function scopeUrgentes($query)
    {
        return $query->where('prioridad', 'urgente');
    }

    /**
     * Reportes con recompensa
     */
    public function scopeConRecompensa($query)
    {
        return $query->whereNotNull('recompensa')->where('recompensa', '>', 0);
    }

    /**
     * Reportes recientes (últimos 7 días)
     */
    public function scopeRecientes($query)
    {
        return $query->where('created_at', '>=', now()->subDays(7));
    }

    // ==========================================
    // MÉTODOS AUXILIARES
    // ==========================================

    /**
     * Verifica si el reporte está activo
     */
    public function estaActivo()
    {
        return $this->estado === 'activo';
    }

    /**
     * Verifica si el reporte está resuelto
     */
    public function estaResuelto()
    {
        return $this->estado === 'resuelto';
    }

    /**
     * Verifica si es un reporte de objeto perdido
     */
    public function esPerdido()
    {
        return $this->tipo_reporte === 'perdido';
    }

    /**
     * Verifica si es un reporte de objeto encontrado
     */
    public function esEncontrado()
    {
        return $this->tipo_reporte === 'encontrado';
    }

    /**
     * Verifica si tiene recompensa
     */
    public function tieneRecompensa()
    {
        return $this->recompensa && $this->recompensa > 0;
    }

    /**
     * Verifica si tiene imágenes
     */
    public function tieneImagenes()
    {
        return is_array($this->imagenes) && count($this->imagenes) > 0;
    }

    /**
     * Verifica si tiene videos
     */
    public function tieneVideos()
    {
        return is_array($this->videos) && count($this->videos) > 0;
    }

    /**
     * Obtiene la cantidad de imágenes
     */
    public function cantidadImagenes()
    {
        return $this->tieneImagenes() ? count($this->imagenes) : 0;
    }

    /**
     * Obtiene la cantidad de videos
     */
    public function cantidadVideos()
    {
        return $this->tieneVideos() ? count($this->videos) : 0;
    }

    /**
     * Obtiene la primera imagen o un placeholder
     */
    public function getPrimeraImagenAttribute()
    {
        if ($this->tieneImagenes()) {
            return asset('storage/' . $this->imagenes[0]);
        }
        return asset('images/placeholder-reporte.png');
    }

    /**
     * Marca el reporte como resuelto
     */
    public function marcarComoResuelto()
    {
        return $this->update(['estado' => 'resuelto']);
    }

    /**
     * Incrementa el contador de vistas
     */
    public function incrementarVistas()
    {
        return $this->increment('vistas');
    }

    /**
     * Incrementa el contador de respuestas
     */
    public function incrementarRespuestas()
    {
        return $this->increment('respuestas_count');
    }

    /**
     * Verifica si puede expandirse a más cuadrantes
     */
    public function puedeExpandirse()
    {
        return $this->nivel_expansion < $this->max_expansion;
    }

    /**
     * Verifica si es momento de expandirse
     */
    public function debeExpandirse()
    {
        return $this->puedeExpandirse() 
            && $this->proxima_expansion 
            && now()->greaterThanOrEqualTo($this->proxima_expansion);
    }

    /**
     * Obtiene el badge de estado con color
     */
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

    /**
     * Obtiene el badge de prioridad con color
     */
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

    /**
     * Obtiene el badge de tipo de reporte
     */
    public function getBadgeTipoAttribute()
    {
        $badges = [
            'perdido' => '<span class="badge bg-danger"><i class="bi bi-exclamation-triangle me-1"></i>Perdido</span>',
            'encontrado' => '<span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Encontrado</span>',
        ];

        return $badges[$this->tipo_reporte] ?? '<span class="badge bg-secondary">Desconocido</span>';
    }

    /**
     * Formato de dirección de referencia corta
     */
    public function getDireccionCortaAttribute()
    {
        if (!$this->direccion_referencia) {
            return 'Sin ubicación especificada';
        }
        return \Str::limit($this->direccion_referencia, 50);
    }

    /**
     * Obtiene los días desde que se reportó
     */
    public function getDiasDesdeReporteAttribute()
    {
        return $this->created_at->diffInDays(now());
    }
}