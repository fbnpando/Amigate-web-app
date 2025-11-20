<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class GrupoMiembro extends Model
{
    use HasUuids;

    protected $table = 'grupo_miembros';
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';
    
    // CRÍTICO: Deshabilitar timestamps
    public $timestamps = false;

    protected $fillable = [
        'grupo_id',
        'usuario_id',
        'rol',
        'notificaciones_activas',
        'joined_at'
    ];

    protected $casts = [
        'notificaciones_activas' => 'boolean',
        'joined_at' => 'datetime'
    ];

    public function grupo()
    {
        return $this->belongsTo(Grupo::class, 'grupo_id');
    }

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }
}