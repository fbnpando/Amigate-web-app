<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Notifications\Notifiable;

class Usuario extends Authenticatable
{
    use HasFactory, HasUuids, HasRoles, Notifiable;

    public $guard_name = 'web';

    protected $table = 'usuarios';

    protected $fillable = [
        'nombre',
        'email',
        'telefono',
        'avatar_url',
        'puntos_ayuda',
        'activo',
        'contrasena',
        'rol',
        'ubicacion_actual_lat',
        'ubicacion_actual_lng'
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

    /**
     * Get the password for the user.
     *
     * @return string
     */
    public function getAuthPassword()
    {
        return $this->contrasena;
    }

    
    
    

    
    public function reportes()
    {
        return $this->hasMany(Reporte::class);
    }

    
    public function respuestas()
    {
        return $this->hasMany(Respuesta::class);
    }

    
    public function notificaciones()
    {
        return $this->hasMany(Notificacion::class);
    }

    
    public function grupos()
    {
        return $this->belongsToMany(Grupo::class, 'grupo_miembros', 'usuario_id', 'grupo_id')
            ->withPivot('rol', 'notificaciones_activas', 'joined_at');
    }

    
    
    

    
    protected static function boot()
    {
        parent::boot();

        
        static::deleting(function ($usuario) {
            
            DB::table('configuracion_notificaciones_usuario')
                ->where('usuario_id', $usuario->id)
                ->delete();
        });
    }

    
    
    

    
    public function scopeActivos($query)
    {
        return $query->where('activo', true);
    }

    
    public function scopeTopColaboradores($query, $limit = 10)
    {
        return $query->orderBy('puntos_ayuda', 'desc')->limit($limit);
    }

    
    
    

    
    public function agregarPuntosAyuda($puntos)
    {
        return $this->increment('puntos_ayuda', $puntos);
    }

    
    public function estaActivo()
    {
        return $this->activo === true;
    }
}