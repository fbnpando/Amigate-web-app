<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'usuarios';

    protected $fillable = [
        'nombre',
        'email',
        'telefono',
        'avatar_url',
        'puntos_ayuda',
        'activo',
    ];

    protected $casts = [
        'activo' => 'boolean',
        'puntos_ayuda' => 'integer',
        'fecha_registro' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    protected $attributes = [
        'activo' => true,
        'puntos_ayuda' => 0,
    ];

    // ==========================================
    // RELACIONES
    // ==========================================

    /**
     * Reportes creados por el usuario
     */
    public function reportes()
    {
        return $this->hasMany(Reporte::class);
    }

    /**
     * Respuestas del usuario
     */
    public function respuestas()
    {
        return $this->hasMany(Respuesta::class);
    }

    /**
     * Notificaciones del usuario
     */
    public function notificaciones()
    {
        return $this->hasMany(Notificacion::class);
    }

    /**
     * Grupos a los que pertenece el usuario
     * NOTA: Se removió withTimestamps() porque grupo_miembros no tiene created_at/updated_at
     */
    public function grupos()
    {
        return $this->belongsToMany(Grupo::class, 'grupo_miembros', 'usuario_id', 'grupo_id')
            ->withPivot('rol', 'notificaciones_activas', 'joined_at');
    }

    // ==========================================
    // SCOPES
    // ==========================================

    /**
     * Usuarios activos
     */
    public function scopeActivos($query)
    {
        return $query->where('activo', true);
    }

    /**
     * Usuarios con más puntos de ayuda
     */
    public function scopeTopColaboradores($query, $limit = 10)
    {
        return $query->orderBy('puntos_ayuda', 'desc')->limit($limit);
    }

    // ==========================================
    // MÉTODOS AUXILIARES
    // ==========================================

    /**
     * Incrementa los puntos de ayuda del usuario
     */
    public function agregarPuntosAyuda($puntos)
    {
        return $this->increment('puntos_ayuda', $puntos);
    }

    /**
     * Verifica si el usuario está activo
     */
    public function estaActivo()
    {
        return $this->activo === true;
    }
}