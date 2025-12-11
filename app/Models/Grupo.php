<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Grupo extends Model
{
    use HasUuids;

    protected $table = 'grupos';
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'cuadrante_id',
        'nombre',
        'descripcion',
        'imagen_url',
        'publico',
        'requiere_aprobacion'
    ];

    protected $casts = [
        'publico' => 'boolean',
        'requiere_aprobacion' => 'boolean',
        'created_at' => 'datetime',
        'updated_at' => 'datetime'
    ];

    public function cuadrante()
    {
        return $this->belongsTo(Cuadrante::class, 'cuadrante_id');
    }

    public function miembros()
    {
        return $this->hasMany(GrupoMiembro::class, 'grupo_id');
    }

    public function usuarios()
    {
        return $this->belongsToMany(Usuario::class, 'grupo_miembros', 'grupo_id', 'usuario_id')
            ->withPivot('rol', 'notificaciones_activas', 'joined_at')
            ->using(GrupoMiembro::class);  // ← Esto le dice que use el modelo pivot
    }
}