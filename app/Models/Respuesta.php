<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Respuesta extends Model
{
    use HasUuids;

    protected $table = 'respuestas';
    public $incrementing = false;
    protected $keyType = 'string';
    const UPDATED_AT = null;

    protected $fillable = [
        'reporte_id', 'usuario_id', 'tipo_respuesta', 'mensaje',
        'ubicacion', 'direccion_referencia', 'imagenes', 'videos',
        'verificada', 'util'
    ];

    protected $casts = [
        'imagenes' => 'array',
        'videos' => 'array',
        'verificada' => 'boolean',
        'util' => 'boolean'
    ];

    public function reporte()
    {
        return $this->belongsTo(Reporte::class, 'reporte_id');
    }

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }
}