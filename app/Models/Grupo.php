<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grupo extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'grupos';

    protected $fillable = [
        'cuadrante_id',
        'nombre',
        'descripcion',
        'imagen_url',
        'publico',
        'requiere_aprobacion',
        'miembros_count',
        'reportes_activos_count',
        'reportes_resueltos_count',
    ];

    protected $casts = [
        'publico' => 'boolean',
        'requiere_aprobacion' => 'boolean',
        'miembros_count' => 'integer',
        'reportes_activos_count' => 'integer',
        'reportes_resueltos_count' => 'integer',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    protected $attributes = [
        'publico' => true,
        'requiere_aprobacion' => false,
        'miembros_count' => 0,
        'reportes_activos_count' => 0,
        'reportes_resueltos_count' => 0,
    ];

    // ==========================================
    // RELACIONES
    // ==========================================

    /**
     * Cuadrante al que pertenece el grupo
     */
    public function cuadrante()
    {
        return $this->belongsTo(Cuadrante::class);
    }

    /**
     * Miembros del grupo
     * NOTA: Se removió withTimestamps() porque grupo_miembros no tiene created_at/updated_at
     */
    public function miembros()
    {
        return $this->belongsToMany(Usuario::class, 'grupo_miembros', 'grupo_id', 'usuario_id')
            ->withPivot('rol', 'notificaciones_activas', 'joined_at');
    }

    /**
     * Reportes del cuadrante asociado al grupo
     * Los grupos no tienen reportes directamente, pero sí a través del cuadrante
     */
    public function reportes()
    {
        return $this->hasManyThrough(
            Reporte::class,           // Modelo final
            Cuadrante::class,         // Modelo intermedio
            'id',                     // Foreign key en cuadrantes
            'cuadrante_id',          // Foreign key en reportes
            'cuadrante_id',          // Local key en grupos
            'id'                      // Local key en cuadrantes
        );
    }

    /**
     * Reportes activos del grupo
     */
    public function reportesActivos()
    {
        return $this->reportes()->where('estado', 'activo');
    }

    /**
     * Reportes resueltos del grupo
     */
    public function reportesResueltos()
    {
        return $this->reportes()->where('estado', 'resuelto');
    }

    /**
     * Reportes perdidos
     */
    public function reportesPerdidos()
    {
        return $this->reportes()->where('tipo_reporte', 'perdido');
    }

    /**
     * Reportes encontrados
     */
    public function reportesEncontrados()
    {
        return $this->reportes()->where('tipo_reporte', 'encontrado');
    }

    // ==========================================
    // SCOPES
    // ==========================================

    /**
     * Grupos públicos
     */
    public function scopePublicos($query)
    {
        return $query->where('publico', true);
    }

    /**
     * Grupos privados
     */
    public function scopePrivados($query)
    {
        return $query->where('publico', false);
    }

    /**
     * Grupos que requieren aprobación
     */
    public function scopeConAprobacion($query)
    {
        return $query->where('requiere_aprobacion', true);
    }

    /**
     * Grupos por cuadrante
     */
    public function scopePorCuadrante($query, $cuadranteId)
    {
        return $query->where('cuadrante_id', $cuadranteId);
    }

    /**
     * Grupos ordenados por actividad
     */
    public function scopeMasActivos($query)
    {
        return $query->orderBy('reportes_activos_count', 'desc');
    }

    /**
     * Grupos con más miembros
     */
    public function scopeMasPopulares($query)
    {
        return $query->orderBy('miembros_count', 'desc');
    }

    // ==========================================
    // MÉTODOS AUXILIARES
    // ==========================================

    /**
     * Verifica si el grupo es público
     */
    public function esPublico()
    {
        return $this->publico === true;
    }

    /**
     * Verifica si el grupo es privado
     */
    public function esPrivado()
    {
        return $this->publico === false;
    }

    /**
     * Verifica si requiere aprobación para unirse
     */
    public function requiereAprobacion()
    {
        return $this->requiere_aprobacion === true;
    }

    /**
     * Verifica si un usuario es miembro del grupo
     */
    public function esMiembro($usuarioId)
    {
        return $this->miembros()->where('usuario_id', $usuarioId)->exists();
    }

    /**
     * Verifica si un usuario es administrador del grupo
     */
    public function esAdmin($usuarioId)
    {
        return $this->miembros()
            ->where('usuario_id', $usuarioId)
            ->wherePivot('rol', 'admin')
            ->exists();
    }

    /**
     * Verifica si un usuario es moderador del grupo
     */
    public function esModerador($usuarioId)
    {
        return $this->miembros()
            ->where('usuario_id', $usuarioId)
            ->wherePivot('rol', 'moderador')
            ->exists();
    }

    /**
     * Obtiene el rol de un usuario en el grupo
     */
    public function rolUsuario($usuarioId)
    {
        $miembro = $this->miembros()->where('usuario_id', $usuarioId)->first();
        return $miembro ? $miembro->pivot->rol : null;
    }

    /**
     * Agrega un miembro al grupo
     */
    public function agregarMiembro($usuarioId, $rol = 'miembro')
    {
        if (!$this->esMiembro($usuarioId)) {
            $this->miembros()->attach($usuarioId, [
                'rol' => $rol,
                'joined_at' => now()
            ]);
            $this->increment('miembros_count');
            return true;
        }
        return false;
    }

    /**
     * Elimina un miembro del grupo
     */
    public function eliminarMiembro($usuarioId)
    {
        if ($this->esMiembro($usuarioId)) {
            $this->miembros()->detach($usuarioId);
            $this->decrement('miembros_count');
            return true;
        }
        return false;
    }

    /**
     * Actualiza el rol de un miembro
     */
    public function actualizarRolMiembro($usuarioId, $nuevoRol)
    {
        if ($this->esMiembro($usuarioId)) {
            $this->miembros()->updateExistingPivot($usuarioId, ['rol' => $nuevoRol]);
            return true;
        }
        return false;
    }

    /**
     * Actualiza los contadores del grupo
     */
    public function actualizarContadores()
    {
        $this->update([
            'miembros_count' => $this->miembros()->count(),
            'reportes_activos_count' => $this->reportesActivos()->count(),
            'reportes_resueltos_count' => $this->reportesResueltos()->count(),
        ]);
    }

    // ==========================================
    // ACCESSORS
    // ==========================================

    /**
     * Obtiene la URL de la imagen o un placeholder
     */
    public function getImagenAttribute()
    {
        return $this->imagen_url ?? 'https://via.placeholder.com/300x300?text=' . urlencode($this->nombre);
    }

    /**
     * Obtiene las iniciales del grupo
     */
    public function getInicialesAttribute()
    {
        $palabras = explode(' ', $this->nombre);
        if (count($palabras) >= 2) {
            return strtoupper(substr($palabras[0], 0, 1) . substr($palabras[1], 0, 1));
        }
        return strtoupper(substr($this->nombre, 0, 2));
    }
}