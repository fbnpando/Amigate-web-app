<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class Usuario extends Authenticatable
{
    use HasUuids, Notifiable;

    protected $table = 'usuarios';
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'nombre',
        'email',
        'contrasena',
        'telefono',
        'avatar_url',
        'puntos_ayuda',
        'activo',
        'ubicacion_actual_lat',
        'ubicacion_actual_lng',
        'rol'
    ];

    protected $hidden = [
        'contrasena',
    ];

    protected $casts = [
        'fecha_registro' => 'datetime',
        'activo' => 'boolean',
        'ubicacion_actual_lat' => 'decimal:8',
        'ubicacion_actual_lng' => 'decimal:8',
        'puntos_ayuda' => 'integer',
        'created_at' => 'datetime',
        'updated_at' => 'datetime'
    ];

    // Override del método para usar 'contrasena' en lugar de 'password'
    public function getAuthPassword()
    {
        return $this->contrasena;
    }

    // Override del método para usar 'email' como username
    public function getAuthIdentifierName()
    {
        return 'email';
    }

    public function configuracionNotificaciones()
    {
        return $this->hasOne(ConfiguracionNotificacionesUsuario::class, 'usuario_id');
    }

    public function reportes()
    {
        return $this->hasMany(Reporte::class, 'usuario_id');
    }

    public function respuestas()
    {
        return $this->hasMany(Respuesta::class, 'usuario_id');
    }

    public function grupoMiembros()
    {
        return $this->hasMany(GrupoMiembro::class, 'usuario_id');
    }


    public function grupos()
    {
        return $this->belongsToMany(Grupo::class, 'grupo_miembros', 'usuario_id', 'grupo_id')
            ->withPivot('rol', 'notificaciones_activas', 'joined_at')
            ->using(GrupoMiembro::class); // Usa el modelo pivot que tiene timestamps = false
    }

    public function notificaciones()
    {
        return $this->hasMany(Notificacion::class, 'usuario_id');
    }
}