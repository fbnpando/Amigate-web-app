<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Reporte extends Model
{
    use HasUuids;

    protected $table = 'reportes';
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'usuario_id',
        'categoria_id',
        'cuadrante_id',
        'tipo_reporte',
        'titulo',
        'descripcion',
        'ubicacion_exacta_lat',
        'ubicacion_exacta_lng',
        'direccion_referencia',
        'fecha_perdida',
        'fecha_reporte',
        'estado',
        'prioridad',
        'nivel_expansion',
        'max_expansion',
        'proxima_expansion',
        'contacto_publico',
        'telefono_contacto',
        'email_contacto',
        'recompensa',
        'vistas'
    ];

    protected $casts = [
        'ubicacion_exacta_lat' => 'decimal:8',
        'ubicacion_exacta_lng' => 'decimal:8',
        'fecha_perdida' => 'datetime',
        'fecha_reporte' => 'datetime',
        'nivel_expansion' => 'integer',
        'max_expansion' => 'integer',
        'proxima_expansion' => 'datetime',
        'contacto_publico' => 'boolean',
        'recompensa' => 'decimal:2',
        'vistas' => 'integer',
        'created_at' => 'datetime',
        'updated_at' => 'datetime'
    ];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }

    public function categoria()
    {
        return $this->belongsTo(Categoria::class, 'categoria_id');
    }

    public function cuadrante()
    {
        return $this->belongsTo(Cuadrante::class, 'cuadrante_id');
    }

    public function caracteristicas()
    {
        return $this->hasMany(ReporteCaracteristica::class, 'reporte_id');
    }

    public function imagenes()
    {
        return $this->hasMany(ReporteImagen::class, 'reporte_id')->orderBy('orden');
    }

    public function videos()
    {
        return $this->hasMany(ReporteVideo::class, 'reporte_id')->orderBy('orden');
    }

    public function respuestas()
    {
        return $this->hasMany(Respuesta::class, 'reporte_id');
    }

    public function expansiones()
    {
        return $this->hasMany(ExpansionReporte::class, 'reporte_id');
    }
}
